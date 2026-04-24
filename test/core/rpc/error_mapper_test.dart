import 'package:flutter_test/flutter_test.dart';
import 'package:grpc/grpc.dart';
import 'package:overseas_safety_map_app/core/rpc/error_mapper.dart';

void main() {
  group('mapRpcError', () {
    test('maps gRPC status codes to AppErrorKind', () {
      final cases = {
        StatusCode.unauthenticated: AppErrorKind.unauthenticated,
        StatusCode.notFound: AppErrorKind.notFound,
        StatusCode.invalidArgument: AppErrorKind.invalidArgument,
        StatusCode.permissionDenied: AppErrorKind.permissionDenied,
        StatusCode.alreadyExists: AppErrorKind.conflict,
        StatusCode.unavailable: AppErrorKind.unavailable,
        StatusCode.internal: AppErrorKind.internal,
      };
      cases.forEach((code, expected) {
        final err = mapRpcError(GrpcError.custom(code, 'msg'));
        expect(err.kind, expected, reason: 'code=$code');
      });
    });

    test('unknown / non-gRPC errors become internal', () {
      final err = mapRpcError(Exception('boom'));
      expect(err.kind, AppErrorKind.internal);
    });

    test('null error falls back to internal', () {
      final err = mapRpcError(null);
      expect(err.kind, AppErrorKind.internal);
    });

    test('cause is preserved', () {
      final original = GrpcError.custom(StatusCode.notFound, 'boom');
      final err = mapRpcError(original);
      expect(err.cause, same(original));
    });
  });
}
