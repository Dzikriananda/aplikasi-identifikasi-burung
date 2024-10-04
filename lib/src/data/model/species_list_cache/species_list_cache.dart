
import 'package:hive/hive.dart';
part 'species_list_cache.g.dart';

@HiveType(typeId: 2)
class SpeciesListCache {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String imagePath;

  SpeciesListCache({
    required this.id,required this.imagePath
  });

  toJson() {
    return ({
      'id' : id,
      'imagePath' : imagePath
    });
  }
}