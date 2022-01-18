// To parse this JSON data, do
//
//     final appointmentModel = appointmentModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

AppointmentModel appointmentModelFromJson(String str) =>
    AppointmentModel.fromJson(json.decode(str));

String appointmentModelToJson(AppointmentModel data) =>
    json.encode(data.toJson());

class AppointmentModel {
  AppointmentModel({
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.name,
    required this.phone,
    required this.reservedTime,
  });

  String userId;
  DateTime startDate;
  DateTime endDate;
  String name;
  String phone;
  String reservedTime;

  factory AppointmentModel.fromJson(Map<String, dynamic> json) =>
      AppointmentModel(
        userId: json["userId"] == null ? null : json["userId"],
        startDate:
            json["startDate"] == null ? null : json["startDate"].toDate(),
        endDate: json["endDate"] == null ? null : json["endDate"].toDate(),
        name: json["name"] == null ? null : json["name"],
        phone: json["phone"] == null ? null : json["phone"],
        reservedTime:
            json["reservedTime"] == null ? null : json["reservedTime"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "startDate": startDate == null ? null : startDate,
        "endDate": endDate == null ? null : endDate,
        "name": name == null ? null : name,
        "phone": phone == null ? null : phone,
        "reservedTime": reservedTime == null ? null : reservedTime,
      };
}
