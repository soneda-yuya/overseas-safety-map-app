// This is a generated file - do not edit.
//
// Generated from v1/safetymap.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use safetyIncidentDescriptor instead')
const SafetyIncident$json = {
  '1': 'SafetyIncident',
  '2': [
    {'1': 'key_cd', '3': 1, '4': 1, '5': 9, '10': 'keyCd'},
    {'1': 'info_type', '3': 2, '4': 1, '5': 9, '10': 'infoType'},
    {'1': 'info_name', '3': 3, '4': 1, '5': 9, '10': 'infoName'},
    {
      '1': 'leave_date',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'leaveDate'
    },
    {'1': 'title', '3': 5, '4': 1, '5': 9, '10': 'title'},
    {'1': 'lead', '3': 6, '4': 1, '5': 9, '10': 'lead'},
    {'1': 'main_text', '3': 7, '4': 1, '5': 9, '10': 'mainText'},
    {'1': 'info_url', '3': 8, '4': 1, '5': 9, '10': 'infoUrl'},
    {'1': 'koukan_cd', '3': 9, '4': 1, '5': 9, '10': 'koukanCd'},
    {'1': 'koukan_name', '3': 10, '4': 1, '5': 9, '10': 'koukanName'},
    {'1': 'area_cd', '3': 11, '4': 1, '5': 9, '10': 'areaCd'},
    {'1': 'area_name', '3': 12, '4': 1, '5': 9, '10': 'areaName'},
    {'1': 'country_cd', '3': 13, '4': 1, '5': 9, '10': 'countryCd'},
    {'1': 'country_name', '3': 14, '4': 1, '5': 9, '10': 'countryName'},
    {
      '1': 'extracted_location',
      '3': 15,
      '4': 1,
      '5': 9,
      '10': 'extractedLocation'
    },
    {
      '1': 'geometry',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.Point',
      '10': 'geometry'
    },
    {
      '1': 'geocode_source',
      '3': 17,
      '4': 1,
      '5': 14,
      '6': '.overseasmap.v1.GeocodeSource',
      '10': 'geocodeSource'
    },
    {
      '1': 'ingested_at',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'ingestedAt'
    },
    {
      '1': 'updated_at',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'updatedAt'
    },
  ],
};

/// Descriptor for `SafetyIncident`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List safetyIncidentDescriptor = $convert.base64Decode(
    'Cg5TYWZldHlJbmNpZGVudBIVCgZrZXlfY2QYASABKAlSBWtleUNkEhsKCWluZm9fdHlwZRgCIA'
    'EoCVIIaW5mb1R5cGUSGwoJaW5mb19uYW1lGAMgASgJUghpbmZvTmFtZRI5CgpsZWF2ZV9kYXRl'
    'GAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJbGVhdmVEYXRlEhQKBXRpdGxlGA'
    'UgASgJUgV0aXRsZRISCgRsZWFkGAYgASgJUgRsZWFkEhsKCW1haW5fdGV4dBgHIAEoCVIIbWFp'
    'blRleHQSGQoIaW5mb191cmwYCCABKAlSB2luZm9VcmwSGwoJa291a2FuX2NkGAkgASgJUghrb3'
    'VrYW5DZBIfCgtrb3VrYW5fbmFtZRgKIAEoCVIKa291a2FuTmFtZRIXCgdhcmVhX2NkGAsgASgJ'
    'UgZhcmVhQ2QSGwoJYXJlYV9uYW1lGAwgASgJUghhcmVhTmFtZRIdCgpjb3VudHJ5X2NkGA0gAS'
    'gJUgljb3VudHJ5Q2QSIQoMY291bnRyeV9uYW1lGA4gASgJUgtjb3VudHJ5TmFtZRItChJleHRy'
    'YWN0ZWRfbG9jYXRpb24YDyABKAlSEWV4dHJhY3RlZExvY2F0aW9uEjEKCGdlb21ldHJ5GBAgAS'
    'gLMhUub3ZlcnNlYXNtYXAudjEuUG9pbnRSCGdlb21ldHJ5EkQKDmdlb2NvZGVfc291cmNlGBEg'
    'ASgOMh0ub3ZlcnNlYXNtYXAudjEuR2VvY29kZVNvdXJjZVINZ2VvY29kZVNvdXJjZRI7Cgtpbm'
    'dlc3RlZF9hdBgSIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCmluZ2VzdGVkQXQS'
    'OQoKdXBkYXRlZF9hdBgTIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSCXVwZGF0ZW'
    'RBdA==');

