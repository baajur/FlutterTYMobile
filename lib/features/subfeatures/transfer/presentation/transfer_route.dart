import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/network/handler/request_status_freezed.dart';
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/widgets/loading_widget.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transfer/presentation/widgets/transfer_display.dart';
import 'package:flutter_ty_mobile/temp/blank_widget.dart';
import 'package:mobx/mobx.dart';

import '../../../../injection_container.dart' show sl;
import 'state/transfer_store.dart';

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
    _disposers.forEach((d) => d());
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('pop transfer route');
        RouterNavigate.navigateToPage(RoutePage.member);
        return Future(() => true);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Observer(
          // Observe using specific widget
          builder: (_) {
            switch (_store.state) {
              case TransferStoreState.initial:
                return BlankWidget();
              case TransferStoreState.loading:
                return LoadingWidget();
              case TransferStoreState.loaded:
                return TransferDisplay(store: _store);
              default:
                return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
