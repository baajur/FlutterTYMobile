import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'subfeatures/roller/presentation/widgets/example/wheel.dart';
import 'subfeatures/roller/presentation/widgets/roller_prize_dialog.dart';

class TestAreaRoute extends StatefulWidget {
  @override
  _TestAreaRouteState createState() => _TestAreaRouteState();
}

class _TestAreaRouteState extends State<TestAreaRoute> with AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Wheel(),
    );
    return Container();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    print('after first layout');
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) => new RollerPrizeDialog('images/turntable/221.png'),
    );
  }
}
