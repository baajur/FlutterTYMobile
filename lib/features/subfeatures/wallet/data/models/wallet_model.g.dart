// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_WalletModel _$_$_WalletModelFromJson(Map<String, dynamic> json) {
  return _$_WalletModel(
    auto: json['auto'] as String ?? '0',
    credit: json['creditlimit'] as String ?? '0.00',
  );
}

// ignore: non_constant_identifier_names
Map<String, dynamic> _$_$_WalletModelToJson(_$_WalletModel instance) =>
    <String, dynamic>{
      'auto': instance.auto,
      'creditlimit': instance.credit,
    };
