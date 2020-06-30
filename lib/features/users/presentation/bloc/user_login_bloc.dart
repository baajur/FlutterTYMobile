import 'package:bloc/bloc.dart';
import 'package:flutter_ty_mobile/core/base/usecase_export.dart';
import 'package:flutter_ty_mobile/core/data/hive_actions.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart'
    show RequestStatusModel;
import 'package:flutter_ty_mobile/features/users/data/form/login_form.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart' show required;
import 'package:super_enum/super_enum.dart';

import '../usecase/get_user.dart';
import 'user_login_event.dart';
import 'user_login_state.dart';

const String _CACHE_LOGIN_FORM = '_CACHE_LOGIN_FORM';

class UserLoginBloc extends Bloc<UserLoginEvent, UserLoginState> {
  final GetUserData getUserData;
  final tag = 'UserLoginBloc';

  final StreamController<Box> _boxControl = new StreamController();
  final StreamController<UserLoginHiveForm> _fastController =
      new StreamController();

  Stream<UserLoginHiveForm> get fastLoginStream => _fastController.stream;

  Box _box;

  UserLoginBloc({
    @required GetUserData userData,
  })  : assert(userData != null),
        getUserData = userData;

  Future<void> initBox() async {
    _boxControl.stream.listen((event) {
      _box = event;
      MyLogger.log(msg: 'User Box check: ${_box?.length}', tag: tag);
      if (_box != null && _box.isNotEmpty) {
        _fastController.sink.add(_box.values?.last);
      }
    });
    Future.value(getHiveBox(_CACHE_LOGIN_FORM))
        .then((value) => _boxControl.sink.add(value));
  }

  Future<void> saveToBox(UserLoginHiveForm form) async {
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

  @override
  UserLoginState get initialState => UserLoginState.uInitial();

  @override
  void onTransition(Transition<UserLoginEvent, UserLoginState> transition) {
//    print('marquee state, current: ${transition.currentState}');
    print('user state, next: ${transition.nextState}');
    super.onTransition(transition);
  }

  @override
  Future<void> close() async {
    try {
      _fastController.close();
      _boxControl.close();
      closeHiveBox(_CACHE_LOGIN_FORM);
    } catch (e) {
      MyLogger.warn(msg: 'close user bloc error', error: e, tag: tag);
    }
    super.close();
  }

  @override
  Stream<UserLoginState> mapEventToState(
    UserLoginEvent event,
  ) async* {
    MyLogger.print(msg: 'mapEventToState: $event', tag: tag);
    if (event is GetUserEvent) {
      yield UserLoginState.uLoading();
    }
    // action on different event
    yield* await event.when(
      getUserEvent: (event) => streamUserDataState(event),
    );
  }

  /// Get user data from repository through [GetUserData]
  Stream<UserLoginState> streamUserDataState(GetUserEvent event) async* {
    final UserLoginForm form = event.form.copyWith();
    final failureOrData = await getUserData(DataParams(form));
    yield failureOrData.fold(
      (failure) {
        var message = '';
        if (failure.props.isNotEmpty) {
          var failureData = failure.props.first;
          // show the message from the model
          if (failureData is RequestStatusModel) message = failureData.msg;
        }
        // else show failure's message
        if (message.isEmpty) message = failure.message;
        return UserLoginState.uError(message: message);
      },
      (data) => UserLoginState.uLoaded(user: data),
    );
  }
}
