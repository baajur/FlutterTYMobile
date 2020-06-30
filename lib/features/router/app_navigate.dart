import 'dart:async' show StreamController;

import 'package:auto_route/auto_route.dart';
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

  static ExtendedNavigatorState get screenNavigator =>
      ExtendedNavigator.ofRouter<ScreenRouter>();

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
          screenNavigator.pushFeatureScreen();
//          screenNavigator.pushNamedAndRemoveUntil(
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
            screenNavigator.pushWebGameScreen(startUrl: webUrl);
            // to hide only bottom bar:
            //        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
            // to hide only status bar:
            //        SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
            // to hide both:
            OrientationHelper.disabledSystemUIOverlays();
            screenIndex = 1;
            break;
          case ScreenEnum.Test:
            screenNavigator.pushTestScreen();
            screenIndex = 2;
            break;
          case ScreenEnum.TestNav:
            screenNavigator.pushTestScreenNav();
            screenIndex = 2;
            break;
          case ScreenEnum.Feature:
          default:
            print('can pop screen: ${screenNavigator.canPop()}');
            if (screenNavigator.canPop())
              screenNavigator.pop();
            else
              screenNavigator.pushFeatureScreen();
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
      print('restoring screen orientation...');
      OrientationHelper.restoreUI();
    }
  }
}

///
/// Feature Router Action class to switch between routes
///
class RouterNavigate {
  static final routerStreams = getRouteUserStreams;

  static final String _tag = 'RouterNavigate';
  // TODO should replace with navigator stack or observer
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

  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<Router>();

  /// Navigate to [page], and clean the stack if route is declared feature
  /// use [arg] to pass [page]'s arguments.
  static navigateToPage(RoutePage page, {Object arg}) {
    if (page.page == _currentRoute) {
      MyLogger.info(
          msg: 'should be on the same page. '
              'current: $_currentRoute, request: ${page.page}',
          tag: _tag);
      return;
    }
    if (page.page == Routes.homeRoute) {
      navigateClean();
      return;
    }
    try {
      if ((_currentRoute != Routes.homeRoute && page.isFeature)) {
        print('navigate feature, from:$_currentRoute to:${page.page}');
        navigator.pushNamedAndRemoveUntil(
          page.page,
          (route) =>
              route.settings.name == page.page ||
              route.settings.name == Routes.homeRoute,
          arguments: arg,
        );
        _setPath(page.page,
            parentRoute:
                (current != Routes.memberRoute) ? page.pageRoot : current);
      } else {
        print('navigate page, from:$_currentRoute to:${page.page}');
        navigator.pushNamed(page.page, arguments: arg);
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

  static replacePage(RoutePage page, {Object arg}) {
    try {
      navigator.pushReplacementNamed(page.page, arguments: arg);
      _setPath(page.page,
          parentRoute:
              (current != Routes.memberRoute) ? page.pageRoot : current);
    } catch (e) {
      MyLogger.warn(
          msg:
              'replace page has exception!! Router current: $_currentRoute, previous: $_previousRoute',
          error: e,
          tag: _tag);
      navigateClean();
      navigateToPage(page, arg: arg);
    }
    _routeInfo.sink.add(page.value);
  }

  /// Pop the current page
  /// if pop action fails, will attempt to return to home screen.
  static navigateBack() async {
    bool isFeature;
    try {
      isFeature = _currentRoute.toRoutePage.isFeature;
    } catch (e) {
      isFeature = false;
    }
    print('navigate back, current:$_currentRoute, previous: $_previousRoute, '
        'canPop: ${navigator.canPop()}, isFeature: $isFeature');
    try {
      if (ScreenNavigate.screenIndex != 0) {
        ScreenNavigate.switchScreen();
      } else if (_previousRoute == Routes.homeRoute) {
        navigateClean();
        return;
      } else if (isFeature) {
        navigateToPage(_previousRoute.toRoutePage);
        return;
      } else if (navigator.canPop()) {
        try {
          navigator.popUntil((route) => route.settings.name == _previousRoute);
        } catch (e) {
          navigator.popAndPushNamed(_previousRoute);
        }
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
        navigator.pushReplacementNamed(Routes.homeRoute);
      } else if (_currentRoute != Routes.homeRoute) {
        navigator.pushNamedAndRemoveUntil(
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

  static updateRoute(RoutePage page) {
    _routeInfo.sink.add(page.value);
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
