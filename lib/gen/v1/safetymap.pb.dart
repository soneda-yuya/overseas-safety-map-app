// This is a generated file - do not edit.
//
// Generated from v1/safetymap.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $1;
import 'common.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// SafetyIncident is one processed MOFA mail item with geocoded location.
class SafetyIncident extends $pb.GeneratedMessage {
  factory SafetyIncident({
    $core.String? keyCd,
    $core.String? infoType,
    $core.String? infoName,
    $1.Timestamp? leaveDate,
    $core.String? title,
    $core.String? lead,
    $core.String? mainText,
    $core.String? infoUrl,
    $core.String? koukanCd,
    $core.String? koukanName,
    $core.String? areaCd,
    $core.String? areaName,
    $core.String? countryCd,
    $core.String? countryName,
    $core.String? extractedLocation,
    $2.Point? geometry,
    $2.GeocodeSource? geocodeSource,
    $1.Timestamp? ingestedAt,
    $1.Timestamp? updatedAt,
  }) {
    final result = create();
    if (keyCd != null) result.keyCd = keyCd;
    if (infoType != null) result.infoType = infoType;
    if (infoName != null) result.infoName = infoName;
    if (leaveDate != null) result.leaveDate = leaveDate;
    if (title != null) result.title = title;
    if (lead != null) result.lead = lead;
    if (mainText != null) result.mainText = mainText;
    if (infoUrl != null) result.infoUrl = infoUrl;
    if (koukanCd != null) result.koukanCd = koukanCd;
    if (koukanName != null) result.koukanName = koukanName;
    if (areaCd != null) result.areaCd = areaCd;
    if (areaName != null) result.areaName = areaName;
    if (countryCd != null) result.countryCd = countryCd;
    if (countryName != null) result.countryName = countryName;
    if (extractedLocation != null) result.extractedLocation = extractedLocation;
    if (geometry != null) result.geometry = geometry;
    if (geocodeSource != null) result.geocodeSource = geocodeSource;
    if (ingestedAt != null) result.ingestedAt = ingestedAt;
    if (updatedAt != null) result.updatedAt = updatedAt;
    return result;
  }

  SafetyIncident._();

