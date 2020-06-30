import 'dart:core';

import 'package:flutter/material.dart' show MediaQueryData, Orientation;
import 'package:flutter_ty_mobile/core/internal/global.dart';

class Device {
  final MediaQueryData _mediaQueryData;
  final double _screenWidth;
  final double _screenHeight;
  double _screenWidthScale;
  double _screenHeightScale;
  double _screenButtonHeight;

  Device(this._mediaQueryData, this._screenWidth, this._screenHeight) {
    _screenWidthScale = _screenWidth / Global.TEST_DEVICE_WIDTH;
    _screenHeightScale = _screenHeight / Global.TEST_DEVICE_HEIGHT;
    _screenButtonHeight = (_screenHeightScale > 1)
        ? (36 * _screenHeightScale).ceilToDouble()
        : 36.0;
  }

  @override
  String toString() {
    return 'width=$_screenWidth\n'
        'width scale=$_screenWidthScale\n'
        'height=$_screenHeight\n'
        'height scale=$_screenHeightScale\n'
        'button=$_screenButtonHeight';
  }

  /// device's current orientation
  Orientation get orientation => _mediaQueryData.orientation;

  /// screen's ratio = width / height
  double get ratio => _mediaQueryData.size.aspectRatio;

  /// screen's ratio = height / width
  double get ratioHor => _mediaQueryData.size.flipped.aspectRatio;

  /// device's width
  double get width => _screenWidth;

  /// device's height
  double get height => _screenHeight;

  /// device's width scale
  double get widthScale => _screenWidthScale;

  /// device's height
  double get heightScale => _screenHeightScale;

  /// device's relative button height
  double get comfortButtonHeight => _screenButtonHeight;
}
