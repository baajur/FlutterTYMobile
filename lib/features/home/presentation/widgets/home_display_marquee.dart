import 'package:flui/flui.dart' show FLMarqueeLabel;
import 'package:flutter/foundation.dart' show compute;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/home/data/entity/marquee_entity.dart';

class HomeDisplayMarquee extends StatelessWidget {
  final List<MarqueeEntity> marquees;

  HomeDisplayMarquee({this.marquees});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(
        Size(Global.device.width, 36.0),
      ),
      color: Themes.defaultMarqueeBarColor,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Icon(
              const IconData(0xf027, fontFamily: 'FontAwesome'),
              color: Colors.white,
              size: 16.0,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: compute(_marqueeToString, marquees),
              builder: (context, snapshot) {
//        print('marquee display state: ${snapshot.connectionState}, '
//            'error: ${snapshot.hasError}');
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasError) {
                  return FLMarqueeLabel(
                    text: snapshot.data,
                    style: TextStyle(fontSize: FontSize.NORMAL.value),
                    loop: true,
                    velocity: 0.8,
                    height: 28,
                    padding: EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
                  );
                } else {
                  if (snapshot.hasError) {
                    MyLogger.warn(
                        msg: 'snapshot error: ${snapshot.error}',
                        tag: 'MarqueeDisplay');
                  }
                  return Icon(Icons.sync_problem);
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: ButtonTheme(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 64.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: RaisedButton(
                child: Text(
                  localeStr.pageTitleNotice,
                  style: TextStyle(
                    fontSize: FontSize.NORMAL.value,
                    color: Themes.defaultTextColorBlack,
                  ),
                ),
                visualDensity: VisualDensity(horizontal: -2.0, vertical: -3.0),
                onPressed: () =>
                    RouterNavigate.navigateToPage(RoutePage.noticeBoard),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Process [MarqueeEntity] content to string
String _marqueeToString(List<dynamic> list) {
  if (list == null || list.isEmpty) return '';
  String separator = '        ';
  List<String> contents = new List();
  list.forEach((item) {
    try {
      contents.add(item.content.replaceAll('\n', '\t'));
//      print('add marquee content to list: ${item.id}');
    } catch (e) {
      print(e);
    }
  });
//  print('computed list: $contents');
  if (list.isNotEmpty && contents.isEmpty) {
    MyLogger.warn(
        msg: 'error marquee type condition!! item: $list',
        tag: 'MarqueeDisplay');
  }
  return '$separator${contents.join(separator)}';
}
