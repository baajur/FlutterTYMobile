import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';

import '../entity/roller_data_entity.dart';
import '../models/roller_order_model.dart';
import '../models/roller_record_model.dart';
import '../models/roller_requirement_model.dart';
import '../models/roller_prize_model.dart';

class RollerApi {
  static const String GET_COUNT = "api/getCount";
  static const String GET_PRIZE = "api/getPrize";
  static const String GET_RULE = "api/getTurntableRule";
  static const String GET_ORDER = "api/getTurntableOrder";
  static const String GET_RECORD = "api/getTurntableRecord";
  static const String POST_REQUIREMENT = "api/applyRequirement";
  static const String GET_WHEEL_PRIZE = "api/startTurntable";
}

abstract class RollerRepository {
  Future<Either<Failure, int>> getCount();
  Future<Either<Failure, RollerDataEntity>> getRollerData();
  Future<Either<Failure, int>> getWheelPrize();
  Future<Either<Failure, List<RollerOrderModel>>> getOrder();
  Future<Either<Failure, List<RollerRecordModel>>> getRecord();
  Future<Either<Failure, RollerRequirementModel>> getRequirement();
}

class RollerRepositoryImpl implements RollerRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'RollerRepository';
  bool jwtChecked = false;

  RollerRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    if (jwtInterface.account.isNotEmpty)
      Future.value(jwtInterface.checkJwt('/'))
          .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, int>> getCount() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(RollerApi.GET_COUNT),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-ROLLER',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => (model.isSuccess) ? Right('${model.data}'.strToInt) : Right(0),
    );
  }

  Future<Either<Failure, String>> _getRollerRule() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(RollerApi.GET_RULE),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      trim: false,
      tag: 'remote-ROLLER',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => (model.isSuccess) ? Right(model.data) : Left(Failure.server()),
    );
  }

  Future<Either<Failure, List<RollerPrizeModel>>> _getRollerPrize() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(RollerApi.GET_PRIZE),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      trim: false,
      tag: 'remote-ROLLER',
    );
//    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold((failure) => Left(failure), (model) {
      if (model.isSuccess == false)
        return Left(Failure.server());
      else {
        try {
          return Right(JsonUtil.decodeMapToModelList(
            model.data,
            (jsonMap) => RollerPrizeModel.jsonToRollerPrizeModel(jsonMap),
            addKey: false,
          ));
        } on Exception {
          return Left(Failure.jsonFormat());
        }
      }
    });
  }

  @override
  Future<Either<Failure, RollerDataEntity>> getRollerData() async {
    final data = await Future.wait([
      _getRollerRule(),
      _getRollerPrize(),
    ]).catchError((e) =>
        Left(Failure.internal(FailureCode(code: FailureType.REPO.value))));
//    print('roller future data list: $data');
    Either either =
        data.singleWhere((element) => element.isLeft(), orElse: () => null);
    if (either != null) return either;
    try {
      // '<p>&nbsp;</p>' equals two '<br />' in flutter HTML widget
      final rule = data[0].fold(
        (_) => '',
        (data) => '$data'.replaceAll('<p>&nbsp;<\/p>', '<br />'),
      );
      final prizes = data[1].fold(
        (_) => [],
        (list) => list,
      );
      return Right(RollerDataEntity(
        rule: rule,
        prizes: (prizes is List &&
                prizes.every((element) => element is RollerPrizeModel))
            ? prizes.cast<RollerPrizeModel>()
            : [],
      ));
    } on Exception {
      return Left(Failure.internal(FailureCode(code: FailureType.REPO.value)));
    }
  }

  @override
  Future<Either<Failure, int>> getWheelPrize() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(RollerApi.GET_WHEEL_PRIZE),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      tag: 'remote-ROLLER',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => (model.isSuccess) ? Right('${model.data}'.strToInt) : Right(0),
    );
  }

  @override
  Future<Either<Failure, List<RollerOrderModel>>> getOrder() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(RollerApi.GET_ORDER),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      trim: false,
      tag: 'remote-ROLLER',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess == false) return Left(Failure.server());
        try {
          return Right(JsonUtil.decodeArrayToModel(
            model.data,
            (jsonMap) => RollerOrderModel.jsonToOrderModel(jsonMap),
          ));
        } on Exception {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }

  @override
  Future<Either<Failure, List<RollerRecordModel>>> getRecord() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(RollerApi.GET_RECORD),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      trim: false,
      tag: 'remote-ROLLER',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess == false) return Left(Failure.server());
        try {
          return Right(JsonUtil.decodeArrayToModel(
            model.data,
            (jsonMap) => RollerRecordModel.jsonToRecordModel(jsonMap),
          ));
        } on Exception {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }

  @override
  Future<Either<Failure, RollerRequirementModel>> getRequirement() async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.post(RollerApi.POST_REQUIREMENT),
      jsonToModel: RequestCodeModel.jsonToCodeModel,
      trim: false,
      tag: 'remote-ROLLER',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) {
        if (model.isSuccess == false) return Left(Failure.server());
        try {
          return Right(
              RollerRequirementModel.jsonToRequirementModel(model.data));
        } on Exception {
          return Left(Failure.jsonFormat());
        }
      },
    );
  }
}
