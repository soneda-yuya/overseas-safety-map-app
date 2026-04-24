# AI-DLC 状態トラッキング（U-APP / Flutter クライアント）

## プロジェクト情報
- **プロジェクト名**: overseas-safety-map-app（Flutter モバイルアプリ）
- **プロジェクトタイプ**: グリーンフィールド（Flutter scaffold から開始）
- **開始日**: 2026-04-24
- **親プロジェクト**: [`overseas-safety-map`](https://github.com/soneda-yuya/overseas-safety-map)（Go サーバーモノレポ、backend 5 Unit 完成済み）
- **Unit ID**: U-APP
- **現在のフェーズ**: CONSTRUCTION
- **現在のステージ**: U-APP Build and Test runbook template 生成完了、PR レビュー待ち（全 Unit サブステージ完走見込み）

## 親プロジェクトとの関係
このリポジトリは **U-APP 専用**。INCEPTION フェーズのアーティファクト（要件分析 / ユーザーストーリー / アプリケーション設計 / ユニット生成）は親リポジトリ `overseas-safety-map` の [`aidlc-docs/inception/`](https://github.com/soneda-yuya/overseas-safety-map/tree/main/aidlc-docs/inception) にある。本リポジトリは CONSTRUCTION フェーズの U-APP 部分のみを持つ。

## ワークフロー圧縮方針（親プロジェクトから継承）
**Functional Design / NFR Requirements / NFR Design を「Minimal 合本版」1 ドキュメントにまとめる**。Infrastructure Design / Code Generation / Build & Test は独立。

## アイデア概要
- **データソース**: BFF（親レポの `cmd/bff` Cloud Run Service、Connect RPC）
- **認証**: Firebase Anonymous Auth（ID Token を Authorization: Bearer で BFF に送る）
- **コア機能**:
  - 地図表示（Choropleth = 国別犯罪マップ / Heatmap = 事象ヒートマップ / Nearby = 現在地付近）
  - 事象一覧 / 詳細
  - GeoJSON 表示（オプション）
  - プロファイル / 通知設定（お気に入り国、通知種別、FCM Token 登録）
- **受信通知**: FCM（foreground / background / terminated）
- **プラットフォーム**: iOS / Android

## ワークスペースの状態
- **既存コード**: Flutter scaffold（`flutter create .` 直後）
- **プログラミング言語**: Dart（Flutter 3.41.x / Dart 3.11.x）
- **ビルドシステム**: pub + Gradle / Xcode
- **プロジェクト構造**: 標準的な Flutter アプリ（`lib/` + `ios/` + `android/` + `test/`）
- **リバースエンジニアリングの要否**: 不要
- **ワークスペースルート**: /Users/y.soneda/projects/yuya/overseas-safety-map-app

## コード配置ルール
- **アプリケーションコード**: ワークスペースルート（`lib/`, `ios/`, `android/`, `test/`）
- **ドキュメント**: `aidlc-docs/` のみ
- **構造パターン**: 親プロジェクトの code-generation.md を参照しつつ Flutter 標準ディレクトリ構成

## 拡張機能の有効化
| 拡張機能 | 有効化 | 決定した段階 |
|---|---|---|
| セキュリティベースライン | Yes | 親プロジェクトから継承 |
| プロパティベーステスト | Yes | 親プロジェクトから継承（Dart では [`test` + `fake_async`]） |

## ステージ進捗

### 🔵 INCEPTION フェーズ（親プロジェクトで完了済み、再実行しない）
- [x] ワークスペース検出（親プロジェクト）
- [x] 要件分析（親プロジェクト）
- [x] ユーザーストーリー（親プロジェクト）
- [x] ワークフロー計画（親プロジェクト）
- [x] アプリケーション設計（親プロジェクト）
- [x] ユニット生成（親プロジェクト、U-APP を含む 6 Unit）

### 🟢 CONSTRUCTION フェーズ（U-APP のみ）

- [x] Minimal 合本版 計画（Functional + NFR Req + NFR Design）— PR #1 merged
- [x] Minimal 合本版 本編（Q1-Q10 [A]）— PR #2 merged
- [x] インフラ設計 計画（Q1-Q6 [A]）— PR #3 merged
- [x] インフラ設計 本編（firebase-setup + mobile-deployment）— PR #4 merged
- [x] コード生成 計画（Phase 1-10 + Q A-F [A]）— PR #5 merged
- [x] コード生成 PR A（Phase 1-3: deps + Firebase + proto + core）— PR #6 merged（Copilot 6 round 対応）
- [x] コード生成 PR B（Phase 4-7: domain + app + presentation + routing）— PR #7 merged（Copilot 7 round 対応）
- [x] コード生成 PR C（Phase 8-10: tests + CI + docs）— PR #8 merged
- [ ] ビルドとテスト runbook（iOS / Android 実機での BFF 疎通手順）— 生成済み、PR レビュー待ち。実機疎通は運用フェーズで記録

### 🟡 OPERATIONS フェーズ
- [ ] オペレーション（プレースホルダー）

## ワークフロー切替前の事前合意事項（参考）
- プラットフォーム: iOS / Android（Flutter）
- BFF: 親プロジェクトの `cmd/bff`（Connect RPC）
- 認証: Firebase Anonymous Auth
- MVP スコープ: フル MVP（地図 + 詳細 + 通知設定 + FCM）
