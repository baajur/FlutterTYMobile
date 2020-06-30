import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestRawString;
import 'package:flutter_ty_mobile/features/general/data/user/user_token_storage.dart';
import 'package:meta/meta.dart' show required;

class MemberApi {
  static const String GET_LIMIT = "api/get_account/creditlimit";
}

abstract class MemberRemoteDataSource {
  Future<String> updateCredit(String account);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final DioApiService dioApiService;
  final tag = 'MemberRemoteDataSource';
  String token = '';

  MemberRemoteDataSourceImpl({@required this.dioApiService});

  Future<void> _checkToken(String account) async {
    if (token.isEmpty) {
      token = await Future.value(UserTokenStorage.load(account))
          .then((value) => value.cookie.value);
      print('test member source token: $token');
    }
  }

  @override
  Future<String> updateCredit(String account) async {
    return await _checkToken(account).then((_) {
      return requestRawString(
        request: dioApiService.get(MemberApi.GET_LIMIT, userToken: token),
        allowJsonString: true,
        tag: 'remote-MEMBER',
      );
    });
  }
}
