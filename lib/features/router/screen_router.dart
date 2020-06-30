import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_ty_mobile/temp/test_nested_nav_screen.dart';
import 'package:flutter_ty_mobile/temp/test_screen.dart';

import '../screen/feature_screen.dart';
import '../screen/web_game_screen.dart';

@MaterialAutoRouter(generateNavigationHelperExtension: true)
class $ScreenRouter {
  @MaterialRoute(initial: true, maintainState: true)
  FeatureScreen featureScreen;

  WebGameScreen webGameScreen;
  TestScreen testScreen;
  TestNestedNavScreen testScreenNav;
}

enum ScreenEnum { Feature, Game, Test, TestNav }
