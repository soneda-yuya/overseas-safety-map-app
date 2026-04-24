import 'dart:async';
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

  /// Serialises concurrent add() calls so two pushes arriving back-to-back
  /// cannot race on the in-memory list (without this, last-writer-wins
  /// would silently drop an entry). Each add() chains onto this Future.
  Future<void> _mutations = Future.value();

  @override
  Future<List<NotificationEntry>> build() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_storageKey) ?? const [];
    final decoded = raw
        .map((s) {
          try {
            // jsonDecode returns Map<String, dynamic>; generic invariance
            // means a direct cast to Map<String, Object?> blows up at
            // runtime. `Map.from` allocates a new map with the narrower
            // value type so fromJson can be strictly typed.
            final m = Map<String, Object?>.from(jsonDecode(s) as Map);
            return NotificationEntry.fromJson(m);
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
    // Enforce the cap at read-time too, not just at write-time — older
    // app versions may have persisted > _historyCap entries.
    if (decoded.length > _historyCap) {
      final trimmed = decoded.sublist(0, _historyCap);
      await prefs.setStringList(
        _storageKey,
        trimmed.map((e) => jsonEncode(e.toJson())).toList(growable: false),
      );
      return trimmed;
    }
    return decoded;
  }

  Future<void> add(NotificationEntry entry) {
    final next = _mutations.then((_) => _doAdd(entry));
    // Log + swallow any throw on the chain so one failure doesn't break
    // later adds. The throw is still returned from the `add` Future so a
    // caller that wants to handle it (e.g. SnackBar) can `await` directly.
    _mutations = next.catchError((Object error, StackTrace stack) {
      _logger.warn(
        'notification history mutation failed',
        error: error,
        stackTrace: stack,
      );
    });
    return next;
  }

  Future<void> _doAdd(NotificationEntry entry) async {
    // `state.value` throws if the initial build hasn't completed yet or it
    // errored; fall back to `await future` which waits for initial build.
    List<NotificationEntry> current;
    final snapshot = state;
    if (snapshot is AsyncData<List<NotificationEntry>>) {
      current = snapshot.value;
    } else {
      current = await future;
    }
    final next = [entry, ...current];
    if (next.length > _historyCap) {
      next.removeRange(_historyCap, next.length);
    }
    state = AsyncData(next);
    await _persist(next);
  }

  Future<void> clear() {
    // clear() also goes through the mutation chain so it is serialised
    // relative to pending adds. We also await `future` first so a
    // clear() that fires before the initial `build()` completes does not
    // race: without this, build() could land after `state = []` and
    // reintroduce the persisted entries.
    final next = _mutations.then((_) async {
      final snapshot = state;
      if (snapshot is! AsyncData<List<NotificationEntry>>) {
        await future;
      }
      state = const AsyncData([]);
      await _persist(const []);
    });
    _mutations = next.catchError((Object error, StackTrace stack) {
      _logger.warn(
        'notification history clear failed',
        error: error,
        stackTrace: stack,
      );
    });
    return next;
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
    AsyncNotifierProvider<NotificationHistoryNotifier, List<NotificationEntry>>(
      NotificationHistoryNotifier.new,
    );
