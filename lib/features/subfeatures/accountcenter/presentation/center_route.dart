import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/general_route_widget_export.dart';

import 'state/center_store.dart';
import 'widgets/center_store_inherit_widget.dart';
import 'widgets/center_display.dart';

class CenterRoute extends StatefulWidget {
  @override
  _CenterRouteState createState() => _CenterRouteState();
}

class _CenterRouteState extends State<CenterRoute> {
  final GlobalKey routeKey = new GlobalKey();
  CenterStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<CenterStore>();
    super.initState();
    // execute action on init
    _store.getAccount();
  }

  @override
  void didChangeDependencies() {
    print('center didChangeDependencies');
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
      /* Reaction on wait response change */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForResponse,
        // Run some logic with the content of the observed field
        (bool wait) {
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
      /* Reaction on request response change */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.requestResponse,
        // Run some logic with the content of the observed field
        (response) {
          if (response.isSuccess) {
            switch (_store.currentRequest) {
              case CenterStoreAction.birth:
              case CenterStoreAction.email:
              case CenterStoreAction.wechat:
              case CenterStoreAction.lucky:
                FLToast.showSuccess(
                  text: localeStr
                      .messageTaskSuccess(localeStr.centerTextButtonBind),
                  showDuration: ToastDuration.DEFAULT.value,
                );
                break;
              case CenterStoreAction.password:
                FLToast.showSuccess(
                  text: localeStr
                      .messageTaskSuccess(localeStr.centerTextButtonEdit),
                  showDuration: ToastDuration.DEFAULT.value,
                );
                RouterNavigate.navigateBack();
                break;
              case CenterStoreAction.verify_request:
              case CenterStoreAction.verify:
                FLToast.showSuccess(
                  text: response.msg,
                  showDuration: ToastDuration.DEFAULT.value,
                );
                break;
            }
          } else {
            switch (_store.currentRequest) {
              case CenterStoreAction.birth:
              case CenterStoreAction.email:
              case CenterStoreAction.wechat:
              case CenterStoreAction.lucky:
                FLToast.showError(
                  text:
                      '${localeStr.messageTaskFailed(localeStr.centerTextButtonBind)}: ${response.msg}',
                  showDuration: ToastDuration.DEFAULT.value,
                );
                break;
              case CenterStoreAction.password:
                FLToast.showError(
                  text: localeStr
                      .messageTaskFailed(localeStr.centerTextButtonEdit),
                  showDuration: ToastDuration.DEFAULT.value,
                );
                break;
              case CenterStoreAction.verify_request:
              case CenterStoreAction.verify:
                FLToast.showError(
                  text: response.msg,
                  showDuration: ToastDuration.DEFAULT.value,
                );
                break;
            }
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    try {
      _store.closeStreams();
      _disposers.forEach((d) => d());
    } on Exception {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('pop center route');
        RouterNavigate.navigateBack();
        return Future(() => true);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: CenterStoreInheritedWidget(
          key: routeKey,
          store: _store,
          child: Observer(
            // Observe using specific widget
            builder: (_) {
              switch (_store.state) {
                case CenterStoreState.initial:
                  return SizedBox.shrink();
                case CenterStoreState.loading:
                  return LoadingWidget();
                case CenterStoreState.loaded:
                  return CenterDisplay();
                default:
                  return SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }
}
