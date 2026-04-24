// proto ⇄ domain converters. Kept on the `core/rpc` boundary so
// presentation / domain stay free of generated protobuf imports.
// Feature UseCases do still import the generated request types (e.g.
// ListSafetyIncidentsRequest) to build the call payload — that's the
// deliberate trade-off vs. wrapping every RPC in a hand-written request
// builder. If we ever add such a builder layer, update this comment.
import 'package:latlong2/latlong.dart';

import '../../gen/google/protobuf/timestamp.pb.dart' as tspb;
import '../../gen/v1/common.pb.dart' as commonpb;
import '../../gen/v1/common.pbenum.dart';
import '../../gen/v1/safetymap.pb.dart' as pbv1;
import '../../features/incidents/domain/incident.dart' as dom;
import '../../features/incidents/domain/incident_filter.dart';
import '../../features/map/domain/choropleth.dart';
import '../../features/map/domain/heatmap.dart';
import '../../features/map/domain/map_filter.dart';
import '../../features/profile/domain/user_profile.dart' as profiledom;

dom.Incident incidentFromProto(pbv1.SafetyIncident p) {
  // leave_date is required at the MOFA source (see parent repo
  // safetyincident/domain/mail_item.go Validate); a missing value is
  // schema drift on the server side. Throwing here makes the bug loud
  // rather than silently rendering `1970-01-01` on the UI.
  if (!p.hasLeaveDate()) {
    throw FormatException(
      'SafetyIncident is missing required leaveDate '
      '(key_cd="${p.keyCd}")',
    );
  }
  // In proto3 an unset message field decodes as the default instance, so
  // `p.geometry` silently becomes (0, 0) off West Africa if the server
  // forgot to populate it. The BFF domain treats geometry as required;
  // surface the drift loudly here rather than showing a phantom pin.
  if (!p.hasGeometry()) {
    throw FormatException(
      'SafetyIncident is missing required geometry '
      '(key_cd="${p.keyCd}")',
    );
  }
  return dom.Incident(
    keyCd: p.keyCd,
    infoType: p.infoType,
    title: p.title,
    countryCd: p.countryCd,
    countryName: p.countryName,
    leaveDate: p.leaveDate.toDateTime().toLocal(),
    location: LatLng(p.geometry.lat, p.geometry.lng),
    geocodeSource: _geocodeSourceFromProto(p.geocodeSource),
    lead: p.lead,
    mainText: p.mainText,
    areaCd: p.areaCd,
    areaName: p.areaName,
    infoName: p.infoName,
    infoUrl: p.infoUrl,
    extractedLocation: p.extractedLocation,
  );
}

pbv1.SafetyIncidentFilter filterToProto(IncidentFilter f) {
  final out = pbv1.SafetyIncidentFilter()
    ..limit = f.limit
    ..cursor = f.cursor
    ..infoTypes.addAll(f.infoTypes);
  if (f.countryCd != null && f.countryCd!.isNotEmpty) {
    out.countryCd = f.countryCd!;
  }
  if (f.areaCd != null && f.areaCd!.isNotEmpty) {
    out.areaCd = f.areaCd!;
  }
  if (f.leaveFrom != null) {
    out.leaveFrom = tspb.Timestamp.fromDateTime(f.leaveFrom!.toUtc());
  }
  if (f.leaveTo != null) {
    out.leaveTo = tspb.Timestamp.fromDateTime(f.leaveTo!.toUtc());
  }
  return out;
}

pbv1.CrimeMapFilter crimeMapFilterToProto(MapFilter f) {
  final out = pbv1.CrimeMapFilter();
  if (f.leaveFrom != null) {
    out.leaveFrom = tspb.Timestamp.fromDateTime(f.leaveFrom!.toUtc());
  }
  if (f.leaveTo != null) {
    out.leaveTo = tspb.Timestamp.fromDateTime(f.leaveTo!.toUtc());
  }
  return out;
}

commonpb.Point pointToProto(LatLng p) =>
    commonpb.Point(lat: p.latitude, lng: p.longitude);

ChoroplethResult choroplethFromProto(pbv1.GetChoroplethResponse r) {
  return ChoroplethResult(
    entries: r.items
        .map((it) => ChoroplethEntry.fromProto(
              countryCd: it.countryCd,
              countryName: it.countryName,
              count: it.count,
              hex: it.color,
            ))
        .toList(growable: false),
    total: r.total,
  );
}

HeatmapResult heatmapFromProto(pbv1.GetHeatmapResponse r) {
  return HeatmapResult(
    points: r.points
        .map((p) => HeatmapPoint(
              location: LatLng(p.location.lat, p.location.lng),
              weight: p.weight,
            ))
        .toList(growable: false),
    excludedFallback: r.excludedFallback,
  );
}

profiledom.UserProfile profileFromProto(pbv1.UserProfile p) {
  return profiledom.UserProfile(
    uid: p.uid,
    favoriteCountryCds: List.unmodifiable(p.favoriteCountryCds),
    preference: profiledom.NotificationPreference(
      enabled: p.notificationPreference.enabled,
      targetCountryCds:
          List.unmodifiable(p.notificationPreference.targetCountryCds),
      infoTypes: List.unmodifiable(p.notificationPreference.infoTypes),
    ),
    fcmTokenCount: p.fcmTokenCount,
  );
}

pbv1.NotificationPreference preferenceToProto(
  profiledom.NotificationPreference pref,
) {
  return pbv1.NotificationPreference()
    ..enabled = pref.enabled
    ..targetCountryCds.addAll(pref.targetCountryCds)
    ..infoTypes.addAll(pref.infoTypes);
}

dom.GeocodeSource _geocodeSourceFromProto(GeocodeSource src) {
  switch (src) {
    case GeocodeSource.GEOCODE_SOURCE_MAPBOX:
      return dom.GeocodeSource.mapbox;
    case GeocodeSource.GEOCODE_SOURCE_COUNTRY_CENTROID:
      return dom.GeocodeSource.countryCentroid;
    default:
      return dom.GeocodeSource.unspecified;
  }
}
