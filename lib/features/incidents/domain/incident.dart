import 'package:latlong2/latlong.dart';

/// How a given incident's coordinate was obtained. We expose this on the
/// domain side so the UI can badge centroid-fallback items ("国レベル" in
/// the design) and so the heatmap filter (design §1.8) can drop them.
enum GeocodeSource { unspecified, mapbox, countryCentroid }

/// Domain view of a SafetyIncident. Mirrors the wire shape but uses
/// Flutter-native types (DateTime, LatLng) so the UI does not import
/// generated proto code outside the adapter boundary.
class Incident {
  const Incident({
    required this.keyCd,
    required this.infoType,
    required this.title,
    required this.countryCd,
    required this.countryName,
    required this.leaveDate,
    required this.location,
    required this.geocodeSource,
    this.lead = '',
    this.mainText = '',
    this.areaCd = '',
    this.areaName = '',
    this.infoName = '',
    this.infoUrl = '',
    this.extractedLocation = '',
  });

  final String keyCd;
  final String infoType;
  final String title;
  final String countryCd;
  final String countryName;
  final DateTime leaveDate;
  final LatLng location;
  final GeocodeSource geocodeSource;
  final String lead;
  final String mainText;
  final String areaCd;
  final String areaName;
  final String infoName;
  final String infoUrl;
  final String extractedLocation;

  bool get isCentroidFallback => geocodeSource == GeocodeSource.countryCentroid;
}

/// Opaque cursor + items pair. Callers pass the cursor straight back to the
/// next List / Search call; the BFF owns its encoding.
class IncidentPage {
  const IncidentPage({required this.items, required this.nextCursor});

  final List<Incident> items;
  final String nextCursor;

  bool get hasMore => nextCursor.isNotEmpty;
}
