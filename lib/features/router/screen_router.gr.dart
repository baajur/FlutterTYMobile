// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/screen/feature_screen.dart';
import 'package:flutter_ty_mobile/features/screen/web_game_screen.dart';
import 'package:flutter_ty_mobile/temp/test_nested_nav_screen.dart';
import 'package:flutter_ty_mobile/temp/test_screen.dart';

export 'screen_router.dart' show ScreenEnum;

abstract class ScreenRoutes {
  static const featureScreen = '/';
  static const webGameScreen = '/web-game-screen';
  static const testScreen = '/test-screen';
  static const testScreenNav = '/test-screen-nav';
}

class ScreenRouter extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<ScreenRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case ScreenRoutes.featureScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => FeatureScreen(),
          settings: settings,
          maintainState: true,
        );
      case ScreenRoutes.webGameScreen:
        if (hasInvalidArgs<WebGameScreenArguments>(args)) {
          return misTypedArgsRoute<WebGameScreenArguments>(args);
        }
        final typedArgs =
            args as WebGameScreenArguments ?? WebGameScreenArguments();
        return MaterialPageRoute<dynamic>(
          builder: (_) => WebGameScreen(startUrl: typedArgs.startUrl),
          settings: settings,
        );
      case ScreenRoutes.testScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TestScreen(),
          settings: settings,
        );
      case ScreenRoutes.testScreenNav:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TestNestedNavScreen(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//WebGameScreen arguments holder class
class WebGameScreenArguments {
  final String startUrl;
  WebGameScreenArguments({this.startUrl = 'https://eg990.com/'});
}

//**************************************************************************
// Navigation helper methods extension
//***************************************************************************

extension ScreenRouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushFeatureScreen() => ScreenRouter.navigator.pushNamedAndRemoveUntil(
        ScreenRoutes.featureScreen,
        (route) => route.settings.name == ScreenRoutes.featureScreen,
      );
  Future pushWebGameScreen({
    String startUrl = 'https://eg990.com/',
  }) =>
      pushNamed(
        ScreenRoutes.webGameScreen,
        arguments: WebGameScreenArguments(startUrl: startUrl),
      );
  Future pushTestScreen() => pushNamed(ScreenRoutes.testScreen);
  Future pushTestScreenNav() => pushNamed(ScreenRoutes.testScreenNav);
}
