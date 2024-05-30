

import 'package:hive/hive.dart';
part 'prediction_response.g.dart';

@HiveType(typeId: 2)
class PredictionResponse extends HiveObject {
  @HiveField(0)
  final Map<String, double> confidence;

  @HiveField(1)
  final String result;

  PredictionResponse({
    required this.confidence,
    required this.result,
  });

  Map<String, dynamic> toJson() {
    return {
      'confidence': confidence,
      'result': result,
    };
  }

  factory PredictionResponse.fromJson(Map<String, dynamic> json) {
    return PredictionResponse(
      confidence: Map<String, double>.from(json['confidence']),
      result: json['result'],
    );
  }
}