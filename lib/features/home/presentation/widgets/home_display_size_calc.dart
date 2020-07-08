import 'package:flutter_ty_mobile/core/internal/global.dart';

class HomeDisplaySizeCalc {
  final double bannerImageScale = 600.0 / Global.device.width;
  final double marqueeHeight = 36.0;
  final double shortcutTitleHeight = 36.0;
  final double shortcutMaxHeight = 120.0;
  final double shortcutMinHeight = 108.0;

  final double barMinWidth = Global.device.width / 3 - 24;
  final double barMaxWidth = Global.device.width / 3 - 18;

  double _bannerHeight;

  double _tabWidthFactor;
  double _barMaxHeight;
  double _barMinHeight;

  double _tabPageMinWidth;
  double _tabPageMaxWidth;

  double _tabPageMinHeight;
  double _tabPageMaxHeight;

  HomeDisplaySizeCalc() {
    _bannerHeight = 231 / bannerImageScale;

    double availableWidth = Global.device.width - barMaxWidth;
    _tabWidthFactor = (Global.device.widthScale > 1.5) ? 1.5 : 1.0;

    _barMinHeight = Global.device.height / 3 / _tabWidthFactor;
    _barMaxHeight = Global.device.height / 1.75 / _tabWidthFactor;

    double availableHeight =
        Global.device.featureContentHeight - shortcutMaxHeight;
    _tabPageMinHeight = Global.device.height / 2.75;
    _tabPageMaxHeight = availableHeight - 24;
    // check if height is larger than available height
    if (_tabPageMinHeight > availableHeight)
      _tabPageMinHeight = availableHeight;

    _tabPageMinWidth = Global.device.width * 0.6;
    _tabPageMaxWidth = Global.device.width / 3 * 2 - 6;
    if (_tabPageMaxWidth > availableWidth) _tabPageMaxWidth = availableWidth;
    if (_tabPageMaxWidth < _tabPageMinWidth)
      _tabPageMaxWidth = _tabPageMinWidth;
  }

  double get bannerHeight => _bannerHeight;

  double get barMaxHeight => _barMaxHeight;
  double get barMinHeight => _barMinHeight;

  double get pageMaxWidth => _tabPageMaxWidth;
  double get pageMinWidth => _tabPageMinWidth;

  double get pageMaxHeight => _tabPageMaxHeight;
  double get pageMinHeight => _tabPageMinHeight;

  // 12 = shortcut widget height variation
  double get userPageMaxHeight => _tabPageMaxHeight + 12.0;
  double get userPageMinHeight => _tabPageMinHeight + 12.0;

  double get widthFactor => _tabWidthFactor;
}
