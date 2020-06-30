import 'dart:convert';

import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';

import '../form/center_password_form.dart';
import '../models/center_model.dart';
import '../../../../../core/network/handler/request_code_model.dart';
import '../source/center_data_source.dart';

abstract class CenterRepository {
  Future<Either<Failure, CenterModel>> getAccount();
  Future<Either<Failure, List<String>>> getCgpBindUrl();
  Future<Either<Failure, List<String>>> getCpwBindUrl();
  Future<Either<Failure, RequestStatusModel>> postPassword(
      CenterPasswordForm form);
  Future<Either<Failure, RequestStatusModel>> postBirth(String dateOfBirth);
  Future<Either<Failure, RequestStatusModel>> postEmail(String email);
  Future<Either<Failure, RequestStatusModel>> postWechat(String wechatno);
  Future<Either<Failure, RequestStatusModel>> postLucky(List<int> numbers);
  Future<Either<Failure, RequestCodeModel>> postVerifyRequest(String mobile);
  Future<Either<Failure, RequestCodeModel>> postVerify(
      String mobile, String code);
}

class CenterRepositoryImpl implements CenterRepository {
  final tag = 'CenterRepository';
  final CenterRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  CenterRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, CenterModel>> getAccount() async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result =
          await handleResponse<CenterModel>(remoteDataSource.getAccount());
//      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) =>
            (model.accountCode != null) ? Right(model) : Left(Failure.token()),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, List<String>>> getCgpBindUrl() async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result =
          await handleResponse<String>(remoteDataSource.getCgpBindUrl());
      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(_parseWalletBindUrl(data)),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, List<String>>> getCpwBindUrl() async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result =
          await handleResponse<String>(remoteDataSource.getCpwBindUrl());
      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(_parseWalletBindUrl(data)),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  List<String> _parseWalletBindUrl(String jsonStr) {
    if (jsonStr.startsWith('{')) {
//      print('encode: ${jsonEncode(jsonStr)}');
//      print('decode: ${jsonDecode(jsonStr)}');
      Map map = jsonDecode(jsonStr);
      var url = (map.containsKey('url')) ? '${map['url']}' : '';
      var qrcode = (map.containsKey('qrcode')) ? '${map['qrcode']}' : '';
      return [url, qrcode];
    } else {
      return [];
    }
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postPassword(
      CenterPasswordForm form) async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result = await handleResponse<RequestStatusModel>(
          remoteDataSource.postPassword(form));
      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postBirth(
      String dateOfBirth) async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result = await handleResponse<RequestStatusModel>(
          remoteDataSource.postBirth(dateOfBirth));
      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postEmail(String email) async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result = await handleResponse<RequestStatusModel>(
          remoteDataSource.postEmail(email));
      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postWechat(
      String wechatno) async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result = await handleResponse<RequestStatusModel>(
          remoteDataSource.postWechat(wechatno));
      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postLucky(
      List<int> numbers) async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result = await handleResponse<RequestStatusModel>(
          remoteDataSource.postLucky(numbers));
//      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postVerifyRequest(
      String mobile) async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result = await handleResponse<RequestCodeModel>(
          remoteDataSource.postVerifyRequest(mobile));
//      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, RequestCodeModel>> postVerify(
      String mobile, String code) async {
    final connected = await networkInfo.isConnected;
//    print('network connected: $connected');
    if (connected) {
      final result = await handleResponse<RequestCodeModel>(
          remoteDataSource.postVerify(mobile, code));
//      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }
}
