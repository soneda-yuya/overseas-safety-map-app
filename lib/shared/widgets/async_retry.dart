import 'package:flutter/material.dart';

import '../../core/rpc/error_mapper.dart';

/// Common "error + retry" body used by every screen whenever a Riverpod
/// AsyncValue resolves to an error. Centralising the message wording keeps
/// strings consistent and avoids each screen re-inventing a retry button.
class AsyncRetryBody extends StatelessWidget {
  const AsyncRetryBody({
    super.key,
    required this.error,
    required this.onRetry,
  });

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final message = _messageFor(error);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 40),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRetry, child: const Text('再試行')),
          ],
        ),
      ),
    );
  }

  String _messageFor(Object error) {
    if (error is AppError) {
      switch (error.kind) {
        case AppErrorKind.unauthenticated:
          return '認証に失敗しました。アプリを再起動してください。';
        case AppErrorKind.notFound:
          return '情報が見つかりませんでした。';
        case AppErrorKind.invalidArgument:
          return 'リクエスト内容が不正です。';
        case AppErrorKind.permissionDenied:
          return 'この操作は許可されていません。';
        case AppErrorKind.conflict:
          return 'すでに操作が反映されています。';
        case AppErrorKind.unavailable:
          return 'サーバに接続できませんでした。電波状況をご確認ください。';
        case AppErrorKind.internal:
          return '予期しないエラーが発生しました。';
      }
    }
    return '通信エラーが発生しました。';
  }
}
