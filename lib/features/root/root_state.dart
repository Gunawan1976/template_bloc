part of 'root_bloc.dart';

class RootState extends Equatable {
  final int tick;
  final bool showFiveMinutesDialog;

  const RootState({
    required this.tick,
    required this.showFiveMinutesDialog,
  });

  factory RootState.initial() {
    return const RootState(
      tick: 0,
      showFiveMinutesDialog: false,
    );
  }

  RootState copyWith({
    int? tick,
    bool? showFiveMinutesDialog,
  }) {
    return RootState(
      tick: tick ?? this.tick,
      showFiveMinutesDialog:
      showFiveMinutesDialog ?? this.showFiveMinutesDialog,
    );
  }

  @override
  List<Object> get props => [tick, showFiveMinutesDialog];
}
