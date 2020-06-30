import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData, requestList;
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:meta/meta.dart' show required;
import 'package:flutter_ty_mobile/utils/value_util.dart' show formatNum;

import '../form/transfer_form.dart';
import '../models/transfer_balance_model.dart';
import '../models/transfer_platform_model.dart';

class TransferApi {
  static const String GET_PLATFORM = "api/getPlatform";
  static const String GET_BALANCE = "api/balance/";
  static const String POST_TRANSFER = "api/transfer";
}

abstract class TransferRemoteDataSource {
  /// Calls the service [TransferApi.GET_PLATFORM] endpoint to get the list.
  Future<List<TransferPlatformModel>> getPlatform();

  /// Calls the service [TransferApi.GET_BALANCE] endpoint to get the platform credit.
  Future<TransferBalanceModel> getBalance(String platform);

  Future<RequestStatusModel> postTransfer(TransferForm form);
}

class TransferRemoteDataSourceImpl implements TransferRemoteDataSource {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'TransferRemoteDataSource';
  bool jwtChecked = false;

  TransferRemoteDataSourceImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.value(jwtInterface.checkJwt('/'))
        .then((value) => jwtChecked = value.isSuccess);
  }

  @override
  Future<List<TransferPlatformModel>> getPlatform() {
    return requestList<TransferPlatformModel>(
      request: dioApiService.get(TransferApi.GET_PLATFORM),
      jsonToModel: TransferPlatformModel.jsonToTransferPlatformModel,
      tag: 'remote-TRANSFER_PLATFORM',
    );
  }

  @override
  Future<TransferBalanceModel> getBalance(String platform) async {
    if (jwtChecked) {
      return requestData<TransferBalanceModel>(
        request: dioApiService.get('${TransferApi.GET_BALANCE}$platform',
            userToken: jwtInterface.token),
        jsonToModel: TransferBalanceModel.jsonToTransferBalanceModel,
        tag: 'remote-TRANSFER_BALANCE',
      );
    } else {
      MyLogger.warn(msg: 'user token is not valid', tag: tag);
      return TransferBalanceModel(balance: formatNum(0, addCreditSign: true));
    }
  }

  @override
  Future<RequestStatusModel> postTransfer(TransferForm form) {
    return requestData<RequestStatusModel>(
      request:
          dioApiService.post(TransferApi.POST_TRANSFER, data: form.toJson()),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-Transfer',
    );
  }
}
