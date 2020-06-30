// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/temp/test_input_route.dart';
import 'package:flutter_ty_mobile/temp/test_nested_nav_screen_view.dart';
import 'package:flutter_ty_mobile/temp/test_permission_screen.dart';

abstract class TestRoutes {
  static const testScreenInnerView = '/test-screen-inner-view';
  static const testPermissionScreen = '/test-permission-screen';
  static const testInputRoute = '/test-input-route';
}

class TestRouter extends RouterBase {
  //This will probably be removed in future versions
  //you should call ExtendedNavigator.ofRouter<Router>() directly
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<TestRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case TestRoutes.testScreenInnerView:
        return CupertinoPageRoute<dynamic>(
          builder: (_) => TestNestedNavScreenView(),
          settings: settings,
        );
      case TestRoutes.testPermissionScreen:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TestPermissionScreen(),
          settings: settings,
        );
      case TestRoutes.testInputRoute:
        return MaterialPageRoute<dynamic>(
          builder: (_) => TestInputRoute(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
