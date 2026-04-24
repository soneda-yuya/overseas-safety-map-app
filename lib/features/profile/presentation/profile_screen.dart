import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/async_retry.dart';
import '../application/profile_usecases.dart';
import '../domain/user_profile.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: profile.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AsyncRetryBody(
          error: e,
          onRetry: () => ref.invalidate(profileProvider),
        ),
        data: (p) => _ProfileBody(profile: p),
      ),
    );
  }
}

class _ProfileBody extends ConsumerStatefulWidget {
  const _ProfileBody({required this.profile});

  final UserProfile profile;

  @override
  ConsumerState<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends ConsumerState<_ProfileBody> {
  /// Local mirror of the switch so the UI updates instantly while the RPC
  /// is in flight. Reverts on RPC failure. The `didUpdateWidget` hook keeps
  /// it in sync if the parent provider data changes from elsewhere.
  late bool _enabled = widget.profile.preference.enabled;
  bool _inFlight = false;

  @override
  void didUpdateWidget(_ProfileBody old) {
    super.didUpdateWidget(old);
    if (widget.profile.preference.enabled != old.profile.preference.enabled) {
      _enabled = widget.profile.preference.enabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profile;
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.fingerprint),
          title: const Text('匿名 UID'),
          subtitle: Text(p.uid),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('通知を受信する'),
          subtitle: const Text('FCM 経由で事象通知を受け取る'),
          value: _enabled,
          onChanged: _inFlight ? null : _togglePreferenceEnabled,
        ),
        ListTile(
          leading: const Icon(Icons.flag),
          title: const Text('通知対象国'),
          subtitle: Text(
            p.preference.targetCountryCds.isEmpty
                ? '未設定'
                : p.preference.targetCountryCds.join(', '),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('通知種別'),
          subtitle: Text(
            p.preference.infoTypes.isEmpty
                ? '全種別'
                : p.preference.infoTypes.join(', '),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('お気に入り国'),
          subtitle: Text(
            p.favoriteCountryCds.isEmpty
                ? '未設定'
                : p.favoriteCountryCds.join(', '),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.devices),
          title: const Text('登録済み端末数'),
          subtitle: Text('${p.fcmTokenCount} 台'),
        ),
      ],
    );
  }

  Future<void> _togglePreferenceEnabled(bool enabled) async {
    if (_inFlight) return;
    // Optimistic update: flip the switch immediately so the UI responds.
    setState(() {
      _enabled = enabled;
      _inFlight = true;
    });
    final next = widget.profile.preference.copyWith(enabled: enabled);
    try {
      await ref.read(profileRemoteProvider).updatePreference(next);
      if (!mounted) return;
      ref.invalidate(profileProvider);
    } catch (_) {
      if (!mounted) return;
      // Revert + surface failure; the switch snaps back.
      setState(() => _enabled = widget.profile.preference.enabled);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('通知設定の更新に失敗しました。時間をおいて再度お試しください。')),
      );
    } finally {
      if (mounted) {
        setState(() => _inFlight = false);
      }
    }
  }
}
