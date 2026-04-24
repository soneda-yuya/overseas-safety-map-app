import 'package:flutter_test/flutter_test.dart';
import 'package:overseas_safety_map_app/core/auth/anonymous_auth.dart';
import 'package:overseas_safety_map_app/core/rpc/bff_client.dart';

/// Stub IdTokenProvider; BffClient only stores the reference, the actual
/// token is requested per RPC via the interceptor.
class _StubTokenProvider implements IdTokenProvider {
  @override
  Future<String?> currentIdToken({bool forceRefresh = false}) async =>
      'stub-token';
}

void main() {
  final idToken = _StubTokenProvider();

  group('BffClient.fromBaseUrl validation', () {
    test('rejects scheme-less URLs', () {
      expect(
        () => BffClient.fromBaseUrl(
          baseUrl: 'localhost:8080',
          idTokenProvider: idToken,
        ),
        throwsArgumentError,
      );
    });

    test('rejects non-http schemes', () {
      expect(
        () => BffClient.fromBaseUrl(
          baseUrl: 'ftp://example.com',
          idTokenProvider: idToken,
        ),
        throwsArgumentError,
      );
    });

    test('rejects URLs with a non-root path', () {
      expect(
        () => BffClient.fromBaseUrl(
          baseUrl: 'https://example.com/api',
          idTokenProvider: idToken,
        ),
        throwsArgumentError,
      );
    });

    test('rejects URLs with query', () {
      expect(
        () => BffClient.fromBaseUrl(
          baseUrl: 'https://example.com?x=1',
          idTokenProvider: idToken,
        ),
        throwsArgumentError,
      );
    });

    test('accepts bare scheme+host+port', () async {
      final c = BffClient.fromBaseUrl(
        baseUrl: 'https://example.com',
        idTokenProvider: idToken,
      );
      // Should not throw; channel shut down cleanly.
      await c.close();
    });

    test('accepts explicit root path', () async {
      final c = BffClient.fromBaseUrl(
        baseUrl: 'https://example.com/',
        idTokenProvider: idToken,
      );
      await c.close();
    });
  });
}
