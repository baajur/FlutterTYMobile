import 'package:flutter_ty_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_ty_mobile/core/store_export.dart';

import '../../data/form/transfer_form.dart';
import '../../data/models/transfer_platform_model.dart';
import '../../data/repository/transfer_repository.dart';

part 'transfer_store.g.dart';

class TransferStore = _TransferStore with _$TransferStore;

enum TransferStoreState { initial, loading, loaded }

abstract class _TransferStore with Store {
  final TransferRepository _repository;

  _TransferStore(this._repository) {
    _site1ValueController.stream.listen((event) {
      site1 = event;
      checkPlatformValid();
    });
    _site2ValueController.stream.listen((event) {
      site2 = event;
      checkPlatformValid();
    });
  }

  final StreamController<String> _site1ValueController =
      new StreamController<String>.broadcast();
  final StreamController<String> _site2ValueController =
      new StreamController<String>.broadcast();

  Stream<String> get site1ValueStream => _site1ValueController.stream;
  Stream<String> get site2ValueStream => _site2ValueController.stream;

  @observable
  ObservableFuture<Either<Failure, TransferPlatformList>> _platformFuture;

  @observable
  List<TransferPlatformModel> platforms;

  @observable
  RequestStatusModel transferResult;

  @observable
  bool waitForTransferResult = false;

  @observable
  String errorMessage;

  int creditLimit = 0;

  bool isPlatformValid = false;

  String site1;
  String site2;

  @computed
  TransferStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_platformFuture == null ||
        _platformFuture.status == FutureStatus.rejected) {
      return TransferStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _platformFuture.status == FutureStatus.pending
        ? TransferStoreState.loading
        : TransferStoreState.loaded;
  }

  @action
  Future<void> getPlatforms() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _platformFuture = ObservableFuture(_repository.getPlatform());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _platformFuture.then((result) {
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            platforms = data.list;
            print('platforms: $platforms');
          },
        );
      });
    } on Exception {
      errorMessage = "Couldn't fetch platforms. Is the device online?";
    }
  }

  @action
  Future<void> getBalance(String site, {bool isLimit = false}) async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository.getBalance(site).then((result) {
        result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            print('$site balance: ${data.balance}');
            bool platformClosed = data.balance == '￥-1.00';
            if (isLimit) {
              creditLimit = (platformClosed) ? 0 : data.balance.strToInt;
              setSite1Value((platformClosed) ? '￥---' : data.balance);
            } else {
              setSite2Value((platformClosed) ? '￥---' : data.balance);
            }
          },
        );
      });
    } on Exception {
      errorMessage = "Couldn't fetch $site balance. Is the device online?";
    }
  }

  @action
  Future<void> sendRequest(TransferForm form) async {
    try {
      if (waitForTransferResult) return;
      // Reset the possible previous error message.
      errorMessage = null;
      transferResult = null;
      waitForTransferResult = true;
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
              Future.delayed(Duration(milliseconds: 1000), () {
                getBalance(form.from, isLimit: true);
                getBalance(form.to);
              });
            }
          },
        );
      });
    } on Exception {
      waitForTransferResult = false;
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.TRANSFER)).message;
    }
  }

  void setSite1Value(String text) async {
    _site1ValueController.sink.add(text);
  }

  void setSite2Value(String text) async {
    _site2ValueController.sink.add(text);
  }

  void checkPlatformValid() {
    isPlatformValid =
        site1 != null && site1 != '￥---' && site2 != null && site2 != '￥---';
    print('platform can transfer: $isPlatformValid');
  }

  Future<void> closeStreams() async {
    try {
      _site1ValueController.close();
      _site2ValueController.close();
    } catch (e) {
      MyLogger.warn(msg: 'close transfer stream error', error: e);
    }
  }
}
