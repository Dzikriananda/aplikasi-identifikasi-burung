import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'species_list_cache.g.dart';

@HiveType(typeId: 2)
class SpeciesListCache {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final Uint8List imageData;

  SpeciesListCache({
    required this.id,required this.imageData
  });

  toJson() {
    return ({
      'id' : id,
    });
  }
}