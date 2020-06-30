import 'package:flutter/widgets.dart' show IconData;
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/router/route_list_item.dart';
import 'package:flutter_ty_mobile/features/router/route_page.dart';
import 'package:generic_enum/generic_enum.dart';

export 'package:flutter_ty_mobile/features/router/route_list_item.dart';

class MoreGridItem extends GenericEnum<RouteListItem> {
  const MoreGridItem._(RouteListItem value) : super(value);

  static MoreGridItem notice = MoreGridItem._(RouteListItem(
    iconData: const IconData(0xf028, fontFamily: 'FontAwesome'),
    route: RoutePage.noticeBoard,
  ));
  static MoreGridItem download = MoreGridItem._(RouteListItem(
    iconData: const IconData(0xf0ed, fontFamily: 'FontAwesome'),
    route: RoutePage.downloadArea,
  ));
  static MoreGridItem tutorial = MoreGridItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleTutorial,
    iconData: const IconData(0xf059, fontFamily: 'FontAwesome'),
    route: RoutePage.moreWeb,
    webUrl: '${Global.CURRENT_SERVICE}newbie',
  ));
  static MoreGridItem service = MoreGridItem._(RouteListItem(
    iconData: const IconData(0xf025, fontFamily: 'FontAwesome'),
    route: RoutePage.service,
    webUrl: Global.TY_SERVICE_URL,
  ));
  static MoreGridItem routeChange = MoreGridItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleRouter,
    iconData: const IconData(0xf1eb, fontFamily: 'FontAwesome'),
  ));
  static MoreGridItem store = MoreGridItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleStore,
    iconData: const IconData(0xf290, fontFamily: 'FontAwesome'),
    isUserOnly: true,
    route: RoutePage.pointStore,
  ));
  static MoreGridItem roller = MoreGridItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleRoller,
    imageName: 'images/moreShow_lucky.png',
    isUserOnly: true,
  ));
  static MoreGridItem task = MoreGridItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleTask,
    imageName: 'images/moreShow_lucky.png',
    isUserOnly: true,
  ));
  static MoreGridItem agentAbout = MoreGridItem._(RouteListItem(
    replaceTitle: localeStr.pageTitleMemberAgentAbout,
    imageName: 'images/footer/ftico_agent.png',
    route: RoutePage.moreWeb,
    webUrl: '${Global.CURRENT_SERVICE}agentPage',
  ));
}
