import 'dart:developer' as developer;

import '../env.dart';

/// Thin wrapper around `dart:developer.log` so the app has a single entry
/// point for structured logging. Production builds drop info-level logs to
/// keep the Android logcat / Xcode console quiet; dev keeps everything.
///
/// We avoid adopting a full logging package for MVP (NFR-APP-OPS-02) —
/// `dart:developer.log` integrates with the Flutter DevTools timeline for
/// free and is plenty for our volume.
class AppLogger {
  const AppLogger(this.scope);

  /// Scope identifier (e.g. 'rpc.bff' or 'feature.map'). Surfaces in the
  /// `name:` field of dart:developer.log.
  final String scope;

  void info(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? fields,
  }) {
    if (Env.isProd) return;
    _log(0, message, error: error, stackTrace: stackTrace, fields: fields);
  }

  void warn(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? fields,
  }) {
    _log(900, message, error: error, stackTrace: stackTrace, fields: fields);
  }

  void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? fields,
  }) {
    _log(1000, message, error: error, stackTrace: stackTrace, fields: fields);
  }

  void _log(
    int level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?>? fields,
  }) {
    final enriched = fields == null || fields.isEmpty
        ? message
        : '$message ${fields.entries.map((e) => '${e.key}=${e.value}').join(' ')}';
    developer.log(
      enriched,
      level: level,
      name: scope,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
