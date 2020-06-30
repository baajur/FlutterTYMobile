import 'dart:convert' show jsonDecode;

import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/features/subfeatures/betrecord/data/form/bet_record_form.dart';
import 'package:flutter_ty_mobile/features/subfeatures/betrecord/data/models/bet_record_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/betrecord/data/models/bet_record_type_model.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

class BetRecordApi {
  static const String GET_CATEGORY = "api/category";
  static const String GET_PLATFORM = "api/platformType";
  static const String GET_RECORD = "api/getRecord/";
}

abstract class BetRecordRepository {
  Future<Either<Failure, List<BetRecordTypeModel>>> getTypeData();
  Future<Either<Failure, BetRecordModel>> getRecord(BetRecordForm form);
  Future<Either<Failure, List<BetRecordDataAllPlatform>>> getRecordAll(
      BetRecordForm form);
}

class BetRecordRepositoryImpl implements BetRecordRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'BetRecordRepository';

  BetRecordRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, List<BetRecordTypeModel>>> getTypeData() async {
    final result = await requestModelList<BetRecordTypeModel>(
      request: dioApiService.get(
        BetRecordApi.GET_CATEGORY,
        userToken: jwtInterface.token,
      ),
      jsonToModel: BetRecordTypeModel.jsonToBetRecordTypeModel,
      tag: 'remote-BET_TYPE',
    );
    if (result.isLeft()) return result;
    var modelList = result.getOrElse(() => []);
    if (modelList.isEmpty) return Left(Failure.internal(FailureCode()));

    final result2 = await requestRawData(
      request: dioApiService.get(
        BetRecordApi.GET_PLATFORM,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-BET_TYPE_2',
    );
    return result2.fold(
      (failure) => Left(failure),
      (data) {
        var map = jsonDecode(data);
        List<BetRecordTypeModel> resultList = new List();
        modelList.forEach((model) {
          resultList.add(
              model.copyWith(platformMap: map[model.categoryId.toString()]));
        });
        print('final model list: $resultList');
        return Right(resultList);
      },
    );
  }

  @override
  Future<Either<Failure, BetRecordModel>> getRecord(BetRecordForm form) async {
    final result = await requestModel<BetRecordModel>(
      request: dioApiService.get(
        '${BetRecordApi.GET_RECORD}${form.categoryId}',
        userToken: jwtInterface.token,
        data: form.toJson,
      ),
      jsonToModel: BetRecordModel.jsonToBetRecordModel,
      tag: 'remote-RECORD',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, List<BetRecordDataAllPlatform>>> getRecordAll(
    BetRecordForm form,
  ) async {
    final result = await requestRawData(
      request: dioApiService.get(
        '${BetRecordApi.GET_RECORD}${form.categoryId}',
        userToken: jwtInterface.token,
        data: form.toJson,
      ),
      allowJsonString: true,
      tag: 'remote-RECORD_ALL',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) {
        try {
          var map = jsonDecode(data);
          List<BetRecordDataAllPlatform> list = JsonUtil.decodeMapToModelList(
            map['data'],
            (jsonMap) =>
                BetRecordDataAllPlatform.jsonToBetRecordDataAllPlatform(
                    jsonMap),
          );
          print('bet platform length: ${list.length}');
          return Right(list);
        } on Exception {
          MyLogger.error(
              msg: 'error on decode map data to model list: $data', tag: tag);
          return Left(Failure.jsonFormat());
        }
      },
    );
  }
}
