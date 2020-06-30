import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/orientation_helper.dart';
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/temp/test_router.gr.dart';
import 'package:flutter_ty_mobile/utils/platform_util.dart';

import 'test_input_dialog.dart';

class TestNestedNavScreenView extends StatefulWidget {
  @override
  _TestNestedNavScreenViewState createState() =>
      _TestNestedNavScreenViewState();
}

class _TestNestedNavScreenViewState extends State<TestNestedNavScreenView> {
  DeviceOrientation _deviceOrientation;
  StreamSubscription<DeviceOrientation> subscription;
  bool _lockAutoRotate = true;
  bool _sensorOn = false;
  int _rotateIndex;

  @override
  void initState() {
    subscription = OrientationHelper.onOrientationChange.listen((value) {
      // If the widget was removed from the tree while the asynchronous platform
      // message was in flight, we want to discard the reply rather than calling
      // setState to update our non-existent appearance.
      if (!mounted) return;
      setState(() {
        if (!_lockAutoRotate) {
          _deviceOrientation = value;
          _rotateIndex = value.index;
          print('auto rotate index: $_rotateIndex');
          OrientationHelper.forceOrientation(value);
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceOrientation ??=
        (MediaQuery.of(context).orientation == Orientation.portrait)
            ? DeviceOrientation.portraitUp
            : DeviceOrientation.landscapeLeft;
    _rotateIndex ??= _deviceOrientation.index;
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: RaisedButton(
            onPressed: () =>
                ScreenNavigate.switchScreen(screen: ScreenEnum.Feature),
            child: Text('Return Home'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Device: '),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () => TestRouter.navigator
                  .pushNamed(TestRoutes.testPermissionScreen),
              child: Text('Permission'),
            ),
            RaisedButton(
              onPressed: () {
                FLToast.showText(
                  text: Global.device.toString(),
                  position: FLToastPosition.top,
                  showDuration: ToastDuration.DEFAULT.value,
                );
              },
              child: Text('Size'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Orientation: '),
              Text(_deviceOrientation.toString()),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _rotateIndex = _rotateIndex + 1;
                if (_rotateIndex > 3) _rotateIndex = 0;
                OrientationHelper.forceOrientation(
                    DeviceOrientation.values[_rotateIndex]);
                print('rotate index: $_rotateIndex');
              },
              child: Text('force'),
            ),
            RaisedButton(
              onPressed: () {
                _lockAutoRotate = !_lockAutoRotate;
                print('lock rotate: $_lockAutoRotate');
              },
              child: Text('lock/unlock'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Rotate Sensor: '),
              StreamBuilder<dynamic>(
                stream: PlatformUtil.sensorStream,
                initialData: '-1',
                builder: (context, snapshot) {
                  return Text(
                      '${snapshot.data.toString()} (listener: $_sensorOn)');
                },
              ),
            ],
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                if (_sensorOn) {
                  PlatformUtil.stopSensorListener();
                  _sensorOn = false;
                } else {
                  PlatformUtil.enableSensorListener();
                  _sensorOn = true;
                }
              },
              child: Text('sensor'),
            ),
            RaisedButton(
              onPressed: () {
                PlatformUtil.disableSensor();
              },
              child: Text('sensor off'),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Input Field'),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              child: Text('dialog'),
              onPressed: () => showDialog(
                context: context,
                barrierDismissible: true,
                builder: (context) => new TestInputDialog(),
              ),
            ),
            RaisedButton(
                child: Text('push'),
                onPressed: () =>
                    TestRouter.navigator.pushNamed(TestRoutes.testInputRoute)),
          ],
        ),
      ],
    );
  }
}
