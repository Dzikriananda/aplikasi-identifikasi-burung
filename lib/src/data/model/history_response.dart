// To parse this JSON data, do
//
//     final historyResponse = historyResponseFromJson(jsonString);

import 'dart:convert';

List<HistoryResponse> historyResponseFromJson(List<dynamic> list) => List<HistoryResponse>.from(list.map((x) => HistoryResponse.fromJson(x)));

String historyResponseToJson(List<HistoryResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryResponse {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? userId;
  final int? modelId;
  final String? result;
  final double? confidence;
  final String? image;

  HistoryResponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userId,
    this.modelId,
    this.result,
    this.confidence,
    this.image,
  });

  factory HistoryResponse.fromJson(Map<String, dynamic> json) => HistoryResponse(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    userId: json["UserID"],
    modelId: json["ModelID"],
    result: json["Result"],
    confidence: json["Confidence"]?.toDouble(),
    image: json["Image"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "UserID": userId,
    "ModelID": modelId,
    "Result": result,
    "Confidence": confidence,
    "Image": image,
  };
}
