import 'package:flui/flui.dart' show FLToast;
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/hex_color.dart';
import 'package:flutter_ty_mobile/features/users/data/models/user_freezed.dart';

import '../../../general_route_widget_export.dart';

///@author H.C.CHIANG
///@version 2020/1/15
class UserDisplay extends StatelessWidget {
  final UserEntity user;
  final bool returnHome;
  final Color bgColor = HexColor.fromHex('#e8e8e8');

  UserDisplay({Key key, @required this.user, this.returnHome = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    getRouteUserStreams
        .updateUser(LoginStatus(loggedIn: true, currentUser: user));
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      var dismiss = FLToast.showLoading(
        text: localeStr.messageWelcomeUser(user.account),
      );
      Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
        try {
          dismiss();
          if (ScreenNavigate.screenIndex == 2)
            ScreenNavigate.switchScreen();
          else if (returnHome) {
            Navigator.pop(context);
            RouterNavigate.navigateClean(force: true);
          } else {
            RouterNavigate.navigateToPage(RoutePage.member);
          }
        } catch (e) {
          MyLogger.warn(
              msg: 'User Login Display has exception!!',
              error: e,
              tag: 'UserDisplay');
        }
      });
    });
    return SizedBox.shrink();
//    return Container(
//      color: bgColor,
//      constraints: BoxConstraints.tightFor(width: Global.device.width - 16),
//      child: Text(user.toString(), style: TextStyle(color: Colors.black87)),
//    );
  }
}
