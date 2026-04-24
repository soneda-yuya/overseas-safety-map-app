# U-APP Mobile Deployment

**Unit**: U-APP（Flutter モバイルアプリ）
**対象**: アプリ署名、リリースビルド、OSM tile 利用、GitHub Actions CI の運用手順
**参照**: [`U-APP-infrastructure-design-plan.md`](../../plans/U-APP-infrastructure-design-plan.md)

---

## 1. アプリ署名（Q4 [A]）

MVP は手元で署名。CI 自動配信（TestFlight / Play Internal）は見送り。

### 1.1 Android

#### 1.1.1 keystore 生成（初回のみ）

```bash
cd android/app
keytool -genkey -v \
  -keystore signing/release.keystore \
  -alias overseas-safety-map \
  -keyalg RSA -keysize 2048 \
  -validity 10000
```

**注意**: `signing/` 配下は `.gitignore` に追加。紛失すると Play Store に再アップロードできなくなるため、**安全な場所（1Password など）にバックアップ**。

#### 1.1.2 `android/key.properties`（`.gitignore` 済）

```properties
storePassword=<keystore password>
keyPassword=<key password>
keyAlias=overseas-safety-map
storeFile=signing/release.keystore
```

#### 1.1.3 `android/app/build.gradle`

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled true
            shrinkResources true
        }
    }
}
```

#### 1.1.4 リリース build

```bash
flutter build appbundle --release  # Play Store 用
flutter build apk --release         # 直接配布用
```

### 1.2 iOS

Xcode の Automatic Signing を使用:

1. Xcode で `ios/Runner.xcworkspace` を開く
2. Runner project → Target → Signing & Capabilities
3. Team: Apple Developer Team を選択
4. Bundle Identifier: `jp.go.mofa.overseas_safety_map`

#### 1.2.1 リリース build

```bash
flutter build ipa --release
```

出力: `build/ios/ipa/overseas_safety_map_app.ipa`

Apple Transporter（または Xcode Organizer）で TestFlight / App Store にアップロード。

---

## 2. `--dart-define` による dev / prod 切替（Q2 [A]）

app identity は 1 系統。BFF URL 等の env を compile-time に注入:

### 2.1 `lib/core/env.dart`

```dart
class Env {
  static const bffBaseUrl = String.fromEnvironment(
    'BFF_BASE_URL',
    defaultValue: 'https://bff-dev.example.com',
  );
  static const environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );
}
```

### 2.2 実行例

```bash
# dev
flutter run \
  --dart-define=BFF_BASE_URL=https://bff-dev.run.app \
  --dart-define=ENVIRONMENT=dev

# prod release build
flutter build appbundle --release \
  --dart-define=BFF_BASE_URL=https://bff.run.app \
  --dart-define=ENVIRONMENT=prod
```

### 2.3 `.vscode/launch.json`（開発者向け）

```json
{
  "configurations": [
    {
      "name": "Flutter (dev)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "args": [
        "--dart-define=BFF_BASE_URL=https://bff-dev.run.app",
        "--dart-define=ENVIRONMENT=dev"
      ]
    },
    {
      "name": "Flutter (prod)",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart",
      "args": [
        "--dart-define=BFF_BASE_URL=https://bff.run.app",
        "--dart-define=ENVIRONMENT=prod"
      ]
    }
  ]
}
```

---

## 3. OSM tile 利用（Q5 [A]）

### 3.1 tile URL

```dart
// lib/features/map/presentation/map_screen.dart
TileLayer(
  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'jp.go.mofa.overseas_safety_map',
  maxZoom: 19,
)
```

### 3.2 Attribution 表示

地図右下に OSM crediting を常時表示。`flutter_map` 付属の `RichAttributionWidget` を使用:

```dart
RichAttributionWidget(
  attributions: [
    TextSourceAttribution(
      'OpenStreetMap contributors',
      onTap: () => launchUrl(Uri.parse('https://www.openstreetmap.org/copyright')),
    ),
  ],
)
```

### 3.3 [Tile Usage Policy](https://operations.osmfoundation.org/policies/tiles/) 遵守事項

| 項目 | 実装 |
|---|---|
| User-Agent ヘッダ | `userAgentPackageName` で指定（FlutterMap が自動付与） |
| Referer | 自動付与 |
| 同時接続数制限 | FlutterMap デフォルトで 2 本、変更しない |
| Bulk download 禁止 | アプリは on-demand 取得のみ、OK |
| Attribution 表示 | §3.2 |
| Cache 必須 | FlutterMap デフォルトで OS レベルキャッシュあり、追加設定不要 |

### 3.4 ユーザ数増加時の移行方針

**1,000 DAU / 10,000 tile req/hour を超えたら**:
1. **Stadia Maps** の無料 tier（10k req/month）を最初の選択肢として検討
2. または **MapTiler Free**（100k req/month）
3. これら有料枠に移行した場合、`TileLayer.urlTemplate` と `RichAttributionWidget` を差し替えるだけで対応可（アプリの他の箇所は変更不要）

---

## 4. GitHub Actions CI（Q6 [A]）

### 4.1 workflow 構成

`.github/workflows/ci.yml`（本 PR では生成せず、Code Generation で作成）:

```yaml
name: CI
on:
  push: { branches: [main] }
  pull_request: { branches: [main] }

