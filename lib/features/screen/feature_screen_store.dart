import 'dart:async';

import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart'
    show getRouteUserStreams;
import 'package:flutter_ty_mobile/features/users/data/models/user_freezed.dart';

part 'feature_screen_store.g.dart';

class FeatureScreenStore = _FeatureScreenStore with _$FeatureScreenStore;

abstract class _FeatureScreenStore with Store {
  final StreamController<bool> _updateController =
      StreamController<bool>.broadcast();

  _FeatureScreenStore() {
    // initialize route observe
    _streamRoute = ObservableStream(RouterNavigate.routeStream);
    _streamRoute.listen((route) => pageInfo = route);
    pageInfo ??= RouterNavigate.current.toRoutePage.value;

    // initialize user status observe
    _streamUser = ObservableStream(getRouteUserStreams.userStream);
    _streamUser.listen((data) {
      userStatus = data;
      _updateController.sink.add(userStatus.loggedIn);
    });
    userStatus ??= LoginStatus(loggedIn: false);
  }

  /* observe route change */
  @observable
  ObservableStream<RouteInfo> _streamRoute;

  /* current route's info */
  @observable
  RouteInfo pageInfo;

  /* observe user change */
  @observable
  ObservableStream<LoginStatus> _streamUser;

  /* current user status */
  @observable
  LoginStatus userStatus;

  /* current user */
  UserEntity get user => userStatus.currentUser;

  /* update notifier */
  Stream<bool> get updateStream => _updateController.stream;

  @computed
  bool get hasUser => (userStatus != null) ? userStatus.loggedIn : false;

  /* bottom navigator selected index */
  @computed
  int get navIndex => (pageInfo != null && pageInfo.bottomNavIndex != null)
      ? pageInfo.bottomNavIndex
      : -1;

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _updateController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close feature stream error',
          error: e,
          tag: 'FeatureScreenStore');
      return null;
    }
  }
}
