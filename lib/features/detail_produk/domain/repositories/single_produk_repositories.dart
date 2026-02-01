import 'package:vcc_remake_bloc/core/data_state.dart';
import 'package:vcc_remake_bloc/features/detail_produk/domain/entities/single_produk_entities.dart';

abstract class SingleProdukRepository {
  Future<DataState<SingleProductEntities>> getSingleProduk({required String id});
}
