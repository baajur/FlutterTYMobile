import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';

import 'center_display_account.dart';
import 'center_display_lotto.dart';
import 'center_display_vip.dart';

class CenterDisplay extends StatefulWidget {
  @override
  _CenterDisplayState createState() => _CenterDisplayState();
}

class _CenterDisplayState extends State<CenterDisplay> {
  final List<String> tabs = [
    localeStr.centerViewTitleData,
    localeStr.centerViewTitleLotto,
    localeStr.centerViewTitleVip,
  ];

  int _clicked = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              childAspectRatio: 3.0,
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: tabs.length,
            itemBuilder: (_, index) {
              return ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  height: Global.device.comfortButtonHeight,
                ),
                child: RaisedButton(
                  visualDensity: VisualDensity.compact,
                  color: (_clicked == index)
                      ? Themes.defaultAccentColor
                      : Themes.defaultDisabledColor,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                        color: (_clicked == index)
                            ? Themes.defaultTextColorBlack
                            : Themes.defaultTextColor),
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
                CenterDisplayAccount(),
                CenterDisplayLotto(),
                CenterDisplayVip(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
