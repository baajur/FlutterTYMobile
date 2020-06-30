import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';

class LoginNavigate extends StatelessWidget {
  final bool returnHomePage;
  final bool closeDialog;

  LoginNavigate(this.returnHomePage, {this.closeDialog = false});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      var dismiss = FLToast.showLoading(
        text: localeStr.messageWelcomeUser(getRouteUserStreams.userName),
      );
      Future.delayed(Duration(milliseconds: 1500)).whenComplete(() {
        try {
          dismiss();
          if (ScreenNavigate.screenIndex == 2)
            ScreenNavigate.switchScreen();
          else if (returnHomePage) {
            if (closeDialog) Navigator.pop(context);
            RouterNavigate.navigateClean(force: true);
          } else {
            RouterNavigate.navigateToPage(RoutePage.member);
          }
        } catch (e) {
          MyLogger.warn(
            msg: 'Login Display has exception!!',
            error: e,
            tag: 'LoginDisplay',
          );
        }
      });
    });
    return SizedBox.shrink();
  }
}
