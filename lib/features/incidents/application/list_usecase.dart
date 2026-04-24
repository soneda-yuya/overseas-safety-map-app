import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/rpc/bff_client.dart';
import '../../../core/rpc/error_mapper.dart';
import '../../../core/rpc/mappers.dart';
import '../../../gen/v1/safetymap.pb.dart';
import '../domain/incident.dart';
import '../domain/incident_filter.dart';

/// Fetches a page of incidents from the BFF. Thin wrapper around
/// `SafetyIncidentServiceClient.listSafetyIncidents` that converts
/// proto ⇄ domain and maps transport errors to AppError.
class ListIncidentsUseCase {
  ListIncidentsUseCase(this._bff);

  final BffClient _bff;

  Future<IncidentPage> execute(IncidentFilter filter) async {
    try {
      final res = await _bff.safetyIncident.listSafetyIncidents(
        ListSafetyIncidentsRequest(filter: filterToProto(filter)),
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

final listIncidentsUseCaseProvider = Provider<ListIncidentsUseCase>(
  (ref) => ListIncidentsUseCase(ref.watch(bffClientProvider)),
);

/// FutureProvider for a specific filter; autoDispose so navigating away from
/// the list screen releases the cache.
final incidentsPageProvider = FutureProvider.autoDispose
    .family<IncidentPage, IncidentFilter>((ref, filter) async {
      return ref.watch(listIncidentsUseCaseProvider).execute(filter);
    });
