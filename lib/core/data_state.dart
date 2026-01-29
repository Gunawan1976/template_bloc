import 'package:dio/dio.dart';

abstract class DataState<T> {
  final T? dataState;
  final DioException? message;

  DataState({this.dataState, this.message});
}

class DataSuccess<T> extends DataState<T> {
  DataSuccess(T data) : super(dataState: data);
}

class DataError<T> extends DataState<T> {
  DataError(DioException message) : super(message: message);
}