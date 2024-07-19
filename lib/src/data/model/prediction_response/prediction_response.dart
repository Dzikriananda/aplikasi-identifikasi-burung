// To parse this JSON data, do
//
//     final predictionResponse = predictionResponseFromJson(jsonString);

import 'dart:convert';

PredictionResponse predictionResponseFromJson(String str) => PredictionResponse.fromJson(json.decode(str));

// String predictionResponseToJson(PredictionResponse data) => json.encode(data.toJson());

class PredictionResponse {
  final Map<String, BirdSpecies>? list;
  final String? result;

  PredictionResponse({
    this.list,
    this.result,
  });

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    Map<String, BirdSpecies> birds = {};
    json["list"].forEach((key, value) {
      birds[key] = BirdSpecies.fromJson(value);
    });
    return PredictionResponse(
      list: birds,
      result: json["result"],
    );
  }

  Map<String, dynamic> toJson() => {
    "list": list,
    "result": result,
  };
}

class BirdSpecies {
  final String? category;
  final double? confidence;
  final String? description;
  final int? id;
  final String? scientificName;

  BirdSpecies({
    this.category,
    this.confidence,
    this.description,
    this.id,
    this.scientificName,
  });

  factory BirdSpecies.fromJson(Map<String, dynamic> json) => BirdSpecies(
    category: json["category"],
    confidence: json["confidence"]?.toDouble(),
    description: json["description"],
    id: json["id"],
    scientificName: json["scientific_name"],
  );

  Map<String, dynamic> toJson() => {
    "category": category,
    "confidence": confidence,
    "description": description,
    "id": id,
    "scientific_name": scientificName,
  };
}
