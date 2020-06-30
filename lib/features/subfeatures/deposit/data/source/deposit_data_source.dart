import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData;
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:meta/meta.dart' show required;

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

abstract class DepositRemoteDataSource {
  /// Calls the service [DepositApi.GET_PAYMENT] endpoint to get [PaymentRaw].
  Future<PaymentRaw> getPayment();

  /// Calls the service [DepositApi.GET_PAYMENT_PROMO] endpoint to get [PaymentPromoTypeJson].
  Future<PaymentPromoTypeJson> getPaymentPromo();

  Future<DepositResult> postDeposit(DepositDataForm form);
}

class DepositRemoteDataSourceImpl implements DepositRemoteDataSource {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'DepositRemoteDataSource';

  DepositRemoteDataSourceImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt(DepositApi.JWT_CHECK_HREF));
  }

  @override
  Future<PaymentRaw> getPayment() async {
    return requestData<PaymentRaw>(
      request: dioApiService.get(DepositApi.GET_PAYMENT,
          userToken: jwtInterface.token),
      jsonToModel: PaymentRaw.jsonToPaymentRaw,
      tag: 'remote-DEPOSIT',
    );
  }

  @override
  Future<PaymentPromoTypeJson> getPaymentPromo() {
    return requestData<PaymentPromoTypeJson>(
      request: dioApiService.get(DepositApi.GET_PAYMENT_PROMO),
      jsonToModel: PaymentPromo.jsonToPaymentPromo,
      tag: 'remote-DEPOSIT',
    );
  }

  @override
  Future<DepositResult> postDeposit(DepositDataForm form) {
    return requestData<DepositResult>(
      request: dioApiService.post(DepositApi.POST_DEPOSIT, data: form.toJson()),
      jsonToModel: DepositResult.jsonToDepositResult,
      tag: 'remote-DEPOSIT',
    );
  }
}
