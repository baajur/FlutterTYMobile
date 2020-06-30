import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_ty_mobile/features/general_route_widget_export.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';

import 'more_grid_item.dart';

///
///@author H.C.CHIANG
///@version 2020/6/1
///
class MoreDialog extends StatelessWidget {
  static final List<MoreGridItem> gridItems = [
    MoreGridItem.notice,
    MoreGridItem.download,
    MoreGridItem.tutorial,
    MoreGridItem.service,
    MoreGridItem.routeChange,
    MoreGridItem.store,
    MoreGridItem.roller,
    MoreGridItem.task,
    MoreGridItem.agentAbout,
  ];

  void _itemTapped(BuildContext context, RouteListItem itemValue) {
    print('item tapped: $itemValue');
    if (itemValue.route != null) {
      if (itemValue.isUserOnly && getRouteUserStreams.hasUser == false) {
        // navigate to login page
        RouterNavigate.navigateToPage(RoutePage.login);
      } else if (itemValue.route == RoutePage.moreWeb ||
          itemValue.route == RoutePage.service) {
        // open web page
        RouterNavigate.replacePage(
          itemValue.route,
          arg: WebRouteArguments(startUrl: itemValue.webUrl),
        );
      } else {
        // navigate to route
        RouterNavigate.navigateToPage(itemValue.route);
      }
      Future.delayed(
        Duration(milliseconds: 100),
        () => Navigator.of(context).pop(),
      );
    } else {
      FLToast.showInfo(text: localeStr.workInProgress);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      constraints: BoxConstraints.tight(Size(320.0, 321.0)),
      darkBg: true,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: 54.0,
                    decoration: BoxDecoration(
                      color: Themes.dialogTitleBgColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      localeStr.pageTitleMore,
                      style: TextStyle(fontSize: FontSize.TITLE.value),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.2,
                ),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 9,
                itemBuilder: (context, index) {
                  var itemValue = gridItems[index].value;
                  return GestureDetector(
                    onTap: () => _itemTapped(context, itemValue),
                    child: _createGridItem(
                      itemValue,
                      cornerBorderLeft: index == 6,
                      cornerBorderRight: index == 8,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _createGridItem(
    RouteListItem itemValue, {
    bool cornerBorderLeft,
    bool cornerBorderRight,
  }) {
    BorderRadius cornerBorder;
    if (cornerBorderLeft)
      cornerBorder = BorderRadius.only(
        bottomLeft: Radius.circular(16.0),
      );
    else if (cornerBorderRight)
      cornerBorder = BorderRadius.only(
        bottomRight: Radius.circular(16.0),
      );
    else
      cornerBorder = BorderRadius.zero;

    return Container(
      decoration: BoxDecoration(
        color: Themes.dialogBgColor,
        borderRadius: cornerBorder,
      ),
      margin: const EdgeInsets.all(0.5),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: (itemValue.imageName != null)
                ? SizedBox(
                    width: 32.0,
                    height: 32.0,
                    child: networkImageBuilder(itemValue.imageName),
                  )
                : Icon(
                    itemValue.iconData,
                    color: Themes.defaultAccentColor,
                    size: 32.0,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              itemValue.replaceTitle ?? itemValue.route?.pageTitle ?? '?',
              style: TextStyle(
                fontSize: FontSize.SUBTITLE.value - 1,
                color: Themes.defaultTextColorWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