@$core.Deprecated('Use safetyIncidentFilterDescriptor instead')
const SafetyIncidentFilter$json = {
  '1': 'SafetyIncidentFilter',
  '2': [
    {'1': 'area_cd', '3': 1, '4': 1, '5': 9, '10': 'areaCd'},
    {'1': 'country_cd', '3': 2, '4': 1, '5': 9, '10': 'countryCd'},
    {'1': 'info_types', '3': 3, '4': 3, '5': 9, '10': 'infoTypes'},
    {
      '1': 'leave_from',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'leaveFrom'
    },
    {
      '1': 'leave_to',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'leaveTo'
    },
    {'1': 'limit', '3': 6, '4': 1, '5': 5, '10': 'limit'},
    {'1': 'cursor', '3': 7, '4': 1, '5': 9, '10': 'cursor'},
  ],
};

/// Descriptor for `SafetyIncidentFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List safetyIncidentFilterDescriptor = $convert.base64Decode(
    'ChRTYWZldHlJbmNpZGVudEZpbHRlchIXCgdhcmVhX2NkGAEgASgJUgZhcmVhQ2QSHQoKY291bn'
    'RyeV9jZBgCIAEoCVIJY291bnRyeUNkEh0KCmluZm9fdHlwZXMYAyADKAlSCWluZm9UeXBlcxI5'
    'CgpsZWF2ZV9mcm9tGAQgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIJbGVhdmVGcm'
    '9tEjUKCGxlYXZlX3RvGAUgASgLMhouZ29vZ2xlLnByb3RvYnVmLlRpbWVzdGFtcFIHbGVhdmVU'
    'bxIUCgVsaW1pdBgGIAEoBVIFbGltaXQSFgoGY3Vyc29yGAcgASgJUgZjdXJzb3I=');

@$core.Deprecated('Use listSafetyIncidentsRequestDescriptor instead')
const ListSafetyIncidentsRequest$json = {
  '1': 'ListSafetyIncidentsRequest',
  '2': [
    {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.SafetyIncidentFilter',
      '10': 'filter'
    },
  ],
};

/// Descriptor for `ListSafetyIncidentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSafetyIncidentsRequestDescriptor =
    $convert.base64Decode(
        'ChpMaXN0U2FmZXR5SW5jaWRlbnRzUmVxdWVzdBI8CgZmaWx0ZXIYASABKAsyJC5vdmVyc2Vhc2'
        '1hcC52MS5TYWZldHlJbmNpZGVudEZpbHRlclIGZmlsdGVy');

@$core.Deprecated('Use listSafetyIncidentsResponseDescriptor instead')
const ListSafetyIncidentsResponse$json = {
  '1': 'ListSafetyIncidentsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.overseasmap.v1.SafetyIncident',
      '10': 'items'
    },
    {'1': 'next_cursor', '3': 2, '4': 1, '5': 9, '10': 'nextCursor'},
    {'1': 'total_hint', '3': 3, '4': 1, '5': 5, '10': 'totalHint'},
  ],
};

