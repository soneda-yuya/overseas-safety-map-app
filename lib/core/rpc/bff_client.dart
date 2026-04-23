import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grpc/grpc.dart';

import '../../gen/v1/safetymap.pbgrpc.dart';
import '../auth/anonymous_auth.dart';
import '../env.dart';
import 'auth_interceptor.dart';

/// Factory for the three BFF Connect service clients. Generated pbgrpc
/// clients share a single channel + interceptor list so the Firebase ID
/// token is attached to every RPC.
///
/// NB: we use the grpc package (ClientChannel) rather than the connectrpc
/// Transport because the generated `.pbgrpc.dart` is grpc-flavoured today.
/// Once the Dart Connect code generator lands, the channel can be swapped
/// without touching call sites. See code-generation-plan Q C note.
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
      crimeMap: CrimeMapServiceClient(
        channel,
        interceptors: interceptors,
      ),
      userProfile: UserProfileServiceClient(
        channel,
        interceptors: interceptors,
      ),
    );
  }

  Future<void> close() => channel.shutdown();
}

final bffClientProvider = Provider<BffClient>((ref) {
  final client = BffClient.fromBaseUrl(
    baseUrl: Env.bffBaseUrl,
    idTokenProvider: ref.watch(idTokenProvider),
  );
  ref.onDispose(client.close);
  return client;
});
