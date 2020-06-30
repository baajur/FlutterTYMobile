import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData;
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/features/general/data/user/user_token_storage.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/features/user/data/repository/user_repository.dart'
    show UserApi;
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:meta/meta.dart' show required;

abstract class MemberJwtInterface {
  String account;
  String token;

  /// Calls the service [UserApi.JWT_CHECK] endpoint to verify [token].
  Future<RequestStatusModel> checkJwt(
    String href, {
    String loginAccount,
    String loginToken,
  });
  Future<void> clearToken();
}

class MemberJwtInterfaceImpl implements MemberJwtInterface {
  final DioApiService dioApiService;
  final tag = 'MemberJwtInterface';

  MemberJwtInterfaceImpl({@required this.dioApiService});

  ///
  /// Check token to confirm user action is valid
  ///
  Future<bool> _readToken() async {
    if (getRouteUserStreams.hasUser == false) {
      MyLogger.debug(msg: 'no user, cannot read token');
      return false;
    }
    String currentAccount = getRouteUserStreams.lastUser.currentUser.account;
    if (token.isEmpty) {
      account = currentAccount;
      token = await Future.value(UserTokenStorage.load(account))
          .then((value) => value.cookie.value);
      print('member jwt token: $token');
    }
    return true;
  }

  @override
  Future<RequestStatusModel> checkJwt(
    String href, {
    String loginAccount,
    String loginToken,
  }) async {
    if (loginAccount != null && loginToken != null) {
      account = loginAccount;
      token = loginToken;
      return requestData<RequestStatusModel>(
        request: dioApiService.post(UserApi.JWT_CHECK,
            userToken: loginToken, data: {"href": href}),
        jsonToModel: RequestStatusModel.jsonToStatusModel,
        tag: 'remote-JWT',
      );
    } else {
      return await _readToken().then((canContinue) {
        if (canContinue)
          return requestData<RequestStatusModel>(
            request: dioApiService.post(UserApi.JWT_CHECK,
                userToken: token, data: {"href": href}),
            jsonToModel: RequestStatusModel.jsonToStatusModel,
            tag: 'remote-JWT',
          );
        else
          return RequestStatusModel(status: 'failed', msg: 'no user');
      });
    }
  }

  @override
  Future<void> clearToken() => Future.sync(() {
        token = '';
        MyLogger.info(msg: 'jwt token cleared', tag: 'MemberJwtInterface');
      });

  @override
  String token = '';

  @override
  String account = '';
}