  factory SafetyIncident.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SafetyIncident.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SafetyIncident',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyCd')
    ..aOS(2, _omitFieldNames ? '' : 'infoType')
    ..aOS(3, _omitFieldNames ? '' : 'infoName')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'leaveDate',
        subBuilder: $1.Timestamp.create)
    ..aOS(5, _omitFieldNames ? '' : 'title')
    ..aOS(6, _omitFieldNames ? '' : 'lead')
    ..aOS(7, _omitFieldNames ? '' : 'mainText')
    ..aOS(8, _omitFieldNames ? '' : 'infoUrl')
    ..aOS(9, _omitFieldNames ? '' : 'koukanCd')
    ..aOS(10, _omitFieldNames ? '' : 'koukanName')
    ..aOS(11, _omitFieldNames ? '' : 'areaCd')
    ..aOS(12, _omitFieldNames ? '' : 'areaName')
    ..aOS(13, _omitFieldNames ? '' : 'countryCd')
    ..aOS(14, _omitFieldNames ? '' : 'countryName')
    ..aOS(15, _omitFieldNames ? '' : 'extractedLocation')
    ..aOM<$2.Point>(16, _omitFieldNames ? '' : 'geometry',
        subBuilder: $2.Point.create)
    ..e<$2.GeocodeSource>(
        17, _omitFieldNames ? '' : 'geocodeSource', $pb.PbFieldType.OE,
        defaultOrMaker: $2.GeocodeSource.GEOCODE_SOURCE_UNSPECIFIED,
        valueOf: $2.GeocodeSource.valueOf,
        enumValues: $2.GeocodeSource.values)
    ..aOM<$1.Timestamp>(18, _omitFieldNames ? '' : 'ingestedAt',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(19, _omitFieldNames ? '' : 'updatedAt',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SafetyIncident clone() => SafetyIncident()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SafetyIncident copyWith(void Function(SafetyIncident) updates) =>
      super.copyWith((message) => updates(message as SafetyIncident))
          as SafetyIncident;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SafetyIncident create() => SafetyIncident._();
  @$core.override
  SafetyIncident createEmptyInstance() => create();
  static $pb.PbList<SafetyIncident> createRepeated() =>
      $pb.PbList<SafetyIncident>();
  @$core.pragma('dart2js:noInline')
  static SafetyIncident getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SafetyIncident>(create);
  static SafetyIncident? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get keyCd => $_getSZ(0);
  @$pb.TagNumber(1)
  set keyCd($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKeyCd() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyCd() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get infoType => $_getSZ(1);
  @$pb.TagNumber(2)
  set infoType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasInfoType() => $_has(1);
  @$pb.TagNumber(2)
  void clearInfoType() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get infoName => $_getSZ(2);
  @$pb.TagNumber(3)
  set infoName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasInfoName() => $_has(2);
  @$pb.TagNumber(3)
  void clearInfoName() => $_clearField(3);

  @$pb.TagNumber(4)
  $1.Timestamp get leaveDate => $_getN(3);
  @$pb.TagNumber(4)
  set leaveDate($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLeaveDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearLeaveDate() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureLeaveDate() => $_ensure(3);

  @$pb.TagNumber(5)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(5)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitle() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get lead => $_getSZ(5);
  @$pb.TagNumber(6)
  set lead($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLead() => $_has(5);
  @$pb.TagNumber(6)
  void clearLead() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get mainText => $_getSZ(6);
  @$pb.TagNumber(7)
  set mainText($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMainText() => $_has(6);
  @$pb.TagNumber(7)
  void clearMainText() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.String get infoUrl => $_getSZ(7);
  @$pb.TagNumber(8)
  set infoUrl($core.String value) => $_setString(7, value);
  @$pb.TagNumber(8)
  $core.bool hasInfoUrl() => $_has(7);
  @$pb.TagNumber(8)
  void clearInfoUrl() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.String get koukanCd => $_getSZ(8);
  @$pb.TagNumber(9)
  set koukanCd($core.String value) => $_setString(8, value);
  @$pb.TagNumber(9)
  $core.bool hasKoukanCd() => $_has(8);
  @$pb.TagNumber(9)
  void clearKoukanCd() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.String get koukanName => $_getSZ(9);
  @$pb.TagNumber(10)
  set koukanName($core.String value) => $_setString(9, value);
  @$pb.TagNumber(10)
  $core.bool hasKoukanName() => $_has(9);
  @$pb.TagNumber(10)
  void clearKoukanName() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.String get areaCd => $_getSZ(10);
  @$pb.TagNumber(11)
  set areaCd($core.String value) => $_setString(10, value);
  @$pb.TagNumber(11)
  $core.bool hasAreaCd() => $_has(10);
  @$pb.TagNumber(11)
  void clearAreaCd() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.String get areaName => $_getSZ(11);
  @$pb.TagNumber(12)
  set areaName($core.String value) => $_setString(11, value);
  @$pb.TagNumber(12)
  $core.bool hasAreaName() => $_has(11);
  @$pb.TagNumber(12)
  void clearAreaName() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.String get countryCd => $_getSZ(12);
  @$pb.TagNumber(13)
  set countryCd($core.String value) => $_setString(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCountryCd() => $_has(12);
  @$pb.TagNumber(13)
  void clearCountryCd() => $_clearField(13);

  @$pb.TagNumber(14)
  $core.String get countryName => $_getSZ(13);
  @$pb.TagNumber(14)
  set countryName($core.String value) => $_setString(13, value);
  @$pb.TagNumber(14)
  $core.bool hasCountryName() => $_has(13);
  @$pb.TagNumber(14)
  void clearCountryName() => $_clearField(14);

  @$pb.TagNumber(15)
  $core.String get extractedLocation => $_getSZ(14);
  @$pb.TagNumber(15)
  set extractedLocation($core.String value) => $_setString(14, value);
  @$pb.TagNumber(15)
  $core.bool hasExtractedLocation() => $_has(14);
  @$pb.TagNumber(15)
  void clearExtractedLocation() => $_clearField(15);

  @$pb.TagNumber(16)
  $2.Point get geometry => $_getN(15);
  @$pb.TagNumber(16)
  set geometry($2.Point value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasGeometry() => $_has(15);
  @$pb.TagNumber(16)
  void clearGeometry() => $_clearField(16);
  @$pb.TagNumber(16)
  $2.Point ensureGeometry() => $_ensure(15);

  @$pb.TagNumber(17)
  $2.GeocodeSource get geocodeSource => $_getN(16);
  @$pb.TagNumber(17)
  set geocodeSource($2.GeocodeSource value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasGeocodeSource() => $_has(16);
  @$pb.TagNumber(17)
  void clearGeocodeSource() => $_clearField(17);

  @$pb.TagNumber(18)
  $1.Timestamp get ingestedAt => $_getN(17);
  @$pb.TagNumber(18)
  set ingestedAt($1.Timestamp value) => $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasIngestedAt() => $_has(17);
  @$pb.TagNumber(18)
  void clearIngestedAt() => $_clearField(18);
  @$pb.TagNumber(18)
  $1.Timestamp ensureIngestedAt() => $_ensure(17);

  @$pb.TagNumber(19)
  $1.Timestamp get updatedAt => $_getN(18);
  @$pb.TagNumber(19)
  set updatedAt($1.Timestamp value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasUpdatedAt() => $_has(18);
  @$pb.TagNumber(19)
  void clearUpdatedAt() => $_clearField(19);
  @$pb.TagNumber(19)
  $1.Timestamp ensureUpdatedAt() => $_ensure(18);
}

class SafetyIncidentFilter extends $pb.GeneratedMessage {
  factory SafetyIncidentFilter({
    $core.String? areaCd,
    $core.String? countryCd,
    $core.Iterable<$core.String>? infoTypes,
    $1.Timestamp? leaveFrom,
    $1.Timestamp? leaveTo,
    $core.int? limit,
    $core.String? cursor,
  }) {
    final result = create();
    if (areaCd != null) result.areaCd = areaCd;
    if (countryCd != null) result.countryCd = countryCd;
    if (infoTypes != null) result.infoTypes.addAll(infoTypes);
    if (leaveFrom != null) result.leaveFrom = leaveFrom;
    if (leaveTo != null) result.leaveTo = leaveTo;
    if (limit != null) result.limit = limit;
    if (cursor != null) result.cursor = cursor;
    return result;
  }

  SafetyIncidentFilter._();

  factory SafetyIncidentFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SafetyIncidentFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SafetyIncidentFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'areaCd')
    ..aOS(2, _omitFieldNames ? '' : 'countryCd')
    ..pPS(3, _omitFieldNames ? '' : 'infoTypes')
    ..aOM<$1.Timestamp>(4, _omitFieldNames ? '' : 'leaveFrom',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(5, _omitFieldNames ? '' : 'leaveTo',
        subBuilder: $1.Timestamp.create)
    ..a<$core.int>(6, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..aOS(7, _omitFieldNames ? '' : 'cursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SafetyIncidentFilter clone() =>
      SafetyIncidentFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SafetyIncidentFilter copyWith(void Function(SafetyIncidentFilter) updates) =>
      super.copyWith((message) => updates(message as SafetyIncidentFilter))
          as SafetyIncidentFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SafetyIncidentFilter create() => SafetyIncidentFilter._();
  @$core.override
  SafetyIncidentFilter createEmptyInstance() => create();
  static $pb.PbList<SafetyIncidentFilter> createRepeated() =>
      $pb.PbList<SafetyIncidentFilter>();
  @$core.pragma('dart2js:noInline')
  static SafetyIncidentFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SafetyIncidentFilter>(create);
  static SafetyIncidentFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get areaCd => $_getSZ(0);
  @$pb.TagNumber(1)
  set areaCd($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAreaCd() => $_has(0);
  @$pb.TagNumber(1)
  void clearAreaCd() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCd => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCd($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCd() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCd() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get infoTypes => $_getList(2);

  @$pb.TagNumber(4)
  $1.Timestamp get leaveFrom => $_getN(3);
  @$pb.TagNumber(4)
  set leaveFrom($1.Timestamp value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasLeaveFrom() => $_has(3);
  @$pb.TagNumber(4)
  void clearLeaveFrom() => $_clearField(4);
  @$pb.TagNumber(4)
  $1.Timestamp ensureLeaveFrom() => $_ensure(3);

  @$pb.TagNumber(5)
  $1.Timestamp get leaveTo => $_getN(4);
  @$pb.TagNumber(5)
  set leaveTo($1.Timestamp value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasLeaveTo() => $_has(4);
  @$pb.TagNumber(5)
  void clearLeaveTo() => $_clearField(5);
  @$pb.TagNumber(5)
  $1.Timestamp ensureLeaveTo() => $_ensure(4);

  @$pb.TagNumber(6)
  $core.int get limit => $_getIZ(5);
  @$pb.TagNumber(6)
  set limit($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.String get cursor => $_getSZ(6);
  @$pb.TagNumber(7)
  set cursor($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCursor() => $_has(6);
  @$pb.TagNumber(7)
  void clearCursor() => $_clearField(7);
}

class ListSafetyIncidentsRequest extends $pb.GeneratedMessage {
  factory ListSafetyIncidentsRequest({
    SafetyIncidentFilter? filter,
  }) {
    final result = create();
    if (filter != null) result.filter = filter;
    return result;
  }

  ListSafetyIncidentsRequest._();

  factory ListSafetyIncidentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSafetyIncidentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSafetyIncidentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<SafetyIncidentFilter>(1, _omitFieldNames ? '' : 'filter',
        subBuilder: SafetyIncidentFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSafetyIncidentsRequest clone() =>
      ListSafetyIncidentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSafetyIncidentsRequest copyWith(
          void Function(ListSafetyIncidentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ListSafetyIncidentsRequest))
          as ListSafetyIncidentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSafetyIncidentsRequest create() => ListSafetyIncidentsRequest._();
  @$core.override
  ListSafetyIncidentsRequest createEmptyInstance() => create();
  static $pb.PbList<ListSafetyIncidentsRequest> createRepeated() =>
      $pb.PbList<ListSafetyIncidentsRequest>();
  @$core.pragma('dart2js:noInline')
  static ListSafetyIncidentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSafetyIncidentsRequest>(create);
  static ListSafetyIncidentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SafetyIncidentFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(SafetyIncidentFilter value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => $_clearField(1);
  @$pb.TagNumber(1)
  SafetyIncidentFilter ensureFilter() => $_ensure(0);
}

class ListSafetyIncidentsResponse extends $pb.GeneratedMessage {
  factory ListSafetyIncidentsResponse({
    $core.Iterable<SafetyIncident>? items,
    $core.String? nextCursor,
    $core.int? totalHint,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (nextCursor != null) result.nextCursor = nextCursor;
    if (totalHint != null) result.totalHint = totalHint;
    return result;
  }

  ListSafetyIncidentsResponse._();

  factory ListSafetyIncidentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListSafetyIncidentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSafetyIncidentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..pc<SafetyIncident>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: SafetyIncident.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextCursor')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'totalHint', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSafetyIncidentsResponse clone() =>
      ListSafetyIncidentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSafetyIncidentsResponse copyWith(
          void Function(ListSafetyIncidentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ListSafetyIncidentsResponse))
          as ListSafetyIncidentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListSafetyIncidentsResponse create() =>
      ListSafetyIncidentsResponse._();
  @$core.override
  ListSafetyIncidentsResponse createEmptyInstance() => create();
  static $pb.PbList<ListSafetyIncidentsResponse> createRepeated() =>
      $pb.PbList<ListSafetyIncidentsResponse>();
  @$core.pragma('dart2js:noInline')
  static ListSafetyIncidentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSafetyIncidentsResponse>(create);
  static ListSafetyIncidentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SafetyIncident> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextCursor => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextCursor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextCursor() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get totalHint => $_getIZ(2);
  @$pb.TagNumber(3)
  set totalHint($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotalHint() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotalHint() => $_clearField(3);
}

class GetSafetyIncidentRequest extends $pb.GeneratedMessage {
  factory GetSafetyIncidentRequest({
    $core.String? keyCd,
  }) {
    final result = create();
    if (keyCd != null) result.keyCd = keyCd;
    return result;
  }

  GetSafetyIncidentRequest._();

  factory GetSafetyIncidentRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSafetyIncidentRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSafetyIncidentRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyCd')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentRequest clone() =>
      GetSafetyIncidentRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentRequest copyWith(
          void Function(GetSafetyIncidentRequest) updates) =>
      super.copyWith((message) => updates(message as GetSafetyIncidentRequest))
          as GetSafetyIncidentRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentRequest create() => GetSafetyIncidentRequest._();
  @$core.override
  GetSafetyIncidentRequest createEmptyInstance() => create();
  static $pb.PbList<GetSafetyIncidentRequest> createRepeated() =>
      $pb.PbList<GetSafetyIncidentRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSafetyIncidentRequest>(create);
  static GetSafetyIncidentRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get keyCd => $_getSZ(0);
  @$pb.TagNumber(1)
  set keyCd($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKeyCd() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyCd() => $_clearField(1);
}

class GetSafetyIncidentResponse extends $pb.GeneratedMessage {
  factory GetSafetyIncidentResponse({
    SafetyIncident? item,
  }) {
    final result = create();
    if (item != null) result.item = item;
    return result;
  }

  GetSafetyIncidentResponse._();

  factory GetSafetyIncidentResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSafetyIncidentResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSafetyIncidentResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<SafetyIncident>(1, _omitFieldNames ? '' : 'item',
        subBuilder: SafetyIncident.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentResponse clone() =>
      GetSafetyIncidentResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentResponse copyWith(
          void Function(GetSafetyIncidentResponse) updates) =>
      super.copyWith((message) => updates(message as GetSafetyIncidentResponse))
          as GetSafetyIncidentResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentResponse create() => GetSafetyIncidentResponse._();
  @$core.override
  GetSafetyIncidentResponse createEmptyInstance() => create();
  static $pb.PbList<GetSafetyIncidentResponse> createRepeated() =>
      $pb.PbList<GetSafetyIncidentResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSafetyIncidentResponse>(create);
  static GetSafetyIncidentResponse? _defaultInstance;

  @$pb.TagNumber(1)
  SafetyIncident get item => $_getN(0);
  @$pb.TagNumber(1)
  set item(SafetyIncident value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasItem() => $_has(0);
  @$pb.TagNumber(1)
  void clearItem() => $_clearField(1);
  @$pb.TagNumber(1)
  SafetyIncident ensureItem() => $_ensure(0);
}

class SearchSafetyIncidentsRequest extends $pb.GeneratedMessage {
  factory SearchSafetyIncidentsRequest({
    SafetyIncidentFilter? filter,
    $core.String? query,
  }) {
    final result = create();
    if (filter != null) result.filter = filter;
    if (query != null) result.query = query;
    return result;
  }

  SearchSafetyIncidentsRequest._();

  factory SearchSafetyIncidentsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchSafetyIncidentsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchSafetyIncidentsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<SafetyIncidentFilter>(1, _omitFieldNames ? '' : 'filter',
        subBuilder: SafetyIncidentFilter.create)
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchSafetyIncidentsRequest clone() =>
      SearchSafetyIncidentsRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchSafetyIncidentsRequest copyWith(
          void Function(SearchSafetyIncidentsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SearchSafetyIncidentsRequest))
          as SearchSafetyIncidentsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchSafetyIncidentsRequest create() =>
      SearchSafetyIncidentsRequest._();
  @$core.override
  SearchSafetyIncidentsRequest createEmptyInstance() => create();
  static $pb.PbList<SearchSafetyIncidentsRequest> createRepeated() =>
      $pb.PbList<SearchSafetyIncidentsRequest>();
  @$core.pragma('dart2js:noInline')
  static SearchSafetyIncidentsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchSafetyIncidentsRequest>(create);
  static SearchSafetyIncidentsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SafetyIncidentFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(SafetyIncidentFilter value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => $_clearField(1);
  @$pb.TagNumber(1)
  SafetyIncidentFilter ensureFilter() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => $_clearField(2);
}

class SearchSafetyIncidentsResponse extends $pb.GeneratedMessage {
  factory SearchSafetyIncidentsResponse({
    $core.Iterable<SafetyIncident>? items,
    $core.String? nextCursor,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (nextCursor != null) result.nextCursor = nextCursor;
    return result;
  }

  SearchSafetyIncidentsResponse._();

  factory SearchSafetyIncidentsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory SearchSafetyIncidentsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchSafetyIncidentsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..pc<SafetyIncident>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: SafetyIncident.create)
    ..aOS(2, _omitFieldNames ? '' : 'nextCursor')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchSafetyIncidentsResponse clone() =>
      SearchSafetyIncidentsResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchSafetyIncidentsResponse copyWith(
          void Function(SearchSafetyIncidentsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SearchSafetyIncidentsResponse))
          as SearchSafetyIncidentsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SearchSafetyIncidentsResponse create() =>
      SearchSafetyIncidentsResponse._();
  @$core.override
  SearchSafetyIncidentsResponse createEmptyInstance() => create();
  static $pb.PbList<SearchSafetyIncidentsResponse> createRepeated() =>
      $pb.PbList<SearchSafetyIncidentsResponse>();
  @$core.pragma('dart2js:noInline')
  static SearchSafetyIncidentsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchSafetyIncidentsResponse>(create);
  static SearchSafetyIncidentsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SafetyIncident> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.String get nextCursor => $_getSZ(1);
  @$pb.TagNumber(2)
  set nextCursor($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNextCursor() => $_has(1);
  @$pb.TagNumber(2)
  void clearNextCursor() => $_clearField(2);
}

class ListNearbyRequest extends $pb.GeneratedMessage {
  factory ListNearbyRequest({
    $2.Point? center,
    $core.double? radiusKm,
    $core.int? limit,
  }) {
    final result = create();
    if (center != null) result.center = center;
    if (radiusKm != null) result.radiusKm = radiusKm;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListNearbyRequest._();

  factory ListNearbyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListNearbyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListNearbyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<$2.Point>(1, _omitFieldNames ? '' : 'center',
        subBuilder: $2.Point.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'radiusKm', $pb.PbFieldType.OD)
    ..a<$core.int>(3, _omitFieldNames ? '' : 'limit', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListNearbyRequest clone() => ListNearbyRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListNearbyRequest copyWith(void Function(ListNearbyRequest) updates) =>
      super.copyWith((message) => updates(message as ListNearbyRequest))
          as ListNearbyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListNearbyRequest create() => ListNearbyRequest._();
  @$core.override
  ListNearbyRequest createEmptyInstance() => create();
  static $pb.PbList<ListNearbyRequest> createRepeated() =>
      $pb.PbList<ListNearbyRequest>();
  @$core.pragma('dart2js:noInline')
  static ListNearbyRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListNearbyRequest>(create);
  static ListNearbyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Point get center => $_getN(0);
  @$pb.TagNumber(1)
  set center($2.Point value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCenter() => $_has(0);
  @$pb.TagNumber(1)
  void clearCenter() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Point ensureCenter() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get radiusKm => $_getN(1);
  @$pb.TagNumber(2)
  set radiusKm($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRadiusKm() => $_has(1);
  @$pb.TagNumber(2)
  void clearRadiusKm() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class ListNearbyResponse extends $pb.GeneratedMessage {
  factory ListNearbyResponse({
    $core.Iterable<SafetyIncident>? items,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    return result;
  }

  ListNearbyResponse._();

  factory ListNearbyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ListNearbyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListNearbyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..pc<SafetyIncident>(1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: SafetyIncident.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListNearbyResponse clone() => ListNearbyResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListNearbyResponse copyWith(void Function(ListNearbyResponse) updates) =>
      super.copyWith((message) => updates(message as ListNearbyResponse))
          as ListNearbyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ListNearbyResponse create() => ListNearbyResponse._();
  @$core.override
  ListNearbyResponse createEmptyInstance() => create();
  static $pb.PbList<ListNearbyResponse> createRepeated() =>
      $pb.PbList<ListNearbyResponse>();
  @$core.pragma('dart2js:noInline')
  static ListNearbyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListNearbyResponse>(create);
  static ListNearbyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<SafetyIncident> get items => $_getList(0);
}

class GetSafetyIncidentsAsGeoJSONRequest extends $pb.GeneratedMessage {
  factory GetSafetyIncidentsAsGeoJSONRequest({
    SafetyIncidentFilter? filter,
  }) {
    final result = create();
    if (filter != null) result.filter = filter;
    return result;
  }

  GetSafetyIncidentsAsGeoJSONRequest._();

  factory GetSafetyIncidentsAsGeoJSONRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSafetyIncidentsAsGeoJSONRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSafetyIncidentsAsGeoJSONRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<SafetyIncidentFilter>(1, _omitFieldNames ? '' : 'filter',
        subBuilder: SafetyIncidentFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentsAsGeoJSONRequest clone() =>
      GetSafetyIncidentsAsGeoJSONRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentsAsGeoJSONRequest copyWith(
          void Function(GetSafetyIncidentsAsGeoJSONRequest) updates) =>
      super.copyWith((message) =>
              updates(message as GetSafetyIncidentsAsGeoJSONRequest))
          as GetSafetyIncidentsAsGeoJSONRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentsAsGeoJSONRequest create() =>
      GetSafetyIncidentsAsGeoJSONRequest._();
  @$core.override
  GetSafetyIncidentsAsGeoJSONRequest createEmptyInstance() => create();
  static $pb.PbList<GetSafetyIncidentsAsGeoJSONRequest> createRepeated() =>
      $pb.PbList<GetSafetyIncidentsAsGeoJSONRequest>();
  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentsAsGeoJSONRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetSafetyIncidentsAsGeoJSONRequest>(
          create);
  static GetSafetyIncidentsAsGeoJSONRequest? _defaultInstance;

  @$pb.TagNumber(1)
  SafetyIncidentFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(SafetyIncidentFilter value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => $_clearField(1);
  @$pb.TagNumber(1)
  SafetyIncidentFilter ensureFilter() => $_ensure(0);
}

class GetSafetyIncidentsAsGeoJSONResponse extends $pb.GeneratedMessage {
  factory GetSafetyIncidentsAsGeoJSONResponse({
    $core.List<$core.int>? geojson,
  }) {
    final result = create();
    if (geojson != null) result.geojson = geojson;
    return result;
  }

  GetSafetyIncidentsAsGeoJSONResponse._();

  factory GetSafetyIncidentsAsGeoJSONResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetSafetyIncidentsAsGeoJSONResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetSafetyIncidentsAsGeoJSONResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..a<$core.List<$core.int>>(
        1, _omitFieldNames ? '' : 'geojson', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentsAsGeoJSONResponse clone() =>
      GetSafetyIncidentsAsGeoJSONResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetSafetyIncidentsAsGeoJSONResponse copyWith(
          void Function(GetSafetyIncidentsAsGeoJSONResponse) updates) =>
      super.copyWith((message) =>
              updates(message as GetSafetyIncidentsAsGeoJSONResponse))
          as GetSafetyIncidentsAsGeoJSONResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentsAsGeoJSONResponse create() =>
      GetSafetyIncidentsAsGeoJSONResponse._();
  @$core.override
  GetSafetyIncidentsAsGeoJSONResponse createEmptyInstance() => create();
  static $pb.PbList<GetSafetyIncidentsAsGeoJSONResponse> createRepeated() =>
      $pb.PbList<GetSafetyIncidentsAsGeoJSONResponse>();
  @$core.pragma('dart2js:noInline')
  static GetSafetyIncidentsAsGeoJSONResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          GetSafetyIncidentsAsGeoJSONResponse>(create);
  static GetSafetyIncidentsAsGeoJSONResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get geojson => $_getN(0);
  @$pb.TagNumber(1)
  set geojson($core.List<$core.int> value) => $_setBytes(0, value);
  @$pb.TagNumber(1)
  $core.bool hasGeojson() => $_has(0);
  @$pb.TagNumber(1)
  void clearGeojson() => $_clearField(1);
}

/// ---- CrimeMap ----
class CrimeMapFilter extends $pb.GeneratedMessage {
  factory CrimeMapFilter({
    $1.Timestamp? leaveFrom,
    $1.Timestamp? leaveTo,
  }) {
    final result = create();
    if (leaveFrom != null) result.leaveFrom = leaveFrom;
    if (leaveTo != null) result.leaveTo = leaveTo;
    return result;
  }

  CrimeMapFilter._();

  factory CrimeMapFilter.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CrimeMapFilter.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CrimeMapFilter',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<$1.Timestamp>(1, _omitFieldNames ? '' : 'leaveFrom',
        subBuilder: $1.Timestamp.create)
    ..aOM<$1.Timestamp>(2, _omitFieldNames ? '' : 'leaveTo',
        subBuilder: $1.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrimeMapFilter clone() => CrimeMapFilter()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CrimeMapFilter copyWith(void Function(CrimeMapFilter) updates) =>
      super.copyWith((message) => updates(message as CrimeMapFilter))
          as CrimeMapFilter;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CrimeMapFilter create() => CrimeMapFilter._();
  @$core.override
  CrimeMapFilter createEmptyInstance() => create();
  static $pb.PbList<CrimeMapFilter> createRepeated() =>
      $pb.PbList<CrimeMapFilter>();
  @$core.pragma('dart2js:noInline')
  static CrimeMapFilter getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CrimeMapFilter>(create);
  static CrimeMapFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Timestamp get leaveFrom => $_getN(0);
  @$pb.TagNumber(1)
  set leaveFrom($1.Timestamp value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLeaveFrom() => $_has(0);
  @$pb.TagNumber(1)
  void clearLeaveFrom() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Timestamp ensureLeaveFrom() => $_ensure(0);

  @$pb.TagNumber(2)
  $1.Timestamp get leaveTo => $_getN(1);
  @$pb.TagNumber(2)
  set leaveTo($1.Timestamp value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasLeaveTo() => $_has(1);
  @$pb.TagNumber(2)
  void clearLeaveTo() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Timestamp ensureLeaveTo() => $_ensure(1);
}

class CountryChoropleth extends $pb.GeneratedMessage {
  factory CountryChoropleth({
    $core.String? countryCd,
    $core.String? countryName,
    $core.int? count,
    $core.String? color,
  }) {
    final result = create();
    if (countryCd != null) result.countryCd = countryCd;
    if (countryName != null) result.countryName = countryName;
    if (count != null) result.count = count;
    if (color != null) result.color = color;
    return result;
  }

  CountryChoropleth._();

  factory CountryChoropleth.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory CountryChoropleth.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CountryChoropleth',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCd')
    ..aOS(2, _omitFieldNames ? '' : 'countryName')
    ..a<$core.int>(3, _omitFieldNames ? '' : 'count', $pb.PbFieldType.O3)
    ..aOS(4, _omitFieldNames ? '' : 'color')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountryChoropleth clone() => CountryChoropleth()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CountryChoropleth copyWith(void Function(CountryChoropleth) updates) =>
      super.copyWith((message) => updates(message as CountryChoropleth))
          as CountryChoropleth;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CountryChoropleth create() => CountryChoropleth._();
  @$core.override
  CountryChoropleth createEmptyInstance() => create();
  static $pb.PbList<CountryChoropleth> createRepeated() =>
      $pb.PbList<CountryChoropleth>();
  @$core.pragma('dart2js:noInline')
  static CountryChoropleth getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CountryChoropleth>(create);
  static CountryChoropleth? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCd => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCd($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCd() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCd() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryName => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryName() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get count => $_getIZ(2);
  @$pb.TagNumber(3)
  set count($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get color => $_getSZ(3);
  @$pb.TagNumber(4)
  set color($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasColor() => $_has(3);
  @$pb.TagNumber(4)
  void clearColor() => $_clearField(4);
}

class HeatmapPoint extends $pb.GeneratedMessage {
  factory HeatmapPoint({
    $2.Point? location,
    $core.double? weight,
  }) {
    final result = create();
    if (location != null) result.location = location;
    if (weight != null) result.weight = weight;
    return result;
  }

  HeatmapPoint._();

  factory HeatmapPoint.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory HeatmapPoint.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HeatmapPoint',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<$2.Point>(1, _omitFieldNames ? '' : 'location',
        subBuilder: $2.Point.create)
    ..a<$core.double>(2, _omitFieldNames ? '' : 'weight', $pb.PbFieldType.OD)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatmapPoint clone() => HeatmapPoint()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HeatmapPoint copyWith(void Function(HeatmapPoint) updates) =>
      super.copyWith((message) => updates(message as HeatmapPoint))
          as HeatmapPoint;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static HeatmapPoint create() => HeatmapPoint._();
  @$core.override
  HeatmapPoint createEmptyInstance() => create();
  static $pb.PbList<HeatmapPoint> createRepeated() =>
      $pb.PbList<HeatmapPoint>();
  @$core.pragma('dart2js:noInline')
  static HeatmapPoint getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HeatmapPoint>(create);
  static HeatmapPoint? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Point get location => $_getN(0);
  @$pb.TagNumber(1)
  set location($2.Point value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasLocation() => $_has(0);
  @$pb.TagNumber(1)
  void clearLocation() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Point ensureLocation() => $_ensure(0);

  @$pb.TagNumber(2)
  $core.double get weight => $_getN(1);
  @$pb.TagNumber(2)
  set weight($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWeight() => $_has(1);
  @$pb.TagNumber(2)
  void clearWeight() => $_clearField(2);
}

class GetChoroplethRequest extends $pb.GeneratedMessage {
  factory GetChoroplethRequest({
    CrimeMapFilter? filter,
  }) {
    final result = create();
    if (filter != null) result.filter = filter;
    return result;
  }

  GetChoroplethRequest._();

  factory GetChoroplethRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChoroplethRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChoroplethRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<CrimeMapFilter>(1, _omitFieldNames ? '' : 'filter',
        subBuilder: CrimeMapFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChoroplethRequest clone() =>
      GetChoroplethRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChoroplethRequest copyWith(void Function(GetChoroplethRequest) updates) =>
      super.copyWith((message) => updates(message as GetChoroplethRequest))
          as GetChoroplethRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChoroplethRequest create() => GetChoroplethRequest._();
  @$core.override
  GetChoroplethRequest createEmptyInstance() => create();
  static $pb.PbList<GetChoroplethRequest> createRepeated() =>
      $pb.PbList<GetChoroplethRequest>();
  @$core.pragma('dart2js:noInline')
  static GetChoroplethRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChoroplethRequest>(create);
  static GetChoroplethRequest? _defaultInstance;

  @$pb.TagNumber(1)
  CrimeMapFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(CrimeMapFilter value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => $_clearField(1);
  @$pb.TagNumber(1)
  CrimeMapFilter ensureFilter() => $_ensure(0);
}

class GetChoroplethResponse extends $pb.GeneratedMessage {
  factory GetChoroplethResponse({
    $core.Iterable<CountryChoropleth>? items,
    $core.int? total,
  }) {
    final result = create();
    if (items != null) result.items.addAll(items);
    if (total != null) result.total = total;
    return result;
  }

  GetChoroplethResponse._();

  factory GetChoroplethResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetChoroplethResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChoroplethResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..pc<CountryChoropleth>(
        1, _omitFieldNames ? '' : 'items', $pb.PbFieldType.PM,
        subBuilder: CountryChoropleth.create)
    ..a<$core.int>(2, _omitFieldNames ? '' : 'total', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChoroplethResponse clone() =>
      GetChoroplethResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChoroplethResponse copyWith(
          void Function(GetChoroplethResponse) updates) =>
      super.copyWith((message) => updates(message as GetChoroplethResponse))
          as GetChoroplethResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetChoroplethResponse create() => GetChoroplethResponse._();
  @$core.override
  GetChoroplethResponse createEmptyInstance() => create();
  static $pb.PbList<GetChoroplethResponse> createRepeated() =>
      $pb.PbList<GetChoroplethResponse>();
  @$core.pragma('dart2js:noInline')
  static GetChoroplethResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetChoroplethResponse>(create);
  static GetChoroplethResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<CountryChoropleth> get items => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

class GetHeatmapRequest extends $pb.GeneratedMessage {
  factory GetHeatmapRequest({
    CrimeMapFilter? filter,
  }) {
    final result = create();
    if (filter != null) result.filter = filter;
    return result;
  }

  GetHeatmapRequest._();

  factory GetHeatmapRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHeatmapRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHeatmapRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<CrimeMapFilter>(1, _omitFieldNames ? '' : 'filter',
        subBuilder: CrimeMapFilter.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHeatmapRequest clone() => GetHeatmapRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHeatmapRequest copyWith(void Function(GetHeatmapRequest) updates) =>
      super.copyWith((message) => updates(message as GetHeatmapRequest))
          as GetHeatmapRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHeatmapRequest create() => GetHeatmapRequest._();
  @$core.override
  GetHeatmapRequest createEmptyInstance() => create();
  static $pb.PbList<GetHeatmapRequest> createRepeated() =>
      $pb.PbList<GetHeatmapRequest>();
  @$core.pragma('dart2js:noInline')
  static GetHeatmapRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHeatmapRequest>(create);
  static GetHeatmapRequest? _defaultInstance;

  @$pb.TagNumber(1)
  CrimeMapFilter get filter => $_getN(0);
  @$pb.TagNumber(1)
  set filter(CrimeMapFilter value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasFilter() => $_has(0);
  @$pb.TagNumber(1)
  void clearFilter() => $_clearField(1);
  @$pb.TagNumber(1)
  CrimeMapFilter ensureFilter() => $_ensure(0);
}

class GetHeatmapResponse extends $pb.GeneratedMessage {
  factory GetHeatmapResponse({
    $core.Iterable<HeatmapPoint>? points,
    $core.int? excludedFallback,
  }) {
    final result = create();
    if (points != null) result.points.addAll(points);
    if (excludedFallback != null) result.excludedFallback = excludedFallback;
    return result;
  }

  GetHeatmapResponse._();

  factory GetHeatmapResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetHeatmapResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHeatmapResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..pc<HeatmapPoint>(1, _omitFieldNames ? '' : 'points', $pb.PbFieldType.PM,
        subBuilder: HeatmapPoint.create)
    ..a<$core.int>(
        2, _omitFieldNames ? '' : 'excludedFallback', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHeatmapResponse clone() => GetHeatmapResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHeatmapResponse copyWith(void Function(GetHeatmapResponse) updates) =>
      super.copyWith((message) => updates(message as GetHeatmapResponse))
          as GetHeatmapResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetHeatmapResponse create() => GetHeatmapResponse._();
  @$core.override
  GetHeatmapResponse createEmptyInstance() => create();
  static $pb.PbList<GetHeatmapResponse> createRepeated() =>
      $pb.PbList<GetHeatmapResponse>();
  @$core.pragma('dart2js:noInline')
  static GetHeatmapResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHeatmapResponse>(create);
  static GetHeatmapResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<HeatmapPoint> get points => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get excludedFallback => $_getIZ(1);
  @$pb.TagNumber(2)
  set excludedFallback($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExcludedFallback() => $_has(1);
  @$pb.TagNumber(2)
  void clearExcludedFallback() => $_clearField(2);
}

/// ---- UserProfile ----
class NotificationPreference extends $pb.GeneratedMessage {
  factory NotificationPreference({
    $core.bool? enabled,
    $core.Iterable<$core.String>? targetCountryCds,
    $core.Iterable<$core.String>? infoTypes,
  }) {
    final result = create();
    if (enabled != null) result.enabled = enabled;
    if (targetCountryCds != null)
      result.targetCountryCds.addAll(targetCountryCds);
    if (infoTypes != null) result.infoTypes.addAll(infoTypes);
    return result;
  }

  NotificationPreference._();

  factory NotificationPreference.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NotificationPreference.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NotificationPreference',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'enabled')
    ..pPS(2, _omitFieldNames ? '' : 'targetCountryCds')
    ..pPS(3, _omitFieldNames ? '' : 'infoTypes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationPreference clone() =>
      NotificationPreference()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NotificationPreference copyWith(
          void Function(NotificationPreference) updates) =>
      super.copyWith((message) => updates(message as NotificationPreference))
          as NotificationPreference;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NotificationPreference create() => NotificationPreference._();
  @$core.override
  NotificationPreference createEmptyInstance() => create();
  static $pb.PbList<NotificationPreference> createRepeated() =>
      $pb.PbList<NotificationPreference>();
  @$core.pragma('dart2js:noInline')
  static NotificationPreference getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NotificationPreference>(create);
  static NotificationPreference? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get enabled => $_getBF(0);
  @$pb.TagNumber(1)
  set enabled($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasEnabled() => $_has(0);
  @$pb.TagNumber(1)
  void clearEnabled() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get targetCountryCds => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$core.String> get infoTypes => $_getList(2);
}

class UserProfile extends $pb.GeneratedMessage {
  factory UserProfile({
    $core.String? uid,
    $core.Iterable<$core.String>? favoriteCountryCds,
    NotificationPreference? notificationPreference,
    $core.int? fcmTokenCount,
  }) {
    final result = create();
    if (uid != null) result.uid = uid;
    if (favoriteCountryCds != null)
      result.favoriteCountryCds.addAll(favoriteCountryCds);
    if (notificationPreference != null)
      result.notificationPreference = notificationPreference;
    if (fcmTokenCount != null) result.fcmTokenCount = fcmTokenCount;
    return result;
  }

  UserProfile._();

  factory UserProfile.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UserProfile.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserProfile',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'uid')
    ..pPS(2, _omitFieldNames ? '' : 'favoriteCountryCds')
    ..aOM<NotificationPreference>(
        3, _omitFieldNames ? '' : 'notificationPreference',
        subBuilder: NotificationPreference.create)
    ..a<$core.int>(
        4, _omitFieldNames ? '' : 'fcmTokenCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile clone() => UserProfile()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserProfile copyWith(void Function(UserProfile) updates) =>
      super.copyWith((message) => updates(message as UserProfile))
          as UserProfile;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UserProfile create() => UserProfile._();
  @$core.override
  UserProfile createEmptyInstance() => create();
  static $pb.PbList<UserProfile> createRepeated() => $pb.PbList<UserProfile>();
  @$core.pragma('dart2js:noInline')
  static UserProfile getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserProfile>(create);
  static UserProfile? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uid => $_getSZ(0);
  @$pb.TagNumber(1)
  set uid($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUid() => $_has(0);
  @$pb.TagNumber(1)
  void clearUid() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.String> get favoriteCountryCds => $_getList(1);

  @$pb.TagNumber(3)
  NotificationPreference get notificationPreference => $_getN(2);
  @$pb.TagNumber(3)
  set notificationPreference(NotificationPreference value) =>
      $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasNotificationPreference() => $_has(2);
  @$pb.TagNumber(3)
  void clearNotificationPreference() => $_clearField(3);
  @$pb.TagNumber(3)
  NotificationPreference ensureNotificationPreference() => $_ensure(2);

  @$pb.TagNumber(4)
  $core.int get fcmTokenCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set fcmTokenCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFcmTokenCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearFcmTokenCount() => $_clearField(4);
}

class GetProfileRequest extends $pb.GeneratedMessage {
  factory GetProfileRequest() => create();

  GetProfileRequest._();

  factory GetProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileRequest clone() => GetProfileRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileRequest copyWith(void Function(GetProfileRequest) updates) =>
      super.copyWith((message) => updates(message as GetProfileRequest))
          as GetProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProfileRequest create() => GetProfileRequest._();
  @$core.override
  GetProfileRequest createEmptyInstance() => create();
  static $pb.PbList<GetProfileRequest> createRepeated() =>
      $pb.PbList<GetProfileRequest>();
  @$core.pragma('dart2js:noInline')
  static GetProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProfileRequest>(create);
  static GetProfileRequest? _defaultInstance;
}

class GetProfileResponse extends $pb.GeneratedMessage {
  factory GetProfileResponse({
    UserProfile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  GetProfileResponse._();

  factory GetProfileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory GetProfileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetProfileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<UserProfile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: UserProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileResponse clone() => GetProfileResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetProfileResponse copyWith(void Function(GetProfileResponse) updates) =>
      super.copyWith((message) => updates(message as GetProfileResponse))
          as GetProfileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static GetProfileResponse create() => GetProfileResponse._();
  @$core.override
  GetProfileResponse createEmptyInstance() => create();
  static $pb.PbList<GetProfileResponse> createRepeated() =>
      $pb.PbList<GetProfileResponse>();
  @$core.pragma('dart2js:noInline')
  static GetProfileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetProfileResponse>(create);
  static GetProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(UserProfile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  UserProfile ensureProfile() => $_ensure(0);
}

class ToggleFavoriteCountryRequest extends $pb.GeneratedMessage {
  factory ToggleFavoriteCountryRequest({
    $core.String? countryCd,
  }) {
    final result = create();
    if (countryCd != null) result.countryCd = countryCd;
    return result;
  }

  ToggleFavoriteCountryRequest._();

  factory ToggleFavoriteCountryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleFavoriteCountryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavoriteCountryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'countryCd')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavoriteCountryRequest clone() =>
      ToggleFavoriteCountryRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavoriteCountryRequest copyWith(
          void Function(ToggleFavoriteCountryRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavoriteCountryRequest))
          as ToggleFavoriteCountryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteCountryRequest create() =>
      ToggleFavoriteCountryRequest._();
  @$core.override
  ToggleFavoriteCountryRequest createEmptyInstance() => create();
  static $pb.PbList<ToggleFavoriteCountryRequest> createRepeated() =>
      $pb.PbList<ToggleFavoriteCountryRequest>();
  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteCountryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavoriteCountryRequest>(create);
  static ToggleFavoriteCountryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get countryCd => $_getSZ(0);
  @$pb.TagNumber(1)
  set countryCd($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCountryCd() => $_has(0);
  @$pb.TagNumber(1)
  void clearCountryCd() => $_clearField(1);
}

class ToggleFavoriteCountryResponse extends $pb.GeneratedMessage {
  factory ToggleFavoriteCountryResponse({
    UserProfile? profile,
  }) {
    final result = create();
    if (profile != null) result.profile = profile;
    return result;
  }

  ToggleFavoriteCountryResponse._();

  factory ToggleFavoriteCountryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory ToggleFavoriteCountryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ToggleFavoriteCountryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<UserProfile>(1, _omitFieldNames ? '' : 'profile',
        subBuilder: UserProfile.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavoriteCountryResponse clone() =>
      ToggleFavoriteCountryResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ToggleFavoriteCountryResponse copyWith(
          void Function(ToggleFavoriteCountryResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ToggleFavoriteCountryResponse))
          as ToggleFavoriteCountryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteCountryResponse create() =>
      ToggleFavoriteCountryResponse._();
  @$core.override
  ToggleFavoriteCountryResponse createEmptyInstance() => create();
  static $pb.PbList<ToggleFavoriteCountryResponse> createRepeated() =>
      $pb.PbList<ToggleFavoriteCountryResponse>();
  @$core.pragma('dart2js:noInline')
  static ToggleFavoriteCountryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ToggleFavoriteCountryResponse>(create);
  static ToggleFavoriteCountryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  UserProfile get profile => $_getN(0);
  @$pb.TagNumber(1)
  set profile(UserProfile value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProfile() => $_has(0);
  @$pb.TagNumber(1)
  void clearProfile() => $_clearField(1);
  @$pb.TagNumber(1)
  UserProfile ensureProfile() => $_ensure(0);
}

class UpdateNotificationPreferenceRequest extends $pb.GeneratedMessage {
  factory UpdateNotificationPreferenceRequest({
    NotificationPreference? preference,
  }) {
    final result = create();
    if (preference != null) result.preference = preference;
    return result;
  }

  UpdateNotificationPreferenceRequest._();

  factory UpdateNotificationPreferenceRequest.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateNotificationPreferenceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateNotificationPreferenceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOM<NotificationPreference>(1, _omitFieldNames ? '' : 'preference',
        subBuilder: NotificationPreference.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationPreferenceRequest clone() =>
      UpdateNotificationPreferenceRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationPreferenceRequest copyWith(
          void Function(UpdateNotificationPreferenceRequest) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateNotificationPreferenceRequest))
          as UpdateNotificationPreferenceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNotificationPreferenceRequest create() =>
      UpdateNotificationPreferenceRequest._();
  @$core.override
  UpdateNotificationPreferenceRequest createEmptyInstance() => create();
  static $pb.PbList<UpdateNotificationPreferenceRequest> createRepeated() =>
      $pb.PbList<UpdateNotificationPreferenceRequest>();
  @$core.pragma('dart2js:noInline')
  static UpdateNotificationPreferenceRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateNotificationPreferenceRequest>(create);
  static UpdateNotificationPreferenceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  NotificationPreference get preference => $_getN(0);
  @$pb.TagNumber(1)
  set preference(NotificationPreference value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPreference() => $_has(0);
  @$pb.TagNumber(1)
  void clearPreference() => $_clearField(1);
  @$pb.TagNumber(1)
  NotificationPreference ensurePreference() => $_ensure(0);
}

class UpdateNotificationPreferenceResponse extends $pb.GeneratedMessage {
  factory UpdateNotificationPreferenceResponse() => create();

  UpdateNotificationPreferenceResponse._();

  factory UpdateNotificationPreferenceResponse.fromBuffer(
          $core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory UpdateNotificationPreferenceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateNotificationPreferenceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationPreferenceResponse clone() =>
      UpdateNotificationPreferenceResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateNotificationPreferenceResponse copyWith(
          void Function(UpdateNotificationPreferenceResponse) updates) =>
      super.copyWith((message) =>
              updates(message as UpdateNotificationPreferenceResponse))
          as UpdateNotificationPreferenceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateNotificationPreferenceResponse create() =>
      UpdateNotificationPreferenceResponse._();
  @$core.override
  UpdateNotificationPreferenceResponse createEmptyInstance() => create();
  static $pb.PbList<UpdateNotificationPreferenceResponse> createRepeated() =>
      $pb.PbList<UpdateNotificationPreferenceResponse>();
  @$core.pragma('dart2js:noInline')
  static UpdateNotificationPreferenceResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<
          UpdateNotificationPreferenceResponse>(create);
  static UpdateNotificationPreferenceResponse? _defaultInstance;
}

class RegisterFcmTokenRequest extends $pb.GeneratedMessage {
  factory RegisterFcmTokenRequest({
    $core.String? token,
    $core.String? deviceId,
  }) {
    final result = create();
    if (token != null) result.token = token;
    if (deviceId != null) result.deviceId = deviceId;
    return result;
  }

  RegisterFcmTokenRequest._();

  factory RegisterFcmTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterFcmTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterFcmTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'token')
    ..aOS(2, _omitFieldNames ? '' : 'deviceId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenRequest clone() =>
      RegisterFcmTokenRequest()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenRequest copyWith(
          void Function(RegisterFcmTokenRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterFcmTokenRequest))
          as RegisterFcmTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterFcmTokenRequest create() => RegisterFcmTokenRequest._();
  @$core.override
  RegisterFcmTokenRequest createEmptyInstance() => create();
  static $pb.PbList<RegisterFcmTokenRequest> createRepeated() =>
      $pb.PbList<RegisterFcmTokenRequest>();
  @$core.pragma('dart2js:noInline')
  static RegisterFcmTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterFcmTokenRequest>(create);
  static RegisterFcmTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get token => $_getSZ(0);
  @$pb.TagNumber(1)
  set token($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get deviceId => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceId($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceId() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceId() => $_clearField(2);
}

class RegisterFcmTokenResponse extends $pb.GeneratedMessage {
  factory RegisterFcmTokenResponse() => create();

  RegisterFcmTokenResponse._();

  factory RegisterFcmTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory RegisterFcmTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterFcmTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenResponse clone() =>
      RegisterFcmTokenResponse()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterFcmTokenResponse copyWith(
          void Function(RegisterFcmTokenResponse) updates) =>
      super.copyWith((message) => updates(message as RegisterFcmTokenResponse))
          as RegisterFcmTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RegisterFcmTokenResponse create() => RegisterFcmTokenResponse._();
  @$core.override
  RegisterFcmTokenResponse createEmptyInstance() => create();
  static $pb.PbList<RegisterFcmTokenResponse> createRepeated() =>
      $pb.PbList<RegisterFcmTokenResponse>();
  @$core.pragma('dart2js:noInline')
  static RegisterFcmTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterFcmTokenResponse>(create);
  static RegisterFcmTokenResponse? _defaultInstance;
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
