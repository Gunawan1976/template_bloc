part of 'home_bloc.dart';

class HomeState extends Equatable {
  final LoadingState status;
  final ProdukEntities? produk;
  final List<ProductEntities>? listProduk;
  final String? error;
  final int page;
  final bool hasReachedMax;

  const HomeState({
    this.produk,
    this.error,
    this.status = LoadingState.initial,
    this.page = 1,
    this.hasReachedMax = false,
    this.listProduk,
  });

  HomeState copyWith({
    LoadingState? status,
    ProdukEntities? produk,
    String? error,
    int? page,
    bool? hasReachedMax,
    List<ProductEntities>? listProduk,
  }) {
    return HomeState(
      status: status ?? this.status,
      produk: produk ?? this.produk,
      error: error ?? this.error,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      listProduk: listProduk ?? this.listProduk,
    );
  }

  @override
  List<Object?> get props => [
    status,
    produk,
    error,
    page,
    hasReachedMax,
    listProduk,
  ];
}
