import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';

import '../source/transfer_data_source.dart';
import '../models/transfer_platform_model.dart';
import '../models/transfer_balance_model.dart';
import '../form/transfer_form.dart';

abstract class TransferRepository {
  Future<Either<Failure, TransferPlatformList>> getPlatform();
  Future<Either<Failure, TransferBalanceModel>> getBalance(String platform);
  Future<Either<Failure, RequestStatusModel>> postTransfer(TransferForm form);
}

class TransferRepositoryImpl implements TransferRepository {
  final tag = 'TransferRepository';
  final TransferRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TransferRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, TransferPlatformList>> getPlatform() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<List<TransferPlatformModel>>(
          remoteDataSource.getPlatform());
      return result.fold(
        (failure) => Left(failure),
        (models) => Right(TransferPlatformList(list: models)),
      );
    }
    return Left(Failure.network());
  }

  @override
  Future<Either<Failure, TransferBalanceModel>> getBalance(
      String platform) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<TransferBalanceModel>(
          remoteDataSource.getBalance(platform));
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Left(Failure.network());
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postTransfer(
      TransferForm form) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<RequestStatusModel>(
          remoteDataSource.postTransfer(form));
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Left(Failure.network());
  }
}
