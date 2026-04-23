import 'package:grpc/grpc.dart';

import '../auth/anonymous_auth.dart';
import '../observability/logger.dart';

/// gRPC-side interceptor that attaches the Firebase ID Token to every RPC.
/// The generated pbgrpc clients accept a `List<ClientInterceptor>` in their
/// constructor; this class plugs in at that layer.
///
/// We picked the grpc package's interceptor API (not connectrpc's Interceptor
/// typedef) because the generated `.pbgrpc.dart` clients still use
/// `$grpc.Client` as of protoc_plugin 22.5 (see code-generation-plan Q C /
/// audit.md on the ecosystem state). Upgrading to a connectrpc-native client
/// once the Dart Connect code generator lands is tracked as a follow-up.
class AuthClientInterceptor implements ClientInterceptor {
  AuthClientInterceptor(this._idTokenProvider);

  final IdTokenProvider _idTokenProvider;
  static const _logger = AppLogger('rpc.auth');

  @override
  ResponseFuture<R> interceptUnary<Q, R>(
    ClientMethod<Q, R> method,
    Q request,
    CallOptions options,
    ClientUnaryInvoker<Q, R> invoker,
  ) {
    return invoker(method, request, _optionsWithAuth(options));
  }

  @override
  ResponseStream<R> interceptStreaming<Q, R>(
    ClientMethod<Q, R> method,
    Stream<Q> requests,
    CallOptions options,
    ClientStreamingInvoker<Q, R> invoker,
  ) {
    return invoker(method, requests, _optionsWithAuth(options));
  }

  CallOptions _optionsWithAuth(CallOptions options) {
    return options.mergedWith(
      CallOptions(
        providers: [
          (Map<String, String> metadata, String uri) async {
            final token = await _idTokenProvider.currentIdToken();
            if (token == null || token.isEmpty) {
              _logger.warn('no ID token available for $uri');
              return;
            }
            metadata['authorization'] = 'Bearer $token';
          },
        ],
      ),
    );
  }
}
