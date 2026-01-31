import 'package:dio/dio.dart';
import 'package:vcc_remake_bloc/features/home_page/data/models/produk_model.dart';

import '../../../../core/network/injection.dart';

abstract class HomeApiServices {
  Future<ProdukModel> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  });
}

class HomeApiServiceImpl extends HomeApiServices {
  Dio dio;

  HomeApiServiceImpl([Dio? dio]) : dio = dio ?? locator<Dio>();

  @override
  Future<ProdukModel> getProduk({
    required String limit,
    required String skip,
    String? sortBy,
    String? order,
  })async {
    try {
      Map<String, dynamic> queryParams = {
        "limit": limit,
        "skip":skip,
        "sortBy":sortBy,
        "order":order,
      };
      queryParams.removeWhere((key, value) => value == null || value == '');
      return await dio.get(
        "products",
        queryParameters:queryParams).then((value) async {
            return ProdukModel.fromJson(value.data);
          });
    } on DioException catch (e) {
      return ProdukModel();
    }
  }
}
