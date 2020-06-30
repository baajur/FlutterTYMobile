import 'package:after_layout/after_layout.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/home/presentation/widgets/home_store_inherit_widget.dart';

import 'state/home_store.dart';
import 'widgets/home_display.dart';

///
/// Main View of [Router.homeRoute]
/// @author H.C.CHIANG
/// @version 2020/6/18
///
class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> with AfterLayoutMixin {
  HomeStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

  @override
  void initState() {
    _store ??= sl.get<HomeStore>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
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
      /* Reaction on wait game url */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForGameUrl,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait game url: $wait');
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
      /* Reaction on game url retrieved */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.gameUrl,
        // Run some logic with the content of the observed field
        (String url) {
          if (url != null && url.isNotEmpty) {
            MyLogger.info(msg: 'opening game: $url', tag: 'HomeRoute');
            Future.delayed(Duration(milliseconds: 300), () {
              _store.clearGameUrl();
              ScreenNavigate.switchScreen(
                screen: ScreenEnum.Game,
                webUrl: '$url',
              );
            });
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
      alignment: Alignment.topCenter,
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          switch (_store.state) {
            case HomeStoreState.loading:
              return LoadingWidget();
            case HomeStoreState.loaded:
              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(), // user can't scroll
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(Size(
                    Global.device.width,
                    Global.device.featureContentHeight,
                  )),
                  child: IntrinsicHeight(
                    child: HomeStoreInheritedWidget(
                      store: _store,
                      child: HomeDisplay(),
                    ),
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

  @override
  void afterFirstLayout(BuildContext context) {
    _store.getInitializeData();
  }
}
