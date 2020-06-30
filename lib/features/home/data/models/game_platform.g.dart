// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_platform.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GamePlatformEntityAdapter extends TypeAdapter<_$GamePlatformEntity> {
  @override
  final typeId = 104;

  @override
  _$GamePlatformEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$GamePlatformEntity(
      id: fields[0] as int,
      className: fields[1] as String,
      ch: fields[2] as String,
      site: fields[3] as String,
      category: fields[4] as String,
      favorite: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$GamePlatformEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.className)
      ..writeByte(2)
      ..write(obj.ch)
      ..writeByte(3)
      ..write(obj.site)
      ..writeByte(4)
      ..write(obj.category)
      ..writeByte(5)
      ..write(obj.favorite);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GamePlatformModel _$_$GamePlatformModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['type']);
  return _$GamePlatformModel(
    id: json['id'] as int,
    className: decodePlatformClassName(json),
    ch: decodePlatformChName(json),
    cid: json['cid'] as int,
    site: json['site'] as String,
    site2: json['site2'] as String,
    category: json['type'] as String,
    sort: json['sort'] as int,
    status: json['status'] as String,
    favorite: json['favorite'] as String ?? '0',
  );
}

Map<String, dynamic> _$_$GamePlatformModelToJson(
        _$GamePlatformModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class': instance.className,
      'ch': instance.ch,
      'cid': instance.cid,
      'site': instance.site,
      'site2': instance.site2,
      'type': instance.category,
      'sort': instance.sort,
      'status': instance.status,
      'favorite': instance.favorite,
    };

_$GamePlatformEntity _$_$GamePlatformEntityFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['type']);
  return _$GamePlatformEntity(
    id: json['id'] as int,
    className: decodePlatformClassName(json),
    ch: decodePlatformChName(json),
    site: json['site'] as String,
    category: json['type'] as String,
    favorite: json['favorite'] as String ?? '0',
  );
}

Map<String, dynamic> _$_$GamePlatformEntityToJson(
        _$GamePlatformEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'class': instance.className,
      'ch': instance.ch,
      'site': instance.site,
      'type': instance.category,
      'favorite': instance.favorite,
    };
