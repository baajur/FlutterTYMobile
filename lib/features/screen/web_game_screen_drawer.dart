import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/router/app_navigate.dart';
import 'package:flutter_ty_mobile/features/router/route_user_streams.dart';
import 'package:flutter_ty_mobile/features/screen/screen_drawer_item.dart';
import 'package:flutter_ty_mobile/features/screen/web_game_screen_store.dart';

part 'web_game_screen_drawer_tile.dart';

final double _gameDrawerMaxWidth = 160;
final double _gameDrawerMinWidth = 64;
final double _gameDrawerItemTitleShowOnWidth = 134;

class WebGameScreenDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final WebGameScreenStore store;

  WebGameScreenDrawer({
    @required this.scaffoldKey,
    @required this.store,
  });

  @override
  _WebGameScreenDrawerState createState() => _WebGameScreenDrawerState();
}

class _WebGameScreenDrawerState extends State<WebGameScreenDrawer>
    with SingleTickerProviderStateMixin {
  final List<ScreenDrawerItem> itemList = [
    ScreenDrawerItem.backHome,
    ScreenDrawerItem.rotate,
  ];

  AnimationController _animationController;
  Animation<double> _widthAnimation;
  bool isCollapsed = true;

  String username;
  int userLevel;

  @override
  void initState() {
    userLevel = getRouteUserStreams.userLevel;
    username = getRouteUserStreams.userName;
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _widthAnimation =
        Tween<double>(begin: _gameDrawerMinWidth, end: _gameDrawerMaxWidth)
            .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) => Material(
        elevation: 8.0,
        child: Container(
          width: _widthAnimation.value,
          height: Global.device.height,
          color: Colors.black54,
          child: Column(
            children: [
              if (widget.store.isScreenPortrait)
                SizedBox(
                  height: (isCollapsed) ? 100 : 144,
                  child: DrawerHeader(
                    decoration:
                        BoxDecoration(color: Themes.defaultBackgroundColor),
                    margin: const EdgeInsets.only(bottom: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/vip/user_vip_$userLevel.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        if (!isCollapsed)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 12.0),
                              child: Text(
                                username,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (_, index) {
//                  return Divider(height: 12.0);
                    return SizedBox(height: 4.0);
                  },
                  itemCount: itemList.length,
                  itemBuilder: (_, index) {
                    RouteListItem item = itemList[index].value;
                    return WebGameScreenDrawerTile(
                      item: item,
                      animationController: _animationController,
                      onTap: () {
                        if (item.route == RoutePage.home) {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('tap button home')),
                          );
                          ScreenNavigate.switchScreen(
                            force: true,
                            screen: ScreenEnum.Feature,
                          );
                        } else {
                          switch (index) {
                            case 1:
                              Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('tap button rotate')),
                              );
                              widget.store.rotateScreenLeft();
                              break;
                            default:
                              break;
                          }
                        }
                        if (widget.scaffoldKey.currentState.isDrawerOpen)
                          Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(content: Text('tap list view')),
                  );
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.reverse()
                        : _animationController.forward();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: AnimatedIcon(
                    icon: AnimatedIcons.view_list,
                    color: Themes.iconColorLightGrey,
                    progress: _animationController,
                    size: 30.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
