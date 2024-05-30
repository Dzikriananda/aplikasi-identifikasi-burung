// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PredictionResponseAdapter extends TypeAdapter<PredictionResponse> {
  @override
  final int typeId = 2;

  @override
  PredictionResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PredictionResponse(
      confidence: (fields[0] as Map).cast<String, double>(),
      result: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PredictionResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.confidence)
      ..writeByte(1)
      ..write(obj.result);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PredictionResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
