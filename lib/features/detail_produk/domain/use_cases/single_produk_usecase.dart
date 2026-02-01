import 'package:vcc_remake_bloc/features/detail_produk/domain/repositories/single_produk_repositories.dart';

import '../../../../core/data_state.dart';
import '../entities/single_produk_entities.dart';

class GetSingleGetProdukUseCase{
  final SingleProdukRepository repository;

  GetSingleGetProdukUseCase(this.repository);

  Future<DataState<SingleProductEntities>> call({required String id}){
    return repository.getSingleProduk(id: id);
  }
}