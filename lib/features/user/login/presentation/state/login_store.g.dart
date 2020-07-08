// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on _LoginStore, Store {
  Computed<LoginStoreState> _$stateComputed;

  @override
  LoginStoreState get state =>
      (_$stateComputed ??= Computed<LoginStoreState>(() => super.state,
              name: '_LoginStore.state'))
          .value;
  Computed<LoginState> _$loginStateComputed;

  @override
  LoginState get loginState =>
      (_$loginStateComputed ??= Computed<LoginState>(() => super.loginState,
              name: '_LoginStore.loginState'))
          .value;

  final _$_initFutureAtom = Atom(name: '_LoginStore._initFuture');

  @override
  ObservableFuture<Box<dynamic>> get _initFuture {
    _$_initFutureAtom.reportRead();
    return super._initFuture;
  }

  @override
  set _initFuture(ObservableFuture<Box<dynamic>> value) {
    _$_initFutureAtom.reportWrite(value, super._initFuture, () {
      super._initFuture = value;
    });
  }

  final _$_loginFutureAtom = Atom(name: '_LoginStore._loginFuture');

  @override
  ObservableFuture<Either<Failure, UserModel>> get _loginFuture {
    _$_loginFutureAtom.reportRead();
    return super._loginFuture;
  }

  @override
  set _loginFuture(ObservableFuture<Either<Failure, UserModel>> value) {
    _$_loginFutureAtom.reportWrite(value, super._loginFuture, () {
      super._loginFuture = value;
    });
  }

  final _$waitForHiveAtom = Atom(name: '_LoginStore.waitForHive');

  @override
  bool get waitForHive {
    _$waitForHiveAtom.reportRead();
    return super.waitForHive;
  }

  @override
  set waitForHive(bool value) {
    _$waitForHiveAtom.reportWrite(value, super.waitForHive, () {
      super.waitForHive = value;
    });
  }

  final _$hiveLoginFormAtom = Atom(name: '_LoginStore.hiveLoginForm');

  @override
  LoginHiveForm get hiveLoginForm {
    _$hiveLoginFormAtom.reportRead();
    return super.hiveLoginForm;
  }

  @override
  set hiveLoginForm(LoginHiveForm value) {
    _$hiveLoginFormAtom.reportWrite(value, super.hiveLoginForm, () {
      super.hiveLoginForm = value;
    });
  }

  final _$waitForLoginAtom = Atom(name: '_LoginStore.waitForLogin');

  @override
  bool get waitForLogin {
    _$waitForLoginAtom.reportRead();
    return super.waitForLogin;
  }

  @override
  set waitForLogin(bool value) {
    _$waitForLoginAtom.reportWrite(value, super.waitForLogin, () {
      super.waitForLogin = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_LoginStore.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$initBoxAsyncAction = AsyncAction('_LoginStore.initBox');

  @override
  Future<void> initBox() {
    return _$initBoxAsyncAction.run(() => super.initBox());
  }

  final _$loginAsyncAction = AsyncAction('_LoginStore.login');

  @override
  Future<dynamic> login(LoginForm form, bool saveForm) {
    return _$loginAsyncAction.run(() => super.login(form, saveForm));
  }

  @override
  String toString() {
    return '''
waitForHive: $waitForHive,
hiveLoginForm: $hiveLoginForm,
waitForLogin: $waitForLogin,
errorMessage: $errorMessage,
state: $state,
loginState: $loginState
    ''';
  }
}
