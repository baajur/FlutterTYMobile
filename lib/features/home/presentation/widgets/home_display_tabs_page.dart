import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/error/exceptions.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/loading_widget.dart';

import '../../data/entity/game_entity.dart';
import '../../data/form/platform_game_form.dart';
import '../../data/models/game_platform.dart';
import '../state/home_store.dart';
import 'grid_item_game.dart';
import 'grid_item_platform.dart';
import 'home_store_inherit_widget.dart';

///
/// Create Platforms and Games [GridView]
/// @author H.C.CHIANG
/// @version 2020/6/20
///
class HomeDisplayTabsPage extends StatefulWidget {
  final String category;
  final double pageMaxWidth;
  final bool addSearchListener;
  final bool addPlugin;

  HomeDisplayTabsPage({
    @required this.pageMaxWidth,
    @required this.category,
    this.addSearchListener = false,
    this.addPlugin = false,
  });

  @override
  _HomeDisplayTabsPageState createState() => _HomeDisplayTabsPageState();
}

class _HomeDisplayTabsPageState extends State<HomeDisplayTabsPage>
    with AfterLayoutMixin {
  final String tag = 'HomeDisplayTabsPage';

  HomeStore _store;
  List<GamePlatformEntity> platforms;

  Widget _grid;
  Widget _gamesView;
  bool _isGameGrid = false;
  int plusGrid;
  double labelHeightFactor;
  double platformItemSize;
  double gameItemSize;

  GamePlatformEntity _currentPlatform;
  List<GameEntity> games;
  bool twoLineText = true;

  String _searched;
  GamePlatformEntity _searchPlatform;

  String _getMapKey(GamePlatformEntity platform) {
    return '${platform.site}/${platform.category}';
  }

  PlatformGameForm _createForm(GamePlatformEntity platform) {
    _currentPlatform = platform;
    return PlatformGameForm(
      category: platform.category,
      platform: platform.site,
    );
  }

  void _setContent(Widget widget) {
    setState(() {
      _grid = widget;
    });
  }

  /// Pass in a [itemData] on grid item tap or back button pressed.
  /// [itemData] should be [GamePlatformEntity] or [GameEntity]
  /// else throw [UnknownConditionException].
  String _onItemTap(dynamic itemData, {bool search = false}) {
    print('onItemTap page: $itemData');
    if (itemData is GamePlatformEntity) {
      if (search)
        _setContent(_buildGamesView(itemData));
      else if (_isGameGrid) {
//        print('clicked back');
        _setContent(_createPlatformGrid());
      } else if (itemData.isGameHall == false) {
//        print('clicked platform: ${itemData.className}, data: $itemData');
        _setContent(_buildGamesView(itemData));
      } else {
        print('clicked game: ${itemData.gameUrl}');
        return itemData.gameUrl;
      }
    } else if (itemData is GameEntity) {
      print('clicked game: ${itemData.gameUrl}');
      return itemData.gameUrl;
    } else {
      MyLogger.warn(msg: 'tapped item unknown, data: $itemData', tag: tag);
    }
    return '';
  }

  void _openGame(String url) {
    if (_store.hasUser == false)
      FLToast.showInfo(
        text: localeStr.messageErrorNotLogin,
        showDuration: ToastDuration.DEFAULT.value,
      );
    else if (_store != null) _store.getGameUrl(url);
  }

  void _setFavorite(dynamic entity, bool favor) {
    if (entity is GamePlatformEntity || entity is GameEntity) {
      print('set ${entity.id} favor to $favor');
      _store.postFavorite(entity: entity, favorite: favor);
    }
  }

  @override
  void initState() {
    plusGrid = (Global.device.widthScale > 1.5) ? 1 : 0;
    if (plusGrid > 0) {
      if (Global.device.widthScale > 2.0) {
        labelHeightFactor = 1.75;
      } else {
        labelHeightFactor = 1.625;
      }
    } else {
      labelHeightFactor = 1.5;
    }
    platformItemSize = widget.pageMaxWidth / (2 + plusGrid) * 1.05;
    gameItemSize = widget.pageMaxWidth / (3 + plusGrid) * 0.95;
    super.initState();
  }

  @override
  void didUpdateWidget(HomeDisplayTabsPage oldWidget) {
    print("update game-page=${widget.category}");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    print("change game-page=${widget.category}");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(type: FailureType.HOME)).message,
        ),
      );
    }

    platforms ??= _store.homePlatformMap[widget.category];
    _grid ??= _createPlatformGrid();
    return _grid;
  }

  /// Main layer to show platforms under category
  Widget _createPlatformGrid() {
    _isGameGrid = false;
    return GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 12.0),
      crossAxisCount: 2 + plusGrid,
      crossAxisSpacing: 4.0,
      childAspectRatio: (plusGrid > 0) ? 1.05 : 0.9,
      shrinkWrap: true,
      children: platforms.map((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Second Layer to show games under platform
  Widget _buildGamesView(GamePlatformEntity platform) {
    _isGameGrid = true;
    if (platform != _currentPlatform) {
      _gamesView = _createGameListListener(
        _createForm(platform),
        _getMapKey(platform),
      );
    }
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          /*
          Platform name and a return button
          */
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: Icon(Icons.arrow_back_ios, size: 20),
                onPressed: () {
                  String url = _onItemTap(platform);
                  if (url.isNotEmpty) _openGame(url);
                },
              ),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                    height: FontSize.SUBTITLE.value * 1.5),
                child: networkImageBuilder(platform.iconUrl),
              ),
              SizedBox(width: 12.0),
              Padding(
                padding: const EdgeInsets.only(bottom: 3.0),
                child: Text(
                  platform.label,
                  style: TextStyle(fontSize: FontSize.SUBTITLE.value),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          /*
          Games grid
          */
          _gamesView,
        ],
      ),
    );
  }

  Widget _createGameListListener(PlatformGameForm form, String mapKey) {
    return StreamBuilder<String>(
      stream: _store.gamesStream,
      initialData: '',
      builder: (_, snapshot) {
        if (snapshot.data == mapKey || _store.hasPlatformGames(mapKey)) {
          return _createGamesGrid(_store.getPlatformGames(mapKey));
        } else {
          _store.getGames(form, mapKey);
          return LoadingWidget(heightFactor: 3);
        }
      },
    );
  }

  Widget _createGamesGrid(List<GameEntity> list) {
    games = List.from(list);
    twoLineText = games.any((element) => element.cname.length >= 5);
    return new GridView.count(
      physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 12.0),
      crossAxisCount: 3 + plusGrid,
      childAspectRatio: (plusGrid > 0) ? 0.85 : 0.7,
      shrinkWrap: true,
      children: games.map((entity) => _createGridItem(entity)).toList(),
    );
  }

  /// Create grid item for data [entity]
  /// Returns a [Stack] widget with image and name
  Widget _createGridItem(dynamic entity) {
    String label;
    String imgUrl;
    double textHeight;
    bool favor = false;

    if (entity is GameEntity) {
      label = entity.cname;
      imgUrl = entity.imageUrl;
      favor = entity.favorite == 1;
    } else if (entity is GamePlatformEntity) {
      label = entity.label;
      imgUrl = entity.imageUrl;
      favor = entity.favorite == '1';
    } else {
      MyLogger.warn(
          msg: '${UnknownConditionException()}!! Grid item: $entity', tag: tag);
    }

    if (!_isGameGrid)
      textHeight = FontSize.SUBTITLE.value * labelHeightFactor;
    else if (twoLineText)
      textHeight = FontSize.NORMAL.value * labelHeightFactor * 2;
    else
      textHeight = FontSize.NORMAL.value * labelHeightFactor;

    return Container(
      padding: const EdgeInsets.only(top: 6.0),
      constraints: (!_isGameGrid)
          ? BoxConstraints.tight(Size(
              platformItemSize,
              platformItemSize + textHeight,
            ))
          : BoxConstraints.tight(Size(
              gameItemSize,
              gameItemSize + textHeight,
            )),
      child: GestureDetector(
        onTap: () {
          String url = _onItemTap(entity);
          if (url.isNotEmpty) _openGame(url);
        },
        child: (!_isGameGrid)
            ? GridItemPlatform(
                imgUrl: imgUrl,
                label: label,
                isFavorite: favor,
                itemSize: platformItemSize,
                textHeight: textHeight,
                pluginTapAction:
                    (widget.addPlugin && imgUrl != null && label != null)
                        ? (isFavorite) => _setFavorite(entity, isFavorite)
                        : null,
              )
            : GridItemGame(
                imgUrl: imgUrl,
                label: label,
                isFavorite: favor,
                itemSize: gameItemSize,
                textHeight: textHeight,
                twoLineText: twoLineText,
                pluginTapAction:
                    (widget.addPlugin && imgUrl != null && label != null)
                        ? (isFavorite) => _setFavorite(entity, isFavorite)
                        : null,
              ),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.addSearchListener) {
      if (_searched == null) {
        _searched = _store.searchPlatform;
        if (_searched != null) findPlatform();
      }
      _store.showPlatformStream.listen((event) {
        if (event.contains(widget.category) == false) return;
        print('page ${widget.category} received search $event');
        _searched = event;
        findPlatform();
      });
    }
  }

  void findPlatform() {
    _searchPlatform = platforms.singleWhere(
      (element) => element.className == _searched,
      orElse: () => null,
    );
    print('search platform: $_searchPlatform');
    if (_searchPlatform != null) {
      _onItemTap(_searchPlatform, search: true);
      _store.clearSearch();
    }
  }
}
