import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_code_model.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:meta/meta.dart' show required;

import '../models/message_model.dart';

class MessageApi {
  static const String GET_STATION = "api/station";
  static const String GET_READ_STATUS = "api/stationCheck";
}

abstract class MessageRepository {
  Future<Either<Failure, List<MessageModel>>> getMessageList();
  Future<Either<Failure, RequestCodeModel>> updateMessageStatus(int id);
}

class MessageRepositoryImpl implements MessageRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'MessageRepository';
  bool jwtChecked = false;

  MessageRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, List<MessageModel>>> getMessageList() async {
    final result = await requestModelList<MessageModel>(
      request: dioApiService.get(MessageApi.GET_STATION),
      jsonToModel: MessageModel.jsonToMessageModel,
      trim: false,
      tag: 'remote-MESSAGE',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (list) => Right(list),
    );
  }

  @override
  Future<Either<Failure, RequestCodeModel>> updateMessageStatus(int id) async {
    final result = await requestModel<RequestCodeModel>(
      request: dioApiService.get(MessageApi.GET_READ_STATUS, data: {'rid': id}),
      jsonToModel: RequestCodeModel.jsonToRequestCodeModel,
      tag: 'remote-MESSAGE_STATUS',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(data),
    );
  }
}
