import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/observability/logger.dart';
import '../../../shared/widgets/async_retry.dart';
import '../application/get_usecase.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({super.key, required this.keyCd});

  final String keyCd;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(incidentDetailProvider(keyCd));

    return Scaffold(
      appBar: AppBar(title: const Text('詳細')),
      body: detail.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => AsyncRetryBody(
          error: e,
          onRetry: () => ref.invalidate(incidentDetailProvider(keyCd)),
        ),
        data: (incident) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              incident.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              '${incident.countryName} · ${_formatDate(incident.leaveDate)}'
              '${incident.isCentroidFallback ? ' · 国レベル' : ''}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (incident.lead.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(incident.lead, style: const TextStyle(fontSize: 16)),
            ],
            if (incident.mainText.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(incident.mainText),
            ],
            if (incident.infoUrl.isNotEmpty) ...[
              const SizedBox(height: 24),
              OutlinedButton.icon(
                icon: const Icon(Icons.open_in_new),
                label: const Text('外務省サイトで全文を見る'),
                onPressed: () => _openExternal(context, incident.infoUrl),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime d) {
    String two(int v) => v < 10 ? '0$v' : '$v';
    return '${d.year}-${two(d.month)}-${two(d.day)}';
  }
}

/// Wraps `launchUrl` so a failure (malformed URI, no browser available,
/// OS refusal) surfaces as a SnackBar instead of a silent no-op. Uses
/// LaunchMode.externalApplication explicitly so the link opens in the
/// device browser rather than an in-app webview.
///
/// Only http/https are launched — the `infoUrl` ultimately comes from the
/// server, so restricting schemes prevents launching `file:`, `intent:`,
/// or arbitrary custom schemes if the wire contract ever slips.
Future<void> _openExternal(BuildContext context, String raw) async {
  const failure = 'リンクを開けませんでした。';
  const logger = AppLogger('ui.launch_url');
  final uri = Uri.tryParse(raw);
  if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('リンクが不正です。')),
      );
    }
    return;
  }
  try {
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(failure)),
      );
    }
  } catch (error, stack) {
    logger.warn('launchUrl threw', error: error, stackTrace: stack);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(failure)),
      );
    }
  }
}
