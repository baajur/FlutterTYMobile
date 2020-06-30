// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member_credit_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MemberCreditStore on _MemberCreditStore, Store {
  final _$_userStreamAtom = Atom(name: '_MemberCreditStore._userStream');

  @override
  ObservableStream<LoginStatus> get _userStream {
    _$_userStreamAtom.reportRead();
    return super._userStream;
  }

  @override
  set _userStream(ObservableStream<LoginStatus> value) {
    _$_userStreamAtom.reportWrite(value, super._userStream, () {
      super._userStream = value;
    });
  }

  final _$userAtom = Atom(name: '_MemberCreditStore.user');

  @override
  UserEntity get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserEntity value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$_creditFutureAtom = Atom(name: '_MemberCreditStore._creditFuture');

  @override
  ObservableFuture<String> get _creditFuture {
    _$_creditFutureAtom.reportRead();
    return super._creditFuture;
  }

  @override
  set _creditFuture(ObservableFuture<String> value) {
    _$_creditFutureAtom.reportWrite(value, super._creditFuture, () {
      super._creditFuture = value;
    });
  }

  final _$creditAtom = Atom(name: '_MemberCreditStore.credit');

  @override
  String get credit {
    _$creditAtom.reportRead();
    return super.credit;
  }

  @override
  set credit(String value) {
    _$creditAtom.reportWrite(value, super.credit, () {
      super.credit = value;
    });
  }

  final _$getCreditAsyncAction = AsyncAction('_MemberCreditStore.getCredit');

  @override
  Future<void> getCredit() {
    return _$getCreditAsyncAction.run(() => super.getCredit());
  }

  @override
  String toString() {
    return '''
user: $user,
credit: $credit
    ''';
  }
}
