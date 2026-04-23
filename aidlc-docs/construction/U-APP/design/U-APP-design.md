# U-APP Design (Minimal 合本版)

**Unit**: U-APP（Flutter モバイルアプリ、**実装順で最後の Unit**）
**Deployable**: `overseas_safety_map_app`（iOS + Android）
**前段**: 親レポ `overseas-safety-map` の BFF（Cloud Run Service、Connect RPC）
**ワークフロー圧縮**: Option B（Functional Design + NFR Requirements + NFR Design 1 本に集約）

---

## 0. Design Decisions（計画回答の確定）

[`U-APP-design-plan.md`](../../plans/U-APP-design-plan.md) Q1-Q10 すべて **[A]** で確定。

| # | 決定事項 | 選択 | 要旨 |
|---|---------|------|------|
| Q1 | 状態管理 | **A** | Riverpod v2（flutter_riverpod + riverpod_annotation + code gen） |
| Q2 | ナビゲーション | **A** | go_router（URL ベース declarative） |
| Q3 | 地図 | **A** | flutter_map（OSS / OSM / MapLibre） |
| Q4 | Connect RPC | **A** | connectrpc.com/connect-dart + buf plugin（親レポ proto を直接参照） |
| Q5 | Firebase | **A** | FlutterFire（core + auth + messaging） |
| Q6 | アーキテクチャ | **A** | Feature-sliced + UseCase 層 |
| Q7 | カバレッジ | **A** | 層別（domain 95 / app 80 / presentation 60 / core 70 / 全体 70+） |
| Q8 | パフォーマンス | **A** | Cold 3s / Warm 500ms / tap 100ms |
| Q9 | セキュリティ | **A** | 最小権限 + ID Token メモリのみ |
| Q10 | リリース / CI | **A** | GitHub Actions lint+test、リリース手動 |

---

## 1. Functional Design

### 1.1 Context — U-APP の責務

**目的**: 外務省の海外安全情報を、親レポ BFF 経由で取得し、モバイルユーザーに **地図 + 一覧 + 通知** で届ける Flutter アプリ。

**責務**:
- Firebase Anonymous Auth で uid を確保、ID Token を BFF に付与
- 3 Service / 11 RPC の Connect クライアント
- 地図（Choropleth / Heatmap / Nearby）表示
- 事象一覧 + 詳細
- プロファイル / 通知設定（お気に入り国 / 通知種別 / FCM token）
- FCM 受信（foreground / background / terminated）

**非責務**:
- データ取り込み（U-ING の責務）
- CMS 書き込み（U-BFF 経由で BFF が行う）
- 通知配信（U-NTF の責務）
- Web 版 Flutter（将来）

### 1.2 画面構成（bottom nav 4 タブ）

```
┌─ Root (go_router ShellRoute) ────────────────────────────┐
│  bottom_navigation_bar                                    │
│                                                           │
│  ┌── 地図 ───┐ ┌── 一覧 ───┐ ┌── 通知 ───┐ ┌── 設定 ──┐  │
│  │ MapScreen │ │ ListScreen│ │Notifica…  │ │ Profile   │  │
│  │           │ │           │ │Screen     │ │ Screen    │  │
│  │ [地図]    │ │ [検索]    │ │ [受信履歴]│ │ [uid]     │  │
│  │ ・Choro   │ │ [Country] │ │ ・in-app  │ │ [お気国]  │  │
│  │ ・Heat    │ │ [InfoType]│ │   history │ │ [通知設定]│  │
│  │ ・Nearby  │ │ list[]    │ │   (local) │ │ [version] │  │
│  │ [マーカー]│ │           │ │           │ │           │  │
│  └───────────┘ └───────────┘ └───────────┘ └───────────┘  │
│        ↓             ↓             ↓             ↓        │
│  DetailScreen (push) — 任意のタブから key_cd 指定で遷移   │
└───────────────────────────────────────────────────────────┘
```

| タブ | 画面 | RPC |
|---|---|---|
| 地図 | `MapScreen`（中央大）/`MapLayerSheet`（切替モーダル） | `GetChoropleth` / `GetHeatmap` / `ListNearby` / `GetSafetyIncidentsAsGeoJSON` |
| 一覧 | `ListScreen`（filter: country, info_type, leave_date range） | `ListSafetyIncidents` / `SearchSafetyIncidents` |
| 通知 | `NotificationHistoryScreen`（端末内 local 履歴、FCM 受信時に追加） | — |
| 設定 | `ProfileScreen`（uid 表示、お気に入り国、通知設定） | `GetProfile` / `ToggleFavoriteCountry` / `UpdateNotificationPreference` / `RegisterFcmToken` |
| 共通 | `DetailScreen`（任意タブから push） | `GetSafetyIncident` |

