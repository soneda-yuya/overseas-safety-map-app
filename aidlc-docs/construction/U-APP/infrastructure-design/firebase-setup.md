# U-APP Firebase Setup

**Unit**: U-APP（Flutter モバイルアプリ）
**対象**: Firebase プロジェクト登録、iOS / Android アプリ追加、APNs 設定、Anonymous Auth の有効化確認
**参照**: [`U-APP-infrastructure-design-plan.md`](../../plans/U-APP-infrastructure-design-plan.md)

---

## 1. 前提

- 親プロジェクト `overseas-safety-map` の Firebase プロジェクトが有効化済（親レポ U-PLT / U-NTF / U-BFF で Firestore + Auth + FCM が設定済み）
- Apple Developer Program 登録済（APNs 発行に必須、$99/year）
- Google Play Console アカウント（Android リリース時に必要、MVP は debug なので後日でも可）

---

## 2. Firebase プロジェクトへのアプリ追加

親レポが使っている Firebase プロジェクト（例: `overseas-safety-map`）に **iOS と Android の 2 アプリ** を登録する。Q1 [A] の共用方針により、テスト用 Firebase プロジェクト（例: `overseas-safety-map-test`）にも同様に登録する。

### 2.1 Android app 追加

Firebase Console → プロジェクト設定 → アプリ → Android を追加:

| 項目 | 値 |
|---|---|
| Android パッケージ名 | `jp.go.mofa.overseas_safety_map` |
| アプリのニックネーム | Overseas Safety Map (Android) |
| デバッグ用の署名証明書 SHA-1 | (任意、Google Sign-in を使わないなら不要) |

ダウンロード: `google-services.json`
配置先: `android/app/google-services.json`（`.gitignore` 対象ではない、Q6 [A] で commit 可）

### 2.2 iOS app 追加

Firebase Console → iOS を追加:

| 項目 | 値 |
|---|---|
| Apple バンドル ID | `jp.go.mofa.overseas_safety_map` |
| アプリのニックネーム | Overseas Safety Map (iOS) |
| App Store ID | (リリース後に追加、MVP では空) |

ダウンロード: `GoogleService-Info.plist`
配置先: `ios/Runner/GoogleService-Info.plist`（Xcode で Target → Runner に追加、`.gitignore` 対象ではない）

### 2.3 `flutterfire configure` による自動化（推奨）

手動配置の代わりに FlutterFire CLI を使うと、`firebase_options.dart` が生成され、配置が自動化される:

```bash
dart pub global activate flutterfire_cli
flutterfire configure \
  --project=overseas-safety-map \
  --platforms=ios,android \
  --ios-bundle-id=jp.go.mofa.overseas_safety_map \
  --android-package-name=jp.go.mofa.overseas_safety_map
```

生成物:
- `lib/firebase_options.dart`（platform ごとの options）
- `ios/Runner/GoogleService-Info.plist`
- `android/app/google-services.json`

`main.dart` から `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)` を呼ぶ。

---

## 3. APNs Auth Key（iOS push 通知）

Q3 [A] で Auth Key 方式を採用。手順:

### 3.1 Apple Developer Portal で Key を作成

1. [Apple Developer → Certificates, Identifiers & Profiles → Keys](https://developer.apple.com/account/resources/authkeys/list)
2. `+` ボタンで新規 Key
3. Key Name: `Overseas Safety Map APNs`
4. Capabilities: **Apple Push Notifications service (APNs)** にチェック
5. Continue → Register → Download（**`.p8` ファイルは 1 回しかダウンロードできない、紛失時は revoke して再作成**）
6. Key ID（10 文字の英数字）と Team ID（10 文字）をメモ

### 3.2 Firebase Console にアップロード

1. Firebase Console → プロジェクト設定 → Cloud Messaging
2. Apple アプリの設定 → **APNs Authentication Key** → アップロード
3. `.p8` + Key ID + Team ID を入力

### 3.3 iOS app 側の設定

`ios/Runner/Info.plist`:
```xml
<key>UIBackgroundModes</key>
<array>
  <string>fetch</string>
  <string>remote-notification</string>
</array>
```

Xcode → Runner → Signing & Capabilities → **Push Notifications** と **Background Modes**（Remote notifications）を追加。

Apple Developer Portal 側 App ID に **Push Notifications** capability を有効化。

---

## 4. Android push 通知設定

Android は FCM token で直接送信できるため、追加証明書は不要。

### 4.1 `AndroidManifest.xml`（`android/app/src/main/AndroidManifest.xml`）

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.POST_NOTIFICATIONS"/> <!-- Android 13+ -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
```

### 4.2 Notification Channel（`lib/core/fcm/notification_channel.dart`）

Android 8.0+ で必須。アプリ起動時に 1 度だけ作成:

```dart
const channel = AndroidNotificationChannel(
  'safety_alerts',                        // id
  '海外安全情報アラート',                    // name
  description: '外務省から配信される安全情報通知',
  importance: Importance.high,
);
```

---

## 5. Anonymous Authentication の有効化確認

Firebase Console → Authentication → Sign-in method:

- **Anonymous**: 有効（親レポ U-BFF / U-NTF が既に前提として動いているため、設定済のはず）

無効の場合:
1. Anonymous 行の `Enable` トグル
2. Save

---

## 6. Firestore Security Rules（親レポ側の話）

U-APP は **BFF 経由でしか Firestore を触らない**（Q4 Design [A] + U-BFF Q4 [A]）ので、Rules 設定は親レポの責務。Flutter アプリに直接 Firestore SDK を組み込まない方針。

ただし念のため親レポ側で以下が設定されていることを確認:

```
// users/{uid} は自分自身のみ read/write 可、BFF の Runtime SA は IAM 経由で bypass
match /users/{uid} {
  allow read, write: if request.auth.uid == uid;
}
```

---

## 7. チェックリスト

Flutter アプリ実装を始める前に確認:

- [ ] Firebase Console に Android アプリ (`jp.go.mofa.overseas_safety_map`) 追加済
- [ ] Firebase Console に iOS アプリ (`jp.go.mofa.overseas_safety_map`) 追加済
- [ ] `flutterfire configure` 実行済（または手動で config ファイル配置）
- [ ] APNs Auth Key (`.p8`) を Firebase Console にアップロード済
- [ ] Apple Developer Portal の App ID で Push Notifications capability 有効化
- [ ] Xcode Signing & Capabilities で Push Notifications + Background Modes 追加済
- [ ] Firebase Console で Anonymous Authentication が有効
- [ ] `google-services.json` / `GoogleService-Info.plist` / `firebase_options.dart` が repo に commit 済（Q6 [A]）
- [ ] （dev 環境が別 Firebase project の場合）テスト用プロジェクトにも同様の設定

---

## 8. 関連ドキュメント

- [`U-APP-design.md §1.6`](../design/U-APP-design.md) — FCM ライフサイクル
- [`U-APP-infrastructure-design-plan.md`](../../plans/U-APP-infrastructure-design-plan.md) — Q1-Q6 根拠
- [`mobile-deployment.md`](./mobile-deployment.md) — アプリ署名 / リリース / CI
- [Firebase for Flutter 公式](https://firebase.google.com/docs/flutter/setup)
