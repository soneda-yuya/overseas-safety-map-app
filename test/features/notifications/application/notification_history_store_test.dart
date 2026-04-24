import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overseas_safety_map_app/features/notifications/application/notification_history_store.dart';
import 'package:overseas_safety_map_app/features/notifications/domain/notification_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

NotificationEntry _entry(String keyCd, {DateTime? at}) {
  return NotificationEntry(
    receivedAt: at ?? DateTime.utc(2026, 4, 24, 10, 30),
    title: 'T-$keyCd',
    body: 'body',
    keyCd: keyCd,
  );
}

void main() {
  setUp(() {
    // shared_preferences_test_plugin backend — uses in-memory map.
    SharedPreferences.setMockInitialValues({});
  });

  test('empty build returns empty list', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final list = await container.read(notificationHistoryProvider.future);
    expect(list, isEmpty);
  });

  test('add persists and is visible on subsequent build', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(notificationHistoryProvider.future); // prime build
    await container
        .read(notificationHistoryProvider.notifier)
        .add(_entry('K1'));
    final visible = await container.read(notificationHistoryProvider.future);
    expect(visible.map((e) => e.keyCd), ['K1']);

    // New container → same SharedPreferences backing; history persists.
    final fresh = ProviderContainer();
    addTearDown(fresh.dispose);
    final reloaded = await fresh.read(notificationHistoryProvider.future);
    expect(reloaded.map((e) => e.keyCd), ['K1']);
  });

  test('clear wipes the list', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(notificationHistoryProvider.future);
    final notifier = container.read(notificationHistoryProvider.notifier);
    await notifier.add(_entry('K1'));
    await notifier.add(_entry('K2'));
    await notifier.clear();
    final list = await container.read(notificationHistoryProvider.future);
    expect(list, isEmpty);
  });

  test('cap trims to 100 newest entries on write', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(notificationHistoryProvider.future);
    final notifier = container.read(notificationHistoryProvider.notifier);

    for (var i = 0; i < 105; i++) {
      await notifier.add(_entry('K$i'));
    }
    final list = await container.read(notificationHistoryProvider.future);
    expect(list.length, 100);
    // Newest-first ordering: K104 at the front, K5 at the tail.
    expect(list.first.keyCd, 'K104');
    expect(list.last.keyCd, 'K5');
  });

  test('concurrent adds do not drop entries', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    await container.read(notificationHistoryProvider.future);
    final notifier = container.read(notificationHistoryProvider.notifier);

    await Future.wait([
      for (var i = 0; i < 10; i++) notifier.add(_entry('K$i')),
    ]);
    final list = await container.read(notificationHistoryProvider.future);
    expect(list.length, 10);
    // Every key ends up in the list (order is serialised but not
    // guaranteed to match Future.wait order).
    expect(list.map((e) => e.keyCd).toSet(), {
      for (var i = 0; i < 10; i++) 'K$i',
    });
  });

  test('malformed persisted entries are dropped on read', () async {
    SharedPreferences.setMockInitialValues({
      'notifications.history.v1': ['not-json', '{"bogus":true}'],
    });
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final list = await container.read(notificationHistoryProvider.future);
    expect(list, isEmpty);
  });
}
