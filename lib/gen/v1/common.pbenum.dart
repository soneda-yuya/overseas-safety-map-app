// This is a generated file - do not edit.
//
// Generated from v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// GeocodeSource records how the Point was derived.
class GeocodeSource extends $pb.ProtobufEnum {
  static const GeocodeSource GEOCODE_SOURCE_UNSPECIFIED =
      GeocodeSource._(0, _omitEnumNames ? '' : 'GEOCODE_SOURCE_UNSPECIFIED');
  static const GeocodeSource GEOCODE_SOURCE_MAPBOX =
      GeocodeSource._(1, _omitEnumNames ? '' : 'GEOCODE_SOURCE_MAPBOX');
  static const GeocodeSource GEOCODE_SOURCE_COUNTRY_CENTROID = GeocodeSource._(
      2, _omitEnumNames ? '' : 'GEOCODE_SOURCE_COUNTRY_CENTROID');

  static const $core.List<GeocodeSource> values = <GeocodeSource>[
    GEOCODE_SOURCE_UNSPECIFIED,
    GEOCODE_SOURCE_MAPBOX,
    GEOCODE_SOURCE_COUNTRY_CENTROID,
  ];

  static final $core.List<GeocodeSource?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 2);
  static GeocodeSource? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const GeocodeSource._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
