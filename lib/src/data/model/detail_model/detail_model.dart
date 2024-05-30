
import 'package:bird_guard/src/data/model/prediction_response/prediction_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'detail_model.g.dart';

@HiveType(typeId: 1)
class DetailModel extends HiveObject {
  @HiveField(0)
  String imagePath;

  @HiveField(1)
  PredictionResponse data;

  DetailModel({required this.imagePath,required this.data});

}