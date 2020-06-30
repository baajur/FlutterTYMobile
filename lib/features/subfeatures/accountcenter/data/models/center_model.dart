import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart'
    show ValueUtilExtension;

import '../entity/center_account_entity.dart';
import '../entity/center_vip_entity.dart';

part 'center_model.freezed.dart';
part 'center_model.g.dart';

@freezed
abstract class CenterModel with _$CenterModel {
  const factory CenterModel({
    @JsonKey(name: 'accountcode', defaultValue: '') String accountCode,
    @JsonKey(name: 'accountid', defaultValue: -1) int accountId,
    @JsonKey(name: 'dob', defaultValue: '') String birthDate,
    @JsonKey(name: 'mobileno', defaultValue: '') String phone,
    @Default('') String gender,
    @Default('') String email,
    @Default('') String wechat,
    @JsonKey(name: 'firstname', defaultValue: '') String firstName,
    @JsonKey(name: 'auto_transfer', defaultValue: '-1') String autoTransfer,
    @JsonKey(name: 'cGP_wallet', defaultValue: '') String cgpWallet,
    @JsonKey(name: 'cPW_wallet', defaultValue: '') String cpwWallet,
    @JsonKey(name: 'address', fromJson: _jsonList) List lotto,
    @JsonKey(name: 'allgame') int allGame,
    @JsonKey(name: 'allgame_level') int allGameLevel,
    @JsonKey(name: 'allgame_value') int allGameValue,
    @JsonKey(name: 'cardgame') int cardGame,
    @JsonKey(name: 'cardgame_level') int cardGameLevel,
    @JsonKey(name: 'cardgame_value') int cardGameValue,
    @JsonKey(name: 'casinogame') int casinoGame,
    @JsonKey(name: 'casinogame_level') int casinoGameLevel,
    @JsonKey(name: 'casinogame_value') int casinoGameValue,
    @JsonKey(name: 'fishgame') int fishGame,
    @JsonKey(name: 'fishgame_level') int fishGameLevel,
    @JsonKey(name: 'fishgame_value') int fishGameValue,
    @JsonKey(name: 'lotterygame') int lotteryGame,
    @JsonKey(name: 'lotterygame_level') int lotteryGameLevel,
    @JsonKey(name: 'lotterygame_value') int lotteryGameValue,
    @JsonKey(name: 'slotgame') int slotGame,
    @JsonKey(name: 'slotgame_level') int slotGameLevel,
    @JsonKey(name: 'slotgame_value') int slotGameValue,
    @JsonKey(name: 'sportgame') int sportGame,
    @JsonKey(name: 'sportgame_level') int sportGameLevel,
    @JsonKey(name: 'sportgame_value') int sportGameValue,
    @JsonKey(name: 'vip_option') dynamic vipOption,
    @JsonKey(name: 'vip_setting') dynamic vipSetting,
  }) = _CenterModel;

  factory CenterModel.fromJson(Map<String, dynamic> json) =>
      _$CenterModelFromJson(json);

  static CenterModel jsonToCenterModel(Map<String, dynamic> jsonMap) =>
      CenterModel.fromJson(jsonMap);
}

extension CenterModelExtension on CenterModel {
  List<int> get getLottoList {
    try {
      return List.castFrom<dynamic, int>(this.lotto);
    } catch (e) {
      print(e);
      return lotto.map((e) => e.toString().strToInt).toList();
    }
  }

  CenterAccountEntity get wrapAccountData {
    try {
      return CenterAccountEntity(
        accountCode: accountCode,
        accountId: accountId,
        birthDate: birthDate,
        phone: phone,
        gender: gender,
        email: email,
        wechat: wechat,
        firstName: firstName,
        autoTransfer: autoTransfer,
        cgpWallet: cgpWallet,
        cpwWallet: cpwWallet,
      );
    } on Exception catch (e) {
      print('center account data error: $e');
      return null;
    }
  }

  CenterVipEntity get wrapVipData {
    try {
      return CenterVipEntity(
        vipOption: vipOption,
        vipSetting: vipSetting,
        allGame: allGame,
        allGameLevel: allGameLevel,
        allGameValue: allGameValue,
        cardGame: cardGame,
        cardGameLevel: cardGameLevel,
        cardGameValue: cardGameValue,
        casinoGame: casinoGame,
        casinoGameLevel: casinoGameLevel,
        casinoGameValue: casinoGameValue,
        fishGame: fishGame,
        fishGameLevel: fishGameLevel,
        fishGameValue: fishGameValue,
        lotteryGame: lotteryGame,
        lotteryGameLevel: lotteryGameLevel,
        lotteryGameValue: lotteryGameValue,
        slotGame: slotGame,
        slotGameLevel: slotGameLevel,
        slotGameValue: slotGameValue,
        sportGame: sportGame,
        sportGameLevel: sportGameLevel,
        sportGameValue: sportGameValue,
      );
    } on Exception catch (e) {
      print('center vip data error: $e');
      return null;
    }
  }
}

List _jsonList(dynamic jsonStr) =>
    JsonUtil.decodeArray(jsonStr, returnNullOnError: true);