/// Descriptor for `ListSafetyIncidentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSafetyIncidentsResponseDescriptor =
    $convert.base64Decode(
        'ChtMaXN0U2FmZXR5SW5jaWRlbnRzUmVzcG9uc2USNAoFaXRlbXMYASADKAsyHi5vdmVyc2Vhc2'
        '1hcC52MS5TYWZldHlJbmNpZGVudFIFaXRlbXMSHwoLbmV4dF9jdXJzb3IYAiABKAlSCm5leHRD'
        'dXJzb3ISHQoKdG90YWxfaGludBgDIAEoBVIJdG90YWxIaW50');

@$core.Deprecated('Use getSafetyIncidentRequestDescriptor instead')
const GetSafetyIncidentRequest$json = {
  '1': 'GetSafetyIncidentRequest',
  '2': [
    {'1': 'key_cd', '3': 1, '4': 1, '5': 9, '10': 'keyCd'},
  ],
};

/// Descriptor for `GetSafetyIncidentRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSafetyIncidentRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRTYWZldHlJbmNpZGVudFJlcXVlc3QSFQoGa2V5X2NkGAEgASgJUgVrZXlDZA==');

@$core.Deprecated('Use getSafetyIncidentResponseDescriptor instead')
const GetSafetyIncidentResponse$json = {
  '1': 'GetSafetyIncidentResponse',
  '2': [
    {
      '1': 'item',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.SafetyIncident',
      '10': 'item'
    },
  ],
};

/// Descriptor for `GetSafetyIncidentResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSafetyIncidentResponseDescriptor =
    $convert.base64Decode(
        'ChlHZXRTYWZldHlJbmNpZGVudFJlc3BvbnNlEjIKBGl0ZW0YASABKAsyHi5vdmVyc2Vhc21hcC'
        '52MS5TYWZldHlJbmNpZGVudFIEaXRlbQ==');

@$core.Deprecated('Use searchSafetyIncidentsRequestDescriptor instead')
const SearchSafetyIncidentsRequest$json = {
  '1': 'SearchSafetyIncidentsRequest',
  '2': [
    {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.SafetyIncidentFilter',
      '10': 'filter'
    },
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
  ],
};

/// Descriptor for `SearchSafetyIncidentsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchSafetyIncidentsRequestDescriptor =
    $convert.base64Decode(
        'ChxTZWFyY2hTYWZldHlJbmNpZGVudHNSZXF1ZXN0EjwKBmZpbHRlchgBIAEoCzIkLm92ZXJzZW'
        'FzbWFwLnYxLlNhZmV0eUluY2lkZW50RmlsdGVyUgZmaWx0ZXISFAoFcXVlcnkYAiABKAlSBXF1'
        'ZXJ5');

@$core.Deprecated('Use searchSafetyIncidentsResponseDescriptor instead')
const SearchSafetyIncidentsResponse$json = {
  '1': 'SearchSafetyIncidentsResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.overseasmap.v1.SafetyIncident',
      '10': 'items'
    },
    {'1': 'next_cursor', '3': 2, '4': 1, '5': 9, '10': 'nextCursor'},
  ],
};

/// Descriptor for `SearchSafetyIncidentsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchSafetyIncidentsResponseDescriptor =
    $convert.base64Decode(
        'Ch1TZWFyY2hTYWZldHlJbmNpZGVudHNSZXNwb25zZRI0CgVpdGVtcxgBIAMoCzIeLm92ZXJzZW'
        'FzbWFwLnYxLlNhZmV0eUluY2lkZW50UgVpdGVtcxIfCgtuZXh0X2N1cnNvchgCIAEoCVIKbmV4'
        'dEN1cnNvcg==');