jobs:
  lint-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - uses: subosito/flutter-action@v2
        with: { flutter-version: '3.41.x', channel: 'stable' }
      - run: flutter pub get
      - run: dart format --set-exit-if-changed .
      - run: flutter analyze
      - run: flutter test --coverage
      - run: flutter build apk --debug
      # coverage 集計は codecov など、MVP では lcov 出力のみ
```

### 4.2 secrets: なし（MVP）

- Firebase config（`google-services.json` / `GoogleService-Info.plist`）は repo に commit（Q6 [A]、公開されても害のない値のみ）
- keystore / Apple API key は後日 release workflow 追加時に secrets に登録

### 4.3 リリース workflow（将来）

MVP 後に追加想定の secrets:

| Secret 名 | 用途 |
|---|---|
| `ANDROID_KEYSTORE_BASE64` | `release.keystore` の base64 |
| `ANDROID_KEYSTORE_PASSWORD` | keystore password |
| `ANDROID_KEY_ALIAS` | key alias |
| `ANDROID_KEY_PASSWORD` | key password |
| `APPLE_API_KEY_ID` | App Store Connect API Key |
| `APPLE_API_ISSUER_ID` | App Store Connect Issuer ID |
| `APPLE_API_KEY_BASE64` | `.p8` の base64 |

workflow 追加時は `.github/workflows/release.yml` を新設、トリガは `tag push` or `workflow_dispatch`。

---

## 5. リリースチェックリスト（MVP 初回 app store 申請時）

- [ ] Android keystore を 1Password にバックアップ
- [ ] `flutter build appbundle --release` でビルドエラーなし
- [ ] `flutter build ipa --release` でビルドエラーなし
- [ ] Play Console → 内部テストトラック にアップロード
- [ ] App Store Connect → TestFlight にアップロード
- [ ] Privacy Policy URL をリリース申請に記入（FCM / 位置情報の取り扱い明記）
- [ ] スクリーンショット（iPhone / Android 各サイズ）準備
- [ ] Age Rating（日本: 4+、アメリカ: 4+ 想定）
- [ ] Play Console の Data Safety / App Store Connect の Privacy: 位置情報 + デバイス識別子 + Firebase Analytics（使わないなら「収集しない」）
- [ ] **Firebase API key restriction 設定**（下記 §5.1、配布直前必須）
- [ ] **Firebase Security Rules 監査**（下記 §5.2、Firestore / Storage の rules が匿名ユーザーに緩すぎないか）
- [ ] **Firebase App Check** 導入検討（下記 §5.3、follow-up issue で別途追跡）

### 5.1 Firebase API key restriction（配布前必須）

配布前の APK / IPA には Firebase の Android / iOS API key が **必ずバイナリに含まれる**。APK / IPA を入手した第三者は鍵を抽出して `identitytoolkit.googleapis.com` で匿名 ID Token を発行 → BFF に `Authorization: Bearer <token>` で叩ける（BFF auth interceptor は Firebase プロジェクト所属の有効な token として通してしまう）。結果として認証済みユーザーになりすまして RPC spam / rate 枯渇 / Cloud Run コスト増 / CMS token 消費が可能になる。

これを防ぐために GCP Credentials で **Application restriction** を設定する。Firebase SDK は OS レベルで `X-Android-Package` / `X-Android-Cert` / bundle ID を付与するため、正規アプリ以外のリクエストは Google 側で 403 にできる。

**手順**（release 用 keystore / bundle ID が確定してから）:

```bash
# 1. Android release keystore の SHA-1 fingerprint を取得
keytool -list -v -keystore <release.jks> -alias <alias> \
  -storepass <password> -keypass <password> | grep SHA1

