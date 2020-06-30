import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart'
    show BankcardRouteArguments, RoutePage, RouterNavigate;
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/features/user/data/entity/login_status.dart';
import 'package:flutter_ty_mobile/features/user/login/presentation/login_route.dart';
import 'package:flutter_ty_mobile/res.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';

/// Creates a widget to show member info under Marquee
///@author H.C.CHIANG
///@version 2020/2/13
class MemberWidget extends StatefulWidget {
  MemberWidget({Key key}) : super(key: key);

  @override
  MemberWidgetState createState() => MemberWidgetState();
}

class MemberWidgetState extends State<MemberWidget> {
  double _areaHeight;
  LoginStatus _userData;

  void updateUser() {
    print('updating member area data...');
    print('streamed user: ${getRouteUserStreams.userStream.toList()}');
    setState(() {
      _userData = getRouteUserStreams.lastUser;
      print('member area user: $_userData');
    });
  }

  void toastLogin() {
    FLToast.showInfo(
      text: localeStr.messageErrorNotLogin,
      showDuration: ToastDuration.DEFAULT.value,
    );
  }

  @override
  void initState() {
    _areaHeight = Global.device.height / 10.5;
    _userData = getRouteUserStreams.lastUser;
    print('updating member area height: $_areaHeight');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: Container(
        /* Outside border */
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: Themes.defaultAccentColor,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          color: Themes.defaultAppbarColor,
        ),
        /* Area frame */
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Themes.defaultAccentColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.0),
                  ),
                ),
                /* Area title message */
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 2.0, 12.0, 6.0),
                      child: Text(
                        (_userData.loggedIn)
                            ? localeStr.homeHintWelcome
                            : localeStr.homeHintWelcomeLogin,
                        style: TextStyle(
                            color: Themes.defaultTextColorBlack,
                            fontSize: (Global.device.height > 700)
                                ? FontSize.NORMAL.value + 1
                                : FontSize.NORMAL.value),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              /* Area Content */
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(6.0),
                  ),
                ),
                child: _buildMemberArea(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberArea() {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 6.0),
          child: _buildLeftContent(),
        ),
        VerticalDivider(
          thickness: 2.0,
          color: Themes.defaultAccentColor,
        ),
        _buildRightContent(),
      ],
    );
  }

  Widget _buildLeftContent() {
    if (_userData.loggedIn == false) {
      return Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
          minWidth: Global.device.width / 3,
        ),
        child: RaisedButton(
          /// if not logged in, show a login button
          child: Text(
            localeStr.pageTitleLogin2,
            style: TextStyle(
              color: Themes.defaultAccentColor,
              fontSize: FontSize.NORMAL.value,
            ),
          ),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Themes.defaultAccentColor),
            borderRadius: BorderRadius.circular(4.0),
          ),
          color: Themes.defaultAppbarColor,
          visualDensity: VisualDensity(horizontal: 4.0),
          onPressed: () => showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) => new LoginRoute(
              returnHomeAfterLogin: true,
              isDialog: true,
            ),
          ),
        ),
      );
    } else {
      double textSize = (_userData.currentUser.account.length > 10)
          ? FontSize.NORMAL.value - 1
          : FontSize.NORMAL.value;
      double availableWidth = Global.device.width / 3;
      double textMinWidth = FontSize.NORMAL.value * 6;
      double textMaxWidth = FontSize.NORMAL.value * 9.5;
      if (textMinWidth < availableWidth) textMinWidth = availableWidth;
      if (textMaxWidth < textMinWidth) textMaxWidth = textMinWidth;
      return Container(
        /// if logged in, show member info
        padding: EdgeInsets.only(left: 4.0),
        constraints: BoxConstraints(
          minWidth: textMinWidth,
          maxWidth: textMaxWidth,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: RichText(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '${_userData.currentUser.account}\r',
                      style: TextStyle(
                        color: Themes.defaultAccentColor,
                        fontSize: textSize,
                      ),
                    ),
                    TextSpan(
                      text: localeStr.homeHintWelcome,
                      style: TextStyle(fontSize: textSize),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: RichText(
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: localeStr.homeHintMemberCreditLeft),
                    TextSpan(
                      text: formatValue(_userData.currentUser.credit,
                          floorIfInt: true, creditSign: true),
                      style: TextStyle(
                        color: Themes.defaultAccentColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildRightContent() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(top: 6.0, bottom: 2.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _createIconButton(
              Res.homeMemberAreaIconDeposit,
              localeStr.pageTitleDeposit,
              () {
                (_userData.loggedIn)
                    ? RouterNavigate.navigateToPage(RoutePage.deposit)
                    : toastLogin();
              },
            ),
            _createIconButton(
              Res.homeMemberAreaIconWithdraw,
              localeStr.pageTitleMemberWithdraw,
              () {
                (_userData.loggedIn)
                    ? RouterNavigate.navigateToPage(
                        RoutePage.withdraw,
                        arg: BankcardRouteArguments(withdraw: true),
                      )
                    : toastLogin();
              },
            ),
            _createIconButton(
              Res.homeMemberAreaIconTransfer,
              localeStr.pageTitleMemberTransfer,
              () {
                (_userData.loggedIn)
                    ? RouterNavigate.navigateToPage(RoutePage.transfer)
                    : toastLogin();
              },
            ),
            _createIconButton(
              Res.homeMemberAreaIconVip,
              'VIP',
              () => FLToast.showInfo(text: localeStr.workInProgress),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createIconButton(String urlIconName, String label, Function func) {
    return GestureDetector(
      onTap: func,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ConstrainedBox(
            constraints:
                BoxConstraints.tightFor(height: (_areaHeight > 70) ? 30 : 24),
            child: networkImageBuilder(urlIconName),
          ),
          Text(
            label,
            style: TextStyle(
              color: Themes.defaultTextColor,
              fontSize: FontSize.NORMAL.value,
            ),
          ),
        ],
      ),
    );
  }
}
