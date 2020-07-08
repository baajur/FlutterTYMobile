import 'dart:async' show StreamController;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/tabs_page_control_widget.dart';

import '../../data/models/game_category_model.dart';
import '../state/home_store.dart';
import 'home_store_inherit_widget.dart';
import 'home_display_size_calc.dart';
import 'home_display_tabs_page.dart';
import 'home_display_tab_recommend.dart';
import 'home_display_tab_favorite.dart';

/// Main view of the game area
/// Creates a [TabBar] widget to switch between each game category
/// Creates a [ConstrainedBox] to contain tab's page view
/// @author H.C.CHIANG
/// @version 2020/6/19
class HomeDisplayUserTabs extends StatefulWidget {
  final HomeDisplaySizeCalc sizeCalc;
  final List<GameCategoryModel> tabs;

  HomeDisplayUserTabs({
    this.tabs,
    @required this.sizeCalc,
  });

  @override
  HomeDisplayUserTabsState createState() => HomeDisplayUserTabsState();
}

class HomeDisplayUserTabsState extends State<HomeDisplayUserTabs>
    with SingleTickerProviderStateMixin {
  final GlobalKey _tabBarKey = new GlobalKey(debugLabel: 'tabbar2');
  final StreamController<String> _selectedController =
      StreamController<String>.broadcast();

  HomeStore _store;
  TabController _tabController;
  PageController _pageController;
  Widget _tabBar;

  String _preType;
  String _currentType;

  Map<String, Widget> iconBuilders;

  void showPlatform(int index, String platformClassName) {
    print('jump to page $index and search $platformClassName');
    _pageController.jumpToPage(index);
    if (_store != null) _store.showSearchPlatform(platformClassName);
  }

  void _tabListener() {
    // Set [_currentType] to change tab bar item color
    try {
      _selectedController.sink.add(widget.tabs[_tabController.index].type);
    } on Exception {}
  }

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
      _pageController = new PageController();
      _tabController =
          new TabController(length: widget.tabs.length, vsync: this);
      _tabController.addListener(() => _tabListener());
    }
  }

  @override
  void dispose() {
    if (!mounted) {
      try {
        MyLogger.print(
            msg: 'disposing controller...', tag: "HomeDisplayUserTabs");
        _selectedController.close();
        if (_pageController != null) {
          _pageController.dispose();
          _pageController = null;
        }
        if (_tabController != null) {
          _tabController.removeListener(() => _tabListener());
          _tabController.dispose();
          _tabController = null;
        }
      } catch (e) {
        MyLogger.warn(msg: 'dispose error: $e', tag: "HomeDisplayUserTabs");
      }
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
    _store ??= HomeStoreInheritedWidget.of(context).store;
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
                  minHeight:
                      Global.device.height / 3 / widget.sizeCalc.widthFactor,
                  maxHeight:
                      Global.device.height / 1.75 / widget.sizeCalc.widthFactor,
                  minWidth: Global.device.width / 3 - 24,
                  maxWidth: Global.device.width / 3 - 18,
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
              minWidth: Global.device.width * 0.6,
              maxWidth: Global.device.width / 3 * 2 - 6,
              minHeight: Global.device.height / 2.75,
              maxHeight: Global.device.height / 1.75,
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
                            addSearchListener: true,
                            addPlugin: true,
                          );
                          break;
                        case GamePageType.Recommend:
                          return HomeDisplayTabRecommend(
                            pageMaxWidth: widget.sizeCalc.pageMaxWidth,
                            onPlatformClicked: (platform) {
                              print('clicked recommend platform: $platform');
                              int pageIndex = widget.tabs.indexWhere(
                                  (element) =>
                                      element.type == platform.category);
                              print('found page index: $pageIndex');
                              showPlatform(pageIndex, platform.className);
                            },
                          );
                          break;
                        case GamePageType.Favorite:
                          return HomeDisplayTabFavorite(
                            pageMaxWidth: widget.sizeCalc.pageMaxWidth,
                            onPlatformClicked: (platform) {
                              print('clicked favorite platform: $platform');
                              int pageIndex = widget.tabs.indexWhere(
                                  (element) =>
                                      element.type == platform.category);
                              print('found page index: $pageIndex');
                              showPlatform(pageIndex, platform.className);
                            },
                          );
                          break;
                        case GamePageType.Movie1:
                          return Center(child: Text('${category.type}'));
                          break;
                        case GamePageType.Movie2:
                          return Center(child: Text('${category.type}'));
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
                width: FontSize.NORMAL.value * 4.5,
                alignment: Alignment.center,
                child: Text(category.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
