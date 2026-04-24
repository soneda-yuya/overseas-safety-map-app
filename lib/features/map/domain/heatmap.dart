import 'package:latlong2/latlong.dart';

/// One point on the heatmap. Weight is 1.0 today (MVP); keeping it as a
/// first-class field preserves the server's option to supply a severity
/// weight later without breaking the client.
class HeatmapPoint {
  const HeatmapPoint({required this.location, required this.weight});

  final LatLng location;
  final double weight;
}

/// Heatmap result + count of incidents whose geocoded location was only a
/// country centroid (dropped from the point cloud; see design §1.8). The
/// UI can surface that number as a data-quality warning.
class HeatmapResult {
  const HeatmapResult({
    required this.points,
    required this.excludedFallback,
  });

  final List<HeatmapPoint> points;
  final int excludedFallback;
}
