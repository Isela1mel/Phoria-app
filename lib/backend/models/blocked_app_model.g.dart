// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_app_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BlockedAppModelAdapter extends TypeAdapter<BlockedAppModel> {
  @override
  final int typeId = 3;

  @override
  BlockedAppModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BlockedAppModel(
      userId: fields[0] as String,
      appName: fields[1] as String,
      isBlocked: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BlockedAppModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.appName)
      ..writeByte(2)
      ..write(obj.isBlocked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BlockedAppModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
