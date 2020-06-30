import 'package:flutter_ty_mobile/core/data/hive_actions.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/accountcenter/data/form/center_password_form.dart';
import 'package:flutter_ty_mobile/features/user/data/form/login_form.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';
import 'package:hive/hive.dart';

import '../../data/entity/center_account_entity.dart';
import '../../data/entity/center_vip_entity.dart';
import '../../data/models/center_model.dart';
import '../../data/repository/center_repository.dart';

part 'center_store.g.dart';

class CenterStore = _CenterStore with _$CenterStore;

enum CenterStoreState { initial, loading, loaded }

enum CenterStoreAction {
  password,
  birth,
  email,
  wechat,
  lucky,
  verify_request,
  verify,
}

typedef CenterFutureTask(String data);

abstract class _CenterStore with Store {
  final CenterRepository _repository;

  final StreamController<CenterAccountEntity> _accountController =
      StreamController<CenterAccountEntity>.broadcast();
  final StreamController<List<int>> _lottoController =
      StreamController<List<int>>.broadcast();
  final StreamController<CenterVipEntity> _vipController =
      StreamController<CenterVipEntity>.broadcast();

  _CenterStore(this._repository) {
    _accountController.stream.listen((event) {
      accountEntity = event;
      print('account data: $event');
      if (accountEntity == null) errorMessage = Failure.jsonFormat().message;
    });
    _lottoController.stream.listen((event) {
      accountLotto = event;
      print('account lotto: $event');
      if (accountLotto == null) errorMessage = Failure.jsonFormat().message;
    });
    _vipController.stream.listen((event) {
      accountVip = event;
      print('account vip: $event');
      if (accountVip == null) errorMessage = Failure.jsonFormat().message;
    });
  }

  @observable
  ObservableFuture<Either<Failure, CenterModel>> _accountFuture;

  @observable
  bool accountDataReady = false;

  CenterAccountEntity accountEntity;
  List<int> accountLotto;
  CenterVipEntity accountVip;

  List<String> cgpUrl;
  List<String> cpwUrl;

  Stream<CenterAccountEntity> get accountStream => _accountController.stream;
  Stream<List<int>> get lottoStream => _lottoController.stream;
  Stream<CenterVipEntity> get vipStream => _vipController.stream;

  CenterStoreAction currentRequest;

  @observable
  bool waitForResponse = false;

  @observable
  dynamic requestResponse;

  @observable
  String errorMessage;

  Box _loginDataBox;

