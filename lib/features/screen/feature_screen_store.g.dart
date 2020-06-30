// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FeatureScreenStore on _FeatureScreenStore, Store {
  Computed<bool> _$hasUserComputed;

  @override
  bool get hasUser => (_$hasUserComputed ??= Computed<bool>(() => super.hasUser,
          name: '_FeatureScreenStore.hasUser'))
      .value;
  Computed<int> _$navIndexComputed;

  @override
  int get navIndex =>
      (_$navIndexComputed ??= Computed<int>(() => super.navIndex,
              name: '_FeatureScreenStore.navIndex'))
          .value;

  final _$_streamRouteAtom = Atom(name: '_FeatureScreenStore._streamRoute');

  @override
  ObservableStream<RouteInfo> get _streamRoute {
    _$_streamRouteAtom.reportRead();
    return super._streamRoute;
  }

  @override
  set _streamRoute(ObservableStream<RouteInfo> value) {
    _$_streamRouteAtom.reportWrite(value, super._streamRoute, () {
      super._streamRoute = value;
    });
  }

  final _$pageInfoAtom = Atom(name: '_FeatureScreenStore.pageInfo');

  @override
  RouteInfo get pageInfo {
    _$pageInfoAtom.reportRead();
    return super.pageInfo;
  }

  @override
  set pageInfo(RouteInfo value) {
    _$pageInfoAtom.reportWrite(value, super.pageInfo, () {
      super.pageInfo = value;
    });
  }

  final _$_streamUserAtom = Atom(name: '_FeatureScreenStore._streamUser');

  @override
  ObservableStream<LoginStatus> get _streamUser {
    _$_streamUserAtom.reportRead();
    return super._streamUser;
  }

  @override
  set _streamUser(ObservableStream<LoginStatus> value) {
    _$_streamUserAtom.reportWrite(value, super._streamUser, () {
      super._streamUser = value;
    });
  }

  final _$userStatusAtom = Atom(name: '_FeatureScreenStore.userStatus');

  @override
  LoginStatus get userStatus {
    _$userStatusAtom.reportRead();
    return super.userStatus;
  }

  @override
  set userStatus(LoginStatus value) {
    _$userStatusAtom.reportWrite(value, super.userStatus, () {
      super.userStatus = value;
    });
  }

  @override
  String toString() {
    return '''
pageInfo: $pageInfo,
userStatus: $userStatus,
hasUser: $hasUser,
navIndex: $navIndex
    ''';
  }
}
