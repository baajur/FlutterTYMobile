import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/repository/member_jwt_interface.dart';

import '../form/deposit_form.dart';
import '../model/deposit_result.dart';
import '../model/payment_promo.dart';
import '../model/payment_raw.dart';

class DepositApi {
  static const String GET_PAYMENT = "api/getPayment";
  static const String GET_PAYMENT_PROMO = "api/getPromo";
  static const String POST_DEPOSIT = "api/deposit";
  static const String JWT_CHECK_HREF = "/deposit";
}

abstract class DepositRepository {
  Future<Either<Failure, PaymentRaw>> getPayment();
  Future<Either<Failure, PaymentPromoTypeJson>> getPaymentPromo();
  Future<Either<Failure, DepositResult>> postDeposit(DepositDataForm form);
}

class DepositRepositoryImpl implements DepositRepository {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'DepositRepository';
  bool jwtChecked = false;

  DepositRepositoryImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<Either<Failure, PaymentRaw>> getPayment() async {
    final result = await requestModel<PaymentRaw>(
      request: dioApiService.get(
        DepositApi.GET_PAYMENT,
        userToken: jwtInterface.token,
      ),
      jsonToModel: PaymentRaw.jsonToPaymentRaw,
      tag: 'remote-DEPOSIT',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, PaymentPromoTypeJson>> getPaymentPromo() async {
    final result = await requestModel<PaymentPromoTypeJson>(
      request: dioApiService.get(
        DepositApi.GET_PAYMENT_PROMO,
        userToken: jwtInterface.token,
      ),
      jsonToModel: PaymentPromo.jsonToPaymentPromo,
      tag: 'remote-DEPOSIT',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }

  @override
  Future<Either<Failure, DepositResult>> postDeposit(
      DepositDataForm form) async {
    final result = await requestModel<DepositResult>(
      request: dioApiService.post(
        DepositApi.POST_DEPOSIT,
        userToken: jwtInterface.token,
        data: form.toJson(),
      ),
      jsonToModel: DepositResult.jsonToDepositResult,
      tag: 'remote-DEPOSIT',
    );
    print('test response type: ${result.runtimeType}, data: $result');
    return result.fold(
      (failure) => Left(failure),
      (model) => Right(model),
    );
  }
}
