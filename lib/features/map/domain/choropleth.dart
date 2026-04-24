import 'package:flutter/painting.dart' show Color;

/// One cell of a choropleth map. Color is computed server-side (BFF §3.2) so
/// every client paints the same shade; we just convert the hex string to a
/// Flutter Color for render.
class ChoroplethEntry {
  const ChoroplethEntry({
    required this.countryCd,
    required this.countryName,
    required this.count,
    required this.color,
  });

  final String countryCd;
  final String countryName;
  final int count;
  final Color color;

  /// Build from the wire payload. `hex` is expected as "#rrggbb"; malformed
  /// values fall back to grey rather than crash, because a server that emits
  /// a non-hex string is a bug but not one we want to break the map over.
  factory ChoroplethEntry.fromProto({
    required String countryCd,
    required String countryName,
    required int count,
    required String hex,
  }) {
    return ChoroplethEntry(
      countryCd: countryCd,
      countryName: countryName,
      count: count,
      color: _parseHex(hex),
    );
  }

  static const _fallback = Color(0xFFF0F0F0);

  static Color _parseHex(String hex) {
    if (hex.length != 7 || !hex.startsWith('#')) return _fallback;
    final value = int.tryParse(hex.substring(1), radix: 16);
    if (value == null) return _fallback;
    return Color(0xFF000000 | value);
  }
}

/// Full choropleth result — entries + corpus-wide total (used for the UI
/// legend without a second round-trip).
class ChoroplethResult {
  const ChoroplethResult({required this.entries, required this.total});

  final List<ChoroplethEntry> entries;
  final int total;

  bool get isEmpty => entries.isEmpty;
}
