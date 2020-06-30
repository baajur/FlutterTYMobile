import 'package:flutter_ty_mobile/core/repository_export.dart';

import '../source/withdraw_data_source.dart';
import '../models/withdraw_model.dart';
import '../form/withdraw_form.dart';

abstract class WithdrawRepository {
  Future<Either<Failure, String>> getCgpWallet();
  Future<Either<Failure, String>> getCpwWallet();
  Future<Either<Failure, String>> getRollback();
  Future<Either<Failure, WithdrawModel>> postWithdraw(WithdrawForm form);
}

class WithdrawRepositoryImpl implements WithdrawRepository {
  final tag = 'WithdrawRepository';
  final WithdrawRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  WithdrawRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, String>> getCgpWallet() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result =
          await handleResponse<String>(remoteDataSource.getCgpWallet());
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, String>> getCpwWallet() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result =
          await handleResponse<String>(remoteDataSource.getCpwWallet());
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, WithdrawModel>> postWithdraw(WithdrawForm form) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<WithdrawModel>(
          remoteDataSource.postWithdraw(form));
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Future.value(Left(Failure.network()));
  }

  @override
  Future<Either<Failure, String>> getRollback() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result =
          await handleResponse<String>(remoteDataSource.getRollback());
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    }
    return Future.value(Left(Failure.network()));
  }
}
