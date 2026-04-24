// This is a generated file - do not edit.
//
// Generated from v1/pubsub.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import '../google/protobuf/timestamp.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// NewArrivalEvent is published by ingestion after a new SafetyIncident has
/// been stored. notifier subscribes and fans out FCM pushes to matching users.
class NewArrivalEvent extends $pb.GeneratedMessage {
  factory NewArrivalEvent({
    $core.String? keyCd,
    $core.String? countryCd,
    $core.String? areaCd,
    $core.String? infoType,
    $core.String? title,
    $0.Timestamp? leaveDate,
    $0.Timestamp? occurredAt,
  }) {
    final result = create();
    if (keyCd != null) result.keyCd = keyCd;
    if (countryCd != null) result.countryCd = countryCd;
    if (areaCd != null) result.areaCd = areaCd;
    if (infoType != null) result.infoType = infoType;
    if (title != null) result.title = title;
    if (leaveDate != null) result.leaveDate = leaveDate;
    if (occurredAt != null) result.occurredAt = occurredAt;
    return result;
  }

  NewArrivalEvent._();

  factory NewArrivalEvent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(data, registry);
  factory NewArrivalEvent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NewArrivalEvent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'overseasmap.v1'),
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'keyCd')
    ..aOS(2, _omitFieldNames ? '' : 'countryCd')
    ..aOS(3, _omitFieldNames ? '' : 'areaCd')
    ..aOS(4, _omitFieldNames ? '' : 'infoType')
    ..aOS(5, _omitFieldNames ? '' : 'title')
    ..aOM<$0.Timestamp>(6, _omitFieldNames ? '' : 'leaveDate',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(7, _omitFieldNames ? '' : 'occurredAt',
        subBuilder: $0.Timestamp.create)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewArrivalEvent clone() => NewArrivalEvent()..mergeFromMessage(this);
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewArrivalEvent copyWith(void Function(NewArrivalEvent) updates) =>
      super.copyWith((message) => updates(message as NewArrivalEvent))
          as NewArrivalEvent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static NewArrivalEvent create() => NewArrivalEvent._();
  @$core.override
  NewArrivalEvent createEmptyInstance() => create();
  static $pb.PbList<NewArrivalEvent> createRepeated() =>
      $pb.PbList<NewArrivalEvent>();
  @$core.pragma('dart2js:noInline')
  static NewArrivalEvent getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NewArrivalEvent>(create);
  static NewArrivalEvent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get keyCd => $_getSZ(0);
  @$pb.TagNumber(1)
  set keyCd($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasKeyCd() => $_has(0);
  @$pb.TagNumber(1)
  void clearKeyCd() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get countryCd => $_getSZ(1);
  @$pb.TagNumber(2)
  set countryCd($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCountryCd() => $_has(1);
  @$pb.TagNumber(2)
  void clearCountryCd() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get areaCd => $_getSZ(2);
  @$pb.TagNumber(3)
  set areaCd($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAreaCd() => $_has(2);
  @$pb.TagNumber(3)
  void clearAreaCd() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get infoType => $_getSZ(3);
  @$pb.TagNumber(4)
  set infoType($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasInfoType() => $_has(3);
  @$pb.TagNumber(4)
  void clearInfoType() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get title => $_getSZ(4);
  @$pb.TagNumber(5)
  set title($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTitle() => $_has(4);
  @$pb.TagNumber(5)
  void clearTitle() => $_clearField(5);

  @$pb.TagNumber(6)
  $0.Timestamp get leaveDate => $_getN(5);
  @$pb.TagNumber(6)
  set leaveDate($0.Timestamp value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLeaveDate() => $_has(5);
  @$pb.TagNumber(6)
  void clearLeaveDate() => $_clearField(6);
  @$pb.TagNumber(6)
  $0.Timestamp ensureLeaveDate() => $_ensure(5);

  @$pb.TagNumber(7)
  $0.Timestamp get occurredAt => $_getN(6);
  @$pb.TagNumber(7)
  set occurredAt($0.Timestamp value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasOccurredAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearOccurredAt() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Timestamp ensureOccurredAt() => $_ensure(6);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
