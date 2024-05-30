// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailModelAdapter extends TypeAdapter<DetailModel> {
  @override
  final int typeId = 1;

  @override
  DetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailModel(
      imagePath: fields[0] as String,
      data: fields[1] as PredictionResponse,
    );
  }

  @override
  void write(BinaryWriter writer, DetailModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.imagePath)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
