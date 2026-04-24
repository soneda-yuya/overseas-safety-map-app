# Audit Log — overseas-safety-map-app (U-APP)

本ログは U-APP（Flutter クライアント）実装の監査記録。親プロジェクト `overseas-safety-map` の audit.md は別途存在する（INCEPTION〜U-BFF までの記録はそちらを参照）。

---

## リポジトリ作成 + Flutter scaffold 初期化

**Timestamp**: 2026-04-24T04:30:00Z
**User Input**: "A"（create repo now）+ "A"（フル MVP スコープ）→ 確認: "はい、両方A"
**AI Response**:
1. `gh repo create soneda-yuya/overseas-safety-map-app --public --clone --description "Flutter client for overseas-safety-map (U-APP)"`
2. `flutter create . --project-name overseas_safety_map_app --org jp.go.mofa.overseas_safety_map --platforms=ios,android`
3. 親プロジェクトから `.aidlc-rule-details/` と `CLAUDE.md` をコピー
4. `aidlc-docs/{inception,construction,operations}` ディレクトリ作成
5. `aidlc-state.md` を初期化（U-APP-only、親プロジェクトを INCEPTION 成果物として参照）
6. 本 audit.md を作成

**環境**:
- Flutter 3.41.6 / Dart 3.11.4
- `lib/main.dart`（標準の Counter App scaffold）

**Context**: U-APP 着手。次は Design Plan の Q&A。

---

## U-APP Design Plan Q1-Q10 回答

**Timestamp**: 2026-04-24T05:00:00Z
**User Input**: "A"（Q1-Q10 全てに対して）
**AI Response**: Q1-Q10 全て A で確定:
- Q1 [A]: Riverpod v2
- Q2 [A]: go_router
- Q3 [A]: flutter_map (OSM)
- Q4 [A]: connectrpc.com/connect-dart + buf plugin
- Q5 [A]: FlutterFire (auth + messaging)
- Q6 [A]: Feature-sliced + UseCase
- Q7 [A]: 層別カバレッジ
- Q8 [A]: Cold 3s / Warm 500ms / tap 100ms
- Q9 [A]: 最小権限 + メモリのみ
- Q10 [A]: GitHub Actions lint+test、リリース手動

**Context**: Plan ファイル更新、PR 作成へ。

---

## U-APP Design Plan #1 マージ + Minimal 合本版 本編 生成

**Timestamp**: 2026-04-24T05:20:00Z
**User Input**: "マージして次へ"
**AI Response**: PR #1 (U-APP Design Plan) を squash merge、`feature/u-app-design-plan` 削除、`feature/u-app-design` branch 作成。`construction/U-APP/design/U-APP-design.md` (Minimal 合本版) を生成:

