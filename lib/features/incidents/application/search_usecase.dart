import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/rpc/bff_client.dart';
import '../../../core/rpc/error_mapper.dart';
import '../../../core/rpc/mappers.dart';
import '../../../gen/v1/safetymap.pb.dart';
import '../domain/incident.dart';
import '../domain/incident_filter.dart';

/// Keyword + filter search. `query` rides on the separate proto field
/// (U-BFF added `query` = 2 in the parent repo after Copilot review);
/// do not stuff it into cursor again.
class SearchIncidentsArgs {
  const SearchIncidentsArgs({required this.filter, required this.query});

  final IncidentFilter filter;
  final String query;

  @override
  bool operator ==(Object other) =>
      other is SearchIncidentsArgs &&
      other.filter == filter &&
      other.query == query;

  @override
  int get hashCode => Object.hash(filter, query);
}

class SearchIncidentsUseCase {
  SearchIncidentsUseCase(this._bff);

  final BffClient _bff;

  Future<IncidentPage> execute(SearchIncidentsArgs args) async {
    try {
      final res = await _bff.safetyIncident.searchSafetyIncidents(
        SearchSafetyIncidentsRequest(
          filter: filterToProto(args.filter),
          query: args.query,
        ),
      );
      return IncidentPage(
        items: res.items.map(incidentFromProto).toList(growable: false),
        nextCursor: res.nextCursor,
      );
    } catch (error) {
      throw mapRpcError(error);
    }
  }
}

final searchIncidentsUseCaseProvider = Provider<SearchIncidentsUseCase>(
  (ref) => SearchIncidentsUseCase(ref.watch(bffClientProvider)),
);

final incidentsSearchProvider = FutureProvider.autoDispose
    .family<IncidentPage, SearchIncidentsArgs>((ref, args) async {
      return ref.watch(searchIncidentsUseCaseProvider).execute(args);
    });
