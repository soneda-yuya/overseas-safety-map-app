# overseas-safety-map-app

外務省 海外安全情報マップの Flutter クライアント（iOS / Android）。親サーバリポジトリ [`overseas-safety-map`](https://github.com/soneda-yuya/overseas-safety-map) の BFF（Cloud Run、Connect RPC）を唯一の後端として、地図 / 一覧 / 通知 / 設定の 4 タブで安全情報を表示する。

## アーキテクチャ

- **状態管理**: Riverpod v2（`flutter_riverpod` + `riverpod_annotation` + codegen）
- **ナビゲーション**: `go_router`（ShellRoute + NavigationBar、auth redirect、deep-link 用 `from` query param）
- **地図**: `flutter_map` + OpenStreetMap tile（Usage Policy 遵守 + attribution 表示）
- **RPC**: `connectrpc` + `grpc`（親レポ proto から `buf generate` で Dart 生成物を作成）
- **認証**: Firebase Anonymous Auth + FCM（foreground / background / terminated を SDK 標準で扱う）
- **レイヤ**: Feature-sliced + UseCase（`lib/features/{map,incidents,profile,auth,notifications}/{domain,application,presentation}/` + `lib/core/`）
- **エラー変換**: `core/rpc/error_mapper.dart` で gRPC status → `AppError`、prod は Internal/Unavailable をマスク

## Getting Started

### 必要なツール

| Tool | バージョン |
|---|---|
| Flutter | 3.41.x (stable) |
| Dart | 3.11.x |
| buf | 1.66+ (proto regen 時のみ) |
| protoc_plugin | 22.5.0 (dart pub global activate) |
| Xcode | 15+（iOS ビルド） |
| Android SDK | API 34+（`flutter build apk` 用） |

### 初期セットアップ

```bash
git clone https://github.com/soneda-yuya/overseas-safety-map-app
cd overseas-safety-map-app
flutter pub get

# Firebase config を自プロジェクト用に生成（placeholder を置き換え）
# 詳細: aidlc-docs/construction/U-APP/infrastructure-design/firebase-setup.md
dart pub global activate flutterfire_cli
flutterfire configure
```

> **⚠️ Firebase config placeholder**: `lib/firebase_options.dart` は `PLACEHOLDER_` で始まる値を持つ scaffold の状態。実端末で起動する前に `flutterfire configure` で上書きしないと、`DefaultFirebaseOptions.currentPlatform` が `UnsupportedError` を throw します。

### ローカル実行（dev）

```bash
flutter run \
  --dart-define=BFF_BASE_URL=https://bff-dev.run.app \
  --dart-define=ENVIRONMENT=dev
```

### Proto 再生成

親レポで proto が変わった場合:

```bash
# 親レポから proto/v1/*.proto を手動 sync
cp ../overseas-safety-map/proto/v1/*.proto proto/v1/

dart pub global activate protoc_plugin 22.5.0
PATH="$HOME/.pub-cache/bin:$PATH" buf generate
```

## テスト

```bash
flutter analyze            # lint
flutter test               # unit + widget test
flutter test --coverage    # lcov.info 生成
```

層別カバレッジ目標（U-APP Design Q7 [A]）:

| 層 | 目標 |
|---|---|
| `lib/features/*/domain/` | 95% |
| `lib/features/*/application/` | 80% |
| `lib/features/*/presentation/` | 60% |
| `lib/core/rpc/` | 70% |
| 全体 | 70%+ |

## リリース

- MVP は手元で署名（Android keystore + iOS Xcode Automatic Signing）、GitHub Actions 自動配信は見送り
- 詳細: `aidlc-docs/construction/U-APP/infrastructure-design/mobile-deployment.md`

## ドキュメント

AI-DLC Adaptive ワークフローで設計・開発。各段階の設計ドキュメントは [`aidlc-docs/`](aidlc-docs/) 配下:

- [`aidlc-state.md`](aidlc-docs/aidlc-state.md) — 進捗トラッキング
- [`construction/U-APP/design/U-APP-design.md`](aidlc-docs/construction/U-APP/design/U-APP-design.md) — Functional + NFR 合本
- [`construction/U-APP/infrastructure-design/`](aidlc-docs/construction/U-APP/infrastructure-design/) — Firebase 登録 / 署名 / OSM / CI
- [`construction/U-APP/code/summary.md`](aidlc-docs/construction/U-APP/code/summary.md) — Code Generation 成果物

## ライセンス

- アプリ: （未設定）
- データ: 外務省 海外安全情報オープンデータ（無償・商用可）
- 地図タイル: © [OpenStreetMap contributors](https://www.openstreetmap.org/copyright) (ODbL)
