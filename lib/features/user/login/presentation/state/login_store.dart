import 'package:flutter_ty_mobile/core/data/hive_actions.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/mobx_store_export.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:hive/hive.dart';

import '../../../data/repository/user_repository.dart';
import '../../../data/form/login_form.dart';
import '../../../data/models/user_model.dart';
import '../../../data/entity/login_status.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStore with _$LoginStore;

enum LoginStoreState { initial, loading, loaded }

enum LoginState { initial, loading, loaded }

abstract class _LoginStore with Store {
  final UserRepository _repository;
  final String tag = 'LoginStore';

  _LoginStore(this._repository);

  @observable
  ObservableFuture<Box> _initFuture;

  @observable
  ObservableFuture<Either<Failure, UserModel>> _loginFuture;

  Box _box;

  @observable
  bool waitForHive = true;

  @observable
  LoginHiveForm hiveLoginForm;

  @observable
  bool waitForLogin = false;

  @observable
  String errorMessage;

  @computed
  LoginStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_initFuture == null || _initFuture.status == FutureStatus.rejected) {
      return LoginStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _initFuture.status == FutureStatus.pending
        ? LoginStoreState.loading
        : LoginStoreState.loaded;
  }

  @action
  Future<void> initBox() async {
    // Reset the possible previous error message.
    errorMessage = null;
    // Fetch from the repository and wrap the regular Future into an observable.
    _initFuture =
        ObservableFuture(Future.value(getHiveBox(Global.CACHE_LOGIN_FORM)));
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await _initFuture.then((value) {
      _box = value;
      MyLogger.log(msg: 'User Box check: ${_box?.length}', tag: tag);
      if (_box != null && _box.isNotEmpty) {
        print('box login data: ${_box.values.last}');
        hiveLoginForm = _box.values.last;
        waitForHive = false;
      } else {
        waitForHive = false;
      }
    });
  }

  @computed
  LoginState get loginState {
    // If the user has not yet triggered a action or there has been an error
    if (_loginFuture == null || _loginFuture.status == FutureStatus.rejected) {
      return LoginState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _loginFuture.status == FutureStatus.pending
        ? LoginState.loading
        : LoginState.loaded;
  }

  @action
  Future login(LoginForm form, bool saveForm) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForLogin = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      _loginFuture = ObservableFuture(_repository.login(form));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _loginFuture.then((value) => value.fold(
            (failure) {
              waitForLogin = false;
              errorMessage = failure.message;
            },
            (model) async {
              if (saveForm)
                await saveToBox(LoginHiveForm(
                  fastLogin: true,
                  account: form.account,
                  password: form.password,
                ));
              else
                await cleanBox();

              getRouteUserStreams.updateUser(LoginStatus(
                loggedIn: true,
                currentUser: model.entity,
              ));

              waitForLogin = false;
            },
          ));
    } on Exception {
      waitForLogin = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage = Failure.internal(FailureCode()).message;
    }
  }

  Future<void> saveToBox(LoginHiveForm form) async {
    if (_box == null) {
      MyLogger.warn(msg: 'User Box is NULL', tag: tag);
      return;
    }
    if (_box.isNotEmpty) {
      await _box
          .putAt(0, form)
          .whenComplete(() => print('form saved: $form'))
          .catchError((e) =>
              MyLogger.error(msg: 'Save error: $_box', error: e, tag: tag));
    } else {
      await _box
          .add(form)
          .whenComplete(() => print('form saved: $form'))
          .catchError((e) =>
              MyLogger.error(msg: 'Save error: $_box', error: e, tag: tag));
    }
  }

  Future<void> cleanBox() async {
    if (_box != null && _box.isNotEmpty) {
      await _box
          .clear()
          .whenComplete(() => print('hive cleared'))
          .catchError((e) => print('hive clear error: $e'));
    }
  }

  void close() {
    try {
      closeHiveBox(Global.CACHE_LOGIN_FORM);
    } catch (e) {
      MyLogger.warn(
          msg: 'close login stream error', error: e, tag: 'LoginStore');
      return null;
    }
  }
}
