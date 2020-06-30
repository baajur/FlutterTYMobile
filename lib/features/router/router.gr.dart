// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_ty_mobile/features/home/presentation/home_route.dart';
import 'package:flutter_ty_mobile/features/users/presentation/login_route.dart';
import 'package:flutter_ty_mobile/features/web/web_route.dart';
import 'package:flutter_ty_mobile/features/member/presentation/member_route.dart';
import 'package:flutter_ty_mobile/features/promo/presentation/promo_route.dart';
import 'package:flutter_ty_mobile/features/subfeatures/deposit/presentation/deposit_route.dart';
import 'package:flutter_ty_mobile/template/mobx/presentation/template_route.dart';
import 'package:flutter_ty_mobile/template/page/presentation/template2_route.dart';

abstract class Routes {
  static const homeRoute = '/';
  static const loginRoute = '/login-route';
  static const serviceRoute = '/service-route';
  static const memberRoute = '/member-route';
  static const promoRoute = '/promo-route';
  static const depositRoute = '/deposit-route';
  static const depositWebRoute = '/deposit-web-route';
  static const templateRoute = '/template-route';
  static const template2Route = '/template2-route';
}

class Router extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.homeRoute:
        if (hasInvalidArgs<HomeRouteArguments>(args)) {
          return misTypedArgsRoute<HomeRouteArguments>(args);
        }
        final typedArgs = args as HomeRouteArguments ?? HomeRouteArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => HomeRoute(key: typedArgs.key),
          settings: settings,
        );
      case Routes.loginRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => LoginRoute(),
          settings: settings,
        );
      case Routes.serviceRoute:
        if (hasInvalidArgs<WebRouteArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<WebRouteArguments>(args);
        }
        final typedArgs = args as WebRouteArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => WebRoute(startUrl: typedArgs.startUrl),
          settings: settings,
        );
      case Routes.memberRoute:
        if (hasInvalidArgs<MemberRouteArguments>(args)) {
          return misTypedArgsRoute<MemberRouteArguments>(args);
        }
        final typedArgs =
            args as MemberRouteArguments ?? MemberRouteArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => MemberRoute(key: typedArgs.key),
          settings: settings,
        );
      case Routes.promoRoute:
        if (hasInvalidArgs<PromoRouteArguments>(args)) {
          return misTypedArgsRoute<PromoRouteArguments>(args);
        }
        final typedArgs = args as PromoRouteArguments ?? PromoRouteArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => PromoRoute(openPromoId: typedArgs.openPromoId),
          settings: settings,
        );
      case Routes.depositRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => DepositRoute(),
          settings: settings,
        );
      case Routes.depositWebRoute:
        if (hasInvalidArgs<WebRouteArguments>(args, isRequired: true)) {
          return misTypedArgsRoute<WebRouteArguments>(args);
        }
        final typedArgs = args as WebRouteArguments;
        return MaterialPageRoute<dynamic>(
          builder: (_) => WebRoute(startUrl: typedArgs.startUrl),
          settings: settings,
        );
      case Routes.templateRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TemplateRoute(),
          settings: settings,
          fullscreenDialog: true,
        );
      case Routes.template2Route:
        return MaterialPageRoute<dynamic>(
          builder: (_) => Template2Route(),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//HomeRoute arguments holder class
class HomeRouteArguments {
  final Key key;
  HomeRouteArguments({this.key});
}

//WebRoute arguments holder class
class WebRouteArguments {
  final String startUrl;
  WebRouteArguments({@required this.startUrl});
}

//MemberRoute arguments holder class
class MemberRouteArguments {
  final Key key;
  MemberRouteArguments({this.key});
}

//PromoRoute arguments holder class
class PromoRouteArguments {
  final int openPromoId;
  PromoRouteArguments({this.openPromoId = -1});
}
