import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/bloc_widget_export.dart';

import '../state/notice_store.dart';
import 'notice_display_content.dart';

class NoticeDisplay extends StatefulWidget {
  final NoticeStore store;

  NoticeDisplay(this.store);

  @override
  _NoticeDisplayState createState() => _NoticeDisplayState();
}

class _NoticeDisplayState extends State<NoticeDisplay> {
  final List<String> tabs = [
    localeStr.btnNoticeGeneral,
    localeStr.btnNoticeMaintenance,
  ];

  int _clicked = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.store.dataModel == null || widget.store.dataModel.code != '0')
      return WarningDisplay(
        message: widget.store.dataModel.msg,
        infiniteHeight: true,
      );
    else
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                childAspectRatio: 3.5,
              ),
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: tabs.length,
              itemBuilder: (_, index) {
                return ConstrainedBox(
                  constraints: const BoxConstraints.tightFor(height: 24),
                  child: RaisedButton(
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(24.0),
                    ),
                    color: (_clicked == index)
                        ? Themes.defaultAccentColor
                        : Themes.defaultDisabledColor,
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        color: (_clicked == index)
                            ? Themes.defaultTextColorBlack
                            : Themes.defaultTextColor,
                      ),
                    ),
                    onPressed: () {
                      if (_clicked == index) return;
                      setState(() {
                        _clicked = index;
                      });
                    },
                  ),
                );
              },
            ),
            Expanded(
              child: IndexedStack(
                index: _clicked,
                children: <Widget>[
                  NoticeDisplayContent(dataList: widget.store.getMarqueeList),
                  NoticeDisplayContent(
                      dataList: widget.store.getMaintenanceList),
                ],
              ),
            ),
          ],
        ),
      );
  }
}
