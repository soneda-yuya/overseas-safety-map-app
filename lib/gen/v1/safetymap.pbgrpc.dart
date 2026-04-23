// This is a generated file - do not edit.
//
// Generated from v1/safetymap.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'safetymap.pb.dart' as $0;

export 'safetymap.pb.dart';

@$pb.GrpcServiceName('overseasmap.v1.SafetyIncidentService')
class SafetyIncidentServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  SafetyIncidentServiceClient(super.channel,
      {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.ListSafetyIncidentsResponse> listSafetyIncidents(
    $0.ListSafetyIncidentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listSafetyIncidents, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSafetyIncidentResponse> getSafetyIncident(
    $0.GetSafetyIncidentRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSafetyIncident, request, options: options);
  }

  $grpc.ResponseFuture<$0.SearchSafetyIncidentsResponse> searchSafetyIncidents(
    $0.SearchSafetyIncidentsRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$searchSafetyIncidents, request, options: options);
  }

  $grpc.ResponseFuture<$0.ListNearbyResponse> listNearby(
    $0.ListNearbyRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$listNearby, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetSafetyIncidentsAsGeoJSONResponse>
      getSafetyIncidentsAsGeoJSON(
    $0.GetSafetyIncidentsAsGeoJSONRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getSafetyIncidentsAsGeoJSON, request,
        options: options);
  }

  // method descriptors

  static final _$listSafetyIncidents = $grpc.ClientMethod<
          $0.ListSafetyIncidentsRequest, $0.ListSafetyIncidentsResponse>(
      '/overseasmap.v1.SafetyIncidentService/ListSafetyIncidents',
      ($0.ListSafetyIncidentsRequest value) => value.writeToBuffer(),
      $0.ListSafetyIncidentsResponse.fromBuffer);
  static final _$getSafetyIncident = $grpc.ClientMethod<
          $0.GetSafetyIncidentRequest, $0.GetSafetyIncidentResponse>(
      '/overseasmap.v1.SafetyIncidentService/GetSafetyIncident',
      ($0.GetSafetyIncidentRequest value) => value.writeToBuffer(),
      $0.GetSafetyIncidentResponse.fromBuffer);
  static final _$searchSafetyIncidents = $grpc.ClientMethod<
          $0.SearchSafetyIncidentsRequest, $0.SearchSafetyIncidentsResponse>(
      '/overseasmap.v1.SafetyIncidentService/SearchSafetyIncidents',
      ($0.SearchSafetyIncidentsRequest value) => value.writeToBuffer(),
      $0.SearchSafetyIncidentsResponse.fromBuffer);
  static final _$listNearby =
      $grpc.ClientMethod<$0.ListNearbyRequest, $0.ListNearbyResponse>(
          '/overseasmap.v1.SafetyIncidentService/ListNearby',
          ($0.ListNearbyRequest value) => value.writeToBuffer(),
          $0.ListNearbyResponse.fromBuffer);
  static final _$getSafetyIncidentsAsGeoJSON = $grpc.ClientMethod<
          $0.GetSafetyIncidentsAsGeoJSONRequest,
          $0.GetSafetyIncidentsAsGeoJSONResponse>(
      '/overseasmap.v1.SafetyIncidentService/GetSafetyIncidentsAsGeoJSON',
      ($0.GetSafetyIncidentsAsGeoJSONRequest value) => value.writeToBuffer(),
      $0.GetSafetyIncidentsAsGeoJSONResponse.fromBuffer);
}

@$pb.GrpcServiceName('overseasmap.v1.SafetyIncidentService')
abstract class SafetyIncidentServiceBase extends $grpc.Service {
  $core.String get $name => 'overseasmap.v1.SafetyIncidentService';

  SafetyIncidentServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.ListSafetyIncidentsRequest,
            $0.ListSafetyIncidentsResponse>(
        'ListSafetyIncidents',
        listSafetyIncidents_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ListSafetyIncidentsRequest.fromBuffer(value),
        ($0.ListSafetyIncidentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSafetyIncidentRequest,
            $0.GetSafetyIncidentResponse>(
        'GetSafetyIncident',
        getSafetyIncident_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSafetyIncidentRequest.fromBuffer(value),
        ($0.GetSafetyIncidentResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SearchSafetyIncidentsRequest,
            $0.SearchSafetyIncidentsResponse>(
        'SearchSafetyIncidents',
        searchSafetyIncidents_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.SearchSafetyIncidentsRequest.fromBuffer(value),
        ($0.SearchSafetyIncidentsResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ListNearbyRequest, $0.ListNearbyResponse>(
        'ListNearby',
        listNearby_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ListNearbyRequest.fromBuffer(value),
        ($0.ListNearbyResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetSafetyIncidentsAsGeoJSONRequest,
            $0.GetSafetyIncidentsAsGeoJSONResponse>(
        'GetSafetyIncidentsAsGeoJSON',
        getSafetyIncidentsAsGeoJSON_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.GetSafetyIncidentsAsGeoJSONRequest.fromBuffer(value),
        ($0.GetSafetyIncidentsAsGeoJSONResponse value) =>
            value.writeToBuffer()));
  }

  $async.Future<$0.ListSafetyIncidentsResponse> listSafetyIncidents_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ListSafetyIncidentsRequest> $request) async {
    return listSafetyIncidents($call, await $request);
  }

  $async.Future<$0.ListSafetyIncidentsResponse> listSafetyIncidents(
      $grpc.ServiceCall call, $0.ListSafetyIncidentsRequest request);

  $async.Future<$0.GetSafetyIncidentResponse> getSafetyIncident_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetSafetyIncidentRequest> $request) async {
    return getSafetyIncident($call, await $request);
  }

  $async.Future<$0.GetSafetyIncidentResponse> getSafetyIncident(
      $grpc.ServiceCall call, $0.GetSafetyIncidentRequest request);

  $async.Future<$0.SearchSafetyIncidentsResponse> searchSafetyIncidents_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.SearchSafetyIncidentsRequest> $request) async {
    return searchSafetyIncidents($call, await $request);
  }

  $async.Future<$0.SearchSafetyIncidentsResponse> searchSafetyIncidents(
      $grpc.ServiceCall call, $0.SearchSafetyIncidentsRequest request);

  $async.Future<$0.ListNearbyResponse> listNearby_Pre($grpc.ServiceCall $call,
      $async.Future<$0.ListNearbyRequest> $request) async {
    return listNearby($call, await $request);
  }

  $async.Future<$0.ListNearbyResponse> listNearby(
      $grpc.ServiceCall call, $0.ListNearbyRequest request);

  $async.Future<$0.GetSafetyIncidentsAsGeoJSONResponse>
      getSafetyIncidentsAsGeoJSON_Pre($grpc.ServiceCall $call,
          $async.Future<$0.GetSafetyIncidentsAsGeoJSONRequest> $request) async {
    return getSafetyIncidentsAsGeoJSON($call, await $request);
  }

  $async.Future<$0.GetSafetyIncidentsAsGeoJSONResponse>
      getSafetyIncidentsAsGeoJSON($grpc.ServiceCall call,
          $0.GetSafetyIncidentsAsGeoJSONRequest request);
}

@$pb.GrpcServiceName('overseasmap.v1.CrimeMapService')
class CrimeMapServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  CrimeMapServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetChoroplethResponse> getChoropleth(
    $0.GetChoroplethRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getChoropleth, request, options: options);
  }

  $grpc.ResponseFuture<$0.GetHeatmapResponse> getHeatmap(
    $0.GetHeatmapRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getHeatmap, request, options: options);
  }

  // method descriptors

