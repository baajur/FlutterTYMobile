import 'package:flutter_ty_mobile/core/error/exceptions.dart'
    show UnknownConditionException;
import 'package:flutter_ty_mobile/core/internal/local_strings.dart'
    show localeStr;
import 'package:generic_enum/generic_enum.dart';

import 'route_info.dart';
import 'router.gr.dart';

class RoutePage extends GenericEnum<RouteInfo> {
  const RoutePage._(RouteInfo info) : super(info);

  static RoutePage home = RoutePage._(RouteInfo(
    route: Routes.homeRoute,
    title: localeStr.pageTitleHome,
    isFeature: true,
    bottomNavIndex: 0,
    hideAppbarActions: false,
  ));

  static RoutePage login = RoutePage._(RouteInfo(
    route: Routes.loginRoute,
    title: localeStr.pageTitleLogin,
  ));

  static RoutePage register = RoutePage._(RouteInfo(
    route: Routes.registerRoute,
    title: localeStr.pageTitleRegister,
  ));

  static RoutePage promo = RoutePage._(RouteInfo(
    route: Routes.promoRoute,
    title: localeStr.pageTitlePromo,
    isFeature: true,
    bottomNavIndex: 2,
    hideAppbarActions: false,
  ));

  static RoutePage service = RoutePage._(RouteInfo(
    route: Routes.serviceRoute,
    title: localeStr.pageTitleService,
    bottomNavIndex: 3,
    hideAppbarActions: false,
  ));

  static RoutePage member = RoutePage._(RouteInfo(
    route: Routes.memberRoute,
    title: localeStr.pageTitleMember,
    isFeature: true,
    bottomNavIndex: 4,
  ));

  static RoutePage deposit = RoutePage._(RouteInfo(
    route: Routes.depositRoute,
    title: localeStr.pageTitleDeposit,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage depositWeb = RoutePage._(RouteInfo(
    route: Routes.depositWebPage,
    title: localeStr.pageTitleDeposit,
    parentRoute: Routes.depositRoute,
  ));

  static RoutePage transfer = RoutePage._(RouteInfo(
    route: Routes.transferRoute,
    title: localeStr.pageTitleMemberTransfer,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage bankcard = RoutePage._(RouteInfo(
    route: Routes.bankcardRoute,
    title: localeStr.pageTitleMemberCard,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage withdraw = RoutePage._(RouteInfo(
    route: Routes.bankcardRoute,
    title: localeStr.pageTitleMemberWithdraw,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage balance = RoutePage._(RouteInfo(
    route: Routes.balanceRoute,
    title: localeStr.pageTitleMemberBalance,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage wallet = RoutePage._(RouteInfo(
    route: Routes.walletRoute,
    title: localeStr.pageTitleMemberWallet,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage message = RoutePage._(RouteInfo(
    route: Routes.messageRoute,
    title: localeStr.pageTitleMemberMessage,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage center = RoutePage._(RouteInfo(
    route: Routes.centerRoute,
    title: localeStr.pageTitleMemberCenter,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage centerPassword = RoutePage._(RouteInfo(
    route: Routes.centerPasswordPage,
    title: localeStr.pageTitleMemberPassword,
    parentRoute: Routes.centerRoute,
  ));

  static RoutePage centerWeb = RoutePage._(RouteInfo(
    route: Routes.centerWebPage,
    title: localeStr.pageTitleMemberCenter,
    parentRoute: Routes.centerRoute,
  ));

  static RoutePage transaction = RoutePage._(RouteInfo(
    route: Routes.transactionRoute,
    title: localeStr.pageTitleMemberTransaction,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage betRecord = RoutePage._(RouteInfo(
    route: Routes.betRecordRoute,
    title: localeStr.pageTitleMemberBets,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage deals = RoutePage._(RouteInfo(
    route: Routes.dealsRoute,
    title: localeStr.pageTitleMemberDeals,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage flows = RoutePage._(RouteInfo(
    route: Routes.flowsRoute,
    title: localeStr.pageTitleMemberFlow,
    parentRoute: Routes.memberRoute,
  ));

  static RoutePage agent = RoutePage._(RouteInfo(
    route: Routes.agentRoute,
    title: localeStr.pageTitleMemberAgent,
    parentRoute: Routes.memberRoute,
    bottomNavIndex: 1,
  ));

  static RoutePage moreWeb = RoutePage._(RouteInfo(
    route: Routes.moreWebPage,
    title: '',
    parentRoute: Routes.homeRoute,
    showDrawer: true,
  ));

  /// side menu route
  static RoutePage downloadArea = RoutePage._(RouteInfo(
    route: Routes.downloadAreaRoute,
    title: localeStr.pageTitleDownload,
    showDrawer: true,
  ));

  static RoutePage noticeBoard = RoutePage._(RouteInfo(
    route: Routes.noticeRoute,
    title: localeStr.pageTitleNotice,
    showDrawer: true,
  ));

  static RoutePage sideWallet = RoutePage._(RouteInfo(
    route: Routes.walletRoute,
    title: localeStr.pageTitleMemberWallet,
    showDrawer: true,
  ));

  static RoutePage vipLevel = RoutePage._(RouteInfo(
    route: Routes.levelRoute,
    title: localeStr.pageTitleRank,
    showDrawer: true,
  ));

  static RoutePage pointStore = RoutePage._(RouteInfo(
    route: Routes.storeRoute,
    title: localeStr.pageTitleStore,
    showDrawer: true,
  ));

  /// test route
  static RoutePage template = RoutePage._(RouteInfo(
    route: Routes.templateRoute,
    title: 'Test Mobx',
  ));

  static RoutePage template2 = RoutePage._(RouteInfo(
    route: Routes.template2Route,
    title: 'Test Bloc',
  ));

  static RoutePage testArea = RoutePage._(RouteInfo(
    route: Routes.testAreaRoute,
    title: 'Test Widget',
  ));
}

extension RouterPageInfoExtension on RoutePage {
  String get page => value.route;
  String get pageTitle => value.title;
  String get pageRoot => value.parentRoute;
  bool get isFeature => value.isFeature;
  bool get hideBarAction => value.hideAppbarActions;
  int get navIndex => value.bottomNavIndex;
}

extension PagesNameExtension on String {
  /// Get route info by router name which generates in [Router.gr.dart]
  RoutePage get toRoutePage {
    print("asking route by name: $this");
    switch (this) {
      case '/':
      case Routes.homeRoute:
        return RoutePage.home;
      case Routes.loginRoute:
        return RoutePage.login;
      case Routes.agentRoute:
        return RoutePage.agent;
      case Routes.depositRoute:
        return RoutePage.deposit;
      case Routes.promoRoute:
        return RoutePage.promo;
      case Routes.serviceRoute:
        return RoutePage.service;
      case Routes.memberRoute:
        return RoutePage.member;
      case Routes.centerRoute:
        return RoutePage.center;
      case Routes.templateRoute:
        return RoutePage.template;
      case Routes.template2Route:
        return RoutePage.template2;
      case Routes.testAreaRoute:
        return RoutePage.testArea;
      default:
        throw UnknownConditionException();
    }
  }
}
