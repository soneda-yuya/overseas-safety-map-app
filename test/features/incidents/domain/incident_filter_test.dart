import 'package:flutter_test/flutter_test.dart';
import 'package:overseas_safety_map_app/features/incidents/domain/incident_filter.dart';

void main() {
  group('IncidentFilter', () {
    test('copyWith sentinel: explicit null clears nullable axes', () {
      final a = IncidentFilter(
        countryCd: 'JP',
        areaCd: 'JP-13',
        leaveFrom: DateTime.utc(2026, 4, 1),
        infoTypes: const ['danger'],
      );
      final b = a.copyWith(countryCd: null, areaCd: null, leaveFrom: null);
      expect(b.countryCd, isNull);
      expect(b.areaCd, isNull);
      expect(b.leaveFrom, isNull);
      // Omitted infoTypes stays untouched.
      expect(b.infoTypes, const ['danger']);
    });

    test('copyWith omitted keeps current', () {
      final a = IncidentFilter(countryCd: 'JP', limit: 100);
      expect(a.copyWith(), a);
    });

    test('equality uses deep list comparison for infoTypes', () {
      const a = IncidentFilter(infoTypes: ['danger', 'warning']);
      const b = IncidentFilter(infoTypes: ['danger', 'warning']);
      const c = IncidentFilter(infoTypes: ['danger']);
      expect(a, b);
      expect(a, isNot(c));
    });
  });
}
