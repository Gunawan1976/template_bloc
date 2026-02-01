part of 'single_produk_bloc.dart';

@freezed
abstract class SingleProdukEvent with _$SingleProdukEvent {
  const factory SingleProdukEvent.fetch({
    required String id,
  }) = _Fetch;

  const factory SingleProdukEvent.increment() = _Increment;
  const factory SingleProdukEvent.decrement() = _Decrement;
}