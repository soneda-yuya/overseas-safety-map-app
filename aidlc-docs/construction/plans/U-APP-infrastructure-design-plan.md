# U-APP Infrastructure Design Plan

## Overview

U-APP（Flutter モバイルアプリ）の **Infrastructure Design** 計画。Flutter は server infra を持たないため本ステージは **Firebase Console 登録（iOS / Android アプリ）、APNs 証明書、アプリ署名、OSM tile 利用方針、CI secrets** などのモバイル特有のインフラ観点に集中する。

## Context — 親プロジェクト / U-APP Design で確定済み

- **BFF**: 親レポ `cmd/bff` Cloud Run Service、public URL（invoker=allUsers）
- **Firebase Project**: 親レポと共用（`overseas-safety-map` / 将来 `overseas-safety-map-test`）。U-APP 側で iOS / Android アプリを追加登録
- **FCM**: 親レポ U-NTF が Admin SDK 経由で send、U-APP は受信のみ
- **認証**: Firebase Anonymous Auth（サーバ側 enable 済み、アプリ側は Sign-in method の確認のみ）
- **CI**: GitHub Actions（lint + test、リリース手動）

---

## Step-by-step Checklist

- [ ] Q1〜Q6 すべて回答
- [ ] 成果物を生成:
  - [ ] `construction/U-APP/infrastructure-design/mobile-deployment.md`
  - [ ] `construction/U-APP/infrastructure-design/firebase-setup.md`
- [ ] 承認後、U-APP Code Generation 計画へ進む

---

## Questions

### Question 1 — Firebase プロジェクト戦略

親レポが使う Firebase プロジェクトを U-APP も共有するか、別にするか:

**選択肢**:

A) **推奨**: **本番 Firebase プロジェクト = 親レポと共用**（1 つの Firebase project に iOS / Android / Web app 全部を紐づけ）
  - ✅ `users/{uid}` collection が同じプロジェクトで共有される（U-BFF がオーナー、U-APP が書込み元として Anonymous Auth を作る）
  - ✅ FCM の送信元（U-NTF）と受信先（U-APP）が同プロジェクト
  - ✅ BFF の Firebase Admin SDK と同じ project で動く
  - ⚠️ テスト用アプリと本番アプリを両方追加するなら app identity を分ける必要がある

B) U-APP 用に別プロジェクトを作って、本番 BFF に向ける
  - ⚠️ FCM の sender / receiver が別プロジェクトになり、認証困難
  - 採用しない

[Answer]: A

### Question 2 — iOS / Android app identity

Firebase プロジェクトに登録する app identity:

**選択肢**:

A) **推奨**: **Bundle ID / applicationId を 1 系統で運用**（MVP）
  - iOS Bundle ID: `jp.go.mofa.overseas_safety_map`（`flutter create` で設定した org と一致）
  - Android applicationId: 同上
  - dev / prod の切替は `--dart-define=BFF_BASE_URL=...` で行う（Firebase 設定は同じ）
  - ⚠️ dev ビルドで本番 Firestore に書き込めてしまうが、匿名 uid なので影響最小

B) flavor で dev / prod を完全に分離（`jp.go.mofa.overseas_safety_map.dev` + `.prod`）
  - ✅ 完全分離
  - ⚠️ Android/iOS 両方で flavor 設定、Firebase に 2 アプリ登録、CI が複雑化

C) dev は完全にローカル（Flutter emulator で BFF_BASE_URL=localhost）
  - ✅ 本番 Firebase 非影響
  - ⚠️ Firebase Auth / FCM が動かないので動作確認範囲が狭い

[Answer]: A

### Question 3 — APNs（iOS プッシュ通知）

iOS で FCM を使うには APNs 証明書または auth key が必要:

**選択肢**:

A) **推奨**: **APNs Auth Key 方式（`.p8` key）**
  - ✅ Apple Developer Portal で一度生成すれば revoke まで使える
  - ✅ 証明書の更新が不要（証明書方式は年次更新）
  - 必要: Apple Developer Program への登録（$99/year）
  - Firebase Console → Cloud Messaging → APNs Authentication Key に `.p8` をアップロード

B) APNs 証明書方式（`.p12` certificate）
  - ⚠️ 年次更新が必要、運用負担

