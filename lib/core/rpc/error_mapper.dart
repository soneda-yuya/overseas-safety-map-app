import 'package:grpc/grpc.dart';

import '../env.dart';

/// Application-facing error. The RPC transport's GrpcError is caught here
/// and translated into an AppError the UI can switch on without knowing
/// about gRPC internals.
class AppError implements Exception {
  AppError(this.kind, this.message, {this.cause});

  final AppErrorKind kind;
  final String message;
  final Object? cause;

  @override
  String toString() => 'AppError($kind, $message)';
}

enum AppErrorKind {
  unauthenticated,
  notFound,
  invalidArgument,
  permissionDenied,
  conflict,
  unavailable,
  internal,
}

/// Map a raw RPC error to an AppError. In production the message is replaced
/// with a safe generic string for [AppErrorKind.internal] / [AppErrorKind.unavailable]
/// to mirror the parent-repo ErrorInterceptor's masking policy (U-BFF design §1.6.2).
AppError mapRpcError(Object? error) {
  if (error is GrpcError) {
    final kind = _kindFromGrpc(error.code);
    final message = _maskForProd(kind, error.message ?? '');
    return AppError(kind, message, cause: error);
  }
  return AppError(
    AppErrorKind.internal,
    _maskForProd(AppErrorKind.internal, error?.toString() ?? 'unknown error'),
    cause: error,
  );
}

AppErrorKind _kindFromGrpc(int code) {
  switch (code) {
    case StatusCode.unauthenticated:
      return AppErrorKind.unauthenticated;
    case StatusCode.notFound:
      return AppErrorKind.notFound;
    case StatusCode.invalidArgument:
      return AppErrorKind.invalidArgument;
    case StatusCode.permissionDenied:
      return AppErrorKind.permissionDenied;
    case StatusCode.alreadyExists:
      return AppErrorKind.conflict;
    case StatusCode.unavailable:
      return AppErrorKind.unavailable;
    default:
      return AppErrorKind.internal;
  }
}

String _maskForProd(AppErrorKind kind, String raw) {
  if (!Env.isProd) return raw;
  switch (kind) {
    case AppErrorKind.internal:
    case AppErrorKind.unavailable:
      return 'サーバ通信エラーが発生しました';
    default:
      return raw;
  }
}
