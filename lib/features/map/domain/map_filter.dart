/// Date scoping applied to the map-tab queries (Choropleth, Heatmap).
/// Null fields mean "no constraint on that axis", which maps onto the
/// proto `CrimeMapFilter`'s empty Timestamp default.
///
/// NB: no `countryCd` here because `CrimeMapFilter` itself only exposes
/// `leaveFrom` / `leaveTo` on the wire today. If the proto grows a country
/// scope we can add it back — until then, a field here would be silently
/// dropped in `crimeMapFilterToProto`.
class MapFilter {
  const MapFilter({this.leaveFrom, this.leaveTo});

  final DateTime? leaveFrom;
  final DateTime? leaveTo;

  /// Sentinel-aware copyWith: pass the param to change it (including
  /// explicit `null` to clear), omit the param to keep the current value.
  /// A plain `param ?? this.param` would prevent clearing date constraints.
  MapFilter copyWith({Object? leaveFrom = _unset, Object? leaveTo = _unset}) {
    return MapFilter(
      leaveFrom: identical(leaveFrom, _unset)
          ? this.leaveFrom
          : leaveFrom as DateTime?,
      leaveTo: identical(leaveTo, _unset) ? this.leaveTo : leaveTo as DateTime?,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is MapFilter &&
      other.leaveFrom == leaveFrom &&
      other.leaveTo == leaveTo;

  @override
  int get hashCode => Object.hash(leaveFrom, leaveTo);
}

const Object _unset = Object();
