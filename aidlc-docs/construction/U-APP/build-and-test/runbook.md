# U-APP Build and Test — Runbook

**Status**: 🟡 **Template only** — 実 Firebase / 実 BFF / iOS+Android 実機疎通は未実施。Flutter 実機（iOS 1 台以上 + Android 1 台以上）と親レポ BFF の `BFF_BASE_URL` が揃い次第、本ランブックに沿って実行し、結果を §6 に記録する。

**前提**:
- U-APP Code Generation PR A (#6) / PR B (#7) / PR C (#8) が main に取り込まれていること
- 親レポ `overseas-safety-map` の **U-BFF が Cloud Run 上で稼働**していること（少なくとも dev 環境で）
- 親レポ **U-ING / U-CSS** が走っていて CMS に `safety-incident` アイテムが数十件以上書き込まれている
- Firebase プロジェクト（親レポと共用 or テスト専用）で **Anonymous Authentication が Enabled**
- Apple Developer Program 登録済（iOS / APNs Auth Key のため、$99/year）
- ローカルに Flutter 3.41.x + Xcode 15+ + Android SDK API 34+ + Android emulator が用意済

---

## 1. 目的

`overseas_safety_map_app` の Flutter アプリが **起動 → 匿名サインイン → BFF 疎通 → 地図/一覧/通知/設定の 4 タブ動作** のパイプラインを正しく動かすことを確認する:

1. `flutterfire configure` で生成した `firebase_options.dart` で `Firebase.initializeApp` が成功する
2. SplashScreen が **匿名サインイン** を kick し、auth state 変化で `/map` にリダイレクトされる
3. 地図タブが OSM tile を表示し、BFF から取得した heatmap の pin が描画される
4. 一覧タブが `ListSafetyIncidents` RPC のページを表示する
5. 詳細画面が `GetSafetyIncident` RPC の本文 + 「外務省サイトで全文を見る」ボタンを表示
6. 設定タブで **通知 Switch をトグル**し、Firestore `users/{uid}.notification_preference.enabled` が変化することを確認（BFF 経由）
7. **FCM token が `RegisterFcmToken` RPC 経由で Firestore `users/{uid}.fcm_tokens` に登録**される（PR A で main.dart に background handler は登録済み、PR B 以降で foreground token フローが走る）
8. 親レポ U-NTF からの **FCM push が iOS / Android 実機に届き**、foreground / background / terminated の 3 状態で通知が表示される
9. 通知タップで **deep link** が `/incidents/detail/:keyCd` に飛び、DetailScreen が表示される（`from` query param の sanitise が効いていること）
10. ErrorInterceptor（サーバ側）の prod mask が効いている（`ENVIRONMENT=prod` 相当で Internal/Unavailable のメッセージがマスクされる）
11. SIGTERM / アプリ終了時に `bffClientProvider` の onDispose が走り、gRPC ChannelShutdown がクリーンに完了する

---

## 2. 事前準備（実行者が用意するもの）

### 2.1 Firebase セットアップ

| 項目 | 取得方法 |
|---|---|
| Firebase プロジェクト | 親レポと共用 or テスト専用（`overseas-safety-map-test` など）。Anonymous Authentication を有効化 |
| iOS / Android アプリ追加 | `flutterfire configure --project=... --platforms=ios,android --ios-bundle-id=jp.go.mofa.overseas_safety_map.overseas_safety_map_app --android-package-name=jp.go.mofa.overseas_safety_map.overseas_safety_map_app` で `lib/firebase_options.dart` を実値に置換 |
| APNs Auth Key (.p8) | Apple Developer Portal で生成し、Firebase Console → Cloud Messaging → APNs Authentication Key にアップロード（詳細は [`firebase-setup.md`](../infrastructure-design/firebase-setup.md) §3） |

> ⚠️ `lib/firebase_options.dart` の `PLACEHOLDER_` 値のまま実機起動すると `DefaultFirebaseOptions.currentPlatform` が `UnsupportedError` を throw する（PR A の fail-fast ガード）。必ず `flutterfire configure` を実行すること。

### 2.2 親レポ BFF URL

```bash
# 変数名は以降の --dart-define=BFF_BASE_URL=... にそのまま渡すので統一
export BFF_BASE_URL=$(gcloud run services describe bff \
  --region=asia-northeast1 \
  --project=overseas-safety-map-test \
  --format='value(status.url)')
echo "$BFF_BASE_URL"
# 例: https://bff-xxxxxxxxxx-an.a.run.app
```

### 2.3 テストデータ

- 親レポ **U-ING** を最低 1 Run 実行し、CMS に `spot_info` / `warning` / `danger` など複数 info_type × 複数国の item を入れる
- **Firestore `users`** は空で OK（初回 `GetProfile` で BFF が lazy create）
- **FCM token 検証用**: 親レポ U-NTF 側で `safety-incident.new-arrival` Pub/Sub トピックに publish するテスト用スクリプトを用意（親レポの `U-NTF/build-and-test/runbook.md` §3.1 を参照）

### 2.4 ローカル環境

```bash
cd /path/to/overseas-safety-map-app
git checkout main && git pull --ff-only
flutter pub get

# Firebase config
dart pub global activate flutterfire_cli
flutterfire configure \
  --project=overseas-safety-map-test \
  --platforms=ios,android \
  --ios-bundle-id=jp.go.mofa.overseas_safety_map.overseas_safety_map_app \
  --android-package-name=jp.go.mofa.overseas_safety_map.overseas_safety_map_app
```

---

## 3. 実行手順

### 3.1 Android emulator での起動確認（最速経路）

```bash
# 利用可能な Android emulator を確認 (事前に Android Studio で AVD を作成しておくこと)
flutter emulators
# 例: Pixel_7_API_34 • android • Pixel 7 API 34

# 名前指定で起動
flutter emulators --launch Pixel_7_API_34
# もしくは: emulator -avd Pixel_7_API_34 &

# 起動後の Android device id を確認
flutter devices
# 例: emulator-5554 • android-x64 • ...

# device id を指定して run
flutter run -d emulator-5554 \
  --dart-define=BFF_BASE_URL="$BFF_BASE_URL" \
  --dart-define=ENVIRONMENT=dev
```

**期待動作**:
- [ ] Splash が 1-2 秒表示されて地図タブに遷移
- [ ] 地図タブで OSM タイル + heatmap の赤ドット表示（BFF から取れれば）
- [ ] bottom nav 4 タブ切替
- [ ] 一覧タブで `ListSafetyIncidents` のレスポンスがリスト表示
- [ ] 一覧 → 詳細 → 戻る、正常に pop できる
- [ ] 設定タブで UID + Switch + お気に入り国などが表示、Switch を on/off で Firestore が更新（Console 目視確認）

### 3.2 iOS 実機での起動確認

```bash
# iPhone を USB で接続、Xcode で signing を Team 設定済み
flutter devices          # 実機の id を確認
flutter run -d "${IPHONE_ID}" \
  --dart-define=BFF_BASE_URL="$BFF_BASE_URL" \
  --dart-define=ENVIRONMENT=dev
```

**期待動作**:
- [ ] 初回起動で Apple Push 許可ダイアログが出る（`FcmService.start()` の request permission が働くのは PR B 以降、実装は present しているがトリガが不足していれば PR B 改修）
- [ ] Splash → 地図 → bottom nav 切替
- [ ] 設定タブで UID 表示 + 各種 ListTile
- [ ] **APNs token → FCM token** が Firestore `users/{uid}.fcm_tokens` に登録される（Console 目視）

### 3.3 BFF 疎通の詳細検証

Dart DevTools の **Network** タブ、または Flutter の `dart:developer` log (prefix `rpc.auth` / `rpc.bff.dispose`) で以下を確認:

- [ ] Authorization ヘッダに `Bearer <id_token>` が付与されている
- [ ] サーバ側の BFF Cloud Run ログで `auth=uid-xxxxx` が記録
- [ ] 5 RPC (`ListSafetyIncidents` / `GetSafetyIncident` / `SearchSafetyIncidents` / `ListNearby` / `GetSafetyIncidentsAsGeoJSON`) + 2 RPC (`GetChoropleth` / `GetHeatmap`) + 4 RPC (`GetProfile` / `ToggleFavoriteCountry` / `UpdateNotificationPreference` / `RegisterFcmToken`) が期待どおりの code で返る

### 3.4 FCM 疎通

U-NTF runbook §3.1 のスクリプトで Pub/Sub に publish、アプリ側の 3 状態を検証:

| 状態 | 期待動作 |
|---|---|
| **Foreground**（アプリが画面最前面） | `FirebaseMessaging.onMessage` で受信、iOS は `setForegroundNotificationPresentationOptions` で heads-up、Android は OS default channel で notification tray に表示 |
| **Background**（ホーム画面など） | `handleBackgroundMessage` が別 isolate で走る、システム通知バナー表示 |
| **Terminated**（アプリ停止状態） | システム通知 → **タップ**で `onMessageOpenedApp` 経由で起動し、deep link (`/incidents/detail/:keyCd`) に飛ぶ |

**deep link 確認**:
- [ ] 通知 payload の `data.keyCd` が URL path に入ること
- [ ] auth 未完了時は `/splash?from=/incidents/detail/:keyCd` に飛び、サインイン完了後に目的地に到達すること

### 3.5 エラーケース

#### Firebase config が placeholder のまま実行

```bash
# flutterfire configure を飛ばして flutter run
flutter run --dart-define=BFF_BASE_URL="$BFF_BASE_URL"
```

- [ ] コンソールに `UnsupportedError: firebase_options.dart still contains PR A placeholder values. Run 'flutterfire configure' ...` が出て起動失敗（fail-fast ガードが効いている）

#### BFF_BASE_URL にパス付き URL

```bash
flutter run --dart-define=BFF_BASE_URL=https://bff.run.app/api
```

- [ ] `BFF_BASE_URL must be scheme+host(+port) only; path / query / fragment are not supported (grpc ClientChannel ignores them).` エラーで起動失敗

#### BFF_BASE_URL が unreachable

```bash
flutter run --dart-define=BFF_BASE_URL=https://bff-does-not-exist.example.com
```

- [ ] 起動は成功するが、各 RPC が `AppError(AppErrorKind.unavailable)` → `AsyncRetryBody` の "サーバに接続できませんでした" 表示
- [ ] 再試行ボタンで provider invalidate、再 fetch

#### 認証無効（ID Token が取れない）

Firebase の Anonymous Auth を Disable した状態で起動:

- [ ] SplashScreen で `anonymous sign-in failed` が `auth.splash` logger に出て、generic error message + 再試行ボタンが出る

### 3.6 Production build + app store 配信（MVP 初回時）

```bash
# Android App Bundle
flutter build appbundle --release \
  --dart-define=BFF_BASE_URL=https://bff.run.app \
  --dart-define=ENVIRONMENT=prod

# iOS IPA (Xcode Archive 経由が推奨)
flutter build ipa --release \
  --dart-define=BFF_BASE_URL=https://bff.run.app \
  --dart-define=ENVIRONMENT=prod
```

以降は `mobile-deployment.md` §5 の「MVP 初回 app store 申請時チェックリスト」を参照。

---

## 4. トラブルシューティング

### 4.1 `UnsupportedError: firebase_options.dart still contains PR A placeholder values`

**原因**: `flutterfire configure` を未実行。
**対処**: §2.4 の手順で実行し、`lib/firebase_options.dart` を正しい値に置き換える。

### 4.2 iOS 実機で FCM token が取れない

- Apple Developer の App ID に **Push Notifications capability** が有効化されていない → [`firebase-setup.md`](../infrastructure-design/firebase-setup.md) §3.3
- APNs Auth Key (`.p8`) が Firebase Console にアップロードされていない
- Xcode の Signing & Capabilities で **Push Notifications** と **Background Modes: Remote notifications** が両方チェックされていない

### 4.3 Android で通知が foreground 時にしか出ない

- `AndroidManifest.xml` に `com.google.firebase.messaging.default_notification_channel_id` メタデータが無い（follow-up で実装予定）
- Android 13+ で `POST_NOTIFICATIONS` 権限を未許可 → `permission_handler` で request

### 4.4 `flutter run` で build は通るが連続クラッシュする

- gRPC ChannelShutdown ログに shutdown error が出ていないか確認（`rpc.bff.dispose` logger）
- `BFF_BASE_URL` の scheme が http/https 以外 → ArgumentError
- Firebase APNs Auth Key が期限切れ（Apple Developer で確認）

### 4.5 通知タップで DetailScreen に飛ばない

- 通知 payload の `data` に `keyCd` が含まれているか（親レポ U-NTF の `buildFCMMessage` を確認）
- `router.dart` の `from` query param が `%2F` エンコード後に decode されているか
- `context.push('/incidents/detail/KEY')` の path パラメータにキーが渡っているか

---

## 5. 観測ポイント

運用時に注視する項目:

| 観測対象 | 見る場所 | 期待値 |
|---|---|---|
| Cold start 時間 (TTI) | Flutter DevTools Performance | p50 < 2s、p95 < 3s (NFR-APP-PERF-01) |
| タブ切替 | 目視 | p95 < 500ms (NFR-APP-PERF-02) |
| 地図タップ → pin tap | 目視 | < 100ms (NFR-APP-PERF-03) |
| ListIncidents 画面遷移 (RPC 含) | Flutter DevTools Network | p95 < 1s (NFR-APP-PERF-04) |
| AppError 発生率 | `dart:developer` log の error level | 通常時 < 1%、spike 時は BFF / Firebase status を確認 |
| FCM token 登録率 | Firestore `users` で `fcm_tokens` が空でない比率 | 95%+（許可拒否を除く） |
| 通知 delivery 率 | 親レポ U-NTF の `app.notifier.fcm.sent{status=success}` メトリック | 全体の 95%+ |

---

## 6. 実行記録

> 実パイプラインで実行する都度、ここに追記する。

### 6.1 [日付未定] ローカル初回実行（Android emulator + test Firebase）

**実行者**: TBD
**Firebase project**: TBD
**BFF URL**: TBD
**起動確認**: TBD（splash → 地図表示まで）
**bottom nav 4 タブ切替**: TBD
**一覧 → 詳細 → 戻る**: TBD
**設定タブ: 通知 Switch トグル → Firestore 反映**: TBD
**AppError 表示確認**: TBD

### 6.2 [日付未定] iOS 実機初回実行

**実行者**: TBD
**実機モデル**: TBD
**Apple Push 許可**: TBD
**FCM token 登録確認**: TBD
**foreground 通知**: TBD
**background 通知**: TBD
**terminated 通知 + タップで deep link**: TBD

### 6.3 [日付未定] Android 実機初回実行

**実行者**: TBD
**実機モデル / Android バージョン**: TBD
**POST_NOTIFICATIONS 許可 (Android 13+)**: TBD
**FCM token 登録確認**: TBD
**3 状態通知受信**: TBD

### 6.4 [日付未定] BFF 本番環境疎通

**実行者**: TBD
**BFF URL (prod)**: TBD
**11 RPC 全通過**: TBD
**通知配信テスト (U-NTF → U-APP)**: TBD
**deep link 正常**: TBD

---

## 7. 関連ドキュメント

- [`U-APP/design/U-APP-design.md`](../design/U-APP-design.md) — Functional + NFR 合本
- [`U-APP/infrastructure-design/firebase-setup.md`](../infrastructure-design/firebase-setup.md) — Firebase / APNs / Android 設定
- [`U-APP/infrastructure-design/mobile-deployment.md`](../infrastructure-design/mobile-deployment.md) — 署名 / リリース / OSM / CI
- [`U-APP/code/summary.md`](../code/summary.md) — Code Generation 成果物 + follow-up
- 親レポ `overseas-safety-map`:
  - [`aidlc-docs/construction/U-BFF/build-and-test/runbook.md`](https://github.com/soneda-yuya/overseas-safety-map/blob/main/aidlc-docs/construction/U-BFF/build-and-test/runbook.md) — BFF 側疎通
  - [`aidlc-docs/construction/U-NTF/build-and-test/runbook.md`](https://github.com/soneda-yuya/overseas-safety-map/blob/main/aidlc-docs/construction/U-NTF/build-and-test/runbook.md) — 通知配信疎通
