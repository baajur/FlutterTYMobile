part of 'feature_screen_view.dart';

///@author H.C.CHIANG
///@version 2020/2/26
class ScreenDrawer extends StatelessWidget {
  const ScreenDrawer();

  static final List<IconData> _menuIcons = [
    IconData(0xf015, fontFamily: 'FontAwesome'),
    IconData(0xf0ed, fontFamily: 'FontAwesome'),
    IconData(0xf027, fontFamily: 'FontAwesome'),
    IconData(0xf155, fontFamily: 'FontAwesome'),
    Icons.warning,
  ];

  static final List<RoutePage> _menuRoute = [
    RoutePage.home,
    RoutePage.downloadArea,
    RoutePage.noticeBoard,
    RoutePage.wallet,
    RoutePage.testArea,
  ];

  @override
  Widget build(BuildContext context) {
    final viewState = FeatureScreenInheritedWidget.of(context);
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          /* Drawer Header */
          DrawerHeader(
            decoration: BoxDecoration(color: Themes.defaultBackgroundColor),
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
                          localeStr
                              .messageWelcomeUser(viewState.store.user.account),
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
                            if (viewState.scaffoldKey.currentState.isDrawerOpen)
                              Navigator.pop(context);
                            RouterNavigate.navigateToPage(RoutePage.login);
                          },
                        ),
                      ),
                    ],
                  ),
          ),
          /* Drawer options list */
          Container(
            height: double.maxFinite,
            child: ListView.builder(
              itemCount: _menuRoute.length,
              itemBuilder: (context, index) {
                /* Generate Drawer List Items */
                return ListTile(
                  leading: Padding(
                    padding: EdgeInsets.only(top: 4.0, left: 8.0),
                    child: Transform.scale(
                      scale: 1.05,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Themes.iconColor)),
                        child: Transform.scale(
                          scale: 0.75,
                          child: Icon(
                            _menuIcons[index],
                            color: Themes.iconColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    _menuRoute[index].pageTitle,
                    style: TextStyle(fontSize: FontSize.MESSAGE.value),
                  ),
                  onTap: () {
                    if (RouterNavigate.current == _menuRoute[index].page)
                      return;
                    // close the drawer
                    if (viewState.scaffoldKey.currentState.isDrawerOpen)
                      Navigator.pop(context);
                    // route navigate
                    if (index == 3 && viewState.store.hasUser == false)
                      RouterNavigate.navigateToPage(RoutePage.login);
                    else
                      RouterNavigate.navigateToPage(_menuRoute[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
