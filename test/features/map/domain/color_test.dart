import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:overseas_safety_map_app/features/map/domain/choropleth.dart';

void main() {
  group('ChoroplethEntry.fromProto', () {
    test('parses valid hex string', () {
      final e = ChoroplethEntry.fromProto(
        countryCd: 'JP',
        countryName: 'Japan',
        count: 10,
        hex: '#ff0000',
      );
      expect(e.color, const Color(0xFFFF0000));
    });

    test('falls back to grey on invalid hex', () {
      final cases = ['', '#xyz', '#12345', 'ff0000', '#gggggg'];
      for (final invalid in cases) {
        final e = ChoroplethEntry.fromProto(
          countryCd: 'JP',
          countryName: 'Japan',
          count: 1,
          hex: invalid,
        );
        expect(
          e.color,
          const Color(0xFFF0F0F0),
          reason: 'fallback expected for $invalid',
        );
      }
    });

    test('preserves other fields', () {
      final e = ChoroplethEntry.fromProto(
        countryCd: 'US',
        countryName: 'United States',
        count: 42,
        hex: '#00ff00',
      );
      expect(e.countryCd, 'US');
      expect(e.countryName, 'United States');
      expect(e.count, 42);
    });
  });
}
