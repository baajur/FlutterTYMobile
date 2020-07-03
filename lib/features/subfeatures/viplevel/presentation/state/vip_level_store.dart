import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/viplevel/data/models/vip_level_model.dart';

import '../../data/repository/vip_repository.dart';

part 'vip_level_store.g.dart';

class VipLevelStore = _VipLevelStore with _$VipLevelStore;

enum VipLevelStoreState { initial, loading, loaded }

abstract class _VipLevelStore with Store {
  final VipLevelRepository _repository;

  _VipLevelStore(this._repository);

  @observable
  ObservableFuture<Either<Failure, VipLevelModel>> _levelFuture;

  VipLevelModel levelModel;

  @observable
  String errorMessage;

  @computed
  VipLevelStoreState get state {
    // If the user has not yet triggered a action or there has been an error
    if (_levelFuture == null || _levelFuture.status == FutureStatus.rejected) {
      return VipLevelStoreState.initial;
    }
    // Pending Future means "loading"
    // Fulfilled Future means "loaded"
    return _levelFuture.status == FutureStatus.pending
        ? VipLevelStoreState.loading
        : VipLevelStoreState.loaded;
  }

  @action
  Future<void> getLevel() async {
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      // Fetch from the repository and wrap the regular Future into an observable.
      _levelFuture = ObservableFuture(_repository.getLevel());
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _levelFuture.then((result) {
//        print('vip level result: $result');
        result.fold(
          (failure) => errorMessage = failure.message,
          (model) => levelModel = model,
        );
      });
    } on Exception {
      //errorMessage = "Couldn't fetch description. Is the device online?";
      errorMessage = Failure.internal(FailureCode()).message;
    }
  }
}
