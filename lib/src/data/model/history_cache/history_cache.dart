import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'history_cache.g.dart';

@HiveType(typeId: 1)
class HistoryCache {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final Uint8List imageData;

  HistoryCache({
    required this.id,required this.imageData
  });
}