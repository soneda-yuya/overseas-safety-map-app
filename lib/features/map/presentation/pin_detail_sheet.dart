import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/async_retry.dart';
import '../../incidents/application/get_usecase.dart';
import '../../incidents/domain/incident.dart';

/// Popup shown when the user taps a pin on the map. Fetches the full
/// incident on demand via `incidentDetailProvider` — heatmap points only
/// carry {keyCd, location, weight}, so title / country / date need a
/// separate RPC. A single tap is fine to pay that cost for; the detail
/// screen caches the same provider.
class PinDetailSheet extends ConsumerWidget {
  const PinDetailSheet({super.key, required this.keyCd});

  final String keyCd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(incidentDetailProvider(keyCd));
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
        child: async.when(
          loading: () => const _LoadingBody(),
          error: (e, _) => AsyncRetryBody(
            error: e,
            onRetry: () => ref.invalidate(incidentDetailProvider(keyCd)),
          ),
          data: (incident) => _DataBody(incident: incident),
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
  const _DataBody({required this.incident});

  final Incident incident;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: 40,
          height: 4,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.outlineVariant,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        Text(
          incident.title,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          '${incident.countryName.isEmpty ? '不明' : incident.countryName}'
          ' · ${_formatDate(incident.leaveDate)}'
          '${incident.isCentroidFallback ? ' · 国レベル' : ''}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (incident.lead.isNotEmpty) ...[
          const SizedBox(height: 12),
          Text(
            incident.lead.trim(),
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ],
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              context.push('/incidents/detail/${incident.keyCd}');
            },
            icon: const Icon(Icons.arrow_forward),
            label: const Text('詳細を見る'),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime d) {
    String two(int v) => v < 10 ? '0$v' : '$v';
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }
}
