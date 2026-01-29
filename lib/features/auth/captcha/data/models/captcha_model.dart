// To parse this JSON data, do
//
//     final captchaModel = captchaModelFromJson(jsonString);

import '../../domain/entities/captcha_entities.dart';

class CaptchaModel extends CaptchaEntities{
  final Data? data;
  final String? message;
  final int? status;

  CaptchaModel({
    this.data,
    this.message,
    this.status,
  });

  factory CaptchaModel.fromJson(Map<String, dynamic> json) => CaptchaModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
    "status": status,
  };
}

class Data extends DataEntities {
  final String? captcha;
  final String? captchaId;

  Data({
    this.captcha,
    this.captchaId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    captcha: json["captcha"].split(",")[1],
    captchaId: json["captcha_id"],
  );

  Map<String, dynamic> toJson() => {
    "captcha": captcha,
    "captcha_id": captchaId,
  };
}
