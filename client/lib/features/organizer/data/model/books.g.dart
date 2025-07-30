// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BooksAdapter extends TypeAdapter<Books> {
  @override
  final typeId = 0;

  @override
  Books read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Books(
      name: fields[0] as String,
      subject: fields[1] as String,
      status: fields[2] as String,
      feedback: fields[3] as String?,
      pdfPath: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Books obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.subject)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.feedback)
      ..writeByte(4)
      ..write(obj.pdfPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BooksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
