import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/observability/logger.dart';
import '../../../shared/widgets/async_retry.dart';
import '../application/heatmap_usecase.dart';
import '../domain/heatmap.dart';
import '../domain/map_filter.dart';
import 'country_list_sheet.dart';
import 'pin_detail_sheet.dart';

/// Map tab. MVP scope: render the OSM tile layer + a heatmap of incident
/// points. The choropleth / nearby views share this screen and land in
/// later iterations (MapLayerSheet is stubbed so the action is discoverable
/// but not implemented beyond switching state).
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final MapFilter _filter = const MapFilter();

  Future<void> _openCountrySheet(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: false,
      builder: (_) => CountryListSheet(filter: _filter),
    );
  }

  @override
  Widget build(BuildContext context) {
    final heatmap = ref.watch(heatmapProvider(_filter));

    return Scaffold(
      appBar: AppBar(
        title: const Text('地図'),
        actions: [
          IconButton(
            tooltip: '国別件数',
            icon: const Icon(Icons.flag_outlined),
            onPressed: () => _openCountrySheet(context),
          ),
          IconButton(
            tooltip: '再読み込み',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(heatmapProvider(_filter)),
          ),
        ],
      ),
      body: heatmap.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AsyncRetryBody(
          error: e,
          onRetry: () => ref.invalidate(heatmapProvider(_filter)),
        ),
        data: (result) => _MapBody(result: result),
      ),
    );
  }
}

class _MapBody extends StatelessWidget {
  const _MapBody({required this.result});

  final HeatmapResult result;

  @override
  Widget build(BuildContext context) {
    // Pick the first point as the centre if we have any, otherwise fall
    // back to Tokyo. This avoids loading the world view empty when there
    // actually are pins to show.
    final initialCentre = result.points.isNotEmpty
        ? result.points.first.location
        : const LatLng(35.68, 139.76);

    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            initialCenter: initialCentre,
            initialZoom: 2.5,
            maxZoom: 18,
            minZoom: 1,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              // Must match the Android applicationId (see
              // android/app/build.gradle.kts) so OSM's Tile Usage Policy
              // can attribute requests correctly. Keep in sync if the
              // applicationId is ever changed.
              userAgentPackageName:
                  'jp.go.mofa.overseas_safety_map.overseas_safety_map_app',
              maxZoom: 19,
            ),
            MarkerLayer(
              markers: [
                for (final p in result.points)
                  Marker(
                    point: p.location,
                    // Widen the marker bounds well beyond the visible dot
                    // so the gesture target matches Material's 48dp min,
                    // even though the dot itself stays small.
                    width: 32,
                    height: 32,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => _openPinSheet(context, p.keyCd),
                      child: const Center(
                        child: _IncidentDot(),
                      ),
                    ),
                  ),
              ],
            ),
            RichAttributionWidget(
              attributions: [
                TextSourceAttribution(
                  'OpenStreetMap contributors',
                  onTap: () => _openOsmCopyright(context),
                ),
              ],
            ),
          ],
        ),
        if (result.excludedFallback > 0)
          Positioned(
            top: 8,
            left: 8,
            child: Card(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  '国レベルのみ: ${result.excludedFallback} 件は表示対象外',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _IncidentDot extends StatelessWidget {
  const _IncidentDot();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.8),
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
  }
}

Future<void> _openPinSheet(BuildContext context, String keyCd) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: false,
    isScrollControlled: true,
    builder: (_) => PinDetailSheet(keyCd: keyCd),
  );
}

/// Opens the OSM copyright page and surfaces a SnackBar if the launch
/// fails so users realise their tap wasn't ignored.
Future<void> _openOsmCopyright(BuildContext context) async {
  const failure = 'OpenStreetMap のページを開けませんでした。';
  const logger = AppLogger('ui.launch_url');
  final uri = Uri.parse('https://www.openstreetmap.org/copyright');
  try {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(failure)));
    }
  } catch (error, stack) {
    logger.warn('launchUrl threw', error: error, stackTrace: stack);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text(failure)));
    }
  }
}
