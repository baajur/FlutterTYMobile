import 'package:flutter_ty_mobile/core/base/usecase_export.dart';
import 'package:flutter_ty_mobile/core/repository_export.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart'
    show getRouteUserStreams;
import 'package:flutter_ty_mobile/features/users/data/models/user_freezed.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository/member_repository.dart';

part 'member_credit_store.g.dart';

class MemberCreditStore = _MemberCreditStore with _$MemberCreditStore;

abstract class _MemberCreditStore with Store {
  final MemberRepository _repository;

  _MemberCreditStore(this._repository) {
    _userStream = ObservableStream(getRouteUserStreams.userStream);
    _userStream.listen((event) {
      user = event.currentUser;
      credit = user.credit;
      print('member store user: $user, credit: $credit');
    });
  }

  @observable
  ObservableStream<LoginStatus> _userStream;

  @observable
  UserEntity user;

  @observable
  ObservableFuture<Either<Failure, String>> _creditFuture;

  @observable
  String credit = '';

  @observable
  String errorMessage;

  final String creditResetStr = '￥---';

  void getUser() {
    user = getRouteUserStreams.lastUser.currentUser;
  }

  @action
  Future<void> getCredit() async {
    try {
      if (user == null) return;
      credit = creditResetStr;
      _creditFuture = ObservableFuture(_repository.updateCredit(user.account));
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _creditFuture.then(
        (result) => result.fold(
          (failure) => errorMessage = failure.message,
          (value) {
            getRouteUserStreams.lastUser.currentUser.updateCredit(value);
            credit = value;
          },
        ),
      );
      print('member store credit: $credit');
    } on Exception catch (e) {
      MyLogger.error(msg: 'member credit has exception', error: e);
    }
  }
}
