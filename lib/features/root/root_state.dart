part of 'root_bloc.dart';

class RootState extends Equatable {
  final int tick;
  final bool showFiveMinutesDialog;
  final String? snackbarMessage;
  final int snackbarId; // unique trigger

  const RootState({
    required this.tick,
    required this.showFiveMinutesDialog,
    this.snackbarMessage,
    required this.snackbarId,
  });

  factory RootState.initial() {
    return const RootState(
      tick: 0,
      showFiveMinutesDialog: false,
      snackbarMessage: null,
      snackbarId: 0,
    );
  }

  RootState copyWith({
    int? tick,
    bool? showFiveMinutesDialog,
    String? snackbarMessage,
    int? snackbarId,
  }) {
    return RootState(
      tick: tick ?? this.tick,
      showFiveMinutesDialog:
      showFiveMinutesDialog ?? this.showFiveMinutesDialog,
      snackbarMessage: snackbarMessage,
      snackbarId: snackbarId ?? this.snackbarId,
    );
  }

  @override
  List<Object?> get props =>
      [tick, showFiveMinutesDialog, snackbarMessage, snackbarId];
}