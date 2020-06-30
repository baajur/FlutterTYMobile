import 'package:flutter_ty_mobile/core/store_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/data/enum/transaction_date_enum.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/data/models/transaction_model.dart';

import '../../data/repository/transaction_repository.dart';

part 'transaction_store.g.dart';

class TransactionStore = _TransactionStore with _$TransactionStore;

abstract class _TransactionStore with Store {
  final TransactionRepository _repository;

  _TransactionStore(this._repository);

  TransactionModel dataModel;

  @observable
  List<TransactionData> dataList;

  @observable
  bool waitForPageData = false;

  @observable
  String errorMessage;

  @action
  Future getRecord({
    int page = 1,
    TransactionDateSelected selection = TransactionDateSelected.all,
  }) async {
    print('waiting: $waitForPageData');
    if (waitForPageData) return;
    try {
      // Reset the possible previous error message.
      errorMessage = null;
      waitForPageData = true;
      // ObservableFuture extends Future - it can be awaited and exceptions will propagate as usual.
      await _repository
          .getDataModel(page, selection)
          .then(
            (result) => result.fold(
              (failure) => errorMessage = failure.message,
              (model) {
                print('transaction data result: $model');
                dataModel = model;
                dataList = model.data;
              },
            ),
          )
          .whenComplete(() => waitForPageData = false);
    } on Exception {
      waitForPageData = false;
      errorMessage =
          Failure.internal(FailureCode(typeCode: FailureTypeCode.TRANSACTIONS))
              .message;
    }
  }
}
