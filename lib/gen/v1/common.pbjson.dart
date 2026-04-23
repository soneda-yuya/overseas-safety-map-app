// This is a generated file - do not edit.
//
// Generated from v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use geocodeSourceDescriptor instead')
const GeocodeSource$json = {
  '1': 'GeocodeSource',
  '2': [
    {'1': 'GEOCODE_SOURCE_UNSPECIFIED', '2': 0},
    {'1': 'GEOCODE_SOURCE_MAPBOX', '2': 1},
    {'1': 'GEOCODE_SOURCE_COUNTRY_CENTROID', '2': 2},
  ],
};

/// Descriptor for `GeocodeSource`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List geocodeSourceDescriptor = $convert.base64Decode(
    'Cg1HZW9jb2RlU291cmNlEh4KGkdFT0NPREVfU09VUkNFX1VOU1BFQ0lGSUVEEAASGQoVR0VPQ0'
    '9ERV9TT1VSQ0VfTUFQQk9YEAESIwofR0VPQ09ERV9TT1VSQ0VfQ09VTlRSWV9DRU5UUk9JRBAC');

@$core.Deprecated('Use pointDescriptor instead')
const Point$json = {
  '1': 'Point',
  '2': [
    {'1': 'lat', '3': 1, '4': 1, '5': 1, '10': 'lat'},
    {'1': 'lng', '3': 2, '4': 1, '5': 1, '10': 'lng'},
  ],
};

/// Descriptor for `Point`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pointDescriptor = $convert.base64Decode(
    'CgVQb2ludBIQCgNsYXQYASABKAFSA2xhdBIQCgNsbmcYAiABKAFSA2xuZw==');
