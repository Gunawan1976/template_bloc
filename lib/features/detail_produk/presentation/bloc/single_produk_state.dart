part of 'single_produk_bloc.dart';

@freezed
class SingleProdukState with _$SingleProdukState {
  const factory SingleProdukState.initial() = _Initial;

  const factory SingleProdukState.loading() = _Loading;

  const factory SingleProdukState.success({
    required SingleProductEntities data,
    @Default(0) int counter,
  }) = _Success;

  const factory SingleProdukState.error(String message) = _Error;

  // const factory SingleProdukState.counter({
  //   @Default(0) int value,
  // }) = _CounterProduk;
}
