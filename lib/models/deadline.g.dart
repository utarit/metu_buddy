// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deadline.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeadlineAdapter extends TypeAdapter<Deadline> {
  @override
  Deadline read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Deadline(
      course: fields[0] as Course,
      endTime: fields[1] as DateTime,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Deadline obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.course)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(3)
      ..write(obj.description);
  }
}
