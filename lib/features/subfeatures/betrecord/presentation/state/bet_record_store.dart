import 'package:flutter_ty_mobile/core/mobx_store_export.dart';

import '../../data/form/bet_record_form.dart';
import '../../data/models/bet_record_type_model.dart';
import '../../data/repository/bet_record_repository.dart';

part 'bet_record_store.g.dart';

class BetRecordStore = _BetRecordStore with _$BetRecordStore;

enum BetRecordStoreState { initial, loading, loaded }

abstract class _BetRecordStore with Store {
  final BetRecordRepository _repository;
  final StreamController _dataController = StreamController.broadcast();

  _BetRecordStore(this._repository) {
    _dataController.stream.listen((event) {
//      print('agent data: $event');
      if (event == null) errorMessage = Failure.jsonFormat().message;
    });
  }

  @observable
  ObservableFuture<Either<Failure, List<BetRecordTypeModel>>> _typeFuture;

  List<BetRecordTypeModel> typeList;

  Stream get dataStream => _dataController.stream;

  @observable
  String errorMessage;

  @observable
  bool waitForRecordResponse = false;

  @computed
  BetRecordStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_typeFuture == null || _typeFuture.status == FutureStatus.rejected) {
      return BetRecordStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _typeFuture.status == FutureStatus.pending
        ? BetRecordStoreState.loading
        : BetRecordStoreState.loaded;
  }

  @action
  Future<void> getTypes() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _typeFuture = ObservableFuture(_repository.getTypeData());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _typeFuture.then(
        (result) => result.fold(
          (failure) => errorMessage = failure.message,
          (list) {
            print('bet record types: $list');
            typeList = list;
          },
        ),
      );
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.BETS)).message;
    }
  }

  @action
  Future<void> getRecord(BetRecordForm form) async {
    try {
      if (waitForRecordResponse) return;
      // Reset the possible previous error message.
      waitForRecordResponse = true;
      errorMessage = null;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      if (form.isGetAllPlatform) {
        await _repository
            .getRecordAll(form)
            .then(
              (result) => result.fold(
                (failure) => errorMessage = failure.message,
                (list) {
                  print('type ${form.categoryId} bet record: $list');
                  _dataController.sink.add(list);
                },
              ),
            )
            .whenComplete(() => waitForRecordResponse = false);
      } else {
        await _repository
            .getRecord(form)
            .then(
              (result) => result.fold(
                (failure) => errorMessage = failure.message,
                (model) {
                  print('${form.platform} bet record: $model');
                  _dataController.sink.add(model);
                },
              ),
            )
            .whenComplete(() => waitForRecordResponse = false);
      }
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      waitForRecordResponse = false;
      errorMessage =
          Failure.internal(FailureCode(type: FailureType.BETS)).message;
    }
  }

  bool get hasValidData => typeList != null && typeList.isNotEmpty;

  Future<void> closeStreams() {
    try {
      return Future.wait([
        _dataController.close(),
      ]);
    } catch (e) {
      MyLogger.warn(
          msg: 'close bet record stream error',
          error: e,
          tag: 'BetRecordStore');
      return null;
    }
  }
}
