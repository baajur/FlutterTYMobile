import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_ty_mobile/core/error/exceptions.dart';
import 'package:flutter_ty_mobile/core/error/failures.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

import 'request_status_freezed.dart';

/// This function should be used inside Repository class.
/// Wrapped remote data request in try-catch to generalize the data source action.
///
/// Takes in a data source's [future] method and wait for the data or throw failure if action has exception.
/// Catch [ServerException] if network request failed.
/// Catch [LocationException] if network request had been redirected to other .
/// Catch [MapJsonDataException] if json decode failed.
/// Catch [LoginException] if login failed or token check failed.
///
Future<Either<Failure, T>> handleResponse<T>(Future future) async {
  try {
    final data = await future;
    return Right(data);
  } on ServerException {
    // throw from dio_api_service.dart
    return Left(Failure.server());
  } on LocationException {
    // while decoding json and json data shown as html
    return Left(Failure.networkLocation());
  } on MapJsonDataException {
    // while decode json into data model has error
    return Left(Failure.jsonFormat());
  } on LoginException catch (ex) {
    // request user token has failed, then pass on the failed message
    return Left(Failure.login(ex.data));
  } on Exception {
    return Left(Failure.internal(FailureCode()));
  }
}

///
/// Throws [JsonFormatException] if [JsonUtil] cannot decode the json data.
/// Throws [MapJsonDataException] if the decoded json cannot be mapped into model entity.
/// Throws [FormatException] if [jsonToModel] returns data different then [T].
///
Future<dynamic> _requestHandler(Function func, String tag) async {
  try {
    return await Future.microtask(func);
  } on ServerException catch (e) {
    MyLogger.warn(msg: 'Request Failed: Server Exception', tag: tag, error: e);
    throw ServerException();
  } on LocationException {
    MyLogger.warn(msg: 'Network Location Exception', tag: tag);
    throw LocationException();
  } on JsonFormatException catch (e) {
    MyLogger.error(msg: 'Json Decode Failed!!', tag: tag, error: e);
    throw e;
  } on FormatException catch (e, s) {
    MyLogger.wtf(msg: 'Data format error!!', tag: tag, error: e, stackTrace: s);
    throw e;
  } on Exception catch (e, s) {
    MyLogger.error(
        msg: 'Something went wrong!!', tag: tag, error: e, stackTrace: s);
    throw e;
  }
}

/// This function should be used inside Data Source class.
/// Wrapped api request in [_requestHandler] to generalize the request action.
///
/// Takes in a [request] and wait for the response or throw failure if request failed.
/// Throws [ResponseException] if response code is not 200 which will be catch as [ServerException].
///
/// Takes in a [jsonToModel] function to transform the response json to a list of model [T].
///
Future<List<T>> requestList<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) jsonToModel,
  String tag = 'remote-List',
}) async {
  final result = await _requestHandler(() async {
    final response = await request;
    if (response == null ||
        response.statusCode == null ||
        response.statusCode != 200) throw ResponseException();
    if (response.data.toString().startsWith('['))
      return JsonUtil.decodeArrayToModel<T>(
        response.data,
        jsonToModel,
        tag: tag,
      );
    else {
      return [
        JsonUtil.decodeToModel<T>(
          response.data,
          jsonToModel,
          tag: tag,
        )
      ];
    }
  }, tag);
  MyLogger.debug(msg: 'remote list type: ${result.runtimeType}', tag: tag);
  return result;
}

///
/// Takes in a [request] and wait for the response or throw failure if request failed.
/// Throws [ResponseException] if response code is not 200 which will be catch as [ServerException].
/// Throws [MapJsonDataException] if the response json is array.
///
/// Takes in a [jsonToModel] function to transform the response json to model [T].
///
Future<T> requestData<T>({
  @required Future<Response<dynamic>> request,
  @required Function(Map<String, dynamic> jsonMap) jsonToModel,
  String tag = 'remote-Data',
}) async {
  final result = await _requestHandler(() async {
    final response = await request;
    if (response == null ||
        response.statusCode == null ||
        response.statusCode != 200) throw ResponseException();
    if (response.data.toString().startsWith('['))
      throw MapJsonDataException();
    else {
      return JsonUtil.decodeToModel<T>(
        response.data,
        jsonToModel,
        tag: tag,
      );
    }
  }, tag);
  MyLogger.debug(msg: 'remote data type: ${result.runtimeType}', tag: tag);
  return result;
}

///
/// Takes in a [request] and wait for the response or throw failure if request failed.
/// Throws [ResponseException] if response code is not 200 which will be catch as [ServerException].
///
/// Specified [header] to filter out desired data from response headers.
///
Future<DataRequestResult> requestResponseHeader({
  @required Future<Response<dynamic>> request,
  @required String header,
  String tag = 'remote-Header',
}) async {
  final result = await _requestHandler(() async {
    final response = await request;
    if (response == null ||
        response.statusCode == null ||
        response.statusCode != 200) throw ResponseException();
    var headerRequested = response.headers.value(header);
    if (headerRequested == null) {
      // request failed
      var model = JsonUtil.decodeToModel(
        response.data,
        RequestStatusModel.jsonToStatusModel,
        tag: tag,
      );
//      print('test failed model: $model');
      return DataRequestResult(failedData: model);
    } else {
      // request success
//      print('test header cookie: $headerRequested');
      return DataRequestResult(data: headerRequested);
    }
  }, tag);
//  MyLogger.debug(msg: 'remote header request result: $result', tag: tag);
  return result;
}

///
/// Takes in a [request] and wait for the response or throw failure if request failed.
/// Throws [ResponseException] if response code is not 200 which will be catch as [ServerException].
/// Throws [MapJsonDataException] if the response json is array.
///
Future<String> requestRawString({
  @required Future<Response<dynamic>> request,
  bool allowJsonString = false,
  String tag = 'remote-Raw',
}) async {
  final result = await _requestHandler(() async {
    final response = await request;
    if (response == null ||
        response.statusCode == null ||
        response.statusCode != 200) throw ResponseException();
    var responseData = response.data.toString();
    if (!allowJsonString &&
        (responseData.startsWith('{') || responseData.startsWith('[')))
      throw MapJsonDataException();
    else
      return responseData;
  }, tag);
  MyLogger.debug(msg: 'remote data type: ${result.runtimeType}', tag: tag);
  return result;
}
