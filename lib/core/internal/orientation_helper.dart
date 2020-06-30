import 'package:flutter/services.dart';
import 'package:orientation/orientation.dart';
import 'package:rxdart/rxdart.dart';

class OrientationHelper {
  static void restoreUI() {
    try {
      // Rotate to normal
      forceOrientationEasy();
      // restore the screen to normal SystemUiOverlay
      setEnabledSystemUIOverlays();
    } on Exception catch (e) {
      print('Orientation Helper has exception: $e');
    }
  }

  static Future<void> setEnabledSystemUIOverlays() {
    print('Restore System UI');
    return OrientationPlugin.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  static Future<void> setDisabledSystemUIOverlays() {
    print('Hide System UI');
    return OrientationPlugin.setEnabledSystemUIOverlays([]);
  }

  static Future<void> setPreferredOrientations() {
    return OrientationPlugin.setPreferredOrientations(
        [DeviceOrientation.portraitUp]);
  }

  static Future<void> forceOrientation(DeviceOrientation orientation) {
    print('force rotate: $orientation');
    return OrientationPlugin.forceOrientation(orientation);
  }

  static Future<void> forceOrientationEasy(
      {bool isPortrait = true, bool isReversed = false}) {
    print('force rotate portrate: $isPortrait, reversed: $isReversed');
    DeviceOrientation ori;
    if (isPortrait && !isReversed)
      ori = DeviceOrientation.portraitUp;
    else if (isPortrait && isReversed)
      ori = DeviceOrientation.portraitDown;
    else if (!isPortrait && isReversed)
      ori = DeviceOrientation.landscapeRight;
    else
      ori = DeviceOrientation.landscapeLeft;
    return OrientationPlugin.forceOrientation(ori);
  }

  /// [DeviceOrientation.portraitUp] is default.
  static final DeviceOrientation initOrientation = DeviceOrientation.portraitUp;

  static Stream<DeviceOrientation> _onOrientationChange;

  static Stream<DeviceOrientation> get onOrientationChange {
    if (_onOrientationChange == null) {
      _onOrientationChange = OrientationPlugin.onOrientationChange
          .shareValueSeeded(initOrientation)
          .distinct((previous, next) => previous == next);
    }
    return _onOrientationChange;
  }
}
