import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/anonymous_auth.dart';
import '../../../core/observability/logger.dart';

/// Displayed while Firebase initialises and we kick off the anonymous
/// sign-in. The router's redirect (auth gate) sends callers here when the
/// Firebase `authStateChanges()` stream has not yet emitted a user.
///
/// On a fresh install Firebase's auth stream emits `null` and never moves
/// on by itself — we have to actively request an anonymous session. The
/// `initState` hook triggers that sign-in once per mount; any failure is
/// surfaced via the `_signInAttempt` state.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  AsyncValue<Object?> _signInAttempt = const AsyncValue.loading();
  static const _logger = AppLogger('auth.splash');

  @override
  void initState() {
    super.initState();
    _kickoffSignIn();
  }

  Future<void> _kickoffSignIn() async {
    setState(() => _signInAttempt = const AsyncValue.loading());
    try {
      // This triggers FirebaseIdTokenProvider.signInAnonymously via its
      // currentIdToken() memo, which in turn makes the auth stream emit a
      // User — unblocking the router redirect from /splash → /map.
      await ref.read(idTokenProvider).currentIdToken();
      setState(() => _signInAttempt = const AsyncValue.data(null));
    } catch (error, stack) {
      _logger.error('anonymous sign-in failed',
          error: error, stackTrace: stack);
      if (!mounted) return;
      setState(() => _signInAttempt = AsyncValue.error(error, stack));
    }
  }

  @override
  Widget build(BuildContext context) {
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
              _signInAttempt.when(
                loading: () => const CircularProgressIndicator(),
                data: (_) => const CircularProgressIndicator(),
                error: (_, _) => _ErrorBody(
                  message: '認証に失敗しました。時間をおいて再試行してください。',
                  onRetry: _kickoffSignIn,
                ),
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