**構成** (7 セクション):
- §0 Design Decisions (Q1-Q10 [A])
- §1 Functional Design
  - §1.1 Context (責務 / 非責務)
  - §1.2 画面構成 (bottom nav 4 タブ + DetailScreen)
  - §1.3 ドメインモデル (LatLng / MapFilter / Incident / UserProfile)
  - §1.4 アーキテクチャ (lib/features/*/{domain,application,presentation}/ + lib/core/)
  - §1.5 Connect クライアント + AuthInterceptor
  - §1.6 FCM ライフサイクル
  - §1.7 go_router config
  - §1.8 flutter_map (OSM tile + Choropleth + Heatmap + Marker)
- §2 NFR Requirements (PERF / SEC / REL / OPS / TEST / EXT)
- §3 NFR Design パターン (Interceptor Chain / Feature-sliced / Cold start / Test / Security)
- §4 依存パッケージ (pubspec.yaml)
- §5 トレーサビリティ (US-01〜US-13)
- §6 不採用 / 制限事項
- §7 関連ドキュメント

**Context**: Design 本編完了。PR 作成へ。

---

## U-APP Infrastructure Design Plan Q1-Q6 回答

**Timestamp**: 2026-04-24T05:45:00Z
**User Input**: "A"（Q1-Q6 全てに対して）
**AI Response**: Q1-Q6 全て A で確定:
- Q1 [A]: Firebase project = 親レポと共用
- Q2 [A]: app identity 1 系統、dev/prod は --dart-define
- Q3 [A]: APNs Auth Key 方式 (.p8)
- Q4 [A]: MVP は手元で署名、CI 自動配信見送り
- Q5 [A]: OSM 公式 tile + attribution
- Q6 [A]: CI secrets ゼロ (Android debug APK のみ)

**Context**: PR 作成へ。

---

## U-APP Infrastructure Design 本編 生成

**Timestamp**: 2026-04-24T06:00:00Z
**User Input**: "マージしました。B"
**AI Response**: PR #3 merged、main pull、feature/u-app-infra-design branch で 2 ドキュメント生成:

1. `firebase-setup.md` (8 セクション):
   - iOS / Android app 追加手順
   - flutterfire configure 自動化
   - APNs Auth Key (.p8) 作成 + Firebase Console アップロード
   - iOS Info.plist / Xcode Capabilities 設定
   - Android AndroidManifest.xml 権限 + Notification Channel
   - Anonymous Auth 有効化確認
   - Firestore Security Rules (親レポ側)
   - チェックリスト

2. `mobile-deployment.md` (7 セクション):
   - Android keystore 生成 + build.gradle 署名設定
   - iOS Xcode Automatic Signing
   - --dart-define による dev/prod 切替
   - OSM tile + attribution 実装 + Tile Usage Policy 遵守
   - GitHub Actions CI (MVP は secrets ゼロ)
   - リリース workflow の将来拡張 (secrets 一覧)
   - リリースチェックリスト

**Context**: Infrastructure Design 完了。PR 作成へ。

---

## U-APP Code Generation Plan Q A-F 回答

**Timestamp**: 2026-04-24T06:20:00Z
**User Input**: "A"（Q A, B, D, E, F）+ "A で protoc_plugin は 25.0.0"（Q C）
**AI Response**:
- Q A [A]: 3 PR 分割 (Phase 1-3 / 4-7 / 8-10)
- Q B [A]: 本レポに proto コピー
- Q C [A']: connectrpc: ^1.0.0 + protoc_plugin: ^25.0.0 (ユーザー指定で 22.x から上げ)
- Q D [A]: Golden test 主要 3 画面のみ
- Q E [A]: Riverpod code generation 使用
- Q F [A]: lcov 出力のみ (外部サービス連携なし)

**Context**: Plan ファイル更新、PR 作成へ。

---

## U-APP Code Generation PR A (Phase 1-3) 実装

**Timestamp**: 2026-04-24T06:50:00Z
**User Input**: "B: 次の段階に進む" → Code Gen PR A 着手 → "C" (protoc_plugin 25.0 は connectrpc と非互換、^22.5 で進行)
**AI Response**: `feature/u-app-code-gen-a` branch で Phase 1-3 実装:

**Phase 1: Dependencies**
- `pubspec.yaml` に全依存追加（`flutter pub add` で resolver が互換性あるバージョンを解決）
- **Q C [A'] の制約発見**: `protoc_plugin 25.0.0` は `protobuf ^6.0.0` 要求、`connectrpc 1.0.0` は `protobuf <5.0.0`。ユーザー選択 C (現状 ^22.5.0 で進行、follow-up で upgrade)
- `grpc ^4.2.0` を追加 (generated pbgrpc.dart が要求)
- `lib/firebase_options.dart` placeholder 作成 (flutterfire configure で差替え予定)
- `lib/main.dart` を Firebase init + ProviderScope + Android channel 登録に書換
- `lib/app.dart` は PR A 完了表示用の placeholder (PR B で go_router wiring)

**Phase 2: Proto 生成**
- `proto/v1/{common,pubsub,safetymap}.proto` を親レポからコピー (Q B [A])
- `proto/google/protobuf/timestamp.proto` を protoc includes からコピー (well-known type)
- `buf.yaml` + `buf.gen.yaml` 配置
- `protoc_plugin 22.5.0` を `dart pub global activate` で有効化
- `buf generate` で `lib/gen/v1/*.dart` + `lib/gen/google/protobuf/timestamp.pb.dart` を生成

**Phase 3: Core レイヤ**
- `core/env.dart`: `--dart-define` で BFF_BASE_URL / ENVIRONMENT
- `core/observability/logger.dart`: dart:developer wrapper、prod は info level drop
- `core/auth/anonymous_auth.dart`: FirebaseIdTokenProvider + Riverpod providers
- `core/rpc/auth_interceptor.dart`: grpc.ClientInterceptor で Bearer ヘッダ付与
- `core/rpc/error_mapper.dart`: GrpcError → AppError、prod で Internal/Unavailable mask
- `core/rpc/bff_client.dart`: ClientChannel + 3 service client factory、Riverpod Provider
- `core/fcm/fcm_service.dart`: onMessage / onBackgroundMessage 登録、top-level handler
- `core/fcm/notification_channel.dart`: Android 8+ 用 foreground presentation

**検証**:
- flutter pub get 緑
- flutter analyze 緑 (No issues found)
- flutter test 緑 (1 passed)

**Context**: Phase 4-7 (domain / app / presentation / routing) は PR B、Phase 8-10 (tests / CI / docs) は PR C。

---

## U-APP Code Generation PR B (Phase 4-7) 実装

**Timestamp**: 2026-04-24T07:30:00Z
**User Input**: "マージしました" → PR #6 merged → Code Gen PR B 着手
**AI Response**: `feature/u-app-code-gen-b` branch で Phase 4-7 実装:

**Phase 4: Domain**
- `features/map/domain/{map_filter,choropleth,heatmap}.dart`: MapFilter / ChoroplethEntry(color parse) / HeatmapResult
- `features/incidents/domain/{incident,incident_filter}.dart`: Incident VO + GeocodeSource enum + IncidentFilter + IncidentPage (cursor)
- `features/profile/domain/user_profile.dart`: UserProfile + NotificationPreference
- `features/notifications/domain/notification_entry.dart`: NotificationEntry + JSON serde

**Phase 5: Application + proto↔domain mappers**
- `core/rpc/mappers.dart`: 全 proto ⇄ domain 変換（Feature 側が gen/ を import しない境界）
- `features/incidents/application/{list,get,search}_usecase.dart`: FutureProvider.autoDispose.family
- `features/map/application/{choropleth,heatmap,nearby}_usecase.dart`
- `features/profile/application/profile_usecases.dart`: ProfileRemote + 4 RPC + profileProvider
- `features/notifications/application/notification_history_store.dart`: AsyncNotifier + shared_preferences、cap 100 件

**Phase 6: Presentation**
- `shared/widgets/async_retry.dart`: 共通 error + retry widget、AppError kind→日本語
- `features/auth/presentation/splash_screen.dart`: Firebase init 中の表示
- `features/map/presentation/map_screen.dart`: flutter_map + OSM tile + heatmap markers + OSM attribution + centroid fallback notice
- `features/incidents/presentation/list_screen.dart`: リスト + infoType 色分け + 日付 + context.push 遷移
- `features/incidents/presentation/detail_screen.dart`: 詳細 + 外務省 URL 遷移
- `features/profile/presentation/profile_screen.dart`: 設定画面、preference enabled SwitchListTile
- `features/notifications/presentation/notification_history_screen.dart`: 履歴 + clear ボタン + keyCd 詳細遷移

**Phase 7: Routing**
- `core/routing/router.dart`: go_router + ShellRoute + NavigationBar + auth redirect + refreshListenable
- `app.dart`: MaterialApp.router で router を配線

**検証**:
- flutter analyze 緑 (No issues found)
- flutter test 緑 (1 passed)

**Context**: Phase 8-10 (tests + CI + docs) は PR C。

---

## U-APP Code Generation PR C (Phase 8-10) 実装

**Timestamp**: 2026-04-24T09:00:00Z
**User Input**: "マージしました" → PR #7 merged → Code Gen PR C 着手
**AI Response**: `feature/u-app-code-gen-c` branch で Phase 8-10 を実装:

**Phase 8: Tests (30 passing)**
- test/core/rpc/error_mapper_test.dart: gRPC code → AppErrorKind mapping、cause 保持
- test/core/rpc/bff_client_test.dart: baseUrl validation 6 ケース
- test/features/map/domain/{color_test,map_filter_test}.dart: hex parse + sentinel copyWith
- test/features/incidents/domain/incident_filter_test.dart: sentinel copyWith + deep list equality
- test/features/notifications/domain/notification_entry_test.dart: JSON roundtrip
- test/features/notifications/application/notification_history_store_test.dart: 7 シナリオ (empty/add/persist/clear/cap/concurrent/malformed)

**Phase 9: CI**
- .github/workflows/ci.yml: lint-and-test (dart format + flutter analyze --fatal-infos + flutter test --coverage + lcov summary) + android-debug-build (APK debug)

**Phase 10: Docs**
- README.md: setup / run / test / リリース / ドキュメント導線
- aidlc-docs/construction/U-APP/code/summary.md: 全 Phase のファイル一覧 + env + テスト + 2 follow-up 記録
- aidlc-docs/aidlc-state.md: U-APP 進捗更新

**検証**:
- flutter analyze --fatal-infos 緑
- flutter test 緑 (30 passed)
- dart format 緑

**Context**: U-APP Code Generation 全完了。残りは Build and Test runbook + 実機疎通。

---
