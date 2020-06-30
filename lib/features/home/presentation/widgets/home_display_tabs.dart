import 'dart:async' show StreamController;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/tabs_page_control_widget.dart';

import 'home_display_size_calc.dart';
import 'home_display_tabs_page.dart';
import 'home_store_inherit_widget.dart';
import '../state/home_store.dart';
import '../../data/models/game_category_model.dart';

/// Main view of the game area
/// Creates a [TabBar] widget to switch between each game category
/// Creates a [ConstrainedBox] to contain tab's page view
/// @author H.C.CHIANG
/// @version 2020/6/19
class HomeDisplayTabs extends StatefulWidget {
  final HomeDisplaySizeCalc sizeCalc;
  final List<GameCategoryModel> tabs;

  HomeDisplayTabs({
    this.tabs,
    @required this.sizeCalc,
  });

  @override
  HomeDisplayTabsState createState() => HomeDisplayTabsState();
}

class HomeDisplayTabsState extends State<HomeDisplayTabs>
    with SingleTickerProviderStateMixin {
  final GlobalKey _tabBarKey = new GlobalKey(debugLabel: 'tabbar');
  final StreamController<String> _selectedController =
      StreamController<String>.broadcast();

  TabController _tabController;
  PageController _pageController;
  Widget _tabBar;

  String _preType;
  String _currentType;

  Map<String, Widget> iconBuilders;

  @override
  void initState() {
    _selectedController.stream.listen((event) {
      _preType = _currentType;
      _currentType = event;
    });
    super.initState();
    if (widget.tabs != null) {
//      print('game tabs = ${widget.tabs}');
//      print('game tabs count = ${widget.tabs.length}');
      _currentType = widget.tabs[0].type;
      _pageController = PageController();
      _tabController = TabController(length: widget.tabs.length, vsync: this);
      _tabController.addListener(() {
        // Set [_currentType] to change tab bar item color
        try {
          _selectedController.sink.add(widget.tabs[_tabController.index].type);
        } on Exception {}
      });
    }
  }

  @override
  void dispose() {
    try {
      if (_tabController != null) _tabController.dispose();
      _selectedController.close();
    } catch (e) {
      MyLogger.warn(msg: '${e.runtimeType}', tag: "HomeDisplayTabs", error: e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController == null)
      return Center(child: CircularProgressIndicator());
    iconBuilders ??= new Map();
    final store = HomeStoreInheritedWidget.of(context).store;
    _tabBar ??= _buildTabBar(store);
    return _tabBar;
  }

  Widget _buildTabBar(HomeStore store) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// category tab bar
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 2.0, 10.0, 12.0),
            child: Material(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(6.0),
              child: Container(
                /* Tab bar constraints */
                constraints: BoxConstraints(
//                  minHeight: widget.sizeCalc.barMinHeight,
//                  maxHeight: widget.sizeCalc.barMaxHeight,
                  minWidth: widget.sizeCalc.barMinWidth,
                  maxWidth: widget.sizeCalc.barMaxWidth,
                ),
                margin: const EdgeInsets.only(bottom: 8.0),
                /* Rotate to vertical */
                child: RotatedBox(
                  quarterTurns: 1,
                  child: TabBar(
                    key: _tabBarKey,
                    unselectedLabelColor: Themes.defaultTextColor,
                    labelColor: Themes.defaultAccentColor,
                    labelStyle: TextStyle(fontSize: FontSize.NORMAL.value + 1),
                    labelPadding: const EdgeInsets.only(top: 2.0),
                    indicatorColor: Colors.transparent, // hide indicator
                    controller: _tabController,
                    isScrollable: true,
                    /* Generate Category Tabs */
                    tabs: widget.tabs.map((data) => _createTab(data)).toList(),
                    onTap: (index) {
                      _pageController.jumpToPage(index);
                    },
                  ),
                ),
              ),
            ),
          ),

          /// platform page control
          ConstrainedBox(
            constraints: BoxConstraints(
//              minWidth: widget.sizeCalc.pageMinWidth,
              maxWidth: widget.sizeCalc.pageMaxWidth,
//              minHeight: widget.sizeCalc.pageMinHeight,
              maxHeight: widget.sizeCalc.pageMaxHeight,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TabsPageControlWidget(
                    pageController: _pageController,
                    tabController: _tabController,
                    children: widget.tabs.map((category) {
                      switch (category.pageType) {
                        case GamePageType.Games:
                          return HomeDisplayTabsPage(
                            pageMaxWidth: widget.sizeCalc.pageMaxWidth,
                            category: category.type,
                          );
                          break;
                        default:
                          return SizedBox.shrink();
                          break;
                      }
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _createTab(GameCategoryModel category) {
    return RotatedBox(
      quarterTurns: 3, // rotate back to normal display
      child: Tab(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          margin: const EdgeInsets.symmetric(horizontal: 3.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 2.0,
                color: Themes.defaultAccentColor,
              ),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                width: 20.0,
                height: 20.0,
                child: StreamBuilder<String>(
                  stream: _selectedController.stream,
                  initialData: _currentType,
                  builder: (ctx, _) {
                    String type = category.type;
                    if (iconBuilders.containsKey(type) &&
                        type != _preType &&
                        type != _currentType) {
                      return iconBuilders[type];
                    } else {
                      // use local images to avoid flashes
                      Widget builder = Image.asset(
                        'assets/${category.iconUrl}',
                        color: category.type == _currentType
                            ? Themes.defaultAccentColor
                            : Themes.defaultTextColor,
                      );
                      iconBuilders[type] = builder;
                      return builder;
                    }
                  },
                ),
              ),
              Container(
                width: FontSize.NORMAL.value * 5,
                padding: const EdgeInsets.only(left: 6.0),
                alignment: Alignment.center,
                child: Text(
                  category.label,
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
