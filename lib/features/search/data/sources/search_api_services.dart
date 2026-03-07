import 'package:vcc_remake_bloc/features/home_page/data/models/produk_model.dart';

abstract class SearchApiServices {
  Future<ProdukModel>getSearchProduk({required String query});
}