### 1.3 ドメインモデル

親レポの proto 型は `connect-dart` 生成物として import。ドメインモデルは Flutter 側で以下の軽量 VO を持つ:

```dart
// lib/core/domain/point.dart
class LatLng { final double lat, lng; const LatLng(this.lat, this.lng); }

// lib/features/map/domain/map_filter.dart
class MapFilter {
  final DateTime? leaveFrom;
  final DateTime? leaveTo;
  final String? countryCd;
  const MapFilter({this.leaveFrom, this.leaveTo, this.countryCd});
}

// lib/features/map/domain/choropleth.dart
class ChoroplethEntry {
  final String countryCd;
  final String countryName;
  final int count;
  final Color color; // サーバ計算値、Flutter Color に parse
}

// lib/features/incidents/domain/incident.dart
class Incident {
  final String keyCd, infoType, title, countryCd, countryName;
  final DateTime leaveDate;
  final LatLng geometry;
  final GeocodeSource geocodeSource; // mapbox / countryCentroid
  // 他 MailItem フィールド
}

enum GeocodeSource { unspecified, mapbox, countryCentroid }

// lib/features/profile/domain/user_profile.dart
class UserProfile {
  final String uid;
  final List<String> favoriteCountryCds;
  final NotificationPreference preference;
  final int fcmTokenCount;
}

class NotificationPreference {
  final bool enabled;
  final List<String> targetCountryCds;
  final List<String> infoTypes;
}
```

### 1.4 アーキテクチャ（Feature-sliced + UseCase）

```
lib/
├── main.dart                     # エントリ、Firebase init、Riverpod ProviderScope
├── app.dart                      # MaterialApp.router、テーマ、go_router config
├── core/                         # 横断的基盤
│   ├── env.dart                  # BFF_BASE_URL 等の compile-time env
│   ├── rpc/
│   │   ├── bff_client.dart       # connect-dart Client factory
│   │   ├── auth_interceptor.dart # Authorization: Bearer ヘッダ付与
│   │   └── error_mapper.dart     # ConnectException → domain error
│   ├── fcm/
│   │   ├── fcm_service.dart      # onMessage / onBackgroundMessage / onLaunch
│   │   └── notification_channel.dart # Android notification channel 初期化
│   ├── auth/
│   │   └── anonymous_auth.dart   # firebase_auth.signInAnonymously + ID Token provider
│   └── observability/
│       └── logger.dart           # dart:developer log wrapper
├── features/
│   ├── map/
│   │   ├── domain/
│   │   │   ├── map_filter.dart
│   │   │   ├── choropleth.dart
│   │   │   └── heatmap.dart
│   │   ├── application/
│   │   │   ├── choropleth_usecase.dart
│   │   │   ├── heatmap_usecase.dart
│   │   │   └── nearby_usecase.dart
│   │   └── presentation/
│   │       ├── map_screen.dart
│   │       ├── map_layer_sheet.dart
│   │       └── marker_widget.dart
│   ├── incidents/
│   │   ├── domain/incident.dart
│   │   ├── application/
│   │   │   ├── list_usecase.dart
│   │   │   ├── search_usecase.dart
│   │   │   └── get_usecase.dart
│   │   └── presentation/
│   │       ├── list_screen.dart
│   │       └── detail_screen.dart
│   ├── profile/
│   │   ├── domain/user_profile.dart
│   │   ├── application/
│   │   │   ├── get_profile_usecase.dart
│   │   │   ├── toggle_favorite_usecase.dart
│   │   │   ├── update_preference_usecase.dart
│   │   │   └── register_fcm_token_usecase.dart
│   │   └── presentation/
│   │       └── profile_screen.dart
│   ├── notifications/
│   │   ├── domain/notification_entry.dart
│   │   ├── application/notification_history_store.dart  # local (in-memory + shared_preferences)
│   │   └── presentation/notification_history_screen.dart
│   └── auth/
│       └── presentation/
│           └── splash_screen.dart           # Firebase init 中
└── gen/                                     # buf generate 出力
    └── proto/overseasmap/v1/*.dart
```

