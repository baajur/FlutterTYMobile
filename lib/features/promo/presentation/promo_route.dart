import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';

import 'state/promo_store.dart';
import 'widgets/promo_display.dart';

///
/// Main View of [Router.promoRoute]
///@author H.C.CHIANG
///@version 2020/6/9
///
class PromoRoute extends StatefulWidget {
  final int openPromoId;

  PromoRoute({this.openPromoId = -1});

  @override
  _PromoRouteState createState() => _PromoRouteState();
}

class _PromoRouteState extends State<PromoRoute> {
  PromoStore _store;
  List<ReactionDisposer> _disposers;

  @override
  void initState() {
    _store ??= sl.get<PromoStore>();
    super.initState();
    _store.getPromoList();
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
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Observer(
        builder: (_) {
          switch (_store.state) {
            case PromoStoreState.loading:
              return LoadingWidget();
            case PromoStoreState.loaded:
              return PromoDisplay(_store.promos,
                  showPromoId: widget.openPromoId);
            default:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
