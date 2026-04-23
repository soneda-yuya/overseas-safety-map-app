# U-APP Code Generation Plan

## Overview

U-APP（Flutter モバイルアプリ、**全 Unit 実装の最後**）の Code Generation 計画。[`U-APP-design.md`](../U-APP/design/U-APP-design.md) と [`U-APP/infrastructure-design/`](../U-APP/infrastructure-design/) に基づいて実装する。

## Goals

- BFF（親レポ `cmd/bff`）を後端とした Flutter iOS / Android モバイルアプリを完成させる
- 4 タブ + Detail 画面、3 Service / 11 RPC の全画面 MVP を提供
- Firebase Anonymous Auth + FCM（foreground / background / terminated）
- 層別カバレッジ（domain 95 / app 80 / presentation 60 / core/rpc 70 / 全体 70+）
- 実機疎通は Build and Test で実施、Code Gen 完了時点でアプリは起動してホーム画面が表示される

## Non-Goals

- バックエンド実装（親レポで完了済）
- Web 版 Flutter（将来）
- 多言語化（MVP は日本語）
- Dark theme（MVP は light）
- Crashlytics / Analytics

---

## Context — 既に存在するもの

- **Flutter scaffold**: `flutter create` 直後の `lib/main.dart`（Counter App）
- **AI-DLC ルール**: 親レポからコピー済み
- **親レポの proto**: `proto/v1/safetymap.proto`（`git submodule` または直接参照で再利用）
- **環境**: Flutter 3.41.6 / Dart 3.11.4

---

## Step-by-step Checklist

### Phase 1: Dependencies + Firebase 初期化

- [ ] `pubspec.yaml` に §4 (U-APP Design) の依存パッケージ追加、`flutter pub get`
- [ ] `flutterfire configure` 実行 → `lib/firebase_options.dart` + platform config ファイル生成
- [ ] `lib/main.dart` を Firebase init + ProviderScope に書き換え

### Phase 2: Proto 生成（connect-dart）

- [ ] 親レポの `proto/` を本レポで参照する方式を確立:
  - Option 1: `git submodule add https://github.com/soneda-yuya/overseas-safety-map` → `submodule/overseas-safety-map/proto`
  - Option 2: 本レポにコピー（`proto/v1/` を複製し、親レポ更新時は手動で sync）
  - **決定は Q B で**
- [ ] `buf.yaml` + `buf.gen.yaml` を本レポに配置、Dart 向けに設定
- [ ] `buf generate` で `lib/gen/proto/overseasmap/v1/*.dart` を生成
- [ ] 生成物を commit

### Phase 3: Core レイヤ

- [ ] `lib/core/env.dart` — compile-time env (BFF_BASE_URL / ENVIRONMENT)
- [ ] `lib/core/observability/logger.dart` — dart:developer wrapper
- [ ] `lib/core/auth/anonymous_auth.dart` — FirebaseAuth.signInAnonymously + IdTokenProvider
- [ ] `lib/core/rpc/bff_client.dart` — ConnectTransport + 3 Service client provider
- [ ] `lib/core/rpc/auth_interceptor.dart` — Bearer ヘッダ付与
- [ ] `lib/core/rpc/error_mapper.dart` — ConnectException → AppError
- [ ] `lib/core/fcm/fcm_service.dart` — onMessage / onBackgroundMessage 登録
- [ ] `lib/core/fcm/notification_channel.dart` — Android channel 初期化

### Phase 4: Domain レイヤ

- [ ] `lib/core/domain/point.dart` — LatLng VO
- [ ] `lib/features/map/domain/` — MapFilter / Choropleth / Heatmap VO
- [ ] `lib/features/incidents/domain/` — Incident VO + GeocodeSource enum
- [ ] `lib/features/profile/domain/` — UserProfile / NotificationPreference VO
- [ ] `lib/features/notifications/domain/` — NotificationEntry VO
- [ ] 各 VO の freezed 生成

### Phase 5: Application レイヤ（UseCases + Riverpod Providers）

