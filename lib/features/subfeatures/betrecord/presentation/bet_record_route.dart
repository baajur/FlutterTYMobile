import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/bet_record_store.dart';
import 'widgets/bet_record_display.dart';

class BetRecordRoute extends StatefulWidget {
  @override
  _BetRecordRouteState createState() => _BetRecordRouteState();
}

class _BetRecordRouteState extends State<BetRecordRoute> {
  BetRecordStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<BetRecordStore>();
    super.initState();
    // execute action on init
    _store.getTypes();
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
            Future.delayed(Duration(milliseconds: 200)).then(
              (value) => FLToast.showError(
                text: message,
                showDuration: ToastDuration.DEFAULT.value,
              ),
            );
          }
        },
      ),
      /* Reaction on bet record action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForRecordResponse,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait record: $wait');
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
    ];
  }

  @override
  void dispose() {
    try {
      _store.closeStreams();
      if (toastDismiss != null) {
        toastDismiss();
        toastDismiss = null;
      }
      _disposers.forEach((d) => d());
    } on Exception {}
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
            case BetRecordStoreState.initial:
              return SizedBox.shrink();
            case BetRecordStoreState.loading:
              return LoadingWidget();
            case BetRecordStoreState.loaded:
              return BetRecordDisplay(store: _store);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
