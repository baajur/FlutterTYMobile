import 'dart:async';
import 'dart:convert';

import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData, requestRawString;
import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

import '../models/wallet_model.dart';

class WalletApi {
  static const String POST_WALLET = "api/walletbalance";
  static const String POST_CHANGE = "api/changewallet";
  static const String GET_PROMISE = "api/allBlancePromise";
  static const String POST_TRANSFER = "api/balancetomain";

  static const String JWT_CHECK_HREF = "/no_transfer_wallet";
  static const String WALLET_OPTION_SINGLE = "WlraLb1";
  static const String WALLET_OPTION_MULTI = "WlraLb0";
}

abstract class WalletRemoteDataSource {
  Future<WalletModel> getWallet();
  Future<String> postWalletType(bool toSingle);
  Future<Map<String, dynamic>> postTransferAll(
      StreamController<String> progressController);
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'WalletRemoteDataSource';
  bool jwtChecked = false;

  WalletRemoteDataSourceImpl(
      {@required this.dioApiService, @required this.jwtInterface});

  @override
  Future<WalletModel> getWallet() async {
    if (!jwtChecked) {
      await jwtInterface
          .checkJwt(WalletApi.JWT_CHECK_HREF)
          .then((value) => jwtChecked = value.isSuccess);
    }
    if (jwtChecked) {
      return requestData<WalletModel>(
        request: dioApiService.post(
          WalletApi.POST_WALLET,
          data: {'accountcode': jwtInterface.account},
          userToken: jwtInterface.token,
        ),
        jsonToModel: WalletModel.jsonToWalletModel,
        tag: 'remote-WALLET',
      );
    } else {
      MyLogger.warn(msg: 'user token is not valid', tag: tag);
      return Future.value(WalletModel(auto: '-1'));
    }
  }

  @override
  Future<String> postWalletType(bool toSingle) {
    return requestRawString(
      request: dioApiService.post(WalletApi.POST_CHANGE,
          data: {
            'accountcode': jwtInterface.account,
            'status': (toSingle)
                ? WalletApi.WALLET_OPTION_SINGLE
                : WalletApi.WALLET_OPTION_MULTI
          },
          userToken: jwtInterface.token),
      tag: 'remote-WALLET_CHANGE',
    );
  }

  Future<List> _getPromiseList() async {
    return await requestRawString(
      request: dioApiService.get(
        WalletApi.GET_PROMISE,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-WALLET_PROMISE',
    ).then((value) {
      if (value.isNotEmpty) {
        try {
          String trimmed = JsonUtil.trimJson(value);
//          MyLogger.print(msg: 'trimmed: $trimmed', tag: tag);
          // decode list in json format to string list
          List decoded = jsonDecode(trimmed);
          MyLogger.print(msg: 'decoded list: $decoded', tag: tag);
          return decoded;
        } on Exception catch (e) {
          MyLogger.error(msg: 'bankcard map error!!', error: e, tag: tag);
        }
      }
      return new List();
    });
  }

  @override
  Future<Map<String, dynamic>> postTransferAll(
      StreamController<String> progressController) async {
    List platforms = await _getPromiseList();
    if (platforms != null && platforms.isNotEmpty) {
//      List testList = platforms.take(5).toList();
//      print('test wallet transfer: $testList');
      return await Future.microtask(
        () => dioApiService.postList(
          WalletApi.POST_TRANSFER,
          dataList: List.generate(
            platforms.length,
            (index) => {
              'accountcode': jwtInterface.account,
              'plat': platforms[index],
            },
          ),
          keyList: platforms,
          stream: progressController,
          userToken: jwtInterface.token,
        ),
      );
    }
    return null;
  }
}
