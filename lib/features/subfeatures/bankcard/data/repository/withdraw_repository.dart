import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/data/models/rollback_model.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';

import '../form/withdraw_form.dart';
import '../models/withdraw_model.dart';

class WithdrawApi {
  static const String GET_CGP = "api/getCgpWallet";
  static const String GET_CPW = "api/getCpwWallet";
  static const String GET_ROLLBACK = "api/rollback";
  static const String POST_WITHDRAW = "api/withdrawal";
}

abstract class WithdrawRepository {
  Future<Either<Failure, String>> getCgpWallet();
  Future<Either<Failure, String>> getCpwWallet();
  Future<Either<Failure, String>> getRollback();
  Future<Either<Failure, WithdrawModel>> postWithdraw(WithdrawForm form);
}

class WithdrawRepositoryImpl implements WithdrawRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'WithdrawRepository';
  bool jwtChecked = false;

  WithdrawRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, String>> getCgpWallet() async {
    final result = await requestRawData(
      request: dioApiService.get(
        WithdrawApi.GET_CGP,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-CGP',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  @override
  Future<Either<Failure, String>> getCpwWallet() async {
    final result = await requestRawData(
      request: dioApiService.get(
        WithdrawApi.GET_CPW,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-CPW',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }

  @override
  Future<Either<Failure, WithdrawModel>> postWithdraw(WithdrawForm form) async {
    final result = await requestModel<WithdrawModel>(
      request: dioApiService.post(
        WithdrawApi.POST_WITHDRAW,
        data: form.toJson(),
        userToken: jwtInterface.token,
      ),
      jsonToModel: WithdrawModel.jsonToWithdrawModel,
      tag: 'remote-WITHDRAW',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, String>> getRollback() async {
    final result = await requestData(
      request: dioApiService.get(
        WithdrawApi.GET_ROLLBACK,
        userToken: jwtInterface.token,
      ),
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        print('rollback data type: ${data.runtimeType}');
        if ('$data'.isEmpty) return Right('0');

        List<RollbackModel> models;
        if (data is Map)
          models = JsonUtil.decodeMapToModelList(
            data,
            (jsonMap) => RollbackModel.jsonToRollbackModel(jsonMap),
          );
        else if (data is String)
          models = JsonUtil.decodeMapToModelList(
            jsonDecode(data),
            (jsonMap) => RollbackModel.jsonToRollbackModel(jsonMap),
          );

        if (models != null && models.isNotEmpty) {
          print('rollback model: $models');
          int totalRollover = 0;
          models.forEach((element) {
            totalRollover += element.rollover;
          });
          return Right('$totalRollover');
        }
        return Right('0');
      },
    );
  }
}
