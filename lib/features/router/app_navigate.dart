import 'dart:async' show StreamController;

import 'package:flutter_ty_mobile/core/internal/orientation_helper.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/platform_util.dart';

import 'route_info.dart';
import 'route_page.dart';
import 'route_user_streams.dart';
import 'router.gr.dart';
import 'screen_router.gr.dart';

export 'package:auto_route/auto_route.dart';

export 'route_info.dart';
export 'route_page.dart';
export 'router.gr.dart';
export 'screen_router.gr.dart';

///
/// Main Screen Navigation
///
class ScreenNavigate {
  static final String _tag = 'ScreenNavigate';
  static int screenIndex = 0;

  /// Switch to different screen, default is [ScreenRouter.featureScreen]
  /// Calls app restart if switch screen failed (UI will freeze).
  /// [web] = true, will open a fullscreen web page, use [webUrl] to pass the url.
  /// [force] = true, clean stack and push [ScreenRouter.featureScreen]
  static switchScreen({
    bool force = false,
    ScreenEnum screen,
    Object webUrl,
  }) {
    if (force) {
      // Router's failed safe
      MyLogger.warn(
        msg: 'force screen to switch, current screen: $screenIndex',
        tag: _tag,
      );
      try {
        if (screenIndex == 0)
          RouterNavigate.navigateClean();
        else
          ScreenRouter.navigator.pushFeatureScreen();
//          ScreenRouter.navigator.pushNamedAndRemoveUntil(
//            ScreenRoutes.featureScreen,
//            (route) => route.settings.name == ScreenRoutes.featureScreen,
//          );
      } catch (e) {
        MyLogger.error(
          msg: 'force screen to switch has exception, restarting app!!',
          error: e,
          tag: _tag,
        );
        // restart app
        Future.delayed(
            Duration(milliseconds: 200), () => PlatformUtil.restart());
      }
    } else {
      try {
        switch (screen) {
          case ScreenEnum.Game:
            ScreenRouter.navigator.pushWebGameScreen(startUrl: webUrl);
            // to hide only bottom bar:
            //        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
            // to hide only status bar:
            //        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
            // to hide both:
            OrientationHelper.setDisabledSystemUIOverlays();
            screenIndex = 1;
            break;
          case ScreenEnum.Test:
            ScreenRouter.navigator.pushTestScreen();
            screenIndex = 2;
            break;
          case ScreenEnum.TestNav:
            ScreenRouter.navigator.pushTestScreenNav();
            screenIndex = 2;
            break;
          case ScreenEnum.Feature:
          default:
            print('can pop screen: ${ScreenRouter.navigator.canPop()}');
            if (ScreenRouter.navigator.canPop())
              ScreenRouter.navigator.pop();
            else
              ScreenRouter.navigator.pushFeatureScreen();
            screenIndex = 0;
            break;
        }
      } catch (e) {
        MyLogger.error(
          msg: 'switch screen to $screen has exception!!',
          error: e,
          tag: _tag,
        );
        switchScreen(force: true);
      }
    }
    if (screenIndex != 1) {
      // Rotate to normal
      OrientationHelper.forceOrientationEasy();
      // restore the screen to normal SystemUiOverlay
      OrientationHelper.setEnabledSystemUIOverlays();
    }
  }
}

///
/// Feature Router Action class to switch between routes
///
class RouterNavigate {
  static final routerStreams = getRouteUserStreams;

  static final String _tag = 'RouterNavigate';
  static String _currentRoute = '/';
  static String _previousRoute = '/';

  static String get current => _currentRoute;

  static StreamController<RouteInfo> _routeInfo =
      StreamController<RouteInfo>.broadcast();

  static Stream<RouteInfo> get routeStream => _routeInfo.stream;

  static dispose() {
    MyLogger.warn(msg: 'disposing router stream!!', tag: _tag);
    _routeInfo.close();
  }

  /// Navigate to [page], and clean the stack if route is declared feature
  /// use [arg] to pass [page]'s arguments.
  static navigateToPage(RoutePage page, {Object arg}) {
    if (page.page == _currentRoute) return;
    if (page.page == Routes.homeRoute) {
      navigateClean();
      return;
    }
    try {
      if ((_currentRoute != Routes.homeRoute && page.isFeature)) {
        print('navigate feature, from:$_currentRoute to:${page.page}');
        Router.navigator.pushNamedAndRemoveUntil(
          page.page,
          (route) =>
              route.settings.name == page.page ||
              route.settings.name == Routes.homeRoute,
          arguments: arg,
        );
        _setPath(page.page, parentRoute: page.pageRoot);
      } else {
        print('navigate page, from:$_currentRoute to:${page.page}');
        Router.navigator.pushNamed(page.page, arguments: arg);
        _setPath(page.page);
      }
    } catch (e) {
      MyLogger.error(
          msg:
              'navigate to page has exception!! Router current: $_currentRoute, previous: $_previousRoute',
          error: e,
          tag: _tag);
    }
    _routeInfo.sink.add(page.value);
  }

  /// Pop the current page
  /// if pop action fails, will attempt to return to home screen.
  static navigateBack() {
    print('navigate back, current:$_currentRoute, previous: $_previousRoute, '
        'canPop: ${Router.navigator.canPop()}');
    try {
      if (ScreenNavigate.screenIndex != 0) {
        ScreenNavigate.switchScreen();
      } else if (_previousRoute == Routes.homeRoute) {
        navigateClean();
      } else if (Router.navigator.canPop()) {
        Router.navigator
            .popUntil((route) => route.settings.name == _previousRoute);
      }
    } catch (e) {
      MyLogger.error(
        msg: 'navigate back has exception!! '
            'Router current: $_currentRoute, previous: $_previousRoute',
        error: e,
        tag: _tag,
      );
      // switch to home screen
      ScreenNavigate.switchScreen(force: true);
    }

    var page = _previousRoute.toRoutePage;
    _setPath(page.page, parentRoute: page.pageRoot);
    _routeInfo.sink.add(page.value);
  }

  /// Navigate to [Router.homeRoute] and clean the stack
  static navigateClean({bool force = false}) {
    print('navigate to home, from:$_currentRoute');
    try {
      if (force && _currentRoute == Routes.homeRoute) {
        Router.navigator.pushReplacementNamed(Routes.homeRoute);
      } else if (_currentRoute != Routes.homeRoute) {
        Router.navigator.pushNamedAndRemoveUntil(
          Routes.homeRoute,
          (route) => route.settings.name == Routes.homeRoute,
        );
      }
      routerStreams.setCheck(true);
    } catch (e) {
      MyLogger.error(
          msg:
              'navigate clean has exception!! Router current: $_currentRoute, previous: $_previousRoute',
          error: e,
          tag: _tag);
    }
    _setPath(Routes.homeRoute, parentRoute: Routes.homeRoute);
//    print('update home app bar on clean');
    _routeInfo.sink.add(RoutePage.home.value);
  }

  static _setPath(String route, {String parentRoute = ''}) {
    _previousRoute = parentRoute.isEmpty ? _currentRoute : parentRoute;
    _currentRoute = route;
    print(
        'set navigate path, current:$_currentRoute, previous: $_previousRoute');
  }

  static resetCheckUser() => routerStreams.setCheck(false);

  static testNavigate(RoutePage page) {
    print('test navigate...page: ${page.value}');
    _setPath(page.page, parentRoute: page.pageRoot);
    _routeInfo.sink.add(page.value);
  }
}
