import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/rpc/bff_client.dart';
import '../../../core/rpc/error_mapper.dart';
import '../../../core/rpc/mappers.dart';
import '../../../gen/v1/safetymap.pb.dart';
import '../domain/choropleth.dart';
import '../domain/map_filter.dart';

class ChoroplethUseCase {
  ChoroplethUseCase(this._bff);

  final BffClient _bff;

  Future<ChoroplethResult> execute(MapFilter filter) async {
    try {
      final res = await _bff.crimeMap.getChoropleth(
        GetChoroplethRequest(filter: crimeMapFilterToProto(filter)),
      );
      return choroplethFromProto(res);
    } catch (error) {
      throw mapRpcError(error);
    }
  }
}

final choroplethUseCaseProvider = Provider<ChoroplethUseCase>(
  (ref) => ChoroplethUseCase(ref.watch(bffClientProvider)),
);

final choroplethProvider = FutureProvider.autoDispose
    .family<ChoroplethResult, MapFilter>((ref, filter) async {
      return ref.watch(choroplethUseCaseProvider).execute(filter);
    });
