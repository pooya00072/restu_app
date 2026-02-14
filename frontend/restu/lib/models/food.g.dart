// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RestuFoodAdapter extends TypeAdapter<RestuFood> {
  @override
  final int typeId = 0;

  @override
  RestuFood read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RestuFood(
      id: fields[0] as int,
      name: fields[1] as String,
      price: fields[2] as double,
      type: fields[3] as String,
      ingredients: fields[4] as String,
      description: fields[5] as String,
      frequency: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RestuFood obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.ingredients)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.frequency);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestuFoodAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
