import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData;
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/features/general/data/user/user_token_storage.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/features/users/data/source/user_api.dart';
import 'package:meta/meta.dart' show required;

abstract class MemberJwtInterface {
  String account;
  String token;

  /// Calls the service [UserApi.JWT_CHECK] endpoint to verify [token].
  Future<RequestStatusModel> checkJwt(String href);
}

class MemberJwtInterfaceImpl implements MemberJwtInterface {
  final DioApiService dioApiService;
  final tag = 'MemberJwtInterface';

  MemberJwtInterfaceImpl({@required this.dioApiService});

  ///
  /// Check token to confirm user action is valid
  ///
  Future<void> _checkToken() async {
    String currentAccount = getRouteUserStreams.lastUser.currentUser.account;
    if (token.isEmpty || currentAccount != account) {
      account = currentAccount;
      token = await Future.value(UserTokenStorage.load(account))
          .then((value) => value.cookie.value);
      print('member jwt token: $token');
    }
  }

  @override
  Future<RequestStatusModel> checkJwt(String href) async {
    return await _checkToken().then((_) {
      return requestData<RequestStatusModel>(
        request: dioApiService
            .post(UserApi.JWT_CHECK, userToken: token, data: {"href": href}),
        jsonToModel: RequestStatusModel.jsonToStatusModel,
        tag: 'remote-JWT',
      );
    });
  }

  @override
  String token = '';

  @override
  String account = '';
}
