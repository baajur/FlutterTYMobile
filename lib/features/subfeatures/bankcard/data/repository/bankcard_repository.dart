import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/data/form/bankcard_form.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/data/models/bankcard_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/data/source/bankcard_data_source.dart';

abstract class BankcardRepository {
  Future<Either<Failure, BankcardModel>> getBankcard();
  Future<Either<Failure, Map<String, String>>> getBanks();
  Future<Either<Failure, Map<String, String>>> getProvinces();
  Future<Either<Failure, Map<String, String>>> getMapByCode(String code);

  Future<Either<Failure, RequestStatusModel>> postBankcard(BankcardForm form);
}

class BankcardRepositoryImpl implements BankcardRepository {
  final tag = 'BankcardRepository';
  final BankcardRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  BankcardRepositoryImpl({
    @required this.remoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, BankcardModel>> getBankcard() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result =
          await handleResponse<BankcardModel>(remoteDataSource.getBankcard());
      return result.fold(
        (failure) => Left(failure),
        (model) =>
            (model.hasCard != null) ? Right(model) : Left(Failure.token()),
      );
    }
    return Left(Failure.network());
  }

  @override
  Future<Either<Failure, Map<String, String>>> getBanks() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<Map<String, String>>(
          remoteDataSource.getBanks());
      return result.fold(
        (failure) => Left(failure),
        (model) => (model != null) ? Right(model) : Left(Failure.jsonFormat()),
      );
    }
    return Left(Failure.network());
  }

  @override
  Future<Either<Failure, Map<String, String>>> getProvinces() async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<Map<String, String>>(
          remoteDataSource.getProvinces());
      return result.fold(
        (failure) => Left(failure),
        (model) => (model != null)
            ? Right(model)
            : Left(Failure.internal(
                FailureCode(typeCode: FailureTypeCode.BANKCARD))),
      );
    }
    return Left(Failure.network());
  }

  @override
  Future<Either<Failure, Map<String, String>>> getMapByCode(String code) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<Map<String, String>>(
          remoteDataSource.getMapByCode(code));
      return result.fold(
        (failure) => Left(failure),
        (model) => (model != null)
            ? Right(model)
            : Left(Failure.internal(
                FailureCode(typeCode: FailureTypeCode.BANKCARD))),
      );
    }
    return Left(Failure.network());
  }

  @override
  Future<Either<Failure, RequestStatusModel>> postBankcard(
      BankcardForm form) async {
    final connected = await networkInfo.isConnected;
    if (connected) {
      final result = await handleResponse<RequestStatusModel>(
          remoteDataSource.postBankcard(form));
      return result.fold(
        (failure) => Left(failure),
        (model) => Right(model),
      );
    }
    return Left(Failure.network());
  }
}
