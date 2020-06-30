import 'package:flutter/material.dart';

///
/// Separate checkbox widget to prevent screen flash
///
class CheckboxWidget extends StatefulWidget {
  final String label;
  final bool initValue;
  final EdgeInsets widgetPadding;

  CheckboxWidget({
    Key key,
    @required this.label,
    this.initValue = false,
    this.widgetPadding = const EdgeInsets.only(top: 2.0),
  }) : super(key: key);

  @override
  CheckboxWidgetState createState() => CheckboxWidgetState();
}

class CheckboxWidgetState extends State<CheckboxWidget> {
  bool boxChecked;

  set setChecked(bool checked) {
    boxChecked = checked;
    setState(() {});
  }

  @override
  void initState() {
    boxChecked = widget.initValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.widgetPadding,
      child: Row(
        children: <Widget>[
          Checkbox(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            value: boxChecked,
            onChanged: (value) => setChecked = value,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Text(widget.label),
          ),
        ],
      ),
    );
  }
}
