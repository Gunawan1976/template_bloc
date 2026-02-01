import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/single_produk_entities.dart';
import '../../domain/use_cases/single_produk_usecase.dart';

part 'single_produk_event.dart';
part 'single_produk_state.dart';
part 'single_produk_bloc.freezed.dart';

class SingleProdukBloc extends Bloc<SingleProdukEvent, SingleProdukState> {
  // final Future<SingleProductEntities> Function(int page) fetchData;
  final GetSingleGetProdukUseCase getSingleGetProdukUseCase;

  SingleProdukBloc({required this.getSingleGetProdukUseCase})
      : super(const SingleProdukState.initial()) {
    on<_Fetch>(_onFetch);
  }

  Future<void> _onFetch(
      _Fetch event,
      Emitter<SingleProdukState> emit,
      ) async {
    // emit(const SingleProdukState.loading());
    //
    // try {
    //   final data = await getSingleGetProdukUseCase.call(id: event.id);
    //   emit(SingleProdukState.success(
    //     data: data.data ?? SingleProductEntities(),
    //   ));
    // } catch (e) {
    //   emit(SingleProdukState.error(e.toString()));
    // }
    await event.when(
      fetch: (id) async {
        emit(const SingleProdukState.loading());
        final data = await getSingleGetProdukUseCase.call(id: id);
        emit(SingleProdukState.success(
          data: data.data ?? SingleProductEntities(),
        ));
      },
    );
  }
}
