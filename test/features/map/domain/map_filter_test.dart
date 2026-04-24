import 'package:flutter_test/flutter_test.dart';
import 'package:overseas_safety_map_app/features/map/domain/map_filter.dart';

void main() {
  group('MapFilter', () {
    test('empty filter equality', () {
      expect(const MapFilter(), const MapFilter());
    });

    test('copyWith omitted params keeps current', () {
      final a = MapFilter(leaveFrom: DateTime.utc(2026, 4, 1));
      final b = a.copyWith();
      expect(b, a);
    });

    test('copyWith with explicit null clears (sentinel behaviour)', () {
      // The point of sentinel copyWith: passing an explicit null must
      // clear the field. A naive `param ?? this.param` implementation
      // would silently keep the old value.
      final a = MapFilter(leaveFrom: DateTime.utc(2026, 4, 1));
      final b = a.copyWith(leaveFrom: null);
      expect(b.leaveFrom, isNull);
    });

    test('copyWith with new value replaces', () {
      final a = MapFilter(leaveFrom: DateTime.utc(2026, 4, 1));
      final b = a.copyWith(leaveFrom: DateTime.utc(2026, 5, 1));
      expect(b.leaveFrom, DateTime.utc(2026, 5, 1));
    });

    test('hashCode equality consistent with ==', () {
      final a = MapFilter(leaveFrom: DateTime.utc(2026, 4, 1));
      final b = MapFilter(leaveFrom: DateTime.utc(2026, 4, 1));
      expect(a.hashCode, b.hashCode);
    });
  });
}
