import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:vcc_remake_bloc/features/home_page/domain/entities/produk_entities.dart';
import 'package:vcc_remake_bloc/features/home_page/domain/use_cases/produk_usecase.dart';

import '../../../../core/data_state.dart';
import '../../../../core/enum.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetProdukUseCase getProdukUseCase;

  HomeBloc({required this.getProdukUseCase}) : super(HomeState()) {
    on<GetProduk>(_onGetProduk);
  }

  Future<void> _onGetProduk(
      GetProduk event,
      Emitter<HomeState> emit,
      )async{

    if (state.hasReachedMax) return;

    if (state.status == LoadingState.loading) return;

    if (state.page == 1) {
      emit(state.copyWith(status: LoadingState.loading));
    }

    await getProdukUseCase.call(limit: "10", skip: (state.page * 1).toString()).then((value) {
      final newList = value.data?.products ?? [];

      if (value is DataSuccess<ProdukEntities>) {
        if (newList.isEmpty) {
          emit(state.copyWith(hasReachedMax: true));
        } else {
          emit(state.copyWith(
            status: LoadingState.success,
            produk: value.data,
            listProduk: List.of(state.listProduk ?? [])..addAll(newList),
            page: state.page + 1,
          ));
        }
      } else if (value is DataFailed<ProdukEntities>) {
        emit(state.copyWith(
          status: LoadingState.failure,
          error: value.error,
        ));
      }
    });

  }
}
