import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/rpc/bff_client.dart';
import '../../../core/rpc/error_mapper.dart';
import '../../../core/rpc/mappers.dart';
import '../../../gen/v1/safetymap.pb.dart';
import '../domain/heatmap.dart';
import '../domain/map_filter.dart';

class HeatmapUseCase {
  HeatmapUseCase(this._bff);

  final BffClient _bff;

  Future<HeatmapResult> execute(MapFilter filter) async {
    try {
      final res = await _bff.crimeMap.getHeatmap(
        GetHeatmapRequest(filter: crimeMapFilterToProto(filter)),
      );
      return heatmapFromProto(res);
    } catch (error) {
      throw mapRpcError(error);
    }
  }
}

final heatmapUseCaseProvider = Provider<HeatmapUseCase>(
  (ref) => HeatmapUseCase(ref.watch(bffClientProvider)),
);

final heatmapProvider = FutureProvider.autoDispose
    .family<HeatmapResult, MapFilter>((ref, filter) async {
  return ref.watch(heatmapUseCaseProvider).execute(filter);
});