- [ ] `lib/features/map/application/` — ChoroplethUseCase / HeatmapUseCase / NearbyUseCase
- [ ] `lib/features/incidents/application/` — ListUseCase / SearchUseCase / GetUseCase / GeoJSONUseCase
- [ ] `lib/features/profile/application/` — GetProfileUseCase / ToggleFavoriteCountryUseCase / UpdateNotificationPreferenceUseCase / RegisterFcmTokenUseCase
- [ ] `lib/features/notifications/application/notification_history_store.dart` — shared_preferences で local 履歴
- [ ] Riverpod Provider 各 UseCase に対して FutureProvider.autoDispose 作成

### Phase 6: Presentation レイヤ

- [ ] `lib/features/auth/presentation/splash_screen.dart` — Firebase init 中
- [ ] `lib/app.dart` — MaterialApp.router、テーマ、go_router 結線
- [ ] `lib/features/map/presentation/map_screen.dart` + `map_layer_sheet.dart`
- [ ] `lib/features/incidents/presentation/list_screen.dart` + `detail_screen.dart`
- [ ] `lib/features/profile/presentation/profile_screen.dart`
- [ ] `lib/features/notifications/presentation/notification_history_screen.dart`
- [ ] 共通 widget (`lib/shared/widgets/`): LoadingIndicator / ErrorRetry / SafetyIncidentListItem 等

### Phase 7: Routing

- [ ] `lib/core/routing/router.dart` — go_router + ShellRoute + redirect by auth
- [ ] bottom_navigation_bar を ShellRoute 内で

### Phase 8: Tests

- [ ] `test/core/rpc/` — bff_client + auth_interceptor + error_mapper unit test
- [ ] `test/features/*/domain/` — VO test
- [ ] `test/features/*/application/` — UseCase test（fake BFF client で Riverpod override）
- [ ] `test/features/*/presentation/` — Widget test（pumpWidget + tester）
- [ ] `test/golden/` — MapScreen / DetailScreen / ProfileScreen の Golden test
- [ ] test helper: `test/helpers/{fake_bff_client,fake_firebase_auth,provider_scope}.dart`

### Phase 9: CI

- [ ] `.github/workflows/ci.yml` — lint + test + Android debug build
- [ ] `.gitignore` 更新（keystore / .env / build/ など）

### Phase 10: Docs

- [ ] `README.md` 更新（setup + run + test + 依存パッケージ）
- [ ] `aidlc-docs/construction/U-APP/code/summary.md` 新規
- [ ] `aidlc-docs/aidlc-state.md` 更新

---

## 設計上の要判断事項

### Question A — PR 分割

Flutter は各層が大きいため 1 PR にまとめると diff が膨らみレビュー困難。

**選択肢**:

A) **推奨**: **3 PR 分割**
  - **PR A**: Phase 1-3（依存追加 + Firebase 初期化 + proto 生成 + core レイヤ）— ビルドが通る最小セット
  - **PR B**: Phase 4-7（domain + application + presentation + routing）— UI 含めた機能実装
  - **PR C**: Phase 8-10（tests + CI + docs）— 品質担保と出荷準備
  - 各 PR 独立してレビュー可能、build が常に通る

B) 2 PR 分割（Phase 1-5 / Phase 6-10）
  - ⚠️ PR A で UI 含まず core+app のみ、PR B が巨大（UI + test + CI + docs）

C) 1 PR にまとめる
  - ⚠️ diff 4000+ 行、レビュー現実的でない

[Answer]: A

### Question B — 親レポ proto の参照方式

**選択肢**:

A) **推奨**: **本レポに proto をコピー**（`proto/v1/*.proto` を本レポの同ディレクトリに複製、親レポ更新時は手動で sync）
  - ✅ 本レポ単独で clone + build が完結
  - ✅ buf 設定を本レポで独立管理できる
  - ⚠️ proto 変更時に両レポで更新が必要（ただし頻繁には変わらない）

