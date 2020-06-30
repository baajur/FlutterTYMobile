import 'package:flutter_ty_mobile/core/network/dio_api_service.dart';
import 'package:flutter_ty_mobile/core/network/handler/data_request_handler.dart'
    show requestData, requestRawString;
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/member/data/source/member_jwt_interface.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:meta/meta.dart' show required;

import '../form/center_password_form.dart';
import '../models/center_model.dart';
import '../../../../../core/network/handler/request_code_model.dart';

class CenterApi {
  static const String GET_ACCOUNT = "api/center";
  static const String GET_CGP_URL = "api/bindcgp";
  static const String GET_CPW_URL = "api/bindcpw";
  static const String POST_PASSWORD = "api/edit_password";
  static const String POST_BIRTH = "api/edit_dob";
  static const String POST_EMAIL = "api/edit_email";
  static const String POST_WECHAT = "api/edit_wechat";
  static const String POST_LUCKY = "api/edit_lucky";
  static const String POST_VERIFY_REQUEST = "api/sendMessage";
  static const String POST_VERIFY = "api/checkVerifyCode";
  static const String JWT_CHECK_HREF = "/center";
}

abstract class CenterRemoteDataSource {
  Future<CenterModel> getAccount();
  Future<String> getCgpBindUrl();
  Future<String> getCpwBindUrl();
  Future<RequestStatusModel> postPassword(CenterPasswordForm form);
  Future<RequestStatusModel> postBirth(String dateOfBirth);
  Future<RequestStatusModel> postEmail(String email);
  Future<RequestStatusModel> postWechat(String wechatno);
  Future<RequestStatusModel> postLucky(List<int> numbers);
  Future<RequestCodeModel> postVerifyRequest(String mobile);
  Future<RequestCodeModel> postVerify(String mobile, String code);
}

class CenterRemoteDataSourceImpl implements CenterRemoteDataSource {
  final DioApiService dioApiService;
  final MemberJwtInterface jwtInterface;
  final tag = 'CenterRemoteDataSource';

  CenterRemoteDataSourceImpl(
      {@required this.dioApiService, @required this.jwtInterface});

  @override
  Future<CenterModel> getAccount() async {
    final validStatus =
        await Future.value(jwtInterface.checkJwt(CenterApi.JWT_CHECK_HREF));
    if (validStatus.isSuccess) {
      return requestData<CenterModel>(
        request: dioApiService.get(
          CenterApi.GET_ACCOUNT,
          userToken: jwtInterface.token,
        ),
        jsonToModel: CenterModel.jsonToCenterModel,
        tag: 'remote-ACCOUNT',
      );
    } else {
      MyLogger.warn(msg: 'user token is not valid: $validStatus', tag: tag);
      return CenterModel();
    }
  }

  @override
  Future<String> getCgpBindUrl() {
    return requestRawString(
      request: dioApiService.get(
        CenterApi.GET_CGP_URL,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-CGP_URL',
    );
  }

  @override
  Future<String> getCpwBindUrl() {
    return requestRawString(
      request: dioApiService.get(
        CenterApi.GET_CPW_URL,
        userToken: jwtInterface.token,
      ),
      allowJsonString: true,
      tag: 'remote-CGP_URL',
    );
  }

  @override
  Future<RequestStatusModel> postPassword(CenterPasswordForm form) {
    return requestData<RequestStatusModel>(
      request: dioApiService.post(
        CenterApi.POST_PASSWORD,
        data: form.toJson(),
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-PASSWORD',
    );
  }

  @override
  Future<RequestStatusModel> postBirth(String dateOfBirth) {
    return requestData<RequestStatusModel>(
      request: dioApiService.post(
        CenterApi.POST_BIRTH,
        data: {'dob': dateOfBirth},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-BIRTH',
    );
  }

  @override
  Future<RequestStatusModel> postEmail(String email) {
    return requestData<RequestStatusModel>(
      request: dioApiService.post(
        CenterApi.POST_EMAIL,
        data: {'email': email},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-EMAIL',
    );
  }

  @override
  Future<RequestStatusModel> postWechat(String wechatno) {
    return requestData<RequestStatusModel>(
      request: dioApiService.post(
        CenterApi.POST_WECHAT,
        data: {'wechat': wechatno},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-WECHAT',
    );
  }

  @override
  Future<RequestStatusModel> postLucky(List<int> numbers) {
    return requestData<RequestStatusModel>(
      request: dioApiService.post(
        CenterApi.POST_LUCKY,
        data: {'lucky': JsonUtil.encodeToJsonArray(numbers)},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestStatusModel.jsonToStatusModel,
      tag: 'remote-LUCKY',
    );
  }

  @override
  Future<RequestCodeModel> postVerifyRequest(String mobile) {
    return requestData<RequestCodeModel>(
      request: dioApiService.post(
        CenterApi.POST_VERIFY_REQUEST,
        data: {'phone': mobile},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToRequestCodeModel,
      tag: 'remote-VERIFY_REQUEST',
    );
  }

  @override
  Future<RequestCodeModel> postVerify(String mobile, String code) {
    return requestData<RequestCodeModel>(
      request: dioApiService.post(
        CenterApi.POST_VERIFY,
        data: {'phone': mobile, 'code': code},
        userToken: jwtInterface.token,
      ),
      jsonToModel: RequestCodeModel.jsonToRequestCodeModel,
      tag: 'remote-VERIFY',
    );
  }
}
