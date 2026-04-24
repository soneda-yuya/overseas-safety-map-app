import 'package:flutter_test/flutter_test.dart';
import 'package:overseas_safety_map_app/features/notifications/domain/notification_entry.dart';

void main() {
  group('NotificationEntry JSON roundtrip', () {
    test('toJson → fromJson preserves every field', () {
      final original = NotificationEntry(
        receivedAt: DateTime.utc(2026, 4, 24, 10, 30),
        title: '危険情報',
        body: '本文',
        keyCd: 'K-001',
      );
      final copy = NotificationEntry.fromJson(original.toJson());
      expect(copy.receivedAt, original.receivedAt);
      expect(copy.title, original.title);
      expect(copy.body, original.body);
      expect(copy.keyCd, original.keyCd);
    });

    test('fromJson rejects missing fields', () {
      expect(
        () => NotificationEntry.fromJson({'title': 'x'}),
        throwsA(anything),
      );
    });
  });
}
