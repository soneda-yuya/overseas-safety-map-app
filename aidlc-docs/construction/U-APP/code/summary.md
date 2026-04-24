# U-APP Code Generation — Summary

**Unit**: U-APP（Flutter モバイルアプリ、親プロジェクトの実装順で最後の Unit）
**対象**: `overseas_safety_map_app`（iOS + Android Flutter app）
**対応する計画**: [`U-APP-code-generation-plan.md`](../../plans/U-APP-code-generation-plan.md)
**上位設計**: [`U-APP/design/U-APP-design.md`](../design/U-APP-design.md)、[`U-APP/infrastructure-design/`](../infrastructure-design/)

---

## 1. 生成ファイル一覧

### Phase 1: Dependencies + Firebase (PR A #6)

| パス | 役割 |
|---|---|
| `pubspec.yaml` | flutter_riverpod / go_router / FlutterFire / flutter_map / connectrpc / grpc / protobuf + 開発系 |
| `lib/firebase_options.dart` | PLACEHOLDER + `flutterfire configure` 前の fail-fast ガード |
| `lib/main.dart` | Firebase init + onBackgroundMessage 登録 + ProviderScope |
| `lib/app.dart` | MaterialApp.router + routerProvider |

### Phase 2: Proto 生成 (PR A #6)

| パス | 役割 |
|---|---|
| `proto/v1/{common,pubsub,safetymap}.proto` | 親レポから手動 sync |
| `proto/google/protobuf/timestamp.proto` | well-known type 同梱 |
| `buf.yaml` / `buf.gen.yaml` | `protoc_plugin ^22.5.0` で `lib/gen/v1/` 生成 |
| `lib/gen/v1/*.dart` + `lib/gen/google/protobuf/*.dart` | 生成物（~3700 行）を commit |

### Phase 3: Core レイヤ (PR A #6)

| パス | 役割 |
|---|---|
| `lib/core/env.dart` | `--dart-define` 経由の compile-time env |
| `lib/core/observability/logger.dart` | dart:developer wrapper、stackTrace 伝播、prod は info drop |
| `lib/core/auth/anonymous_auth.dart` | FirebaseIdTokenProvider + 並行 sign-in レース防止の `_pendingSignIn` メモ化 |
| `lib/core/rpc/bff_client.dart` | ClientChannel + 3 Service client factory、baseUrl validation (scheme/host/path) |
| `lib/core/rpc/auth_interceptor.dart` | grpc ClientInterceptor で Bearer 付与 |
| `lib/core/rpc/error_mapper.dart` | GrpcError → AppError、prod で Internal/Unavailable マスク |
| `lib/core/fcm/fcm_service.dart` | foreground / tap listener、bg は top-level 関数で別登録 |
| `lib/core/fcm/notification_channel.dart` | iOS foreground presentation、Android は manifest メタデータに依存 |

### Phase 4: Domain レイヤ (PR B #7)

| パス | 役割 |
|---|---|
| `lib/features/map/domain/` | MapFilter (sentinel copyWith) / ChoroplethEntry (hex parse) / HeatmapResult |
| `lib/features/incidents/domain/` | Incident + GeocodeSource + IncidentFilter (sentinel copyWith) + IncidentPage |
| `lib/features/profile/domain/` | UserProfile + NotificationPreference |
| `lib/features/notifications/domain/` | NotificationEntry + JSON roundtrip |

VO は手書きクラス（MVP では freezed 未使用、後付け可能）。

### Phase 5: Application + proto ⇄ domain (PR B #7)

| パス | 役割 |
|---|---|
| `lib/core/rpc/mappers.dart` | proto ⇄ domain 変換の単一境界。leaveDate / geometry 未セットは FormatException |
| `lib/features/incidents/application/` | list / get / search UseCase + Provider.autoDispose.family |
| `lib/features/map/application/` | choropleth / heatmap / nearby UseCase |
| `lib/features/profile/application/profile_usecases.dart` | ProfileRemote + 4 RPC + profileProvider |
| `lib/features/notifications/application/notification_history_store.dart` | AsyncNotifier + shared_preferences、cap 100 件、read/write 両方で適用、mutation Future chain でシリアライズ |

### Phase 6: Presentation (PR B #7)

