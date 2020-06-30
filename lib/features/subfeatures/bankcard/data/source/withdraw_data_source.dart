import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData, requestRawString;
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:meta/meta.dart' show required;

import '../form/withdraw_form.dart';
import '../models/withdraw_model.dart';

class WithdrawApi {
  static const String GET_CGP = "api/getCgpWallet";
  static const String GET_CPW = "api/getCpwWallet";
  static const String GET_ROLLBACK = "api/rollback";
  static const String POST_WITHDRAW = "api/withdrawal";
}

abstract class WithdrawRemoteDataSource {
  Future<String> getCgpWallet();
  Future<String> getCpwWallet();
  Future<String> getRollback();
  Future<WithdrawModel> postWithdraw(WithdrawForm form);
}

class WithdrawRemoteDataSourceImpl implements WithdrawRemoteDataSource {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'WithdrawRemoteDataSource';

  WithdrawRemoteDataSourceImpl(
      {@required this.dioApiService, @required this.jwtInterface}) {
    Future.sync(() => jwtInterface.checkJwt('/'));
  }

  @override
  Future<String> getCgpWallet() {
    return requestRawString(
      request: dioApiService.get(
        WithdrawApi.GET_CGP,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-CGP',
    );
  }

  @override
  Future<String> getCpwWallet() {
    return requestRawString(
      request: dioApiService.get(
        WithdrawApi.GET_CPW,
        userToken: jwtInterface.token,
      ),
      tag: 'remote-CPW',
    );
  }

  @override
  Future<WithdrawModel> postWithdraw(WithdrawForm form) async {
    return requestData<WithdrawModel>(
      request: dioApiService.post(
        WithdrawApi.POST_WITHDRAW,
        data: form.toJson(),
        userToken: jwtInterface.token,
      ),
      jsonToModel: WithdrawModel.jsonToWithdrawModel,
      tag: 'remote-WITHDRAW',
    );
  }

  @override
  Future<String> getRollback() {
    return requestRawString(
      request: dioApiService.get(
        WithdrawApi.GET_ROLLBACK,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-ROLLBACK',
    );
  }
}
