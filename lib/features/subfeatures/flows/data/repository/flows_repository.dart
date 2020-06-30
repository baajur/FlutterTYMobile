import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:meta/meta.dart' show required;

import '../models/flow_model.dart';

class FlowsApi {
  static const String GET_RECORD = "api/rollback";
}

abstract class FlowsRepository {
  Future<Either<Failure, List<FlowModel>>> getDataModel(int page);
}

class FlowsRepositoryImpl implements FlowsRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'FlowRepository';

  FlowsRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<Either<Failure, List<FlowModel>>> getDataModel(int page) async {
    final result = await requestModelList<FlowModel>(
      request: dioApiService.get(FlowsApi.GET_RECORD),
      jsonToModel: FlowModel.jsonToFlowModel,
      tag: 'remote-FLOW',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }
}
