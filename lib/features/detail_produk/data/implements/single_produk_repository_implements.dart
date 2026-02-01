import 'package:dio/dio.dart';
import 'package:vcc_remake_bloc/core/data_state.dart';
import 'package:vcc_remake_bloc/features/detail_produk/data/sources/single_produk_api_services.dart';

import 'package:vcc_remake_bloc/features/detail_produk/domain/entities/single_produk_entities.dart';

import '../../../../core/network/error_handling.dart';
import '../../domain/repositories/single_produk_repositories.dart';
import '../models/single_produk_model.dart';

class SingleProdukRepositoryImpl extends SingleProdukRepository {
  SingleProdukApiServices singleProdukApiServices;

  SingleProdukRepositoryImpl({required this.singleProdukApiServices});

  @override
  Future<DataState<SingleProductEntities>> getSingleProduk({required String id})async {
    try {
      SingleProduct response = await singleProdukApiServices.getSingleProduk(id: id);
      return DataSuccess(response);
    } on DioException catch (e) {
      return DataFailed(mapDioError(e));
    } catch (e) {
      return DataFailed<SingleProductEntities>('Unexpected error');
    }
  }
}