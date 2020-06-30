import 'dart:convert' show jsonDecode;

import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData, requestRawString;
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

import '../form/bankcard_form.dart';
import '../models/bankcard_model.dart';

class BankcardApi {
  static const String GET_CARD = "api/bankcard";
  static const String POST_PROVINCES = "api/getProvince";
  static const String POST_BANKS = "api/getBankid";
  static const String POST_CITY = "api/getCity";
  static const String POST_NEW_CARD = "api/addbankcard";
}

abstract class BankcardRemoteDataSource {
  Future<BankcardModel> getBankcard();
  Future<Map<String, String>> getBanks();
  Future<Map<String, String>> getProvinces();
  Future<Map<String, String>> getMapByCode(String code);

  Future<RequestStatusModel> postBankcard(BankcardForm form);
}

class BankcardRemoteDataSourceImpl implements BankcardRemoteDataSource {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'BankcardRemoteDataSource';

  BankcardRemoteDataSourceImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<BankcardModel> getBankcard() async {
    return await requestRawString(
      request: dioApiService.get(
        BankcardApi.GET_CARD,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-Bankcard',
    ).then((value) {
      if (value == 'false') {
        return BankcardModel(hasCard: false);
      } else {
        try {
          String trimmed = JsonUtil.trimJson(value);
          Map<String, dynamic> map = jsonDecode(trimmed);
          map.putIfAbsent('hasCard', () => true);
          MyLogger.print(msg: 'bankcard map: $map', tag: tag);
          return BankcardModel.fromJson(map);
        } on Exception catch (e) {
          MyLogger.error(msg: 'bankcard map error!!', error: e, tag: tag);
          return BankcardModel(hasCard: null);
        }
      }
    });
  }

  @override
  Future<Map<String, String>> getBanks() async {
    return await requestRawString(
      request: dioApiService.post(BankcardApi.POST_BANKS),
      allowJsonString: true,
      tag: 'remote-BankIds',
    ).then((value) {
      try {
        String trimmed = JsonUtil.trimJson(value);
        Map<String, dynamic> map = jsonDecode(trimmed);
        MyLogger.print(msg: 'banks id map: $map', tag: tag);
        return map.map<String, String>(
            (key, value) => MapEntry<String, String>(key, value.toString()));
      } on Exception catch (e) {
        MyLogger.error(msg: 'get banks map error!!', error: e, tag: tag);
        return null;
      }
    });
  }

  @override
  Future<Map<String, String>> getProvinces() async {
    return await requestRawString(
      request: dioApiService.post(BankcardApi.POST_PROVINCES),
      allowJsonString: true,
      tag: 'remote-BankProvinces',
    ).then((value) {
      String trimmed = JsonUtil.trimJson(value);
      if (trimmed.isEmpty || trimmed == '[]') return null;
      Map<String, dynamic> map = jsonDecode(trimmed);
//      MyLogger.print(msg: 'provinces map: $map', tag: tag);
      return map.map<String, String>(
          (key, value) => MapEntry<String, String>(key, value.toString()));
    });
  }

  @override
  Future<Map<String, String>> getMapByCode(String code) async {
    return await requestRawString(
      request: dioApiService.post(BankcardApi.POST_CITY, data: {"code": code}),
      allowJsonString: true,
      tag: 'remote-BankArea',
    ).then((value) {
      String trimmed = JsonUtil.trimJson(value);
      if (trimmed.isEmpty || trimmed == '[]') return null;
      Map<String, dynamic> map = jsonDecode(trimmed);
//        MyLogger.print(msg: 'requested map: $code', tag: tag);
      return map.map<String, String>(
          (key, value) => MapEntry<String, String>(key, value.toString()));
    });
  }

  @override
  Future<RequestStatusModel> postBankcard(BankcardForm form) {
    return requestData<RequestStatusModel>(
      request:
          dioApiService.post(BankcardApi.POST_NEW_CARD, data: form.toJson()),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-BankNewCard',
    );
  }
}