### 1.5 Connect クライアント + AuthInterceptor

```dart
// lib/core/rpc/bff_client.dart
final bffClientProvider = Provider<SafetyIncidentServiceClient>((ref) {
  final transport = ConnectTransport(
    baseUrl: Env.bffBaseUrl,
    interceptors: [ref.watch(authInterceptorProvider)],
  );
  return SafetyIncidentServiceClient(transport);
});

// lib/core/rpc/auth_interceptor.dart
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._authProvider);
  final IdTokenProvider _authProvider;

  @override
  Future<UnaryResponse<Req, Res>> intercept<Req, Res>(
    UnaryRequest<Req, Res> req,
    Function(UnaryRequest<Req, Res>) next,
  ) async {
    final token = await _authProvider.currentIdToken();
    return next(req.withHeader('Authorization', 'Bearer $token'));
  }
}
```

**Riverpod Provider 構造**:

```dart
// 認証状態は StateNotifierProvider
final anonymousAuthProvider = StreamProvider<User?>((ref) =>
    FirebaseAuth.instance.authStateChanges());

// 各 UseCase は Provider.family で引数化
final listIncidentsProvider = FutureProvider.family.autoDispose<
    (List<Incident>, String?), ListFilter>((ref, filter) async {
  final uc = ref.watch(listIncidentsUseCaseProvider);
  return uc.execute(filter);
});
```

### 1.6 FCM ライフサイクル

```
アプリ起動
  ↓
FirebaseAuth.signInAnonymously() → uid
  ↓
FirebaseMessaging.requestPermission() → iOS で Apple Push 許可 prompt
  ↓
FirebaseMessaging.getToken() → fcm_token
  ↓
BFF.RegisterFcmToken(token) → Firestore users/{uid}.fcm_tokens に ArrayUnion
  ↓
通常運用:
  - foreground (onMessage): NotificationHistoryStore に追加 + in-app banner
  - background (onBackgroundMessage): OS の notification tray に表示
  - terminated (onLaunch): タップで起動、onLaunch message を初期表示
```

onBackgroundMessage は isolate で動くため、グローバル関数として登録する必要あり。BFF 呼び出しは行わない（uid / ID Token が無い状態で安全に処理できない）。

### 1.7 ナビゲーション（go_router）

```dart
final router = GoRouter(
  initialLocation: '/map',
  routes: [
    GoRoute(path: '/splash', builder: (_, __) => SplashScreen()),
    ShellRoute(
      builder: (_, __, child) => RootScaffold(child: child),
      routes: [
        GoRoute(path: '/map', builder: (_, __) => MapScreen()),
        GoRoute(path: '/incidents', builder: (_, __) => ListScreen(),
          routes: [
            GoRoute(path: 'detail/:keyCd',
              builder: (_, s) => DetailScreen(s.pathParameters['keyCd']!)),
          ]),
        GoRoute(path: '/notifications',
          builder: (_, __) => NotificationHistoryScreen()),
        GoRoute(path: '/profile', builder: (_, __) => ProfileScreen()),
      ],
    ),
  ],
  redirect: (ctx, state) async {
    final user = await ref.read(anonymousAuthProvider.future);
    if (user == null) return '/splash';
    return null;
  },
);
```

### 1.8 地図表示（flutter_map）

- **Base tile**: OSM tile server（`https://tile.openstreetmap.org/{z}/{x}/{y}.png`、利用規約に従い attribution 表示）。将来 MapLibre tile に切替可能
- **Choropleth layer**: Natural Earth の国境 GeoJSON を assets に同梱し、BFF レスポンスの countryCd で塗り分け
- **Heatmap layer**: `flutter_map_heatmap` パッケージ、BFF レスポンスの point cloud を重ねる
- **Nearby marker**: `Marker` widget + `Cluster` パッケージで近接マーカー凝集
- **GeoJSON layer**: `flutter_map_geojson` を必要に応じて、MVP は Choropleth / Heatmap / Marker で十分

---

## 2. NFR Requirements（U-APP 固有）

親レポ U-PLT の NFR を継承。以下は U-APP 固有値。

### 2.1 パフォーマンス

| ID | 内容 | 値 |
|---|---|---|
| NFR-APP-PERF-01 | Cold start（アプリ起動から地図表示まで） | p50 < 2s、p95 < 3s |
| NFR-APP-PERF-02 | Warm navigation（tab 切替） | p95 < 500ms |
| NFR-APP-PERF-03 | 地図 tap → marker tap 応答 | < 100ms |
| NFR-APP-PERF-04 | `ListIncidents` 画面遷移（RPC 往復込） | p95 < 1s |