C) MVP では push 無効、Firebase Auth のみ
  - ⚠️ 通知機能の半分が欠落、US-04 達成不可

[Answer]: A

### Question 4 — アプリ署名（release ビルド）

リリースビルドの署名方針:

**選択肢**:

A) **推奨**: **MVP は手元で署名、CI で自動署名は見送り**
  - Android: ローカルで keystore を生成、`android/app/signing/` に配置（`.gitignore` 必須）、`key.properties` を local のみ
  - iOS: Xcode の Automatic Signing を使用、Apple Developer Team を指定
  - `flutter build apk --release` / `flutter build ipa` はローカル実行
  - ⚠️ keystore の紛失に注意（Android は紛失すると以降 Play Store にアップロード不可）

B) 最初から GitHub Actions で署名 + TestFlight / Play Internal 配信
  - ⚠️ secrets 設定 + Apple Developer Transporter 認証 + Android service account 作成、MVP には重い

C) debug ビルドのみ、リリースしない
  - ⚠️ 実機 FCM テストは debug でも可だが、最終的には release が必要

[Answer]: A

### Question 5 — OSM tile 利用方針

`flutter_map` で OpenStreetMap の公式 tile server を使う場合の運用:

**選択肢**:

A) **推奨**: **OSM 公式 tile + attribution 表示（MVP、小規模ユーザ）**
  - ✅ 完全無料、即稼働可
  - ✅ 地図右下に [`© OpenStreetMap contributors`](https://www.openstreetmap.org/copyright) を表示
  - ⚠️ OSM の [Tile Usage Policy](https://operations.osmfoundation.org/policies/tiles/) の制約：重い負荷をかけない、必要なら自前 proxy / cache
  - ⚠️ ユーザ 1,000 人超えたら自前 tile server or 有償 tile provider を検討

B) **Stadia Maps / MapTiler / Mapbox** の有償 tile に最初から
  - ✅ SLA あり、attribution の自由度
  - ⚠️ 月額課金発生、MVP には早い

C) 自前 tile server を GCP に建てる
  - ⚠️ MVP で明確に過剰、別アーキテクチャ案件

[Answer]: A

### Question 6 — CI / secrets 管理

GitHub Actions で必要になる secrets:

**選択肢**:

A) **推奨**: **MVP は secrets ゼロ**（lint + test + debug build のみ）
  - `flutter analyze` / `flutter test` / `flutter build apk --debug` は secrets 不要
  - Firebase config（`google-services.json` / `GoogleService-Info.plist`）は **公開されても害がない** 値のみ含まれるので repo に commit しても可（機密キーではなく project ID / app ID のような公開情報）
  - Release 時に keystore / Apple API key を secrets 追加する方針
  - ⚠️ iOS は debug build もデバイス固定（simulator は OK）、CI では macOS runner + Xcode が必要。MVP は Android APK debug build だけに絞る

B) 最初から release 用 secrets（keystore / Apple API Key）も設定
  - ⚠️ 時期尚早

[Answer]: A

---

## 承認前の最終確認（回答確定）

- **Q1 [A]**: Firebase プロジェクト = **親レポと共用**（`users/{uid}` / FCM / Auth すべて同プロジェクト）
- **Q2 [A]**: app identity = **1 系統**（`jp.go.mofa.overseas_safety_map`、dev/prod は `--dart-define`）
- **Q3 [A]**: APNs = **Auth Key 方式（`.p8`）**、Firebase Console にアップロード
- **Q4 [A]**: アプリ署名 = **MVP は手元で署名**、CI 自動配信は見送り
- **Q5 [A]**: OSM tile = **公式 tile + attribution 表示**、1,000 ユーザ超で有償 provider 検討
- **Q6 [A]**: CI secrets = **MVP はゼロ**（Android APK debug build のみ、Firebase config は commit 可）

回答確定済み。以下を生成:

- `construction/U-APP/infrastructure-design/mobile-deployment.md`（アプリ署名 / リリース / OSM / CI の運用手順）
- `construction/U-APP/infrastructure-design/firebase-setup.md`（iOS / Android アプリ登録、APNs 設定、Firebase Console 操作手順）