@$core.Deprecated('Use listNearbyRequestDescriptor instead')
const ListNearbyRequest$json = {
  '1': 'ListNearbyRequest',
  '2': [
    {
      '1': 'center',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.Point',
      '10': 'center'
    },
    {'1': 'radius_km', '3': 2, '4': 1, '5': 1, '10': 'radiusKm'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListNearbyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listNearbyRequestDescriptor = $convert.base64Decode(
    'ChFMaXN0TmVhcmJ5UmVxdWVzdBItCgZjZW50ZXIYASABKAsyFS5vdmVyc2Vhc21hcC52MS5Qb2'
    'ludFIGY2VudGVyEhsKCXJhZGl1c19rbRgCIAEoAVIIcmFkaXVzS20SFAoFbGltaXQYAyABKAVS'
    'BWxpbWl0');

@$core.Deprecated('Use listNearbyResponseDescriptor instead')
const ListNearbyResponse$json = {
  '1': 'ListNearbyResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.overseasmap.v1.SafetyIncident',
      '10': 'items'
    },
  ],
};

/// Descriptor for `ListNearbyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listNearbyResponseDescriptor = $convert.base64Decode(
    'ChJMaXN0TmVhcmJ5UmVzcG9uc2USNAoFaXRlbXMYASADKAsyHi5vdmVyc2Vhc21hcC52MS5TYW'
    'ZldHlJbmNpZGVudFIFaXRlbXM=');

@$core.Deprecated('Use getSafetyIncidentsAsGeoJSONRequestDescriptor instead')
const GetSafetyIncidentsAsGeoJSONRequest$json = {
  '1': 'GetSafetyIncidentsAsGeoJSONRequest',
  '2': [
    {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.SafetyIncidentFilter',
      '10': 'filter'
    },
  ],
};

/// Descriptor for `GetSafetyIncidentsAsGeoJSONRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSafetyIncidentsAsGeoJSONRequestDescriptor =
    $convert.base64Decode(
        'CiJHZXRTYWZldHlJbmNpZGVudHNBc0dlb0pTT05SZXF1ZXN0EjwKBmZpbHRlchgBIAEoCzIkLm'
        '92ZXJzZWFzbWFwLnYxLlNhZmV0eUluY2lkZW50RmlsdGVyUgZmaWx0ZXI=');

@$core.Deprecated('Use getSafetyIncidentsAsGeoJSONResponseDescriptor instead')
const GetSafetyIncidentsAsGeoJSONResponse$json = {
  '1': 'GetSafetyIncidentsAsGeoJSONResponse',
  '2': [
    {'1': 'geojson', '3': 1, '4': 1, '5': 12, '10': 'geojson'},
  ],
};

/// Descriptor for `GetSafetyIncidentsAsGeoJSONResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getSafetyIncidentsAsGeoJSONResponseDescriptor =
    $convert.base64Decode(
        'CiNHZXRTYWZldHlJbmNpZGVudHNBc0dlb0pTT05SZXNwb25zZRIYCgdnZW9qc29uGAEgASgMUg'
        'dnZW9qc29u');

@$core.Deprecated('Use crimeMapFilterDescriptor instead')
const CrimeMapFilter$json = {
  '1': 'CrimeMapFilter',
  '2': [
    {
      '1': 'leave_from',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'leaveFrom'
    },
    {
      '1': 'leave_to',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'leaveTo'
    },
  ],
};

/// Descriptor for `CrimeMapFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List crimeMapFilterDescriptor = $convert.base64Decode(
    'Cg5DcmltZU1hcEZpbHRlchI5CgpsZWF2ZV9mcm9tGAEgASgLMhouZ29vZ2xlLnByb3RvYnVmLl'
    'RpbWVzdGFtcFIJbGVhdmVGcm9tEjUKCGxlYXZlX3RvGAIgASgLMhouZ29vZ2xlLnByb3RvYnVm'
    'LlRpbWVzdGFtcFIHbGVhdmVUbw==');

@$core.Deprecated('Use countryChoroplethDescriptor instead')
const CountryChoropleth$json = {
  '1': 'CountryChoropleth',
  '2': [
    {'1': 'country_cd', '3': 1, '4': 1, '5': 9, '10': 'countryCd'},
    {'1': 'country_name', '3': 2, '4': 1, '5': 9, '10': 'countryName'},
    {'1': 'count', '3': 3, '4': 1, '5': 5, '10': 'count'},
    {'1': 'color', '3': 4, '4': 1, '5': 9, '10': 'color'},
  ],
};

