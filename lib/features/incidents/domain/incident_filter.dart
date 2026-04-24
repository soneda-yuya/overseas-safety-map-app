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

  IncidentFilter copyWith({
    String? countryCd,
    String? areaCd,
    List<String>? infoTypes,
    DateTime? leaveFrom,
    DateTime? leaveTo,
    int? limit,
    String? cursor,
  }) {
    return IncidentFilter(
      countryCd: countryCd ?? this.countryCd,
      areaCd: areaCd ?? this.areaCd,
      infoTypes: infoTypes ?? this.infoTypes,
      leaveFrom: leaveFrom ?? this.leaveFrom,
      leaveTo: leaveTo ?? this.leaveTo,
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

bool _listEqual(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