### 2.2 セキュリティ

| ID | 内容 |
|---|---|
| NFR-APP-SEC-01 | Firebase ID Token はメモリのみ保持（永続化しない） |
| NFR-APP-SEC-02 | 通信は HTTPS のみ（`NSAllowsArbitraryLoads=false` / `usesCleartextTraffic=false`） |
| NFR-APP-SEC-03 | 位置情報は `when_in_use`、ユーザ拒否時は Nearby 機能を disable |
| NFR-APP-SEC-04 | API Key 等の機密情報を apk / ipa に埋め込まない（Firebase config は公開されても害のない値のみ） |

### 2.3 信頼性

| ID | 内容 |
|---|---|
| NFR-APP-REL-01 | BFF 一時的 5xx は retry + exponential backoff（connect-dart の機能） |
| NFR-APP-REL-02 | 画面スケルトン表示でオフライン時も UI が崩れない |
| NFR-APP-REL-03 | Firebase 認証失敗時も splash screen でエラー表示 + リトライボタン |

### 2.4 運用性

| ID | 内容 |
|---|---|
| NFR-APP-OPS-01 | Crashlytics 等 crash reporter は MVP 後（Firebase Crashlytics を検討） |
| NFR-APP-OPS-02 | ログは `dart:developer` のみ、production ビルドは level=severe のみ |
| NFR-APP-OPS-03 | version / build number を ProfileScreen に表示し、サポート問合せ時に特定可能 |

### 2.5 テスト

| ID | 内容 |
|---|---|
| NFR-APP-TEST-01 | layered coverage（domain 95 / app 80 / presentation 60 / core 70） |
| NFR-APP-TEST-02 | Widget test で bottom nav 4 tab の遷移を検証 |
| NFR-APP-TEST-03 | Golden test は MapScreen / DetailScreen / ProfileScreen の 3 画面 |

### 2.6 拡張性

| ID | 内容 |
|---|---|
| NFR-APP-EXT-01 | Dark mode / 英語対応は将来（Theme / Locale を差し込める構造） |
| NFR-APP-EXT-02 | Web 版 Flutter は将来（`core/env.dart` の base URL 差替で対応可） |

---

## 3. NFR Design パターン

### 3.1 Interceptor Chain（親レポと対称）

```
Request → AuthInterceptor (Bearer 付与) → RetryInterceptor (5xx / Unavailable) → ErrorMapperInterceptor → BFF
```

- **AuthInterceptor**: ID Token を自動付与、token 期限切れなら Firebase が refresh
- **RetryInterceptor**: `connect-dart` 標準の retry policy（3 回、exp backoff）を `CodeUnavailable` にのみ適用
- **ErrorMapperInterceptor**: `ConnectException.code` → アプリ内 `AppError`（`unauthenticated → 再ログイン誘導`、`notFound → 該当画面で空表示`、`unavailable → retry ボタン`）

### 3.2 Feature-sliced + UseCase

各 feature は 3 層構成。UseCase は BFF RPC の薄いラッパ + 画面に必要な形への変換:

```
Widget → ref.watch(someProvider) → UseCase.execute() → BFFClient.rpc() → proto response
                                         ↓
                                    domain VO へ変換
                                         ↓
                                    Widget が表示
```

### 3.3 Cold start 3s の達成

- Flutter の `runApp` までに blocking 処理を入れない（Firebase.init は async で並列）
- 初期画面 `SplashScreen` は `const` widget で即表示
- 地図の初回描画は `MapScreen` の後ろで bfgClient 初期化（FutureBuilder + shimmer placeholder）

### 3.4 テスト戦略

| 層 | テスト種別 | fake |
|---|---|---|
| domain | 純 Dart unit test、`test` パッケージ | — |
| application | UseCase unit test、fake BFF client を Riverpod で override | `FakeBffClient`（in-memory response） |
| presentation | Widget test（`pump` + `tester`）+ Golden test（主要 3 画面） | `FakeBffClient` + `FakeFirebaseAuth` |
| core/rpc | Connect client wrapper の unit test | `MockClient`（http_mock_adapter 相当） |
| core/fcm | FCM service の手動疎通（CI では skip、Build and Test で実機確認） | — |

