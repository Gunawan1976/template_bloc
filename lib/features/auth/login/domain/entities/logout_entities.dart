import 'package:equatable/equatable.dart';

class LogoutEntities extends Equatable {
  final String? data;
  final String? message;
  final int? status;

  LogoutEntities({
    this.data,
    this.message,
    this.status,
  });

  @override
  List<Object?> get props => [data, message, status];

}