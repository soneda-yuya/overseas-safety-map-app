import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/rpc/bff_client.dart';
import '../../../core/rpc/error_mapper.dart';
import '../../../core/rpc/mappers.dart';
import '../../../gen/v1/safetymap.pb.dart';
import '../../incidents/domain/incident.dart';

class NearbyArgs {
  const NearbyArgs({
    required this.center,
    required this.radiusKm,
    this.limit = 20,
  });

  final LatLng center;
  final double radiusKm;
  final int limit;

  @override
  bool operator ==(Object other) =>
      other is NearbyArgs &&
      other.center == center &&
      other.radiusKm == radiusKm &&
      other.limit == limit;

  @override
  int get hashCode => Object.hash(center, radiusKm, limit);
}

class NearbyUseCase {
  NearbyUseCase(this._bff);

  final BffClient _bff;

  Future<List<Incident>> execute(NearbyArgs args) async {
    try {
      final res = await _bff.safetyIncident.listNearby(
        ListNearbyRequest(
          center: pointToProto(args.center),
          radiusKm: args.radiusKm,
          limit: args.limit,
        ),
      );
      return res.items.map(incidentFromProto).toList(growable: false);
    } catch (error) {
      throw mapRpcError(error);
    }
  }
}

final nearbyUseCaseProvider = Provider<NearbyUseCase>(
  (ref) => NearbyUseCase(ref.watch(bffClientProvider)),
);

final nearbyProvider = FutureProvider.autoDispose
    .family<List<Incident>, NearbyArgs>((ref, args) async {
  return ref.watch(nearbyUseCaseProvider).execute(args);
});
