import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/observability/logger.dart';
import '../domain/notification_entry.dart';

/// Caps the persisted history so shared_preferences stays small on devices
/// with heavy notification volume. Oldest entries are evicted first.
const _historyCap = 100;
const _storageKey = 'notifications.history.v1';

/// Notifier that owns the in-memory history list and flushes to
/// shared_preferences. Notification history is intentionally local-only
/// (US-13, design §6) — the server does not track per-device history.
class NotificationHistoryNotifier
    extends AsyncNotifier<List<NotificationEntry>> {
  static const _logger = AppLogger('notifications.history');

  @override
  Future<List<NotificationEntry>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_storageKey) ?? const [];
    return raw
        .map((s) {
          try {
            return NotificationEntry.fromJson(
                jsonDecode(s) as Map<String, Object?>);
          } catch (error, stack) {
            _logger.warn(
              'dropping malformed entry',
              error: error,
              stackTrace: stack,
            );
            return null;
          }
        })
        .whereType<NotificationEntry>()
        .toList();
  }

  Future<void> add(NotificationEntry entry) async {
    final current = await future;
    final next = [entry, ...current];
    if (next.length > _historyCap) {
      next.removeRange(_historyCap, next.length);
    }
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> clear() async {
    state = const AsyncData([]);
    await _persist(const []);
  }

  Future<void> _persist(List<NotificationEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _storageKey,
      entries.map((e) => jsonEncode(e.toJson())).toList(growable: false),
    );
  }
}

final notificationHistoryProvider =
    AsyncNotifierProvider<NotificationHistoryNotifier,
        List<NotificationEntry>>(NotificationHistoryNotifier.new);
