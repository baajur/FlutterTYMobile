// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_game_screen_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$WebGameScreenStore on _WebGameScreenStore, Store {
  final _$_streamRotateAtom = Atom(name: '_WebGameScreenStore._streamRotate');

  @override
  ObservableStream<DeviceOrientation> get _streamRotate {
    _$_streamRotateAtom.reportRead();
    return super._streamRotate;
  }

  @override
  set _streamRotate(ObservableStream<DeviceOrientation> value) {
    _$_streamRotateAtom.reportWrite(value, super._streamRotate, () {
      super._streamRotate = value;
    });
  }

  final _$deviceOrientationAtom =
      Atom(name: '_WebGameScreenStore.deviceOrientation');

  @override
  DeviceOrientation get deviceOrientation {
    _$deviceOrientationAtom.reportRead();
    return super.deviceOrientation;
  }

  @override
  set deviceOrientation(DeviceOrientation value) {
    _$deviceOrientationAtom.reportWrite(value, super.deviceOrientation, () {
      super.deviceOrientation = value;
    });
  }

  final _$rotateScreenAsyncAction =
      AsyncAction('_WebGameScreenStore.rotateScreen');

  @override
  Future<void> rotateScreen(DeviceOrientation receivedRotate) {
    return _$rotateScreenAsyncAction
        .run(() => super.rotateScreen(receivedRotate));
  }

  final _$rotateScreenByIdAsyncAction =
      AsyncAction('_WebGameScreenStore.rotateScreenById');

  @override
  Future<void> rotateScreenById(int receivedId) {
    return _$rotateScreenByIdAsyncAction
        .run(() => super.rotateScreenById(receivedId));
  }

  final _$initSensorStreamAsyncAction =
      AsyncAction('_WebGameScreenStore.initSensorStream');

  @override
  Future<void> initSensorStream() {
    return _$initSensorStreamAsyncAction.run(() => super.initSensorStream());
  }

  final _$stopSensorAsyncAction = AsyncAction('_WebGameScreenStore.stopSensor');

  @override
  Future<void> stopSensor() {
    return _$stopSensorAsyncAction.run(() => super.stopSensor());
  }

  @override
  String toString() {
    return '''
deviceOrientation: $deviceOrientation
    ''';
  }
}
