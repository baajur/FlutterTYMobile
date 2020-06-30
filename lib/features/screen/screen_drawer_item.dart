import 'package:flutter/material.dart' show IconData, Icons;
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/router/route_list_item.dart';
import 'package:flutter_ty_mobile/features/router/route_page.dart';
import 'package:generic_enum/generic_enum.dart';

export 'package:flutter_ty_mobile/features/router/route_list_item.dart';

class ScreenDrawerItem extends GenericEnum<RouteListItem> {
  const ScreenDrawerItem._(RouteListItem value) : super(value);

  static ScreenDrawerItem home = ScreenDrawerItem._(RouteListItem(
    iconData: IconData(0xf015, fontFamily: 'FontAwesome'),
    route: RoutePage.home,
  ));
  static ScreenDrawerItem download = ScreenDrawerItem._(RouteListItem(
    iconData: IconData(0xf0ed, fontFamily: 'FontAwesome'),
    route: RoutePage.downloadArea,
  ));
  static ScreenDrawerItem tutorial = ScreenDrawerItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleTutorial,
    iconData: IconData(0xf059, fontFamily: 'FontAwesome'),
    route: RoutePage.moreWeb,
    webUrl: '${Global.CURRENT_SERVICE}newbie',
  ));
  static ScreenDrawerItem notice = ScreenDrawerItem._(RouteListItem(
    iconData: IconData(0xf028, fontFamily: 'FontAwesome'),
    route: RoutePage.noticeBoard,
  ));
  static ScreenDrawerItem wallet = ScreenDrawerItem._(RouteListItem(
    iconData: IconData(0xf155, fontFamily: 'FontAwesome'),
    route: RoutePage.wallet,
    isUserOnly: true,
  ));
  static ScreenDrawerItem vip = ScreenDrawerItem._(RouteListItem(
    replaceTitle: localeStr.centerViewTitleVip,
    iconData: IconData(0xf219, fontFamily: 'FontAwesome'),
  ));
  static ScreenDrawerItem store = ScreenDrawerItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleStore,
    iconData: IconData(0xf219, fontFamily: 'FontAwesome'),
    isUserOnly: true,
  ));
  static ScreenDrawerItem logout = ScreenDrawerItem._(RouteListItem(
    replaceTitle: localeStr.memberGridTitleLogout,
    iconData: IconData(0xf08b, fontFamily: 'FontAwesome'),
    isUserOnly: true,
  ));
  static ScreenDrawerItem testUI = ScreenDrawerItem._(RouteListItem(
    replaceTitle: 'Test UI',
    iconData: Icons.warning,
    route: RoutePage.testArea,
  ));
  static ScreenDrawerItem test = ScreenDrawerItem._(RouteListItem(
    replaceTitle: 'Test',
    iconData: Icons.warning,
  ));
}