  static final _$getChoropleth =
      $grpc.ClientMethod<$0.GetChoroplethRequest, $0.GetChoroplethResponse>(
          '/overseasmap.v1.CrimeMapService/GetChoropleth',
          ($0.GetChoroplethRequest value) => value.writeToBuffer(),
          $0.GetChoroplethResponse.fromBuffer);
  static final _$getHeatmap =
      $grpc.ClientMethod<$0.GetHeatmapRequest, $0.GetHeatmapResponse>(
          '/overseasmap.v1.CrimeMapService/GetHeatmap',
          ($0.GetHeatmapRequest value) => value.writeToBuffer(),
          $0.GetHeatmapResponse.fromBuffer);
}

@$pb.GrpcServiceName('overseasmap.v1.CrimeMapService')
abstract class CrimeMapServiceBase extends $grpc.Service {
  $core.String get $name => 'overseasmap.v1.CrimeMapService';

  CrimeMapServiceBase() {
    $addMethod(
        $grpc.ServiceMethod<$0.GetChoroplethRequest, $0.GetChoroplethResponse>(
            'GetChoropleth',
            getChoropleth_Pre,
            false,
            false,
            ($core.List<$core.int> value) =>
                $0.GetChoroplethRequest.fromBuffer(value),
            ($0.GetChoroplethResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.GetHeatmapRequest, $0.GetHeatmapResponse>(
        'GetHeatmap',
        getHeatmap_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetHeatmapRequest.fromBuffer(value),
        ($0.GetHeatmapResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetChoroplethResponse> getChoropleth_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.GetChoroplethRequest> $request) async {
    return getChoropleth($call, await $request);
  }

  $async.Future<$0.GetChoroplethResponse> getChoropleth(
      $grpc.ServiceCall call, $0.GetChoroplethRequest request);

  $async.Future<$0.GetHeatmapResponse> getHeatmap_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetHeatmapRequest> $request) async {
    return getHeatmap($call, await $request);
  }

  $async.Future<$0.GetHeatmapResponse> getHeatmap(
      $grpc.ServiceCall call, $0.GetHeatmapRequest request);
}

@$pb.GrpcServiceName('overseasmap.v1.UserProfileService')
class UserProfileServiceClient extends $grpc.Client {
  /// The hostname for this service.
  static const $core.String defaultHost = '';

  /// OAuth scopes needed for the client.
  static const $core.List<$core.String> oauthScopes = [
    '',
  ];

  UserProfileServiceClient(super.channel, {super.options, super.interceptors});

  $grpc.ResponseFuture<$0.GetProfileResponse> getProfile(
    $0.GetProfileRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$getProfile, request, options: options);
  }

  $grpc.ResponseFuture<$0.ToggleFavoriteCountryResponse> toggleFavoriteCountry(
    $0.ToggleFavoriteCountryRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$toggleFavoriteCountry, request, options: options);
  }

  $grpc.ResponseFuture<$0.UpdateNotificationPreferenceResponse>
      updateNotificationPreference(
    $0.UpdateNotificationPreferenceRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$updateNotificationPreference, request,
        options: options);
  }

  $grpc.ResponseFuture<$0.RegisterFcmTokenResponse> registerFcmToken(
    $0.RegisterFcmTokenRequest request, {
    $grpc.CallOptions? options,
  }) {
    return $createUnaryCall(_$registerFcmToken, request, options: options);
  }

  // method descriptors

  static final _$getProfile =
      $grpc.ClientMethod<$0.GetProfileRequest, $0.GetProfileResponse>(
          '/overseasmap.v1.UserProfileService/GetProfile',
          ($0.GetProfileRequest value) => value.writeToBuffer(),
          $0.GetProfileResponse.fromBuffer);
  static final _$toggleFavoriteCountry = $grpc.ClientMethod<
          $0.ToggleFavoriteCountryRequest, $0.ToggleFavoriteCountryResponse>(
      '/overseasmap.v1.UserProfileService/ToggleFavoriteCountry',
      ($0.ToggleFavoriteCountryRequest value) => value.writeToBuffer(),
      $0.ToggleFavoriteCountryResponse.fromBuffer);
  static final _$updateNotificationPreference = $grpc.ClientMethod<
          $0.UpdateNotificationPreferenceRequest,
          $0.UpdateNotificationPreferenceResponse>(
      '/overseasmap.v1.UserProfileService/UpdateNotificationPreference',
      ($0.UpdateNotificationPreferenceRequest value) => value.writeToBuffer(),
      $0.UpdateNotificationPreferenceResponse.fromBuffer);
  static final _$registerFcmToken = $grpc.ClientMethod<
          $0.RegisterFcmTokenRequest, $0.RegisterFcmTokenResponse>(
      '/overseasmap.v1.UserProfileService/RegisterFcmToken',
      ($0.RegisterFcmTokenRequest value) => value.writeToBuffer(),
      $0.RegisterFcmTokenResponse.fromBuffer);
}

@$pb.GrpcServiceName('overseasmap.v1.UserProfileService')
abstract class UserProfileServiceBase extends $grpc.Service {
  $core.String get $name => 'overseasmap.v1.UserProfileService';

  UserProfileServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.GetProfileRequest, $0.GetProfileResponse>(
        'GetProfile',
        getProfile_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.GetProfileRequest.fromBuffer(value),
        ($0.GetProfileResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ToggleFavoriteCountryRequest,
            $0.ToggleFavoriteCountryResponse>(
        'ToggleFavoriteCountry',
        toggleFavoriteCountry_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.ToggleFavoriteCountryRequest.fromBuffer(value),
        ($0.ToggleFavoriteCountryResponse value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.UpdateNotificationPreferenceRequest,
            $0.UpdateNotificationPreferenceResponse>(
        'UpdateNotificationPreference',
        updateNotificationPreference_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.UpdateNotificationPreferenceRequest.fromBuffer(value),
        ($0.UpdateNotificationPreferenceResponse value) =>
            value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RegisterFcmTokenRequest,
            $0.RegisterFcmTokenResponse>(
        'RegisterFcmToken',
        registerFcmToken_Pre,
        false,
        false,
        ($core.List<$core.int> value) =>
            $0.RegisterFcmTokenRequest.fromBuffer(value),
        ($0.RegisterFcmTokenResponse value) => value.writeToBuffer()));
  }

  $async.Future<$0.GetProfileResponse> getProfile_Pre($grpc.ServiceCall $call,
      $async.Future<$0.GetProfileRequest> $request) async {
    return getProfile($call, await $request);
  }

  $async.Future<$0.GetProfileResponse> getProfile(
      $grpc.ServiceCall call, $0.GetProfileRequest request);

  $async.Future<$0.ToggleFavoriteCountryResponse> toggleFavoriteCountry_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.ToggleFavoriteCountryRequest> $request) async {
    return toggleFavoriteCountry($call, await $request);
  }

  $async.Future<$0.ToggleFavoriteCountryResponse> toggleFavoriteCountry(
      $grpc.ServiceCall call, $0.ToggleFavoriteCountryRequest request);

  $async.Future<$0.UpdateNotificationPreferenceResponse>
      updateNotificationPreference_Pre(
          $grpc.ServiceCall $call,
          $async.Future<$0.UpdateNotificationPreferenceRequest>
              $request) async {
    return updateNotificationPreference($call, await $request);
  }

  $async.Future<$0.UpdateNotificationPreferenceResponse>
      updateNotificationPreference($grpc.ServiceCall call,
          $0.UpdateNotificationPreferenceRequest request);

  $async.Future<$0.RegisterFcmTokenResponse> registerFcmToken_Pre(
      $grpc.ServiceCall $call,
      $async.Future<$0.RegisterFcmTokenRequest> $request) async {
    return registerFcmToken($call, await $request);
  }

  $async.Future<$0.RegisterFcmTokenResponse> registerFcmToken(
      $grpc.ServiceCall call, $0.RegisterFcmTokenRequest request);
}
