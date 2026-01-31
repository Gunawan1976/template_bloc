
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/enum.dart';

part 'index_state.dart';

class IndexCubit extends Cubit<IndexState> {
  IndexCubit() : super(const IndexState(0));

  void getNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(IndexState(0));
        break;
      case 1:
        emit(IndexState(1));
        break;
      case 2:
        emit(IndexState(2));
        break;
    }
  }
}