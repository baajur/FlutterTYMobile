import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:meta/meta.dart' show required;

import 'member_jwt_interface.dart';

class MemberApi {
  static const String GET_LIMIT = "api/get_account/creditlimit";
  static const String GET_NEW_MESSAGE_COUNT = 'api/stationCount';
}

abstract class MemberRepository {
  Future<Either<Failure, String>> updateCredit(String account);
  Future<Either<Failure, bool>> checkNewMessage();
}

class MemberRepositoryImpl implements MemberRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'MemberRepository';
  bool jwtChecked = false;

  MemberRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, bool>> checkNewMessage() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(MemberApi.GET_NEW_MESSAGE_COUNT),
      jsonToModel: RequestCodeModel.jsonToRequestCodeModel,
      tag: 'remote-MEMBER',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess == false) return Right(false);
        Map<String, dynamic> data = model.data;
        if (data != null && data.containsKey('count') && data['count'] > 0)
          return Right(true);
        else
          return Right(false);
      },
    );
  }

  @override
  Future<Either<Failure, String>> updateCredit(String account) async {
    final result = await requestRawData(
      request: dioApiService.get(
        MemberApi.GET_LIMIT,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-MEMBER',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          var map = jsonDecode(data);
          if (map.containsKey('creditlimit')) {
            print('decoded limit: ${map['creditlimit']}');
            return Right(map['creditlimit']);
          } else {
            print('decoded: $map');
            return Left(Failure.token());
          }
        } catch (e) {
          print('credit limit error: $e');
          return Left(Failure.server());
        }
      },
    );
  }
}
