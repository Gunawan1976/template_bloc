import 'package:equatable/equatable.dart';

class CaptchaEntities extends Equatable {
  final DataEntities? data;
  final String? message;
  final int? status;

  const CaptchaEntities({this.data, this.message, this.status});

  @override
  List<Object?> get props => [data,message,status];
}

class DataEntities extends Equatable {
  final String? captcha;
  final String? captchaId;

  const DataEntities({this.captcha, this.captchaId});

  @override
  List<Object?> get props => [captcha,captchaId];

}