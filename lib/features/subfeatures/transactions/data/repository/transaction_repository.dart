import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/data/enum/transaction_date_enum.dart';
import 'package:flutter_ty_mobile/utils/datetime_format.dart';
import 'package:meta/meta.dart' show required;

import '../models/transaction_model.dart';

class TransactionApi {
  static const String POST_RECORD = "api/transferRecord";
}

abstract class TransactionRepository {
  Future<Either<Failure, TransactionModel>> getDataModel(
      int page, TransactionDateSelected dateSelected);
}

class TransactionRepositoryImpl implements TransactionRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'TransactionRepository';
  bool jwtChecked = false;

  TransactionRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, TransactionModel>> getDataModel(
      int page, TransactionDateSelected dateSelected) async {
    DateTime now = DateTime.now();
    String endDate = now.toDateEndString;
    String startDate;
    switch (dateSelected) {
      case TransactionDateSelected.all:
        startDate = DateTime(2011, 1, 1).toDateStartString;
        break;
      case TransactionDateSelected.today:
        startDate = now.toDateStartString;
        break;
      case TransactionDateSelected.yesterday:
        startDate = now.subtract(Duration(days: 1)).toDateStartString;
        break;
      case TransactionDateSelected.month:
        var lastMonth = now.subtract(Duration(days: 30));
        startDate = DateTime(lastMonth.year, lastMonth.month, now.day)
            .toDateStartString;
        break;
    }

    final result = await requestModel<TransactionModel>(
      request: dioApiService.post(
        TransactionApi.POST_RECORD,
        param: {'page': page},
        data: {'dateend': endDate, 'datestart': startDate},
      ),
      jsonToModel: TransactionModel.jsonToTransactionModel,
      tag: 'remote-TRANSACTION',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}
