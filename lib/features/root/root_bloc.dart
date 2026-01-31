import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  Timer? _timer;
  int _seconds = 0;

  RootBloc() : super(RootState.initial()) {
    on<StartGlobalTimer>(_onStartTimer);
    on<TickEvent>(_onTick);
    on<FiveMinutesPassed>(_onFiveMinutesPassed);
  }

  void _onStartTimer(StartGlobalTimer event, Emitter<RootState> emit) {
    if (_timer != null) return; // prevent multiple timer

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!isClosed) {
        add(TickEvent());
      }
    });
  }

  void _onTick(TickEvent event, Emitter<RootState> emit) {
    _seconds++;
    emit(state.copyWith(
      tick: _seconds,
      showFiveMinutesDialog: false,
    ));

    if (_seconds % 300 == 0) {
      add(FiveMinutesPassed());
    }
  }

  void _onFiveMinutesPassed(
      FiveMinutesPassed event, Emitter<RootState> emit) {
    emit(state.copyWith(showFiveMinutesDialog: true));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
