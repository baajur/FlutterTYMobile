import 'dart:async' show StreamSubscription;
import 'dart:io' show Platform;

import 'package:flutter/services.dart'
    show DeviceOrientation, EventChannel, MethodChannel;

import '../mylogger.dart';

class PlatformUtil {
  static const String TAG = 'PlatformUtil';
  static const restartChannel = const MethodChannel('com.op.tymobile/restart');
  static const sensorChannel =
      const MethodChannel('com.op.tymobile/sensorswitch');
  static const sensorEventChannel =
      const EventChannel('com.op.tymobile/sensor');
  static const iosRotationChannel =
      const MethodChannel('com.op.tymobile/orientation');

  static StreamSubscription sensorSubscription;
  static Stream sensorStream;

  static restart() {
    if (Platform.isAndroid) {
      MyLogger.log(msg: 'restarting android app...', tag: TAG);
      restartChannel.invokeMethod('appRestart');
    }
  }

  static enableSensor() {
    MyLogger.info(msg: 'enabling sensor...', tag: TAG);
    sensorChannel.invokeMethod('enable');
  }

  static enableSensorListener() {
    if (sensorStream == null) sensorChannel.invokeMethod('enable');
    if (sensorSubscription != null && sensorSubscription.isPaused) {
      MyLogger.info(msg: 'restoring sensor stream...', tag: TAG);
      sensorSubscription.resume();
    } else {
      MyLogger.info(msg: 'enabling sensor stream...', tag: TAG);
      Future.delayed(Duration(milliseconds: 500), () {
        sensorStream = sensorEventChannel.receiveBroadcastStream();
        sensorSubscription = sensorStream.listen((event) {
          print('sensor event: $event');
        }, onError: (dynamic error) {
          print('sensor error: ${error.message}');
        });
      }).catchError(
        (e) => MyLogger.error(msg: 'Sensor listener has error: $e', tag: TAG),
      );
    }
  }

  static pauseSensorListener() {
    MyLogger.info(msg: 'pausing sensor stream...', tag: TAG);
    sensorSubscription.pause();
  }

  static disableSensor() {
    MyLogger.log(msg: 'disabling sensor...', tag: TAG);
    sensorChannel.invokeMethod('disable');
    sensorSubscription?.cancel();
    sensorStream = null;
  }

  static setIosOrientation(DeviceOrientation orientation) {
    if (Platform.isIOS) {
      MyLogger.log(msg: 'set ios orientation', tag: TAG);
      switch (orientation) {
        case DeviceOrientation.portraitUp:
        case DeviceOrientation.portraitDown: // iphone cannot use portrait down
          iosRotationChannel.invokeMethod('setPortrait');
          break;
        case DeviceOrientation.landscapeLeft:
          iosRotationChannel.invokeMethod('setLandscapeRight');
          break;
        case DeviceOrientation.landscapeRight:
          iosRotationChannel.invokeMethod('setLandscapeLeft');
          break;
      }
    }
  }
}
