// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
part 'user_model.g.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

@HiveType(typeId: 3)
class UserModel {
  @HiveField(0)
  final int? id;

  @HiveField(1)
  final DateTime? createdAt;

  @HiveField(2)
  final DateTime? updatedAt;

  @HiveField(3)
  final dynamic deletedAt;

  @HiveField(4)
  final String? name;

  @HiveField(5)
  final String? phone;

  @HiveField(6)
  final String? username;

  @HiveField(7)
  final String? email;

  @HiveField(8)
  final String? password;

  @HiveField(9)
  final dynamic predictions;

  @HiveField(10)
  final String? userType;

  UserModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.phone,
    this.username,
    this.email,
    this.password,
    this.predictions,
    this.userType,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    name: json["Name"],
    phone: json["Phone"],
    username: json["Username"],
    email: json["Email"],
    password: json["Password"],
    predictions: json["Predictions"],
    userType: json["UserType"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "Name": name,
    "Phone": phone,
    "Username": username,
    "Email": email,
    "Password": password,
    "Predictions": predictions,
    "UserType": userType,
  };
}


