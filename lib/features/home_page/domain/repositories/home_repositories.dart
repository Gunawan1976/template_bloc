import 'package:vcc_remake_bloc/core/data_state.dart';
import 'package:vcc_remake_bloc/features/home_page/domain/entities/produk_entities.dart';

abstract class HomeRepository {
  Future<DataState<ProdukEntities>> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  });
}
