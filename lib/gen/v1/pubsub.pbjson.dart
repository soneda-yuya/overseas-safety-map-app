// This is a generated file - do not edit.
//
// Generated from v1/pubsub.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use newArrivalEventDescriptor instead')
const NewArrivalEvent$json = {
  '1': 'NewArrivalEvent',
  '2': [
    {'1': 'key_cd', '3': 1, '4': 1, '5': 9, '10': 'keyCd'},
    {'1': 'country_cd', '3': 2, '4': 1, '5': 9, '10': 'countryCd'},
    {'1': 'area_cd', '3': 3, '4': 1, '5': 9, '10': 'areaCd'},
    {'1': 'info_type', '3': 4, '4': 1, '5': 9, '10': 'infoType'},
    {'1': 'title', '3': 5, '4': 1, '5': 9, '10': 'title'},
    {
      '1': 'leave_date',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'leaveDate'
    },
    {
      '1': 'occurred_at',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.google.protobuf.Timestamp',
      '10': 'occurredAt'
    },
  ],
};

/// Descriptor for `NewArrivalEvent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newArrivalEventDescriptor = $convert.base64Decode(
    'Cg9OZXdBcnJpdmFsRXZlbnQSFQoGa2V5X2NkGAEgASgJUgVrZXlDZBIdCgpjb3VudHJ5X2NkGA'
    'IgASgJUgljb3VudHJ5Q2QSFwoHYXJlYV9jZBgDIAEoCVIGYXJlYUNkEhsKCWluZm9fdHlwZRgE'
    'IAEoCVIIaW5mb1R5cGUSFAoFdGl0bGUYBSABKAlSBXRpdGxlEjkKCmxlYXZlX2RhdGUYBiABKA'
    'syGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUglsZWF2ZURhdGUSOwoLb2NjdXJyZWRfYXQY'
    'ByABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgpvY2N1cnJlZEF0');
