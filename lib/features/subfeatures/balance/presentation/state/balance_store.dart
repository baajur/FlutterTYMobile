import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/balance/data/repository/balance_repository.dart';
import 'package:flutter_ty_mobile/features/subfeatures/balance/presentation/enum/balance_grid_action.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transfer/data/form/transfer_form.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart'
    show ValueUtilExtension;
import 'package:super_enum/super_enum.dart';

part 'balance_store.g.dart';

class BalanceStore = _BalanceStore with _$BalanceStore;

enum BalanceStoreState { initial, loading, loaded }

abstract class _BalanceStore with Store {
  final BalanceRepository _repository;

  final StreamController<String> _loadingController =
      StreamController<String>.broadcast();

  _BalanceStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, List<String>>> _promiseFuture;

  List<String> promises;
  int totalPlatform;
  Map<String, String> balanceMap;

  Stream<String> get loadingStream => _loadingController.stream;

  @observable
  String errorMessage;

  int balanceRequestProgress;

  @observable
  String balanceUpdated = '';

  @observable
  RequestStatusModel transferResult;

  @observable
  bool waitForTransferResult = false;

  double creditLimit;

  @computed
  BalanceStoreState get state {
    // If the user has not yet triggerd a action or there has been an error
    if (_promiseFuture == null ||
        _promiseFuture.status == FutureStatus.rejected) {
      return BalanceStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _promiseFuture.status == FutureStatus.pending
        ? BalanceStoreState.loading
        : BalanceStoreState.loaded;
  }

  @action
  Future<void> getPromises() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _promiseFuture = ObservableFuture(_repository.getPromise());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _promiseFuture.then(
        (result) => result.fold(
          (failure) => errorMessage = failure.message,
          (list) {
            promises = list;
            totalPlatform = list.length;
            print('balance promise list: $list');
            if (promises.isNotEmpty) getBalances();
          },
        ),
      );
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.BALANCE))
              .message;
    }
  }

  void sinkProgress({bool reset = false, bool close = false}) {
    if (_loadingController.isClosed) return;
    if (close) {
      balanceRequestProgress = -1;
      _loadingController.sink.add('');
      return;
    }
    if (reset)
      balanceRequestProgress = 1;
    else
      balanceRequestProgress += 1;
    _loadingController.sink.add('$balanceRequestProgress / $totalPlatform');
  }

  @action
  Future<void> getBalances() async {
    try {
      // Reset the possible previous error message.
      balanceMap = new Map();
      sinkProgress(reset: true);
      // Fetch from the repository and wrap the regular Future into an observable.
      // TODO change this to stream might run faster??
      await Future.forEach(promises, (platform) async {
        await getBalance(platform, showProgress: true);
      }).whenComplete(() {
        print('balance map: $balanceMap');
        sinkProgress(close: true);
      });
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.BALANCE))
              .message;
    }
  }

  @action
  Future<void> getBalance(String platform, {bool showProgress = false}) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      balanceUpdated = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository.getBalance(platform).then(
        (result) {
          result.fold(
            (failure) => balanceMap[platform] = 'x',
            (data) {
              if (showProgress) sinkProgress();
              balanceMap[platform] = data;
              print('add balance to map: $platform, credit: $data');
              balanceUpdated = platform;
            },
          );
        },
      );
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.BALANCE))
              .message;
    }
  }

  @action
  Future<void> getCreditLimit() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      await _repository.getLimit().then(
        (result) {
          result.fold(
            (failure) => errorMessage = failure.message,
            (data) => creditLimit = data.strToDouble,
          );
        },
      ).whenComplete(() => print('credit limit: $creditLimit'));
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.BALANCE))
              .message;
    }
  }

  @action
  Future<void> postTransfer(TransferForm form) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      transferResult = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postTransfer(form)
          .whenComplete(() => waitForTransferResult = false)
          .then((result) {
        print('transfer from ${form.from} to ${form.to} result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            transferResult = data;
            if (data.isSuccess) {
              Future.delayed(Duration(milliseconds: 500), () {
                (form.from == '0')
                    ? getBalance(form.to)
                    : getBalance(form.from);
                getCreditLimit();
              });
            }
          },
        );
      });
    } on Exception {
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.TRANSFER))
              .message;
    }
  }

  @action
  Future<void> exeGridAction(BalanceGridAction action, String platform) async {
    print('execute $platform grid action: $action');
    if ((action == BalanceGridAction.transferIn ||
        action == BalanceGridAction.transferOut)) {
      if (waitForTransferResult) {
        errorMessage = localeStr.messageWait;
        return;
      }
      waitForTransferResult = true;
    }
    switch (action) {
      case BalanceGridAction.transferIn:
        print('account limit: $creditLimit');
        if (creditLimit > 1) {
          postTransfer(
            TransferForm(
              from: '0',
              to: platform,
              amount: '${creditLimit.floor()}',
            ),
          );
        } else {
          waitForTransferResult = false;
          errorMessage = localeStr.balanceTransferAmountError('￥$creditLimit');
        }
        break;
      case BalanceGridAction.transferOut:
        var credit = balanceMap[platform].strToDouble;
        print('platform limit: $credit');
        if (credit >= 1) {
          postTransfer(
            TransferForm(
              from: platform,
              to: '0',
              amount: '${credit.floor()}',
            ),
          );
        } else {
          waitForTransferResult = false;
          errorMessage = localeStr.balanceTransferAmountError('￥$credit');
        }
        break;
      case BalanceGridAction.refresh:
        getBalance(platform);
        break;
    }
  }

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _loadingController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close balance stream error', error: e, tag: 'BalanceStore');
      return null;
    }
  }
}