B) `git submodule` で親レポを追加
  - ✅ 単一 source of truth
  - ⚠️ submodule の初期化コストと、CI での fetch 設定が必要
  - ⚠️ Flutter アプリで submodule を扱うケースが稀で混乱を招く可能性

C) 親レポに公開する buf module（`buf.build`）を使って参照
  - ⚠️ buf.build のアカウント / 公開 module 設定が必要
  - ⚠️ MVP には時期尚早

[Answer]: A

### Question C — Connect Dart / buf plugin バージョン

**選択肢**:

A) **推奨**: **`connectrpc: ^1.0.0` + `protoc_plugin: ^25.0.0` + `buf.gen.yaml` で Dart 用 plugin 指定**
  - ✅ 2026 時点の安定版
  - ✅ 親レポ Go 側の `connectrpc.com/connect v1.19.x` と互換
  - proto の Code Gen plugin は Dart 公式
  - **ユーザー指定**: `protoc_plugin` は `^25.0.0`（過去の `^22.x` から上げる）

B) gRPC-Web + grpc-dart
  - ⚠️ Connect プロトコル使えず、親サーバ側で追加対応が必要

[Answer]: A（protoc_plugin は ^25.0.0 固定）

### Question D — Golden Test のスコープ

**選択肢**:

A) **推奨**: **Golden test は主要 3 画面のみ**（Q7 [A] のとおり）
  - MapScreen / DetailScreen / ProfileScreen
  - `golden_toolkit` パッケージ使用
  - CI で macOS/Linux font 差異を避けるため `loadAppFonts()` を common helper に

B) 全画面（5+ screens）
  - ⚠️ golden 更新コストが増大、MVP には過剰

C) Golden test なし、Widget test のみ
  - ⚠️ UI の regression 検出力が弱い

[Answer]: A

### Question E — Riverpod code-generation (`riverpod_generator`)

**選択肢**:

A) **推奨**: **Code generation 使用**（`riverpod_annotation` + `build_runner` + `riverpod_generator`）
  - ✅ Provider 定義が簡潔（関数 + `@riverpod` アノテーション）
  - ✅ 型安全、family Provider の型推論が綺麗
  - ⚠️ build_runner の起動時間（初回 30s 程度）
  - ⚠️ 生成物を commit する必要（`.g.dart`）

B) Manual Provider 定義（`Provider<T>((ref) => ...)` 形式）
  - ✅ build_runner 不要、即コンパイル
  - ⚠️ boilerplate 多め、特に family + autoDispose 組合せ

[Answer]: A

### Question F — カバレッジ計測と報告

**選択肢**:

A) **推奨**: **lcov 出力のみ**（codecov 等の外部サービス連携は見送り）
  - `flutter test --coverage` で `coverage/lcov.info` 生成
  - PR コメントは lcov-reporter-action 等で OK
  - 親レポと同じ「数値目標あり、社内報告のみ」の方針

B) codecov / Coveralls 連携
  - ⚠️ 外部サービス設定 + secrets、MVP には早い

[Answer]: A

---

## 承認前の最終確認（回答確定）

- **Q A [A]**: PR 分割 = **3 PR**（PR A: Phase 1-3 / PR B: Phase 4-7 / PR C: Phase 8-10）
- **Q B [A]**: proto 参照 = **本レポにコピー**（`proto/v1/*.proto` を複製、親レポ更新時は手動 sync）
- **Q C [A']**: Connect Dart = **`connectrpc: ^1.0.0` + `protoc_plugin: ^25.0.0`**（ユーザー指定で 22.x から上げ）
- **Q D [A]**: Golden test = **主要 3 画面のみ**（MapScreen / DetailScreen / ProfileScreen、`golden_toolkit` + `loadAppFonts`）
- **Q E [A]**: Riverpod = **code generation 使用**（`riverpod_annotation` + `build_runner` + `riverpod_generator`、`.g.dart` commit）
- **Q F [A]**: カバレッジ = **lcov 出力のみ**（外部サービス連携なし）

回答確定済み。Phase 1-10 を PR A / PR B / PR C の 3 PR に分けて順次実装する。