### 3.5 セキュリティ実装

- Android: `network_security_config.xml` で `usesCleartextTraffic=false`
- iOS: `Info.plist` の `NSAppTransportSecurity` で HTTPS 強制
- 位置情報: `permission_handler` で `when_in_use` を request、拒否時は Nearby タブに説明文表示
- ID Token: `Stream<User?>` で監視、ログアウト時に即破棄

---

## 4. 依存パッケージ（`pubspec.yaml` へ追加予定）

```yaml
dependencies:
  # State & navigation
  flutter_riverpod: ^3.0.0
  riverpod_annotation: ^3.0.0
  go_router: ^17.0.0

  # Firebase
  firebase_core: ^4.0.0
  firebase_auth: ^6.0.0
  firebase_messaging: ^16.0.0

  # Connect RPC
  connectrpc: ^1.0.0          # connectrpc.com/connect-dart
  protobuf: ^4.0.0

  # Map
  flutter_map: ^9.0.0
  flutter_map_heatmap: ^0.1.0
  latlong2: ^0.9.0

  # Utility
  permission_handler: ^12.0.0
  shared_preferences: ^3.0.0    # 通知履歴 local 永続化

dev_dependencies:
  build_runner: ^2.5.0
  riverpod_generator: ^3.0.0
  freezed: ^3.0.0               # Immutable VO
  json_serializable: ^6.9.0
  golden_toolkit: ^0.18.0
```

バージョンは `flutter create` 直後の pubspec.yaml の lower bound（Flutter 3.41 / Dart 3.11）を満たす範囲。実装時に最新安定版に合わせる。

---

## 5. トレーサビリティ

| 上位要件（親レポ User Story） | U-APP 対応 |
|---|---|
| US-01 地図閲覧 | §1.2 MapScreen / §1.8 flutter_map |
| US-02 事象詳細 | §1.2 DetailScreen |
| US-03 地図フィルタ | §1.2 MapLayerSheet + MapFilter |
| US-04 通知受信 | §1.6 FCM lifecycle + NotificationHistoryScreen |
| US-05 通知設定 | §1.2 ProfileScreen + UpdateNotificationPreference |
| US-06 お気に入り国 | §1.2 ProfileScreen + ToggleFavoriteCountry |
| US-07 匿名利用 | §1.5 anonymousAuthProvider |
| US-08 現在地付近 | §1.2 ListNearby（地図タブ内） |
| US-09 検索 | §1.2 ListScreen + SearchSafetyIncidents |
| US-10 Choropleth | §1.2 MapScreen layer sheet |
| US-11 Heatmap | §1.2 MapScreen layer sheet |
| US-12 GeoJSON | §1.2 MapScreen layer sheet（MVP は内部、UI は Choropleth/Heatmap/Markerで代用） |
| US-13 履歴閲覧 | §1.2 NotificationHistoryScreen（local only） |

---

## 6. 明示的な不採用 / 制限事項

- Web 版 Flutter: 将来対応。`core/env.dart` で差し替え可能な構造
- Dark theme: 将来対応。Material3 ThemeData は準備済
- 英語 UI: 将来対応。全 user-facing string を `lib/l10n/` に集約
- iPad タブレット: phone レイアウトの拡大表示、ネイティブ iPad UI は将来
- Offline cache: 直近取得したデータを表示するのみ、編集キャッシュなし
- certificate pinning: Cloud Run 証明書更新コストを鑑み不採用（HTTPS は強制）
- Crashlytics: 利用者プライバシー検討のため MVP 後に判断

---

## 7. 関連ドキュメント

- [`U-APP-design-plan.md`](../../plans/U-APP-design-plan.md) — Q1-Q10 の根拠
- 親レポ `overseas-safety-map`:
  - [`aidlc-docs/inception/application-design/`](https://github.com/soneda-yuya/overseas-safety-map/tree/main/aidlc-docs/inception/application-design) — 全体 Application Design、Unit 間関係
  - [`aidlc-docs/construction/U-BFF/design/`](https://github.com/soneda-yuya/overseas-safety-map/tree/main/aidlc-docs/construction/U-BFF/design) — BFF の 11 RPC 定義（本 Unit の後端）
  - [`proto/v1/safetymap.proto`](https://github.com/soneda-yuya/overseas-safety-map/blob/main/proto/v1/safetymap.proto) — Connect RPC 定義（本 Unit で dart 生成）
