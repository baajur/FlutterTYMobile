import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/widgets/loading_widget.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/data/models/withdraw_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/presentation/widgets/bankcard_display_card.dart';
import 'package:flutter_ty_mobile/features/subfeatures/bankcard/presentation/widgets/withdraw_display_view.dart';
import 'package:mobx/mobx.dart';

import '../../../../../injection_container.dart' show sl;
import '../../data/models/bankcard_model.dart';
import '../state/withdraw_store.dart';
import '../state/bankcard_store.dart';

class WithdrawDisplay extends StatefulWidget {
  final BankcardStore bankcardStore;
  final BankcardModel bankcard;

  WithdrawDisplay({this.bankcardStore, this.bankcard});

  @override
  _WithdrawDisplayState createState() => _WithdrawDisplayState();
}

class _WithdrawDisplayState extends State<WithdrawDisplay> {
  WithdrawStore _store;
  Function toastDismiss;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<WithdrawStore>();
    super.initState();
    _store.getCgpWallet();
    _store.getCpwWallet();
    _store.getRollback();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
        (String msg) {
          if (msg != null && msg.isNotEmpty) {
            FLToast.showError(
              text: msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
          }
        },
      ),
      /* Reaction on withdraw action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForWithdrawResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('withdraw wait: $wait');
          if (wait) {
            toastDismiss = FLToast.showLoading(
              text: localeStr.messageWait,
            );
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
          }
        },
      ),
      /* Reaction on deposit result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.withdrawResult,
        // Run some logic with the content of the observed field
        (WithdrawModel result) {
          print('withdraw result: $result');
          if (result == null) return;
          if (result.code == 0) {
            FLToast.showSuccess(
              text: result.msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
          } else {
            FLToast.showError(
              text: result.msg,
              showDuration: ToastDuration.DEFAULT.value,
            );
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case WithdrawStoreState.initial:
              return SizedBox.shrink();
            case WithdrawStoreState.loading:
              return Center(child: LoadingWidget());
            case WithdrawStoreState.loaded:
              return Container(
                constraints: BoxConstraints(
                  maxWidth: Global.device.width - 12,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      BankcardDisplayCard(
                        store: widget.bankcardStore,
                        bankcard: widget.bankcard,
                        nested: true,
                      ),
                      WithdrawDisplayView(store: _store),
                    ],
                  ),
                ),
              );
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