# 2. gcloud で Android キーに restriction を追加
#    (既存 API restriction は温存、application restriction だけ上書き)
gcloud services api-keys update projects/9675530544/locations/global/keys/<android-key-uid> \
  --allowed-application=sha1_fingerprint=<SHA1>,package_name=jp.go.mofa.overseas_safety_map.overseas_safety_map_app \
  --project=overseas-safety-map

# 3. iOS キーに bundle ID restriction を追加
gcloud services api-keys update projects/9675530544/locations/global/keys/<ios-key-uid> \
  --allowed-bundle-ids=jp.go.mofa.overseassafetymap.overseasSafetyMapApp \
  --project=overseas-safety-map
```

- Android key の uid / iOS key の uid は `gcloud services api-keys list` で取得
- `debug.keystore` の SHA-1 は **含めない**（release build には debug 署名が存在しないので不要、攻撃面を増やすだけ）
- Play Store からの App Signing を使っている場合、Google が自動再署名するので **Play Console → Setup → App signing の SHA-1** を使うこと（keytool のローカル値ではない）

### 5.2 Firebase Security Rules 監査

匿名認証を許容しているので `request.auth != null` だけでは「誰でも書ける」と同義。Firestore / Storage の rules が最低限 `request.auth.uid == <uid field>` あるいは role-based になっているか確認。

```bash
firebase firestore:rules:get --project=overseas-safety-map
firebase storage:rules:get --project=overseas-safety-map
```

User Profile 系は本アプリが BFF 経由でしか書き込まないので、**直書き禁止**（CMS / BFF の service account のみ）にするのが本筋。

### 5.3 Firebase App Check（配布後の運用で — [#12](https://github.com/soneda-yuya/overseas-safety-map-app/issues/12) で追跡）

§5.1 の restriction は「99% の自動スキャン・素人攻撃」を弾くが、motivated attacker が APK を re-sign すれば回避可能。完全な attestation は [Firebase App Check](https://firebase.google.com/docs/app-check) が必要（Play Integrity API / Apple DeviceCheck による device 正当性証明）。

- Flutter: `firebase_app_check` パッケージ + `debug` provider for dev / `playIntegrity` for Android release / `deviceCheck` (または `appAttest`) for iOS release
- BFF: Firebase Admin SDK の [App Check token 検証](https://firebase.google.com/docs/app-check/custom-resource-backend#verify-token)
- CI ビルド時に Play Integrity / App Attest の configuration を一式用意する必要があるため、リリース直後の first follow-up として扱う

---

## 6. 非スコープ

- **Play Feature Delivery / App Bundle の dynamic module**（MVP で過剰）
- **Flutter Web ビルド**（将来）
- **macOS / Linux / Windows 向けデスクトップ build**（将来）
- **iPad 専用 UI**（phone レイアウトをそのまま拡大）
- **Crashlytics / Firebase Analytics**（プライバシー観点で MVP 後に判断）
- **OTA update（Shorebird 等）**（app store ポリシーとの兼ね合いで MVP 後）

---

## 7. 関連ドキュメント

- [`U-APP-design.md`](../design/U-APP-design.md) — Functional + NFR 合本
- [`U-APP-infrastructure-design-plan.md`](../../plans/U-APP-infrastructure-design-plan.md) — Q1-Q6 根拠
- [`firebase-setup.md`](./firebase-setup.md) — Firebase プロジェクト + APNs 設定
- [OSM Tile Usage Policy](https://operations.osmfoundation.org/policies/tiles/)
- [Flutter Build and release 公式](https://docs.flutter.dev/deployment)
