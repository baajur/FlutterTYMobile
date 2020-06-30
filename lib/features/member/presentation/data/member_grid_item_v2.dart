import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/router/route_list_item.dart';
import 'package:flutter_ty_mobile/features/router/route_page.dart';
import 'package:generic_enum/generic_enum.dart';

export 'package:flutter_ty_mobile/features/router/route_list_item.dart';

class MemberGridItemV2 extends GenericEnum<RouteListItem> {
  const MemberGridItemV2._(RouteListItem value) : super(value);

  static MemberGridItemV2 deposit = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_dsp.png',
    route: RoutePage.deposit,
    isUserOnly: true,
  ));
  static MemberGridItemV2 transfer = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_tsf.png',
    route: RoutePage.transfer,
    isUserOnly: true,
  ));
  static MemberGridItemV2 bankcard = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_bkcard.png',
    route: RoutePage.bankcard,
    isUserOnly: true,
  ));
  static MemberGridItemV2 withdraw = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_wdl.png',
    route: RoutePage.withdraw,
    isUserOnly: true,
  ));
  static MemberGridItemV2 balance = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_plaf.png',
    route: RoutePage.balance,
    isUserOnly: true,
  ));
  static MemberGridItemV2 wallet = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_tsfwa.png',
    route: RoutePage.wallet,
    isUserOnly: true,
  ));
  static MemberGridItemV2 stationMessages = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_msg.png',
    route: RoutePage.message,
    isUserOnly: true,
  ));
  static MemberGridItemV2 accountCenter = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_cent.png',
    route: RoutePage.center,
    isUserOnly: true,
  ));
  static MemberGridItemV2 transferRecord = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_tsfre.png',
    route: RoutePage.transaction,
    isUserOnly: true,
  ));
  static MemberGridItemV2 betRecord = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_bthis.png',
    route: RoutePage.betRecord,
    isUserOnly: true,
  ));
  static MemberGridItemV2 dealRecord = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_trans.png',
    route: RoutePage.deals,
    isUserOnly: true,
  ));
  static MemberGridItemV2 flowRecord = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_rolb.png',
    route: RoutePage.flows,
    isUserOnly: true,
  ));
  static MemberGridItemV2 agent = MemberGridItemV2._(RouteListItem(
    imageName: 'images/user/macico_agent.png',
    route: RoutePage.agent,
    isUserOnly: true,
  ));
  static MemberGridItemV2 logout = MemberGridItemV2._(RouteListItem(
    replaceTitle: localeStr.memberGridTitleLogout,
    imageName: 'images/user/macico_logout.png',
    isUserOnly: true,
  ));
}
