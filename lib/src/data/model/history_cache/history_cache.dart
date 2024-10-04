import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'history_cache.g.dart';

@HiveType(typeId: 1)
class HistoryCache {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String imagePath;

  HistoryCache({
    required this.id,required this.imagePath
  });
}