| パス | 役割 |
|---|---|
| `lib/shared/widgets/async_retry.dart` | AppError kind → 日本語メッセージの共通 retry 表示 |
| `lib/features/auth/presentation/splash_screen.dart` | initState で匿名サインインをキック、エラーは generic メッセージ + logger |
| `lib/features/map/presentation/map_screen.dart` | OSM tile + heatmap markers + attribution（scheme validated）+ centroid fallback notice |
| `lib/features/incidents/presentation/list_screen.dart` | 一覧 + infoType 色分け + context.push で詳細へ |
| `lib/features/incidents/presentation/detail_screen.dart` | 詳細 + 外部 URL open（http/https のみ許可 + SnackBar） |
| `lib/features/profile/presentation/profile_screen.dart` | 設定、preference Switch の optimistic update + failure rollback |
| `lib/features/notifications/presentation/notification_history_screen.dart` | 履歴 + clear（async + SnackBar）+ keyCd → 詳細 |

### Phase 7: Routing (PR B #7)

| パス | 役割 |
|---|---|
| `lib/core/routing/router.dart` | go_router + ShellRoute + NavigationBar 4 タブ + auth redirect + refreshListenable + deep-link 用 `from` query param（sanitize で内部パスのみ許可） |

### Phase 8: Tests (PR C)

| パス | 役割 |
|---|---|
| `test/core/rpc/error_mapper_test.dart` | gRPC code → AppErrorKind マッピング、cause 保持 |
| `test/core/rpc/bff_client_test.dart` | baseUrl validation の 4 つの reject + 2 つの accept ケース |
| `test/features/map/domain/color_test.dart` | ChoroplethEntry.fromProto の hex parse と fallback |
| `test/features/map/domain/map_filter_test.dart` | sentinel copyWith の clear 動作 |
| `test/features/incidents/domain/incident_filter_test.dart` | sentinel copyWith + 深い list 比較 |
| `test/features/notifications/domain/notification_entry_test.dart` | JSON roundtrip |
| `test/features/notifications/application/notification_history_store_test.dart` | build / add / clear / cap / 並行 / malformed エントリ drop |

### Phase 9: CI (PR C)

| パス | 役割 |
|---|---|
| `.github/workflows/ci.yml` | lint（dart format / flutter analyze）+ test + coverage summary + Android debug apk build |

### Phase 10: Docs (PR C)

| パス | 役割 |
|---|---|
| `README.md` | setup + run + test + リリース + ドキュメント導線 |
| `aidlc-docs/construction/U-APP/code/summary.md` | 本ファイル |
| `aidlc-docs/aidlc-state.md` | 進捗更新 |

---

## 2. env 一覧

| env | 供給元 | default | 用途 |
|---|---|---|---|
| `BFF_BASE_URL` | `--dart-define` | `https://bff-dev.invalid` | BFF の Cloud Run URL |
| `ENVIRONMENT` | `--dart-define` | `dev` | prod / staging / dev 判定 |

Firebase の config は `lib/firebase_options.dart`（`flutterfire configure` 生成）。Anonymous Auth / FCM は親レポ Firebase プロジェクトを共用。

---

## 3. テスト結果 (PR C 時点)

- `flutter analyze`: 緑 (No issues)
- `flutter test`: **30 passed**
- カバレッジ: 各 package lcov.info 参照（CI の step summary で集計）

---

## 4. 実機疎通

Code Generation 完了時点で、`flutter run` は placeholder Firebase config では UnsupportedError で止まる設計（fail fast）。Build and Test フェーズで `flutterfire configure` した本番 / テスト Firebase プロジェクトに接続した状態で実機 / エミュレータ疎通を行う。手順は次の runbook で提供予定。

---

## 5. 参考: 2 系統の follow-up

1. **`protoc_plugin ^25.0.0` への upgrade**: 今は `connectrpc 1.0.0` が `protobuf <5.0.0` を要求するため `^22.5.0` で pin。Dart Connect の新版が出次第 swap。
2. **Android default notification channel**: 現状 OS デフォルトにフォールバック。`AndroidManifest.xml` に `com.google.firebase.messaging.default_notification_channel_id` メタデータ + string resource を追加する follow-up。
