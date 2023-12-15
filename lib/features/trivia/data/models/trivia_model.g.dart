// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trivia_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TriviaModelAdapter extends TypeAdapter<TriviaModel> {
  @override
  final int typeId = 1;

  @override
  TriviaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TriviaModel(
      results: (fields[0] as List).cast<QuestionModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, TriviaModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TriviaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
