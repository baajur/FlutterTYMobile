import 'package:flutter_ty_mobile/core/mobx_store_export.dart';

import '../../data/models/wallet_model.dart';
import '../../data/repository/wallet_repository.dart';

part 'wallet_store.g.dart';

class WalletStore = _WalletStore with _$WalletStore;

enum WalletStoreState { initial, loading, loaded }

abstract class _WalletStore with Store {
  final WalletRepository _repository;

  _WalletStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, WalletModel>> _walletFuture;

  @observable
  WalletModel wallet;

  @observable
  String errorMessage;

  @observable
  bool changeSuccess;

  @observable
  bool waitForTypeChange = false;

  @observable
  bool waitForTransfer;

  bool showingDialog;

  StreamController<String> _progressController;

  /* observe progress change */
  @observable
  String transferProgress;

  @observable
  bool transferSuccess;

  StringBuffer transferErrorList;

  @computed
  WalletStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_walletFuture == null ||
        _walletFuture.status == FutureStatus.rejected) {
      return WalletStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _walletFuture.status == FutureStatus.pending
        ? WalletStoreState.loading
        : WalletStoreState.loaded;
  }

  @action
  Future getWallet() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _walletFuture = ObservableFuture(_repository.getWallet());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _walletFuture.then(
        (result) => result.fold(
          (failure) => errorMessage = failure.message,
          (data) {
            wallet = data;
            print('wallet updated: $wallet');
          },
        ),
      );
    } on Exception {
      errorMessage = "Couldn't fetch wallet. Is the device online?";
    }
  }

  @action
  Future postWalletType(bool toSingle) async {
    try {
      print('change wallet to single: $toSingle');
      // Reset the possible previous error message.
      errorMessage = null;
      changeSuccess = null;
      waitForTypeChange = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postWalletType(toSingle)
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (data) {
                changeSuccess = data == 'success';
                Future.delayed(Duration(milliseconds: 500), () => getWallet());
              },
            ),
          )
          .whenComplete(() => waitForTypeChange = false);
    } on Exception {
      waitForTypeChange = false;
      errorMessage = "Couldn't fetch wallet. Is the device online?";
    }
  }

  @action
  Future postWalletTransfer({bool toSingle = false}) async {
    try {
      // Reset the possible previous error message.
      transferErrorList = null;
      transferSuccess = null;
      transferProgress = '0/0';
      _progressController = new StreamController();
      _progressController.stream.listen((progress) {
        print('wallet transfer progress: $progress');
        transferProgress = progress;
      });
      waitForTransfer = true;
      // Fetch from the repository and wrap the regular Future into an observable.
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .postTransferAll(_progressController)
          .then(
            (result) => result.fold(
              (failure) {
                transferErrorList ??= new StringBuffer();
                transferErrorList.write(failure.message);
              },
              (Map map) {
                print('wallet transfer result: ${map.length}');
                map.forEach((key, value) {
                  if (value.toString() != '200') {
                    transferErrorList ??= new StringBuffer();
                    if (transferErrorList.isNotEmpty)
                      transferErrorList.write(', ');
                    transferErrorList.write('${key.toString().toUpperCase()}');
                  }
                });
                transferSuccess =
                    transferErrorList == null || transferErrorList.isEmpty;
                MyLogger.debug(
                    msg:
                        'wallet transfer error: ${transferErrorList.toString()}',
                    tag: 'Wallet');
                if (toSingle)
                  Future.delayed(
                      Duration(milliseconds: 500), () => postWalletType(true));
              },
            ),
          )
          .whenComplete(() => Future.delayed(
              Duration(milliseconds: 500), () => waitForTransfer = false));
    } on Exception {
      waitForTypeChange = false;
      errorMessage = "Couldn't fetch wallet. Is the device online?";
    }
  }

  Future<void> closeStream() async {
    try {
      if (_progressController.isClosed == false) {
        transferProgress = null;
        transferErrorList = null;
        _progressController.close();
      }
    } catch (e) {
      MyLogger.warn(
          msg: 'close wallet transfer progress stream error', error: e);
    }
  }
}
