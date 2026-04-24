import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/async_retry.dart';
import '../application/choropleth_usecase.dart';
import '../domain/choropleth.dart';
import '../domain/map_filter.dart';

/// Bottom sheet listing countries that have incidents, sorted by count desc.
/// Tapping a row closes the sheet and navigates to the incidents list,
/// pre-filtered by that country.
class CountryListSheet extends ConsumerWidget {
  const CountryListSheet({super.key, required this.filter});

  final MapFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(choroplethProvider(filter));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.55,
      minChildSize: 0.3,
      maxChildSize: 0.92,
      builder: (context, scrollController) {
        return Column(
          children: [
            const _GrabHandle(),
            _Header(total: async.asData?.value.total),
            const Divider(height: 1),
            Expanded(
              child: async.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => AsyncRetryBody(
                  error: e,
                  onRetry: () => ref.invalidate(choroplethProvider(filter)),
                ),
                data: (result) =>
                    _Body(result: result, scrollController: scrollController),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _GrabHandle extends StatelessWidget {
  const _GrabHandle();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.total});

  final int? total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: Row(
        children: [
          Text('国別件数', style: Theme.of(context).textTheme.titleMedium),
          const Spacer(),
          if (total != null)
            Text('全 $total 件', style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.result, required this.scrollController});

  final ChoroplethResult result;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (result.isEmpty) {
      return const Center(child: Text('該当する事件はありません'));
    }
    // Server does not guarantee ordering; sort by count desc for the UI.
    final sorted = [...result.entries]
      ..sort((a, b) => b.count.compareTo(a.count));
    return ListView.separated(
      controller: scrollController,
      itemCount: sorted.length,
      separatorBuilder: (_, _) => const Divider(height: 1),
      itemBuilder: (_, i) => _CountryTile(entry: sorted[i]),
    );
  }
}

class _CountryTile extends StatelessWidget {
  const _CountryTile({required this.entry});

  final ChoroplethEntry entry;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          color: entry.color,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      title: Text(entry.countryName),
      trailing: Text(
        '${entry.count} 件',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      onTap: () {
        // Close the sheet first so the navigation push does not stack on
        // top of a still-mounted modal.
        Navigator.of(context).pop();
        final uri = Uri(
          path: '/incidents',
          queryParameters: {
            'country': entry.countryCd,
            'countryName': entry.countryName,
          },
        );
        context.go(uri.toString());
      },
    );
  }
}
