import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart'
    show getRouteUserStreams;
import 'package:flutter_ty_mobile/features/user/data/entity/login_status.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/user_entity.dart';
import 'package:flutter_ty_mobile/features/user/data/models/event_model.dart';
import 'package:flutter_ty_mobile/features/user/data/repository/event_repository.dart';
import 'package:flutter_ty_mobile/injection_container.dart';

part 'feature_screen_store.g.dart';

class FeatureScreenStore = _FeatureScreenStore with _$FeatureScreenStore;

abstract class _FeatureScreenStore with Store {
  final StreamController<bool> _loginStateController =
      StreamController<bool>.broadcast();

  _FeatureScreenStore() {
    // initialize route observe
    _streamRoute = ObservableStream(RouterNavigate.routeStream);
    _streamRoute.listen((route) => pageInfo = route);
    pageInfo ??= RouterNavigate.current.toRoutePage.value;

    // initialize user status observe
    _streamUser = ObservableStream(getRouteUserStreams.userStream);
    _streamUser.listen((data) async {
      userStatus = data;
      _loginStateController.sink.add(userStatus.loggedIn);
      if (userStatus.loggedIn) {
        await getNewMessageCount();
        await getEvent();
      } else {
        showEvent = false;
        forceShowEvent = false;
        hasSignedEvent = false;
        hasNewMessage = false;
        signedTimes = null;
      }
    });
    userStatus ??= LoginStatus(loggedIn: false);
  }

  @observable
  String errorMessage;

  /// Route
  /* observe route change */
  @observable
  ObservableStream<RouteInfo> _streamRoute;

  /* current route's info */
  @observable
  RouteInfo pageInfo;

  /* bottom navigator selected index */
  @computed
  int get navIndex => (pageInfo != null && pageInfo.bottomNavIndex != null)
      ? pageInfo.bottomNavIndex
      : -1;

  bool get showMenuDrawer =>
      (pageInfo != null) ? pageInfo.isFeature || pageInfo.showDrawer : true;

  /// User
  /* observe user change */
  @observable
  ObservableStream<LoginStatus> _streamUser;

  /* current user status */
  @observable
  LoginStatus userStatus;

  /* current user */
  UserEntity get user => userStatus.currentUser;

  /* login state changed notifier */
  Stream<bool> get loginStateStream => _loginStateController.stream;

  @computed
  bool get hasUser => (userStatus != null) ? userStatus.loggedIn : false;

  /// Event
  EventRepository _eventRepository;

  EventModel _event;

  EventModel get event => _event;

  @observable
  bool showEvent = false;

  bool forceShowEvent = false;

  set setShowEvent(bool show) {
    showEvent = show;
  }

  set setForceShowEvent(bool show) {
    showEvent = (!show) ? showEvent : true;
    forceShowEvent = show;
  }

  @observable
  bool hasSignedEvent = false;

  int signedTimes;

  @observable
  bool hasNewMessage = false;

  String getEventError() => errorMessage;

  @action
  Future<void> getNewMessageCount() async {
    _eventRepository ??= sl.get<EventRepository>();
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await _eventRepository.checkNewMessage().then((result) {
      print('new message result: $result');
      result.fold(
        (failure) => errorMessage = failure.message,
        (value) => hasNewMessage = value,
      );
    });
  }

  @action
  Future<void> getEvent() async {
    _eventRepository ??= sl.get<EventRepository>();
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    await _eventRepository.getEvent().then((result) {
      print('event result: $result');
      result.fold(
        (failure) => errorMessage = failure.message,
        (model) {
          _event = model;
          showEvent =
              _event.hasData && _event.showDialog(user.vip) && _event.canSign;
          forceShowEvent = false;
          hasSignedEvent = _event.canSign == false;
          signedTimes = _event.signData?.times ?? 0;
          print('event show: $showEvent, has signed: $hasSignedEvent');
        },
      );
    });
  }

  @action
  Future<bool> signEvent() async {
    _eventRepository ??= sl.get<EventRepository>();
    // Reset the possible previous error message.
    errorMessage = null;
    // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
    return await _eventRepository
        .signEvent(_event.eventData.id, _event.eventData.prize)
        .then((result) {
      print('event result: $result');
      return result.fold(
        (failure) {
          errorMessage = failure.message;
          return false;
        },
        (model) async {
          if (model.isSuccess == false) {
            errorMessage = localeStr.eventButtonSignUpFailed;
          } else if (model.data is bool) {
            showEvent = false;
            forceShowEvent = false;
            hasSignedEvent = true;
            signedTimes = (_event.signData?.times ?? 0) + 1;
            getEvent();
            return true;
          } else if (model.data is Map) {
            String msg = model.data['msg'];
            errorMessage = (msg == 'alreadySign')
                ? localeStr.eventButtonSignUpAlready
                : msg;
          }
          return false;
        },
      );
    });
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _loginStateController.close(),
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
