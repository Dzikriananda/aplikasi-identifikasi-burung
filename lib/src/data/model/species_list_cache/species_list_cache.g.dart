// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'species_list_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SpeciesListCacheAdapter extends TypeAdapter<SpeciesListCache> {
  @override
  final int typeId = 2;

  @override
  SpeciesListCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SpeciesListCache(
      id: fields[0] as int,
      imagePath: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SpeciesListCache obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.imagePath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SpeciesListCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
