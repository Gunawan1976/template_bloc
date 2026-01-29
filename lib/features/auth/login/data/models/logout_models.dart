// To parse this JSON data, do
//
//     final logoutModel = logoutModelFromJson(jsonString);

import 'dart:convert';

import '../../domain/entities/logout_entities.dart';

LogoutModel logoutModelFromJson(String str) => LogoutModel.fromJson(json.decode(str));

String logoutModelToJson(LogoutModel data) => json.encode(data.toJson());

class LogoutModel extends LogoutEntities {
  final String? data;
  final String? message;
  final int? status;

  LogoutModel({
    this.data,
    this.message,
    this.status,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => LogoutModel(
    data: json["data"],
    message: json["message"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
    "message": message,
    "status": status,
  };
}
