import 'dart:async' show unawaited;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

import '../../gen/v1/safetymap.pbgrpc.dart';
import '../auth/anonymous_auth.dart';
import '../env.dart';
import '../observability/logger.dart';
import 'auth_interceptor.dart';

/// Factory for the three BFF gRPC service clients. Generated `.pbgrpc.dart`
/// clients share a single ClientChannel + interceptor list so the Firebase
/// ID token is attached to every RPC.
///
/// Connect-protocol migration: the Dart side today uses the `grpc` package
/// because that is what the generated `.pbgrpc.dart` targets; the BFF
/// speaks Connect over HTTP/2, which is grpc-wire compatible on the
/// unary path we use. Once a Dart Connect code generator lands on pub.dev
/// (tracked in code-generation-plan Q C) we can swap ClientChannel for
/// connectrpc.Transport without touching call sites.
class BffClient {
  BffClient._({
    required this.channel,
    required this.safetyIncident,
    required this.crimeMap,
    required this.userProfile,
  });

  final ClientChannel channel;
  final SafetyIncidentServiceClient safetyIncident;
  final CrimeMapServiceClient crimeMap;
  final UserProfileServiceClient userProfile;

  factory BffClient.fromBaseUrl({
    required String baseUrl,
    required IdTokenProvider idTokenProvider,
  }) {
    final uri = Uri.parse(baseUrl);
    // `Uri.parse('localhost:8080')` yields scheme='localhost', host='',
    // which would silently create a ClientChannel with an invalid host.
    // Demand an absolute http/https URL so the failure mode is loud.
    if ((uri.scheme != 'http' && uri.scheme != 'https') || uri.host.isEmpty) {
      throw ArgumentError.value(
        baseUrl,
        'baseUrl',
        'BFF_BASE_URL must be an absolute http/https URL '
            '(e.g. "https://bff.example.com"). '
            'Got scheme=${uri.scheme}, host=${uri.host}.',
      );
    }
    // ClientChannel only consumes host + port; any path, query, or fragment
    // on baseUrl is silently discarded. Refuse them rather than ship an RPC
    // client that ignores its own configuration.
    final hasExtraPath = uri.path.isNotEmpty && uri.path != '/';
    if (hasExtraPath || uri.hasQuery || uri.hasFragment) {
      throw ArgumentError.value(
        baseUrl,
        'baseUrl',
        'BFF_BASE_URL must be scheme+host(+port) only; '
            'path / query / fragment are not supported '
            '(grpc ClientChannel ignores them).',
      );
    }

    final channel = ClientChannel(
      uri.host,
      port: uri.hasPort ? uri.port : (uri.scheme == 'https' ? 443 : 80),
      options: ChannelOptions(
        credentials: uri.scheme == 'https'
            ? const ChannelCredentials.secure()
            : const ChannelCredentials.insecure(),
        connectionTimeout: const Duration(seconds: 10),
      ),
    );
    final interceptors = <ClientInterceptor>[
      AuthClientInterceptor(idTokenProvider),
    ];
    return BffClient._(
      channel: channel,
      safetyIncident: SafetyIncidentServiceClient(
        channel,
        interceptors: interceptors,
      ),
      crimeMap: CrimeMapServiceClient(channel, interceptors: interceptors),
      userProfile: UserProfileServiceClient(
        channel,
        interceptors: interceptors,
      ),
    );
  }

  Future<void> close() => channel.shutdown();
}

const _disposeLogger = AppLogger('rpc.bff.dispose');

final bffClientProvider = Provider<BffClient>((ref) {
  final client = BffClient.fromBaseUrl(
    baseUrl: Env.bffBaseUrl,
    idTokenProvider: ref.watch(idTokenProvider),
  );
  // Riverpod's onDispose callback is sync-only — if `close` returned a
  // Future directly we'd silently drop any shutdown error. Wrap in a sync
  // closure so the Future is explicitly fire-and-forget and any error is
  // logged rather than dropped.
  ref.onDispose(() {
    unawaited(
      client.close().catchError(
        (Object error, StackTrace stack) => _disposeLogger.warn(
          'channel shutdown failed',
          error: error,
          stackTrace: stack,
        ),
      ),
    );
  });
  return client;
});
