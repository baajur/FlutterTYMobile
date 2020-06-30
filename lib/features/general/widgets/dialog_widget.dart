import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';

class DialogWidget extends StatefulWidget {
  final Key key;

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry padding;

  final BoxConstraints constraints;

  /// The widget that's inside a dialog.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  DialogWidget({
    this.key,
    @required this.child,
    this.padding,
    this.constraints,
  }) : super(key: key);

  @override
  DialogWidgetState createState() => DialogWidgetState();
}

class DialogWidgetState extends State<DialogWidget> {
  final double dialogHeight = Global.device.height * 0.85;
  // screen width - dialog padding
  final double dialogWidth = Global.device.width - 32;
  // screen width - dialog padding - stack padding - text padding
  final double contentWidth = Global.device.width - 32 - 20 - 8;

  Duration insetAnimationDuration = const Duration(milliseconds: 100);
  Curve insetAnimationCurve = Curves.decelerate;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Material(
            // round corner view
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(2.0)),
            ),
            color: Themes.dialogBgColor,
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                constraints: widget.constraints ??
                    BoxConstraints(
                      minWidth: dialogWidth,
                      maxWidth: dialogWidth,
                      minHeight: dialogHeight / 4,
                      maxHeight: dialogHeight,
                    ),
                child: widget.child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
