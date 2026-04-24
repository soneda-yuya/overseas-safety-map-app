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

class _ProfileBody extends ConsumerWidget {
  const _ProfileBody({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.fingerprint),
          title: const Text('匿名 UID'),
          subtitle: Text(profile.uid),
        ),
        const Divider(),
        SwitchListTile(
          title: const Text('通知を受信する'),
          subtitle: const Text('FCM 経由で事象通知を受け取る'),
          value: profile.preference.enabled,
          onChanged: (v) => _togglePreferenceEnabled(ref, v),
        ),
        ListTile(
          leading: const Icon(Icons.flag),
          title: const Text('通知対象国'),
          subtitle: Text(profile.preference.targetCountryCds.isEmpty
              ? '未設定'
              : profile.preference.targetCountryCds.join(', ')),
        ),
        ListTile(
          leading: const Icon(Icons.category),
          title: const Text('通知種別'),
          subtitle: Text(profile.preference.infoTypes.isEmpty
              ? '全種別'
              : profile.preference.infoTypes.join(', ')),
        ),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('お気に入り国'),
          subtitle: Text(profile.favoriteCountryCds.isEmpty
              ? '未設定'
              : profile.favoriteCountryCds.join(', ')),
        ),
        ListTile(
          leading: const Icon(Icons.devices),
          title: const Text('登録済み端末数'),
          subtitle: Text('${profile.fcmTokenCount} 台'),
        ),
      ],
    );
  }

  Future<void> _togglePreferenceEnabled(WidgetRef ref, bool enabled) async {
    final next = profile.preference.copyWith(enabled: enabled);
    await ref.read(profileRemoteProvider).updatePreference(next);
    ref.invalidate(profileProvider);
  }
}
