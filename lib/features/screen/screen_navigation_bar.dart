part of 'feature_screen_view.dart';

///
///@author H.C.CHIANG
///@version 2020/6/2
///
class ScreenNavigationBar extends StatefulWidget {
  const ScreenNavigationBar();

  @override
  _ScreenNavigationBarState createState() => _ScreenNavigationBarState();
}

class _ScreenNavigationBarState extends State<ScreenNavigationBar> {
  static final List<ScreenNavigationBarItem> _tabs = [
    ScreenNavigationBarItem.home,
    ScreenNavigationBarItem.deposit,
    ScreenNavigationBarItem.promo,
    ScreenNavigationBarItem.service,
    ScreenNavigationBarItem.member,
    ScreenNavigationBarItem.more,
  ];

  static final List<ScreenNavigationBarItem> _userTabs = [
    ScreenNavigationBarItem.home,
    ScreenNavigationBarItem.agent,
    ScreenNavigationBarItem.promo,
    ScreenNavigationBarItem.service,
    ScreenNavigationBarItem.member,
    ScreenNavigationBarItem.more,
  ];

  int _navIndex = 0;
  bool isUserTabs = false;
  Widget barWidget;

  void _itemTapped(int index, bool hasUser) {
//            RouterNavigate.testNavigate(_tabRoute[index]);
//              RouterNavigate.switchScreen(web: true);
    var item = (isUserTabs) ? _userTabs[index] : _tabs[index];
    print('tapped item: $item');
    if (item == ScreenNavigationBarItem.more) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => new MoreDialog(),
      );
    } else if (item.value.route == null) {
      FLToast.showInfo(text: localeStr.workInProgress);
    } else {
      var value = item.value;
      if (value.isUserOnly && !hasUser)
        RouterNavigate.navigateToPage(RoutePage.login);
      else if (item == ScreenNavigationBarItem.service)
        RouterNavigate.navigateToPage(
          value.route,
          arg: WebRouteArguments(startUrl: value.webUrl),
        );
      else
        RouterNavigate.navigateToPage(value.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final viewState = FeatureScreenInheritedWidget.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Themes.defaultAccentColor),
        ),
      ),
      child: StreamBuilder<bool>(
          stream: viewState.store.updateStream,
          initialData: false,
          builder: (context, snapshot) {
            if (isUserTabs != snapshot.data) {
              barWidget = _buildWidget(snapshot.data, viewState);
            }
            barWidget ??= _buildWidget(snapshot.data, viewState);
            isUserTabs = snapshot.data;
            return barWidget;
          }),
    );
  }

  Widget _buildWidget(bool hasUser, FeatureScreenInheritedWidget viewState) {
    return Observer(builder: (_) {
      // observe nav index to change icon icon color (setState does not work).
      final index = viewState.store.navIndex;
      if (index >= 0) _navIndex = index;
      return BottomNavigationBar(
        onTap: (index) {
          print('store state user: ${viewState.store.userStatus}');
          _itemTapped(index, viewState.store.hasUser);
        },
        currentIndex: _navIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: FontSize.NORMAL.value,
        unselectedFontSize: FontSize.NORMAL.value,
        unselectedItemColor: Themes.defaultTextColor,
        fixedColor: Themes.defaultAccentColor,
        backgroundColor: Themes.defaultAppbarColor,
        items: (hasUser)
            ? List.generate(_userTabs.length, (index) {
                var itemValue = _userTabs[index].value;
                return BottomNavigationBarItem(
                  icon: Icon(itemValue.iconData),
                  title: Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(itemValue.replaceTitle ??
                        itemValue.route?.pageTitle ??
                        '?'),
                  ),
                );
              })
            : List.generate(_tabs.length, (index) {
                var itemValue = _tabs[index].value;
                return BottomNavigationBarItem(
                  icon: Icon(itemValue.iconData),
                  title: Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Text(itemValue.replaceTitle ??
                        itemValue.route?.pageTitle ??
                        '?'),
                  ),
                );
              }),
      );
    });
  }
}
