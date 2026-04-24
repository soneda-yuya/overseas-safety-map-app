import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/anonymous_auth.dart';

/// Displayed while Firebase initialises and we kick off the anonymous
/// sign-in. The router's redirect (auth gate) sends callers here when the
/// Firebase `authStateChanges()` stream has not yet emitted a user.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.public, size: 72),
              const SizedBox(height: 16),
              const Text(
                '海外安全情報マップ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              auth.when(
                loading: () => const CircularProgressIndicator(),
                error: (e, _) => _ErrorBody(
                  message: '認証に失敗しました: $e',
                  onRetry: () => ref.invalidate(authStateProvider),
                ),
                data: (_) => const CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ErrorBody extends StatelessWidget {
  const _ErrorBody({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: onRetry, child: const Text('再試行')),
      ],
    );
  }
}
