import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';

///
/// Separate checkbox widget to prevent screen flash
///
class FastLoginWidget extends StatefulWidget {
  final bool initValue;

  FastLoginWidget({Key key, this.initValue}) : super(key: key);

  @override
  FastLoginWidgetState createState() => FastLoginWidgetState();
}

class FastLoginWidgetState extends State<FastLoginWidget> {
  bool fastLogin;

  set setChecked(bool isChecked) {
    fastLogin = isChecked;
    setState(() {});
  }

  @override
  void initState() {
    fastLogin = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            visualDensity: VisualDensity.compact,
            value: fastLogin,
            onChanged: (value) => setChecked = value,
          ),
          Text(localeStr.btnFastLogin),
        ],
      ),
    );
  }
}
