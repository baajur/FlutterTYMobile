// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_vip_setting_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$CenterVipSetting _$_$CenterVipSettingFromJson(Map<String, dynamic> json) {
  return _$CenterVipSetting(
    item: CenterVipSettingModel.jsonToCenterVipSettingItem(
        json['setting'] as Map<String, dynamic>),
    title: json['title'] as String,
  );
}

// ignore: non_constant_identifier_names
Map<String, dynamic> _$_$CenterVipSettingToJson(_$CenterVipSetting instance) =>
    <String, dynamic>{
      'setting': instance.item,
      'title': instance.title,
    };

// ignore: non_constant_identifier_names
_$CenterVipSettingItem _$_$CenterVipSettingItemFromJson(
    Map<String, dynamic> json) {
  return _$CenterVipSettingItem(
    allgame: json['allgame'] as String,
    slotgame: json['slotgame'] as String,
    casinogame: json['casinogame'] as String,
    sportgame: json['sportgame'] as String,
    fishgame: json['fishgame'] as String,
    lotterygame: json['lotterygame'] as String,
    cardgame: json['cardgame'] as String,
  );
}

// ignore: non_constant_identifier_names
Map<String, dynamic> _$_$CenterVipSettingItemToJson(
        _$CenterVipSettingItem instance) =>
    <String, dynamic>{
      'allgame': instance.allgame,
      'slotgame': instance.slotgame,
      'casinogame': instance.casinogame,
      'sportgame': instance.sportgame,
      'fishgame': instance.fishgame,
      'lotterygame': instance.lotterygame,
      'cardgame': instance.cardgame,
    };
