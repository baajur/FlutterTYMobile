import 'dart:async';

import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/general_route_widget_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/register/data/form/register_form.dart';
import 'package:flutter_ty_mobile/features/users/data/form/login_form.dart';
import 'package:flutter_ty_mobile/features/users/data/repository/user_repository.dart';

import '../../data/repository/register_repository.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  final RegisterRepository _repository;
  final UserRepository _userRepository;
  final StreamController _loginController = StreamController.broadcast();

  _RegisterStore(this._repository, this._userRepository);

  Stream get loginStream => _loginController.stream;

  @observable
  RequestStatusModel registerResult;

  @observable
  bool waitForRegister = false;

  @observable
  String errorMessage;

  @action
  Future<void> postRegister(RegisterForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      registerResult = null;
      waitForRegister = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postRegister(form)
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (model) {
//                print('register result: $model');
                registerResult = model;
                if (model.isSuccess) {
                  Future.delayed(Duration(milliseconds: 500), () {
                    postLogin(UserLoginForm(
                      account: form.username,
                      password: form.confirmPassword,
                    ));
                  });
                }
              },
            ),
          )
          .whenComplete(() => waitForRegister = false);
    } on Exception {
      waitForRegister = false;
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.REGISTER))
              .message;
    }
  }

  @action
  Future<void> postLogin(UserLoginForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _userRepository.getAccount(form).then(
            (result) => result.fold(
              (failure) {
                print('auto login failed: $failure');
                _loginController.sink.add('');
              },
              (model) {
                print('login result: $model');
                _loginController.sink.add(model);
              },
            ),
          );
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.REGISTER))
              .message;
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _loginController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close register stream error', error: e, tag: 'RegisterStore');
      return null;
    }
  }
}
