/// Scope for `ListSafetyIncidents`. Null / empty fields mean "no constraint"
/// on that axis. The BFF translates this one-to-one onto `SafetyIncidentFilter`.
class IncidentFilter {
  const IncidentFilter({
    this.countryCd,
    this.areaCd,
    this.infoTypes = const [],
    this.leaveFrom,
    this.leaveTo,
    this.limit = 50,
    this.cursor = '',
  });

  final String? countryCd;
  final String? areaCd;
  final List<String> infoTypes;
  final DateTime? leaveFrom;
  final DateTime? leaveTo;
  final int limit;
  final String cursor;

  /// Sentinel-aware copyWith: pass `null` explicitly to clear a nullable
  /// filter axis; omit the argument to keep the current value. A plain
  /// `param ?? this.param` would prevent the UI from removing an active
  /// country / area / date filter.
  IncidentFilter copyWith({
    Object? countryCd = _unset,
    Object? areaCd = _unset,
    List<String>? infoTypes,
    Object? leaveFrom = _unset,
    Object? leaveTo = _unset,
    int? limit,
    String? cursor,
  }) {
    return IncidentFilter(
      countryCd: identical(countryCd, _unset)
          ? this.countryCd
          : countryCd as String?,
      areaCd: identical(areaCd, _unset) ? this.areaCd : areaCd as String?,
      infoTypes: infoTypes ?? this.infoTypes,
      leaveFrom: identical(leaveFrom, _unset)
          ? this.leaveFrom
          : leaveFrom as DateTime?,
      leaveTo: identical(leaveTo, _unset) ? this.leaveTo : leaveTo as DateTime?,
      limit: limit ?? this.limit,
      cursor: cursor ?? this.cursor,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is IncidentFilter &&
      other.countryCd == countryCd &&
      other.areaCd == areaCd &&
      _listEqual(other.infoTypes, infoTypes) &&
      other.leaveFrom == leaveFrom &&
      other.leaveTo == leaveTo &&
      other.limit == limit &&
      other.cursor == cursor;

  @override
  int get hashCode => Object.hash(
    countryCd,
    areaCd,
    Object.hashAll(infoTypes),
    leaveFrom,
    leaveTo,
    limit,
    cursor,
  );
}

const Object _unset = Object();

bool _listEqual(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