/// Descriptor for `CountryChoropleth`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List countryChoroplethDescriptor = $convert.base64Decode(
    'ChFDb3VudHJ5Q2hvcm9wbGV0aBIdCgpjb3VudHJ5X2NkGAEgASgJUgljb3VudHJ5Q2QSIQoMY2'
    '91bnRyeV9uYW1lGAIgASgJUgtjb3VudHJ5TmFtZRIUCgVjb3VudBgDIAEoBVIFY291bnQSFAoF'
    'Y29sb3IYBCABKAlSBWNvbG9y');

@$core.Deprecated('Use heatmapPointDescriptor instead')
const HeatmapPoint$json = {
  '1': 'HeatmapPoint',
  '2': [
    {
      '1': 'location',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.Point',
      '10': 'location'
    },
    {'1': 'weight', '3': 2, '4': 1, '5': 1, '10': 'weight'},
  ],
};

/// Descriptor for `HeatmapPoint`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List heatmapPointDescriptor = $convert.base64Decode(
    'CgxIZWF0bWFwUG9pbnQSMQoIbG9jYXRpb24YASABKAsyFS5vdmVyc2Vhc21hcC52MS5Qb2ludF'
    'IIbG9jYXRpb24SFgoGd2VpZ2h0GAIgASgBUgZ3ZWlnaHQ=');

@$core.Deprecated('Use getChoroplethRequestDescriptor instead')
const GetChoroplethRequest$json = {
  '1': 'GetChoroplethRequest',
  '2': [
    {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.CrimeMapFilter',
      '10': 'filter'
    },
  ],
};

/// Descriptor for `GetChoroplethRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChoroplethRequestDescriptor = $convert.base64Decode(
    'ChRHZXRDaG9yb3BsZXRoUmVxdWVzdBI2CgZmaWx0ZXIYASABKAsyHi5vdmVyc2Vhc21hcC52MS'
    '5DcmltZU1hcEZpbHRlclIGZmlsdGVy');

