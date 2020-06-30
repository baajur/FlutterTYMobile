import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';

class SingleInputChipWidget extends StatefulWidget {
  @override
  _SingleInputChipWidgetState createState() => _SingleInputChipWidgetState();
}

class _SingleInputChipWidgetState extends State<SingleInputChipWidget> {
  @override
  Widget build(BuildContext context) {
    return InputChip(
      avatar: CircleAvatar(
        backgroundColor: Themes.hintHyperLink,
        child: Text('B'),
      ),
      label: Text('Button'),
      onPressed: () {
        FLToast.showText(
          text: ('You pressed me'),
          showDuration: ToastDuration.SHORT.value,
          position: FLToastPosition.top,
        );
      },
    );
  }
}
