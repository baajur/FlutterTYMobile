part of 'feature_screen_view.dart';

///
///@author H.C.CHIANG
///@version 2020/6/2
///
class ScreenDrawer extends StatelessWidget {
  const ScreenDrawer();

  static final List<ScreenDrawerItem> _menuItems = [
    ScreenDrawerItem.home,
    ScreenDrawerItem.download,
    ScreenDrawerItem.tutorial,
    ScreenDrawerItem.notice,
    ScreenDrawerItem.wallet,
    ScreenDrawerItem.vip,
    ScreenDrawerItem.event,
    ScreenDrawerItem.store,
    ScreenDrawerItem.logout,
    ScreenDrawerItem.testUI,
    ScreenDrawerItem.test,
  ];

  bool _itemTapped(ScreenDrawerItem item, {FeatureScreenStore store}) {
    if (item == ScreenDrawerItem.logout) {
      getRouteUserStreams.logout();
      return true;
    }
    if (item == ScreenDrawerItem.test) {
      ScreenNavigate.switchScreen(screen: ScreenEnum.Test);
      return true;
    }
    if (item == ScreenDrawerItem.event) {
      store.setForceShowEvent = true;
      return true;
    }
    var route = item.value.route;
    if (route == null) {
      FLToast.showInfo(text: localeStr.workInProgress);
    } else if (route == RoutePage.moreWeb) {
      // open web page
      RouterNavigate.replacePage(
        route,
        arg: WebRouteArguments(
          startUrl: item.value.webUrl,
          hideBars: true,
        ),
      );
      return true;
    } else if (route.page != RouterNavigate.current) {
      RouterNavigate.navigateToPage(route);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final viewState = FeatureScreenInheritedWidget.of(context);
    double drawerWidth = Global.device.width / 3 * 2;
    if (drawerWidth < 240) drawerWidth = 240;
    return Container(
      constraints: BoxConstraints(
        maxWidth: drawerWidth,
        maxHeight: Global.device.height,
      ),
      child: Drawer(
        elevation: 8.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /* Drawer Header */
            DrawerHeader(
              decoration: BoxDecoration(color: Themes.defaultBackgroundColor),
              margin: const EdgeInsets.only(bottom: 4.0),
              child: (viewState.store.hasUser)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Image.asset(
                            'assets/images/vip/user_vip_${viewState.store.user.vip}.png',
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                            localeStr.messageWelcomeUser(
                                viewState.store.user.account),
                            style: TextStyle(color: Colors.white)),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(localeStr.messageWelcome,
                            style: TextStyle(color: Colors.white)),
                        SizedBox(height: 8),
                        ButtonTheme(
                          child: RaisedButton(
                            color: Themes.buttonLightAccentColor,
                            textColor: Themes.defaultTextColorBlack,
                            child: Text(localeStr.pageTitleLogin2),
                            onPressed: () {
                              if (viewState.scaffoldKey.currentState
                                  .isDrawerOpen) Navigator.of(context).pop();
                              RouterNavigate.navigateToPage(
                                RoutePage.login,
                                arg: LoginRouteArguments(
                                    returnHomeAfterLogin: true),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
            ),
            Container(
              constraints: BoxConstraints(
                // _kDrawerHeaderHeight = 161
                maxHeight: Global.device.height - 161.0 - 36.0,
              ),
              padding: const EdgeInsets.only(top: 12.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: _menuItems.length,
                itemBuilder: (_, index) {
                  ScreenDrawerItem item = _menuItems[index];
                  if (item.value.isUserOnly &&
                      getRouteUserStreams.hasUser == false)
                    return SizedBox.shrink();
                  if (item == ScreenDrawerItem.event &&
                      viewState.store.event.hasData == false)
                    return SizedBox.shrink();
                  return GestureDetector(
                    onTap: () {
                      if ((item == ScreenDrawerItem.event)
                          ? _itemTapped(item, store: viewState.store)
                          : _itemTapped(item)) {
                        // close the drawer
                        if (viewState.scaffoldKey.currentState.isDrawerOpen)
                          Navigator.of(context).pop();
                      }
                    },
                    child: _buildListItem(item.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(RouteListItem itemValue) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Transform.scale(
            scale: 1.05,
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Themes.iconColor)),
              child: Transform.scale(
                scale: 0.75,
                child: Icon(
                  itemValue.iconData,
                  color: Themes.iconColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              itemValue.replaceTitle ?? itemValue.route?.pageTitle ?? '?',
              style: TextStyle(fontSize: FontSize.MESSAGE.value),
            ),
          ),
        ],
      ),
    );
  }
}
