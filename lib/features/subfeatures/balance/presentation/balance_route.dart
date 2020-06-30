import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/balance_store.dart';
import 'widgets/balance_display.dart';

class BalanceRoute extends StatefulWidget {
  @override
  _BalanceRouteState createState() => _BalanceRouteState();
}

class _BalanceRouteState extends State<BalanceRoute> {
  BalanceStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<BalanceStore>();
    super.initState();
    // execute action on init
    _store.getPromises();
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
        (String message) {
          if (message != null && message.isNotEmpty) {
            Future.delayed(Duration(milliseconds: 200)).then((value) {
              FLToast.showError(
                text: message,
                showDuration: ToastDuration.DEFAULT.value,
              );
            });
          }
        },
      ),
      /* Reaction on new transfer action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForTransferResult,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait transfer: $wait');
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
      /* Reaction on transfer result changed */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.transferResult,
        // Run some logic with the content of the observed field
        (RequestStatusModel result) {
          print('reaction on transfer result: $result');
          if (result == null) return;
          if (result.isSuccess) {
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
    if (toastDismiss != null) {
      toastDismiss();
      toastDismiss = null;
    }
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case BalanceStoreState.initial:
              return SizedBox.shrink();
            case BalanceStoreState.loading:
              return LoadingWidget();
            case BalanceStoreState.loaded:
              return BalanceDisplay(_store);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