@$core.Deprecated('Use getChoroplethResponseDescriptor instead')
const GetChoroplethResponse$json = {
  '1': 'GetChoroplethResponse',
  '2': [
    {
      '1': 'items',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.overseasmap.v1.CountryChoropleth',
      '10': 'items'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `GetChoroplethResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChoroplethResponseDescriptor = $convert.base64Decode(
    'ChVHZXRDaG9yb3BsZXRoUmVzcG9uc2USNwoFaXRlbXMYASADKAsyIS5vdmVyc2Vhc21hcC52MS'
    '5Db3VudHJ5Q2hvcm9wbGV0aFIFaXRlbXMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

@$core.Deprecated('Use getHeatmapRequestDescriptor instead')
const GetHeatmapRequest$json = {
  '1': 'GetHeatmapRequest',
  '2': [
    {
      '1': 'filter',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.CrimeMapFilter',
      '10': 'filter'
    },
  ],
};

/// Descriptor for `GetHeatmapRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHeatmapRequestDescriptor = $convert.base64Decode(
    'ChFHZXRIZWF0bWFwUmVxdWVzdBI2CgZmaWx0ZXIYASABKAsyHi5vdmVyc2Vhc21hcC52MS5Dcm'
    'ltZU1hcEZpbHRlclIGZmlsdGVy');

@$core.Deprecated('Use getHeatmapResponseDescriptor instead')
const GetHeatmapResponse$json = {
  '1': 'GetHeatmapResponse',
  '2': [
    {
      '1': 'points',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.overseasmap.v1.HeatmapPoint',
      '10': 'points'
    },
    {
      '1': 'excluded_fallback',
      '3': 2,
      '4': 1,
      '5': 5,
      '10': 'excludedFallback'
    },
  ],
};

/// Descriptor for `GetHeatmapResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHeatmapResponseDescriptor = $convert.base64Decode(
    'ChJHZXRIZWF0bWFwUmVzcG9uc2USNAoGcG9pbnRzGAEgAygLMhwub3ZlcnNlYXNtYXAudjEuSG'
    'VhdG1hcFBvaW50UgZwb2ludHMSKwoRZXhjbHVkZWRfZmFsbGJhY2sYAiABKAVSEGV4Y2x1ZGVk'
    'RmFsbGJhY2s=');

@$core.Deprecated('Use notificationPreferenceDescriptor instead')
const NotificationPreference$json = {
  '1': 'NotificationPreference',
  '2': [
    {'1': 'enabled', '3': 1, '4': 1, '5': 8, '10': 'enabled'},
    {
      '1': 'target_country_cds',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'targetCountryCds'
    },
    {'1': 'info_types', '3': 3, '4': 3, '5': 9, '10': 'infoTypes'},
  ],
};

/// Descriptor for `NotificationPreference`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List notificationPreferenceDescriptor = $convert.base64Decode(
    'ChZOb3RpZmljYXRpb25QcmVmZXJlbmNlEhgKB2VuYWJsZWQYASABKAhSB2VuYWJsZWQSLAoSdG'
    'FyZ2V0X2NvdW50cnlfY2RzGAIgAygJUhB0YXJnZXRDb3VudHJ5Q2RzEh0KCmluZm9fdHlwZXMY'
    'AyADKAlSCWluZm9UeXBlcw==');

@$core.Deprecated('Use userProfileDescriptor instead')
const UserProfile$json = {
  '1': 'UserProfile',
  '2': [
    {'1': 'uid', '3': 1, '4': 1, '5': 9, '10': 'uid'},
    {
      '1': 'favorite_country_cds',
      '3': 2,
      '4': 3,
      '5': 9,
      '10': 'favoriteCountryCds'
    },
    {
      '1': 'notification_preference',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.NotificationPreference',
      '10': 'notificationPreference'
    },
    {'1': 'fcm_token_count', '3': 4, '4': 1, '5': 5, '10': 'fcmTokenCount'},
  ],
};

/// Descriptor for `UserProfile`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userProfileDescriptor = $convert.base64Decode(
    'CgtVc2VyUHJvZmlsZRIQCgN1aWQYASABKAlSA3VpZBIwChRmYXZvcml0ZV9jb3VudHJ5X2Nkcx'
    'gCIAMoCVISZmF2b3JpdGVDb3VudHJ5Q2RzEl8KF25vdGlmaWNhdGlvbl9wcmVmZXJlbmNlGAMg'
    'ASgLMiYub3ZlcnNlYXNtYXAudjEuTm90aWZpY2F0aW9uUHJlZmVyZW5jZVIWbm90aWZpY2F0aW'
    '9uUHJlZmVyZW5jZRImCg9mY21fdG9rZW5fY291bnQYBCABKAVSDWZjbVRva2VuQ291bnQ=');

@$core.Deprecated('Use getProfileRequestDescriptor instead')
const GetProfileRequest$json = {
  '1': 'GetProfileRequest',
};

/// Descriptor for `GetProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProfileRequestDescriptor =
    $convert.base64Decode('ChFHZXRQcm9maWxlUmVxdWVzdA==');

@$core.Deprecated('Use getProfileResponseDescriptor instead')
const GetProfileResponse$json = {
  '1': 'GetProfileResponse',
  '2': [
    {
      '1': 'profile',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.UserProfile',
      '10': 'profile'
    },
  ],
};

/// Descriptor for `GetProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getProfileResponseDescriptor = $convert.base64Decode(
    'ChJHZXRQcm9maWxlUmVzcG9uc2USNQoHcHJvZmlsZRgBIAEoCzIbLm92ZXJzZWFzbWFwLnYxLl'
    'VzZXJQcm9maWxlUgdwcm9maWxl');

