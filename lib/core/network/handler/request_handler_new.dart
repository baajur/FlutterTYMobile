import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ty_mobile/core/base/task_extension.dart';
import 'package:flutter_ty_mobile/core/error/exceptions.dart';
import 'package:flutter_ty_mobile/core/error/failures.dart';
import 'package:flutter_ty_mobile/core/network/util/network_info.dart';
import 'package:flutter_ty_mobile/injection_container.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

///
/// Catch [ResponseException] and exceptions from dio service as [ServerException].
/// Catch [FormatException] on error data type.
/// Catch other [Exception] caused by the call.
///
Future<dynamic> _exceptionHandler(Function func, String tag) async {
  try {
    return await Future.microtask(func);
  } on ServerException {
    MyLogger.warn(msg: 'Request Failed: Server Exception', tag: tag);
    return Failure.server();
  } on FormatException catch (e, s) {
    MyLogger.wtf(msg: 'Data format error!!', tag: tag, error: e, stackTrace: s);
    throw e;
  } on Exception catch (e, s) {
    MyLogger.error(
        msg: 'Something went wrong!!', tag: tag, error: e, stackTrace: s);
    return Failure.internal(FailureCode());
  }
}

Future _requestDataTest({
  @required Future<Response> request,
  String tag = 'remote-DATA',
}) async {
  // check if network is connected
  final connected = await sl.get<NetworkInfo>()?.isConnected ?? false;
  print('network connected: $connected');
  if (!connected) return Failure.network();
  // request data with exception handler
  final result = await _exceptionHandler(() async {
    final response = await request;
    if (response == null ||
        response.statusCode == null ||
        response.statusCode != 200) throw ResponseException();
    return response.data;
  }, tag);
  MyLogger.debug(msg: 'remote data result: $result', tag: tag);
  return result;
}

Future<Either<Failure, String>> requestRawData({
  @required Future<Response<dynamic>> request,
  bool allowJsonString = false,
  String tag = 'remote-RAW',
}) async {
  return await runTask(_requestDataTest(request: request)).then((result) {
    return result.fold(
      (failure) => Left(failure),
      (data) {
        if (!allowJsonString && (data.startsWith('{') || data.startsWith('[')))
          return Left(Failure.jsonFormat());
        return Right('$data');
      },
    );
  });
}

///
/// call example:
///
///   Future<Either<Failure, DataModel>> getData() async {
///     final result = await requestDataModel<DataModel>(
///        request: dioApiService.get(
///          DataApi.GET_DATA,
///          userToken: jwtInterface.token,
///        ),
///        jsonToModel: DataModel.jsonToDataModel,
///     );
///     print('test response type: ${result.runtimeType}, data: $result');
///     return result.fold(
///       (failure) => Left(failure),
///       (model) => Right(model),
///     );
///  }
///
Future<Either<Failure, T>> requestModel<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) jsonToModel,
  bool trim = true,
  String tag = 'remote-MODEL',
}) async {
  return await runTask(_requestDataTest(request: request)).then((result) {
    return result.fold(
      (failure) => Left(failure),
      (data) => Right(JsonUtil.decodeToModel<T>(data, jsonToModel, trim, tag)),
    );
  });
}

Future<Either<Failure, List<T>>> requestModelList<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) jsonToModel,
  bool trim = true,
  String tag = 'remote-MODEL_LIST',
}) async {
  return await runTask(_requestDataTest(request: request)).then((result) {
    return result.fold(
      (failure) => Left(failure),
      (data) {
        final model = (data.toString().startsWith('['))
            ? JsonUtil.decodeArrayToModel<T>(data, jsonToModel, trim, tag)
            : [JsonUtil.decodeToModel<T>(data, jsonToModel, trim, tag)];
        return Right(model);
      },
    );
  });
}
