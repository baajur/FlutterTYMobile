import 'package:flutter/widgets.dart';

class TableCellTextWidget extends StatelessWidget {
  final String text;
  final bool shrinkInset;

  TableCellTextWidget({@required this.text, this.shrinkInset = true})
      : assert(text is String);

  @override
  Widget build(BuildContext context) {
    if (text.isEmpty) return SizedBox.shrink();
    if (shrinkInset) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
        child: Text(text, textAlign: TextAlign.center),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 1.0),
        child: Text(text, textAlign: TextAlign.center),
      );
    }
  }
}
