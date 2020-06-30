import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_ty_mobile/features/general/bloc_widget_export.dart';
import 'package:flutter_ty_mobile/features/member/presentation/widgets/member_display.dart';

import '../../../injection_container.dart' show sl;
import 'state/member_credit_store.dart';

/// Main View of [Router.memberRoute]
/// @author H.C.CHIANG
/// @version 2020/5/15
class MemberRoute extends StatefulWidget {
  MemberRoute({Key key}) : super(key: key);

  @override
  _MemberRouteState createState() => _MemberRouteState();
}

class _MemberRouteState extends State<MemberRoute> {
  MemberCreditStore _store;

  @override
  void initState() {
    _store ??= sl.get<MemberCreditStore>();
    _store.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Observer(
        // Observe using specific widget
        builder: (_) {
          print('member observe user: ${_store.user}');
          if (_store.user != null)
            return MemberDisplay(_store);
          else
            return LoadingWidget();
        },
      ),
    );
  }
}
