// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'marquee_freezed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MarqueeEntityAdapter extends TypeAdapter<_$_MarqueeEntity> {
  @override
  final typeId = 102;

  @override
  _$_MarqueeEntity read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _$_MarqueeEntity(
      id: fields[0] as int,
      content: fields[1] as String,
      url: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _$_MarqueeEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.url);
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MarqueeModel _$_$_MarqueeModelFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['created_at', 'updated_at']);
  return _$_MarqueeModel(
    id: json['id'] as int,
    content: json['content'] as String,
    url: json['url'] as String,
    createdAt: json['created_at'] as String,
    updatedAt: json['updated_at'] as String,
    showDate: json['showDate'] as String,
  );
}

Map<String, dynamic> _$_$_MarqueeModelToJson(_$_MarqueeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'url': instance.url,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'showDate': instance.showDate,
    };

_$_MarqueeModelList _$_$_MarqueeModelListFromJson(Map<String, dynamic> json) {
  return _$_MarqueeModelList(
    marquees: (json['marquees'] as List)
        ?.map((e) =>
            e == null ? null : MarqueeModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    speed: json['speed'] as int,
  );
}

Map<String, dynamic> _$_$_MarqueeModelListToJson(
        _$_MarqueeModelList instance) =>
    <String, dynamic>{
      'marquees': instance.marquees,
      'speed': instance.speed,
    };
