/// Date / country scoping applied to the map-tab queries (Choropleth,
/// Heatmap, Nearby). Null fields mean "no constraint on that axis", which
/// maps onto the proto filter's empty-string / zero default.
class MapFilter {
  const MapFilter({
    this.leaveFrom,
    this.leaveTo,
    this.countryCd,
  });

  final DateTime? leaveFrom;
  final DateTime? leaveTo;
  final String? countryCd;

  MapFilter copyWith({
    DateTime? leaveFrom,
    DateTime? leaveTo,
    String? countryCd,
  }) {
    return MapFilter(
      leaveFrom: leaveFrom ?? this.leaveFrom,
      leaveTo: leaveTo ?? this.leaveTo,
      countryCd: countryCd ?? this.countryCd,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MapFilter &&
      other.leaveFrom == leaveFrom &&
      other.leaveTo == leaveTo &&
      other.countryCd == countryCd;

  @override
  int get hashCode => Object.hash(leaveFrom, leaveTo, countryCd);
}