  @computed
  CenterStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_accountFuture == null ||
        _accountFuture.status == FutureStatus.rejected) {
      return CenterStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _accountFuture.status == FutureStatus.pending || !accountDataReady
        ? CenterStoreState.loading
        : CenterStoreState.loaded;
  }

  @action
  Future<void> getAccount() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _accountFuture = ObservableFuture(_repository.getAccount());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _accountFuture.then((result) {
//        print('center data result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (model) {
            if (model.cgpWallet.isEmpty && cgpUrl == null) getCgpUrl();
            if (model.cpwWallet.isEmpty && cpwUrl == null) getCpwUrl();
            _accountController.sink.add(model.wrapAccountData);
            _lottoController.sink.add(model.getLottoList);
            _vipController.sink.add(model.wrapVipData);
            accountDataReady = true;
          },
        );
      });
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.CENTER))
              .message;
    }
  }

  @action
  Future<void> getCgpUrl() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getCgpBindUrl().then((result) {
//        print('cpg url result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (list) {
            if (list.isEmpty) {
              errorMessage = '${localeStr.messageErrorBindUrl('CGP')}';
              _accountController.sink
                  .add(accountEntity.copyWith(cgpWallet: '-1'));
            }
            cgpUrl = list;
          },
        );
      });
    } on Exception {
      cgpUrl = [];
    }
  }

  @action
  Future<void> getCpwUrl() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getCpwBindUrl().then((result) {
//        print('cpw url result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (list) {
            if (list.isEmpty) {
              errorMessage = '${localeStr.messageErrorBindUrl('CPW')}';
              _accountController.sink
                  .add(accountEntity.copyWith(cpwWallet: '-1'));
            }
            cpwUrl = list;
          },
        );
      });
    } on Exception {
      cpwUrl = [];
    }
  }

  @action
  Future<void> initLoginDataBox() async {
    await getHiveBox(Global.CACHE_LOGIN_FORM)
        .then((value) => _loginDataBox = value);
  }

  @action
  Future<void> postPassword(CenterPasswordForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = CenterStoreAction.password;
      await _repository.postPassword(form).then((result) {
//        print('center password result: $result');
        return result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            if (data.isSuccess &&
                _loginDataBox != null &&
                _loginDataBox.isNotEmpty) {
              LoginHiveForm hiveForm = _loginDataBox.values?.last;
              if (hiveForm.account == accountEntity.accountCode) {
                LoginHiveForm newHiveForm = hiveForm.copyWith(password: '');
                Future.sync(() {
                  _loginDataBox
                      .putAt(0, newHiveForm)
                      .whenComplete(() => print('Login Hive - data updated'))
                      .catchError((e) => MyLogger.error(
                          msg: 'Save error: $_loginDataBox',
                          error: e,
                          tag: 'CenterStore'));
                });
              }
            }
            requestResponse = data;
          },
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      errorMessage = Failure.internal(
        FailureCode(typeCode: FailureTypeCode.CENTER),
      ).message;
    }
  }

  void bindBirth(String dateOfBirth) async {
    _postStringData(
      dateOfBirth,
      CenterStoreAction.birth,
      _repository.postBirth,
      () => _accountController.sink
          .add(accountEntity.copyWith(birthDate: dateOfBirth)),
    );
  }

  void bindEmail(String email) async {
    _postStringData(
      email,
      CenterStoreAction.email,
      _repository.postEmail,
      () => _accountController.sink.add(accountEntity.copyWith(email: email)),
    );
  }

  void bindWechat(String wechatno) {
    _postStringData(
      wechatno,
      CenterStoreAction.wechat,
      _repository.postWechat,
      () =>
          _accountController.sink.add(accountEntity.copyWith(wechat: wechatno)),
    );
  }

  @action
  Future<void> _postStringData(
    String data,
    CenterStoreAction action,
    CenterFutureTask task,
    Function callback,
  ) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = action;
      await task(data).then((result) {
//        print('center $action result: $result');
        return result.fold(
          (failure) => errorMessage = failure.message,
          (RequestStatusModel data) {
            if (data.isSuccess) callback();
            requestResponse = data;
          },
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      errorMessage = Failure.internal(
        FailureCode(typeCode: FailureTypeCode.CENTER),
      ).message;
    }
  }

  @action
  Future<void> postLucky(List<int> numbers) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = CenterStoreAction.lucky;
      await _repository.postLucky(numbers).then((result) {
//        print('center lotto result: $result');
        return result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            if (data.isSuccess) {
              _lottoController.sink
                  .add(JsonUtil.decodeArray(data.msg).cast<int>());
            }
            requestResponse = data;
          },
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      errorMessage = Failure.internal(
        FailureCode(typeCode: FailureTypeCode.CENTER),
      ).message;
    }
  }

  @action
  Future<void> postVerifyRequest(String mobile) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = CenterStoreAction.verify_request;
      await _repository.postVerifyRequest(mobile).then((result) {
        print('center verify request result: $result');
        return result.fold(
          (failure) => errorMessage = failure.message,
          (data) => requestResponse = data,
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      errorMessage = Failure.internal(
        FailureCode(typeCode: FailureTypeCode.CENTER),
      ).message;
    }
  }

  @action
  Future<void> postVerify(String mobile, String code) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      requestResponse = null;
      waitForResponse = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      currentRequest = CenterStoreAction.verify;
      await _repository.postVerify(mobile, code).then((result) {
        print('center verify result: $result');
        return result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            if (data.isSuccess)
              Future.delayed(Duration(milliseconds: 300), () => getAccount());
            requestResponse = data;
          },
        );
      }).whenComplete(() => waitForResponse = false);
    } on Exception {
      waitForResponse = false;
      errorMessage = Failure.internal(
        FailureCode(typeCode: FailureTypeCode.CENTER),
      ).message;
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _accountController.close(),
        _lottoController.close(),
        _vipController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close center stream error', error: e, tag: 'CenterStore');
      return null;
    }
  }
}
