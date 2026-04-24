import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/async_retry.dart';
import '../application/notification_history_store.dart';
import '../domain/notification_entry.dart';

class NotificationHistoryScreen extends ConsumerWidget {
  const NotificationHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(notificationHistoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('通知'),
        actions: [
          IconButton(
            tooltip: '履歴をクリア',
            icon: const Icon(Icons.delete_outline),
            onPressed: () =>
                ref.read(notificationHistoryProvider.notifier).clear(),
          ),
        ],
      ),
      body: history.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AsyncRetryBody(
          error: e,
          onRetry: () => ref.invalidate(notificationHistoryProvider),
        ),
        data: (entries) {
          if (entries.isEmpty) {
            return const Center(child: Text('まだ通知はありません'));
          }
          return ListView.separated(
            itemCount: entries.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) => _HistoryTile(entry: entries[i]),
          );
        },
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.entry});

  final NotificationEntry entry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.notifications_active),
      title: Text(entry.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${entry.body.isNotEmpty ? entry.body : "(本文なし)"}\n'
        '${_formatTime(entry.receivedAt)}',
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: true,
      trailing: const Icon(Icons.chevron_right),
      onTap: entry.keyCd.isEmpty
          ? null
          : () => context.push('/incidents/detail/${entry.keyCd}'),
    );
  }

  String _formatTime(DateTime d) {
    String two(int v) => v < 10 ? '0$v' : '$v';
    final dt = d.toLocal();
    return '${dt.year}-${two(dt.month)}-${two(dt.day)} '
        '${two(dt.hour)}:${two(dt.minute)}';
  }
}
