# U-APP Design Plan (Minimal 合本版)

## Overview

U-APP（Flutter モバイルアプリ、**バックエンド 5 Unit 完成後の最後の Unit**）の **Minimal 合本版**（Functional Design + NFR Requirements + NFR Design を 1 ドキュメントに集約）の計画。親プロジェクト `overseas-safety-map` の `cmd/bff`（Connect RPC）を唯一の後端として、**iOS + Android** の 2 プラットフォーム向けに Flutter で実装する。

## Context — 親プロジェクトで確定済みの前提

- **BFF URL / RPC 定義**: 親レポの [`proto/v1/safetymap.proto`](https://github.com/soneda-yuya/overseas-safety-map/blob/main/proto/v1/safetymap.proto)（3 Service / 11 RPC）
- **認証**: Firebase Anonymous Auth の ID Token を `Authorization: Bearer` で送付
- **共有 Firestore collection**: `users/{uid}` は BFF がオーナー、U-APP は通知設定 / FCM token 登録を BFF 経由で書く
- **FCM**: 親レポの U-NTF が配信元、アプリ側は受信 + 表示のみ
- **NFR-BFF-PERF-01**: BFF の p95 < 500ms（U-APP 側は cold start を意識した UX 設計が必要）

## Non-Goals

- **独自 backend 実装**（U-APP は純粋なクライアント）
- **Web 版 Flutter**（将来対応、MVP は mobile のみ）
- **オフライン完全対応**（last-fetched データの表示のみ、編集キャッシュなし）
- **多言語化**（MVP は日本語のみ、英語は将来）
- **テーマ切替**（MVP は light のみ、dark は将来）
- **iPad / タブレット専用 UI**（phone レイアウトのみ）

---

## Step-by-step Checklist

- [ ] Q1〜Q10 すべて回答
- [ ] Minimal 合本版本編（`aidlc-docs/construction/U-APP/design/U-APP-design.md`）を生成
- [ ] 承認後、Infrastructure Design へ進む

---

## Questions

### Question 1 — 状態管理ライブラリ

Flutter の state management は選択肢が多い。BFF とのやりとりは少数の Connect RPC に集約され、UI 状態と async state のクリーンな分離がほしい。

**選択肢**:

A) **推奨**: **Riverpod**（v2 系、`flutter_riverpod` + `riverpod_annotation` + code gen）
  - ✅ Provider より安全（compile-time に依存グラフ検証）
  - ✅ 非同期 state（`FutureProvider` / `StreamProvider`）の扱いが綺麗、Connect RPC との相性が良い
  - ✅ Flutter コミュニティで 2026 時点のデファクト
  - ✅ `ref.watch` / `ref.listen` で再描画の粒度が細かい

B) **Bloc / flutter_bloc**
  - ✅ Event-driven で大規模なら強力
  - ⚠️ 小規模な MVP ではボイラープレートが多い

C) **Provider + ChangeNotifier**（標準的、軽量）
  - ✅ 学習コスト低
  - ⚠️ 大規模になると型安全性が弱い

D) **GetX**
  - ⚠️ 一時期流行ったが現在は推奨されない（グローバル状態と injection の混在）

[Answer]: A

### Question 2 — ナビゲーション

画面遷移 / deep link / web 将来対応 を見据えて:

**選択肢**:

A) **推奨**: **`go_router`**（公式系、URL ベース、declarative）
  - ✅ Deep link / back button / web URL 対応が簡潔
  - ✅ Flutter 公式が第一候補として推奨
  - ✅ Nested navigation（bottom nav bar 内での個別スタック）が素直

B) **`auto_route`**（コード生成ベース）
  - ✅ 型安全、ルート定義が綺麗
  - ⚠️ コード生成のセットアップ追加コスト

C) **素の Navigator 2.0 / Navigator 1.0 直接使用**
  - ⚠️ 画面数が増えると管理が手作業になり保守が辛い

