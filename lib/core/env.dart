/// Compile-time environment. Switch dev / prod with `--dart-define=...`;
/// see aidlc-docs/construction/U-APP/infrastructure-design/mobile-deployment.md
/// §2 for the exact CLI recipe.
class Env {
  const Env._();

  /// Base URL of the parent-repo BFF (`cmd/bff` Cloud Run Service). Dev
  /// default points at a non-resolvable host so forgetting `--dart-define`
  /// fails loudly instead of silently talking to prod.
  static const String bffBaseUrl = String.fromEnvironment(
    'BFF_BASE_URL',
    defaultValue: 'https://bff-dev.invalid',
  );

  /// 'dev' | 'staging' | 'prod'. Used by observability and for picking
  /// feature flags. Defaults to 'dev' so local `flutter run` without a
  /// `--dart-define` is clearly not production.
  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );

  /// Whether this build is production-facing. Keeps the `environment == 'prod'`
  /// check in one place so downstream code does not re-invent the string.
  static bool get isProd => environment == 'prod';
}