@$core.Deprecated('Use toggleFavoriteCountryRequestDescriptor instead')
const ToggleFavoriteCountryRequest$json = {
  '1': 'ToggleFavoriteCountryRequest',
  '2': [
    {'1': 'country_cd', '3': 1, '4': 1, '5': 9, '10': 'countryCd'},
  ],
};

/// Descriptor for `ToggleFavoriteCountryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavoriteCountryRequestDescriptor =
    $convert.base64Decode(
        'ChxUb2dnbGVGYXZvcml0ZUNvdW50cnlSZXF1ZXN0Eh0KCmNvdW50cnlfY2QYASABKAlSCWNvdW'
        '50cnlDZA==');

@$core.Deprecated('Use toggleFavoriteCountryResponseDescriptor instead')
const ToggleFavoriteCountryResponse$json = {
  '1': 'ToggleFavoriteCountryResponse',
  '2': [
    {
      '1': 'profile',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.UserProfile',
      '10': 'profile'
    },
  ],
};

/// Descriptor for `ToggleFavoriteCountryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List toggleFavoriteCountryResponseDescriptor =
    $convert.base64Decode(
        'Ch1Ub2dnbGVGYXZvcml0ZUNvdW50cnlSZXNwb25zZRI1Cgdwcm9maWxlGAEgASgLMhsub3Zlcn'
        'NlYXNtYXAudjEuVXNlclByb2ZpbGVSB3Byb2ZpbGU=');

@$core.Deprecated('Use updateNotificationPreferenceRequestDescriptor instead')
const UpdateNotificationPreferenceRequest$json = {
  '1': 'UpdateNotificationPreferenceRequest',
  '2': [
    {
      '1': 'preference',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.overseasmap.v1.NotificationPreference',
      '10': 'preference'
    },
  ],
};

/// Descriptor for `UpdateNotificationPreferenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationPreferenceRequestDescriptor =
    $convert.base64Decode(
        'CiNVcGRhdGVOb3RpZmljYXRpb25QcmVmZXJlbmNlUmVxdWVzdBJGCgpwcmVmZXJlbmNlGAEgAS'
        'gLMiYub3ZlcnNlYXNtYXAudjEuTm90aWZpY2F0aW9uUHJlZmVyZW5jZVIKcHJlZmVyZW5jZQ==');

@$core.Deprecated('Use updateNotificationPreferenceResponseDescriptor instead')
const UpdateNotificationPreferenceResponse$json = {
  '1': 'UpdateNotificationPreferenceResponse',
};

/// Descriptor for `UpdateNotificationPreferenceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateNotificationPreferenceResponseDescriptor =
    $convert
        .base64Decode('CiRVcGRhdGVOb3RpZmljYXRpb25QcmVmZXJlbmNlUmVzcG9uc2U=');

@$core.Deprecated('Use registerFcmTokenRequestDescriptor instead')
const RegisterFcmTokenRequest$json = {
  '1': 'RegisterFcmTokenRequest',
  '2': [
    {'1': 'token', '3': 1, '4': 1, '5': 9, '10': 'token'},
    {'1': 'device_id', '3': 2, '4': 1, '5': 9, '10': 'deviceId'},
  ],
};

/// Descriptor for `RegisterFcmTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFcmTokenRequestDescriptor =
    $convert.base64Decode(
        'ChdSZWdpc3RlckZjbVRva2VuUmVxdWVzdBIUCgV0b2tlbhgBIAEoCVIFdG9rZW4SGwoJZGV2aW'
        'NlX2lkGAIgASgJUghkZXZpY2VJZA==');

@$core.Deprecated('Use registerFcmTokenResponseDescriptor instead')
const RegisterFcmTokenResponse$json = {
  '1': 'RegisterFcmTokenResponse',
};

/// Descriptor for `RegisterFcmTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerFcmTokenResponseDescriptor =
    $convert.base64Decode('ChhSZWdpc3RlckZjbVRva2VuUmVzcG9uc2U=');
