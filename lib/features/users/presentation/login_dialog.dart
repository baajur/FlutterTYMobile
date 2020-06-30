import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_ty_mobile/features/users/presentation/login_route.dart';

class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      children: <Widget>[
        LoginRoute(
          returnHomeAfterLogin: true,
          isDialog: true,
        ),
      ],
    );
  }
}
