part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();

  @override
  List<Object?> get props => [];
}

class StartGlobalTimer extends RootEvent {}

class TickEvent extends RootEvent {}

class FiveMinutesPassed extends RootEvent {}
