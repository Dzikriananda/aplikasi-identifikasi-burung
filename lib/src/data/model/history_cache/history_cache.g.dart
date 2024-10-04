// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_cache.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryCacheAdapter extends TypeAdapter<HistoryCache> {
  @override
  final int typeId = 1;

  @override
  HistoryCache read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryCache(
      id: fields[0] as int,
      imagePath: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryCache obj) {
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
      other is HistoryCacheAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
