import 'package:flutter/material.dart' show IconData, Icons;
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/router/route_list_item.dart';
import 'package:flutter_ty_mobile/features/router/route_page.dart';
import 'package:generic_enum/generic_enum.dart';

export 'package:flutter_ty_mobile/features/router/route_list_item.dart';

class ScreenNavigationBarItem extends GenericEnum<RouteListItem> {
  const ScreenNavigationBarItem._(RouteListItem value) : super(value);

  static ScreenNavigationBarItem home = ScreenNavigationBarItem._(RouteListItem(
    iconData: const IconData(0xf015, fontFamily: 'FontAwesome'),
    route: RoutePage.home,
  ));
  static ScreenNavigationBarItem deposit =
      ScreenNavigationBarItem._(RouteListItem(
    iconData: const IconData(0xf09d, fontFamily: 'FontAwesome'),
    route: RoutePage.deposit,
    isUserOnly: true,
  ));
  static ScreenNavigationBarItem agent =
      ScreenNavigationBarItem._(RouteListItem(
    iconData: const IconData(0xf2b5, fontFamily: 'FontAwesome'),
    route: RoutePage.agent,
    isUserOnly: true,
  ));
  static ScreenNavigationBarItem promo =
      ScreenNavigationBarItem._(RouteListItem(
    iconData: const IconData(0xf06b, fontFamily: 'FontAwesome'),
    route: RoutePage.promo,
  ));
  static ScreenNavigationBarItem service =
      ScreenNavigationBarItem._(RouteListItem(
    iconData: const IconData(0xf27a, fontFamily: 'FontAwesome'),
    route: RoutePage.service,
    webUrl: Global.TY_SERVICE_URL,
  ));
  static ScreenNavigationBarItem member =
      ScreenNavigationBarItem._(RouteListItem(
    iconData: const IconData(0xf2bd, fontFamily: 'FontAwesome'),
    route: RoutePage.member,
    isUserOnly: true,
  ));
  static ScreenNavigationBarItem more = ScreenNavigationBarItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleMore,
    iconData: Icons.more_horiz,
  ));
}
