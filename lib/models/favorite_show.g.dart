// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_show.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteShowAdapter extends TypeAdapter<FavoriteShow> {
  @override
  final int typeId = 0;

  @override
  FavoriteShow read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteShow(
      title: fields[0] as String,
      day: fields[1] as String,
      image: fields[2] as String,
      description: fields[3] as String,
      savedAt: fields[4] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteShow obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.day)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.savedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteShowAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
