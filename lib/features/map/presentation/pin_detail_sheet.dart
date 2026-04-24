import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../shared/widgets/async_retry.dart';
import '../../incidents/domain/incident.dart';
import '../application/nearby_usecase.dart';

/// Popup shown when the user taps a pin on the map. Fetches **multiple**
/// nearby incidents via ListNearby so the user sees other events in the
/// same area, not just the single tapped incident. The tapped coordinate
/// is the search centre; default radius / limit are tuned to show a
/// handful of items without overwhelming the bottom sheet.
class PinDetailSheet extends ConsumerWidget {
  const PinDetailSheet({super.key, required this.center});

  final LatLng center;

  /// Radius wide enough to group a few nearby incidents, narrow enough to
  /// stay "around this pin". 300km ≈ two Japanese prefectures or one
  /// mid-sized country's populated belt.
  static const _radiusKm = 300.0;

  /// Shown in the popup; "もっと見る" opens the country-filtered list for
  /// the rest. 5 keeps the sheet compact on most devices.
  static const _limit = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = NearbyArgs(center: center, radiusKm: _radiusKm, limit: _limit);
    final async = ref.watch(nearbyProvider(args));

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: async.when(
          loading: () => const _LoadingBody(),
          error: (e, _) => AsyncRetryBody(
            error: e,
            onRetry: () => ref.invalidate(nearbyProvider(args)),
          ),
          data: (items) => _DataBody(items: items),
        ),
      ),
    );
  }
}

class _LoadingBody extends StatelessWidget {
  const _LoadingBody();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 160,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _DataBody extends StatelessWidget {
  const _DataBody({required this.items});

  final List<Incident> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox(
        height: 120,
        child: Center(child: Text('この付近の事件は見つかりませんでした')),
      );
    }
    // Pick a country to carry into "もっと見る" — use the closest item's
    // (the list is server-sorted by distance). If blank, the button is
    // hidden so we don't route to an unusable /incidents?country=.
    final pivotCountry = items.firstWhere(
      (i) => i.countryCd.isNotEmpty && i.countryName.isNotEmpty,
      orElse: () => items.first,
    );
    final canDrillDown =
        pivotCountry.countryCd.isNotEmpty &&
        pivotCountry.countryName.isNotEmpty;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'この付近の事件 ${items.length} 件',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Divider(height: 1),
        for (final (i, incident) in items.indexed) ...[
          if (i > 0) const Divider(height: 1),
          _IncidentTile(incident: incident),
        ],
        const SizedBox(height: 12),
        if (canDrillDown)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                final uri = Uri(
                  path: '/incidents',
                  queryParameters: {
                    'country': pivotCountry.countryCd,
                    'countryName': pivotCountry.countryName,
                  },
                );
                context.go(uri.toString());
              },
              icon: const Icon(Icons.arrow_forward),
              label: Text('${pivotCountry.countryName} の一覧をもっと見る'),
            ),
          ),
      ],
    );
  }
}

class _IncidentTile extends StatelessWidget {
  const _IncidentTile({required this.incident});

  final Incident incident;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        incident.title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Text(
        '${incident.countryName.isEmpty ? '不明' : incident.countryName}'
        ' · ${_formatDate(incident.leaveDate)}'
        '${incident.isCentroidFallback ? ' · 国レベル' : ''}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () {
        Navigator.of(context).pop();
        context.push('/incidents/detail/${incident.keyCd}');
      },
    );
  }

  String _formatDate(DateTime d) {
    String two(int v) => v < 10 ? '0$v' : '$v';
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }
}
