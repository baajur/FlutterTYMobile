// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BannerEntityAdapter extends TypeAdapter<_$_BannerEntity> {
  @override
  final typeId = 101;

  @override
  _$_BannerEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_BannerEntity(
      id: fields[0] as int,
      pic: fields[1] as String,
      noPromo: fields[2] as bool,
      promoUrl: fields[3] as String,
      sort: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, _$_BannerEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.pic)
      ..writeByte(2)
      ..write(obj.noPromo)
      ..writeByte(3)
      ..write(obj.promoUrl)
      ..writeByte(4)
      ..write(obj.sort);
  }
}
