import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestRawString;
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:meta/meta.dart' show required;

class MemberApi {
  static const String GET_LIMIT = "api/get_account/creditlimit";
}

abstract class MemberRemoteDataSource {
  Future<String> updateCredit(String account);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'MemberRemoteDataSource';

  MemberRemoteDataSourceImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<String> updateCredit(String account) async {
    return requestRawString(
      request:
          dioApiService.get(MemberApi.GET_LIMIT, userToken: jwtInterface.token),
      allowJsonString: true,
      tag: 'remote-MEMBER',
    );
  }
}
