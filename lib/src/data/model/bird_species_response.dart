// To parse this JSON data, do
//
//     final birdSpeciesResponse = birdSpeciesResponseFromJson(jsonString);

import 'dart:convert';

List<BirdSpeciesResponse> birdSpeciesResponseFromJson(List<dynamic> list) => List<BirdSpeciesResponse>.from(list.map((x) => BirdSpeciesResponse.fromJson(x)));

String birdSpeciesResponseToJson(List<BirdSpeciesResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BirdSpeciesResponse {
  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? name;
  final String? description;
  final int? training;
  final int? untrained;
  final int? testing;
  final int? validation;
  final String? scientificName;
  final String? category;
  final dynamic datasets;

  BirdSpeciesResponse({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.name,
    this.description,
    this.training,
    this.untrained,
    this.testing,
    this.validation,
    this.scientificName,
    this.category,
    this.datasets,
  });

  factory BirdSpeciesResponse.fromJson(Map<String, dynamic> json) => BirdSpeciesResponse(
    id: json["ID"],
    createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
    updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
    deletedAt: json["DeletedAt"],
    name: json["Name"],
    description: json["Description"],
    training: json["Training"],
    untrained: json["Untrained"],
    testing: json["Testing"],
    validation: json["Validation"],
    scientificName: json["ScientificName"],
    category: json["Category"],
    datasets: json["Datasets"],
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "CreatedAt": createdAt?.toIso8601String(),
    "UpdatedAt": updatedAt?.toIso8601String(),
    "DeletedAt": deletedAt,
    "Name": name,
    "Description": description,
    "Training": training,
    "Untrained": untrained,
    "Testing": testing,
    "Validation": validation,
    "ScientificName": scientificName,
    "Category": category,
    "Datasets": datasets,
  };
}
