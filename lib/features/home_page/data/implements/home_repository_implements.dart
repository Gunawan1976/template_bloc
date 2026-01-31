import 'package:dio/dio.dart';
import 'package:vcc_remake_bloc/core/data_state.dart';
import 'package:vcc_remake_bloc/features/home_page/data/models/produk_model.dart';
import 'package:vcc_remake_bloc/features/home_page/data/sources/home_api_services.dart';
import 'package:vcc_remake_bloc/features/home_page/domain/entities/produk_entities.dart';
import 'package:vcc_remake_bloc/features/home_page/domain/repositories/home_repositories.dart';

import '../../../../core/network/error_handling.dart';

class HomeRepositoryImp extends HomeRepository {
  HomeApiServices homeApiServices;

  HomeRepositoryImp({required this.homeApiServices});

  @override
  Future<DataState<ProdukEntities>> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  }) async {
    try {
      ProdukModel response = await homeApiServices.getProduk(
          limit: limit, skip: skip,sortBy: sortBy,order: order);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(mapDioError(e));
    } catch (e) {
      return DataFailed<ProdukEntities>('Unexpected error');
    }
  }
}
