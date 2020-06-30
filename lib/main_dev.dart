import 'package:reflectable/reflectable.dart';

import 'env/environment.dart';
import 'main_common.dart';
import 'main_dev.reflectable.dart';

Future<void> main() async {
  // setup reflectable support (build target defined in build.yaml)
  initializeReflectable();
  await mainCommon(Environment.dev);
}
