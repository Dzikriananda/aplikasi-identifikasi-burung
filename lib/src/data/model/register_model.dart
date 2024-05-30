// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  final String? name;
  final String? phone;
  final String? username;
  final String? email;
  final String? password;

  RegisterModel({
    this.name,
    this.phone,
    this.username,
    this.email,
    this.password,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    name: json["name"],
    phone: json["phone"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "username": username,
    "email": email,
    "password": password,
  };
}
