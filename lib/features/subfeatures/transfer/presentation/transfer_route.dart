import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_model.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/transfer_store.dart';
import 'widgets/transfer_display.dart';

class TransferRoute extends StatefulWidget {
  @override
  _TransferRouteState createState() => _TransferRouteState();
}

class _TransferRouteState extends State<TransferRoute> {
  TransferStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<TransferStore>();
    super.initState();
    // execute action on init
    _store.getPlatforms();
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
    _store.closeStreams();
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
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case TransferStoreState.initial:
              return SizedBox.shrink();
            case TransferStoreState.loading:
              return LoadingWidget();
            case TransferStoreState.loaded:
              return TransferDisplay(store: _store);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
