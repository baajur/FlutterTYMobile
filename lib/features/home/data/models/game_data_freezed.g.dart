// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_data_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_GameModel _$_$_GameModelFromJson(Map<String, dynamic> json) {
  return _$_GameModel(
    id: json['id'] as int,
    category: json['category'] as String,
    platform: json['platform'] as String,
    gameId: json['gameid'] as String,
    cname: json['cname'] as String,
  );
}

// ignore: non_constant_identifier_names
Map<String, dynamic> _$_$_GameModelToJson(_$_GameModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'category': instance.category,
      'platform': instance.platform,
      'gameid': instance.gameId,
      'cname': instance.cname,
    };
