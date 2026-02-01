part of 'single_produk_bloc.dart';

@freezed
class SingleProdukState with _$SingleProdukState {
  const factory SingleProdukState.initial() = _Initial;

  const factory SingleProdukState.loading() = _Loading;

  const factory SingleProdukState.success({
    required SingleProductEntities data,
  }) = _Success;

  const factory SingleProdukState.error(String message) = _Error;
}