[Answer]: A

### Question 3 — 地図ライブラリ

Choropleth / Heatmap / Nearby / GeoJSON を表示する地図が必要。

**選択肢**:

A) **推奨**: **`flutter_map`**（OSS、OpenStreetMap / MapLibre ベース）
  - ✅ 無料、API Key 不要（OSM tile を使う場合）
  - ✅ Choropleth / polyline / marker / popup のカスタマイズが自由
  - ✅ GeoJSON layer を追加するプラグインが豊富
  - ⚠️ Cluster やヒートマップは追加パッケージが必要

B) **`google_maps_flutter`**（公式 Google Maps）
  - ✅ 高品質、滑らか
  - ⚠️ API Key + 課金 account 必要、iOS / Android の platform-specific 設定あり
  - ⚠️ Choropleth 描画が native の paint を介するため色調節の自由度が少し狭い

C) **`mapbox_maps_flutter`**（Mapbox 公式）
  - ✅ GeoJSON layer / heatmap / choropleth が native
  - ⚠️ Mapbox account + token 必要、free tier の上限に注意
  - ⚠️ Flutter 3.41 との互換性検証が必要（新しめのリポ）

[Answer]: A

### Question 4 — Connect RPC クライアント

BFF の `proto/v1/safetymap.proto` を Dart 側でどう呼ぶか:

**選択肢**:

A) **推奨**: **`connectrpc.com/connect-dart`** + buf plugin で proto 生成
  - ✅ Connect 公式の Dart クライアント（2025+ 安定版）
  - ✅ Go サーバと同じ Connect プロトコルで通信、型安全
  - ✅ proto 定義は親レポのものを `buf.gen.yaml` で直接参照（= single source of truth）

B) **gRPC-Web + `grpc` パッケージ**
  - ⚠️ Connect プロトコルにダウングレード不可、親サーバ側の変更必要
  - ⚠️ モバイルでは overkill

C) **REST / JSON を手で組み立て**
  - ⚠️ 型安全性なし、protobuf の恩恵消失、NFR に反する

[Answer]: A

### Question 5 — Firebase Auth / FCM 統合

Firebase Anonymous Auth で uid 確保、FCM で push 受信:

**選択肢**:

A) **推奨**: **FlutterFire 一式**（`firebase_core` + `firebase_auth` + `firebase_messaging`）
  - ✅ Firebase 公式、iOS / Android 両対応
  - ✅ BFF 側の Firebase Admin SDK と同じプロジェクトで動く
  - ✅ FCM の foreground / background / terminated state handling が SDK 内で整理されている

B) Firebase 独自ラッパー（OSS 代替）
  - ⚠️ 公式が安定しているので採用理由が薄い

[Answer]: A

### Question 6 — アーキテクチャ（レイヤリング）

親レポは DDD + Layered（Domain / Application / Infrastructure / Interfaces）。Flutter でも同じ粒度か、軽量版か:

**選択肢**:

A) **推奨**: **Feature-sliced + UseCase 層あり**
  - `lib/features/{map,incidents,profile,auth}/{domain,application,presentation}.dart`
  - `lib/core/rpc/` に Connect client、`lib/core/fcm/` に FCM wrapper
  - 親レポと用語が揃う、UseCase 層で BFF RPC の合成ロジック（Choropleth → 色変換は BFF 側、App 側は表示） を入れる余地を残す

B) MVVM（`feature/screen.dart` + `feature/screen_model.dart`）
  - ⚠️ Flutter コミュニティには少ない、Riverpod と合わない

C) ミニマル（UI widget に直接 provider を書く）
  - ⚠️ フル MVP には薄すぎ、テスト困難

[Answer]: A

### Question 7 — テスト戦略

**選択肢**:

A) **推奨**: **層別カバレッジ**
  - `lib/features/*/domain/` 95%（pure Dart、Widget なし）
  - `lib/features/*/application/` 80%（UseCase、Riverpod Provider のロジック）
  - `lib/features/*/presentation/` 60%（Widget test、Golden test は重要画面のみ）
  - `lib/core/rpc/` 70%（Connect client wrapper、fake server）
  - 全体 70%+
  - 親レポの層別カバレッジ方針と同じ考え方

B) 一律 70%
C) 数値目標なし（Widget test / Golden test 中心）

[Answer]: A

### Question 8 — NFR: パフォーマンス目標

モバイルアプリの特徴的な NFR:

**選択肢**:

A) **推奨**: **Cold start 3s、Warm navigation 500ms、地図 tap 反応 100ms**
  - Flutter の TTI（Time To Interactive）ベンチマーク基準
  - BFF の p95 500ms + RTT ~100ms を含めて Cold start 3s 目標

B) Cold start 5s（余裕を持たせる）
C) 数値目標なし（「重くなければ OK」）

[Answer]: A

### Question 9 — セキュリティ / プライバシー

Flutter アプリの保持データと権限:

**選択肢**:

A) **推奨**: **最小権限 + ID Token をメモリのみ保持**
  - Firebase が自動で ID Token を refresh
  - FCM token は BFF 経由で Firestore に保存（端末側 storage にはキャッシュしない）
  - 位置情報は `when_in_use` のみ（always は Nearby 取得時も不要）
  - Android / iOS の権限 prompt を適切に表示（日本語）
  - HTTPS 通信のみ、certificate pinning は MVP 非対応（overkill）

B) certificate pinning を入れる
  - ⚠️ Cloud Run 証明書更新時にアプリ更新が必要、MVP 過剰

[Answer]: A

### Question 10 — リリース / CI

**選択肢**:

A) **推奨**: **GitHub Actions で lint + test、リリースは手動（MVP）**
  - `flutter analyze` / `flutter test` / `dart format --set-exit-if-changed`
  - ビルドは PR 毎に `flutter build apk --debug`（リリースビルドはサイズが大きいので main merge 後のみ）
  - Fastlane / Codemagic はしばらく見送り（最初の app store 公開で導入を検討）

B) 最初から Fastlane + TestFlight / Google Play Internal Testing 自動配信
  - ⚠️ MVP で時期尚早、app store account 準備など副作用が大きい

[Answer]: A

---

## 承認前の最終確認（回答確定）

- **Q1 [A]**: 状態管理 = **Riverpod v2**（`flutter_riverpod` + `riverpod_annotation` + code gen）
- **Q2 [A]**: ナビゲーション = **`go_router`**
- **Q3 [A]**: 地図 = **`flutter_map`**（OSS / OSM / MapLibre）
- **Q4 [A]**: Connect RPC = **`connectrpc.com/connect-dart`** + buf plugin（親レポの proto を single source of truth）
- **Q5 [A]**: Firebase = **FlutterFire 一式**（`firebase_core` + `firebase_auth` + `firebase_messaging`）
- **Q6 [A]**: アーキテクチャ = **Feature-sliced + UseCase 層あり**（`lib/features/{map,incidents,profile,auth}/{domain,application,presentation}/` + `lib/core/`）
- **Q7 [A]**: カバレッジ = **層別**（domain 95 / app 80 / presentation 60 / core/rpc 70 / 全体 70+）
- **Q8 [A]**: パフォーマンス = **Cold start 3s / Warm navigation 500ms / 地図 tap 反応 100ms**
- **Q9 [A]**: セキュリティ = **最小権限 + ID Token メモリのみ**（Firebase 自動 refresh、位置情報 `when_in_use`、HTTPS のみ、certificate pinning なし）
- **Q10 [A]**: リリース / CI = **GitHub Actions で lint + test、リリース手動（MVP）**

回答確定済み。以下を生成:

- `construction/U-APP/design/U-APP-design.md`（Minimal 合本版）
