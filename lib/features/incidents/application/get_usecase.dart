import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/rpc/bff_client.dart';
import '../../../core/rpc/error_mapper.dart';
import '../../../core/rpc/mappers.dart';
import '../../../gen/v1/safetymap.pb.dart';
import '../domain/incident.dart';

/// Fetches a single incident by `key_cd`. Used by DetailScreen and by the
/// notification-tap deep link.
class GetIncidentUseCase {
  GetIncidentUseCase(this._bff);

  final BffClient _bff;

  Future<Incident> execute(String keyCd) async {
    try {
      final res = await _bff.safetyIncident.getSafetyIncident(
        GetSafetyIncidentRequest(keyCd: keyCd),
      );
      return incidentFromProto(res.item);
    } catch (error) {
      throw mapRpcError(error);
    }
  }
}

final getIncidentUseCaseProvider = Provider<GetIncidentUseCase>(
  (ref) => GetIncidentUseCase(ref.watch(bffClientProvider)),
);

final incidentDetailProvider = FutureProvider.autoDispose
    .family<Incident, String>((ref, keyCd) async {
      return ref.watch(getIncidentUseCaseProvider).execute(keyCd);
    });
