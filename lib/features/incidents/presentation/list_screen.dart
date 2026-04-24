import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/async_retry.dart';
import '../application/list_usecase.dart';
import '../domain/incident.dart';
import '../domain/incident_filter.dart';

/// Incidents tab. MVP shows the first page of incidents for the current
/// filter; country dropdown + info-type filter lands in a follow-up.
class ListScreen extends ConsumerStatefulWidget {
  const ListScreen({super.key});

  @override
  ConsumerState<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends ConsumerState<ListScreen> {
  final IncidentFilter _filter = const IncidentFilter();

  @override
  Widget build(BuildContext context) {
    final page = ref.watch(incidentsPageProvider(_filter));

    return Scaffold(
      appBar: AppBar(
        title: const Text('一覧'),
        actions: [
          IconButton(
            tooltip: '再読み込み',
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(incidentsPageProvider(_filter)),
          ),
        ],
      ),
      body: page.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AsyncRetryBody(
          error: e,
          onRetry: () => ref.invalidate(incidentsPageProvider(_filter)),
        ),
        data: (page) {
          if (page.items.isEmpty) {
            return const Center(child: Text('該当する情報はありません'));
          }
          return ListView.separated(
            itemCount: page.items.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (_, i) => _IncidentTile(incident: page.items[i]),
          );
        },
      ),
    );
  }
}

class _IncidentTile extends StatelessWidget {
  const _IncidentTile({required this.incident});

  final Incident incident;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: _infoTypeColor(incident.infoType),
        child: Text(
          _infoTypeLabel(incident.infoType),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ),
      title: Text(incident.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        '${incident.countryName} · ${_formatDate(incident.leaveDate)}'
        '${incident.isCentroidFallback ? ' · 国レベル' : ''}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => context.push('/incidents/detail/${incident.keyCd}'),
    );
  }

  Color _infoTypeColor(String infoType) {
    switch (infoType) {
      case 'danger':
        return Colors.redAccent;
      case 'warning':
        return Colors.orangeAccent;
      case 'spot_info':
      case 'spot':
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }

  String _infoTypeLabel(String infoType) {
    switch (infoType) {
      case 'danger':
        return '危険';
      case 'warning':
        return '注意';
      case 'spot_info':
      case 'spot':
        return 'ｽﾎﾟｯﾄ';
      default:
        return '情報';
    }
  }

  String _formatDate(DateTime d) {
    String two(int v) => v < 10 ? '0$v' : '$v';
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }
}
