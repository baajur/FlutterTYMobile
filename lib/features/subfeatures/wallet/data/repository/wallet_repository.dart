import 'dart:async';

import 'package:flutter_ty_mobile/core/repository_export.dart';

import '../source/wallet_data_source.dart';
import '../models/wallet_model.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletModel>> getWallet();
  Future<Either<Failure, String>> postWalletType(bool toSingle);
  Future<Either<Failure, Map<String, dynamic>>> postTransferAll(
      StreamController<String> progressController);
}

class WalletRepositoryImpl implements WalletRepository {
  final tag = 'WalletRepository';
  final WalletRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WalletRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, WalletModel>> getWallet() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result =
          await handleResponse<WalletModel>(remoteDataSource.getWallet());
//      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (model) => (model.auto != '-1') ? Right(model) : Left(Failure.token()),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, String>> postWalletType(bool toSingle) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<String>(
          remoteDataSource.postWalletType(toSingle));
//      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (result) => Right(result),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> postTransferAll(
      StreamController<String> progressController) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<Map<String, dynamic>>(
          remoteDataSource.postTransferAll(progressController));
//      print('test response type: ${result.runtimeType}');
      return result.fold(
        (failure) => Left(failure),
        (map) => Right(map),
      );
    }
    return Future.value(Left(Failure.network()));
  }
}
