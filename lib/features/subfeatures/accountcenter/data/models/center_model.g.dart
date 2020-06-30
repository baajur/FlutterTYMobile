// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'center_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_CenterModel _$_$_CenterModelFromJson(Map<String, dynamic> json) {
  return _$_CenterModel(
    accountCode: json['accountcode'] as String ?? '',
    accountId: json['accountid'] as int ?? -1,
    birthDate: json['dob'] as String ?? '',
    phone: json['mobileno'] as String ?? '',
    gender: json['gender'] as String ?? '',
    email: json['email'] as String ?? '',
    wechat: json['wechat'] as String ?? '',
    firstName: json['firstname'] as String ?? '',
    autoTransfer: json['auto_transfer'] as String ?? '-1',
    cgpWallet: json['cGP_wallet'] as String ?? '',
    cpwWallet: json['cPW_wallet'] as String ?? '',
    lotto: _jsonList(json['address']),
    allGame: json['allgame'] as int,
    allGameLevel: json['allgame_level'] as int,
    allGameValue: json['allgame_value'] as int,
    cardGame: json['cardgame'] as int,
    cardGameLevel: json['cardgame_level'] as int,
    cardGameValue: json['cardgame_value'] as int,
    casinoGame: json['casinogame'] as int,
    casinoGameLevel: json['casinogame_level'] as int,
    casinoGameValue: json['casinogame_value'] as int,
    fishGame: json['fishgame'] as int,
    fishGameLevel: json['fishgame_level'] as int,
    fishGameValue: json['fishgame_value'] as int,
    lotteryGame: json['lotterygame'] as int,
    lotteryGameLevel: json['lotterygame_level'] as int,
    lotteryGameValue: json['lotterygame_value'] as int,
    slotGame: json['slotgame'] as int,
    slotGameLevel: json['slotgame_level'] as int,
    slotGameValue: json['slotgame_value'] as int,
    sportGame: json['sportgame'] as int,
    sportGameLevel: json['sportgame_level'] as int,
    sportGameValue: json['sportgame_value'] as int,
    vipOption: json['vip_option'],
    vipSetting: json['vip_setting'],
  );
}

// ignore: non_constant_identifier_names
Map<String, dynamic> _$_$_CenterModelToJson(_$_CenterModel instance) =>
    <String, dynamic>{
      'accountcode': instance.accountCode,
      'accountid': instance.accountId,
      'dob': instance.birthDate,
      'mobileno': instance.phone,
      'gender': instance.gender,
      'email': instance.email,
      'wechat': instance.wechat,
      'firstname': instance.firstName,
      'auto_transfer': instance.autoTransfer,
      'cGP_wallet': instance.cgpWallet,
      'cPW_wallet': instance.cpwWallet,
      'address': instance.lotto,
      'allgame': instance.allGame,
      'allgame_level': instance.allGameLevel,
      'allgame_value': instance.allGameValue,
      'cardgame': instance.cardGame,
      'cardgame_level': instance.cardGameLevel,
      'cardgame_value': instance.cardGameValue,
      'casinogame': instance.casinoGame,
      'casinogame_level': instance.casinoGameLevel,
      'casinogame_value': instance.casinoGameValue,
      'fishgame': instance.fishGame,
      'fishgame_level': instance.fishGameLevel,
      'fishgame_value': instance.fishGameValue,
      'lotterygame': instance.lotteryGame,
      'lotterygame_level': instance.lotteryGameLevel,
      'lotterygame_value': instance.lotteryGameValue,
      'slotgame': instance.slotGame,
      'slotgame_level': instance.slotGameLevel,
      'slotgame_value': instance.slotGameValue,
      'sportgame': instance.sportGame,
      'sportgame_level': instance.sportGameLevel,
      'sportgame_value': instance.sportGameValue,
      'vip_option': instance.vipOption,
      'vip_setting': instance.vipSetting,
    };
