import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/error/exceptions.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';

import '../../data/entity/game_entity.dart';
import '../../data/models/game_platform.dart';
import '../state/home_store.dart';
import 'grid_item_mix.dart';
import 'home_store_inherit_widget.dart';

class HomeDisplayTabRecommend extends StatefulWidget {
  final double pageMaxWidth;
  final HomeSearchPlatformClicked onPlatformClicked;

  const HomeDisplayTabRecommend({
    Key key,
    @required this.pageMaxWidth,
    @required this.onPlatformClicked,
  }) : super(key: key);

  @override
  _HomeDisplayTabRecommendState createState() =>
      _HomeDisplayTabRecommendState();
}

class _HomeDisplayTabRecommendState extends State<HomeDisplayTabRecommend> {
  final String tag = 'HomeDisplayTabRecommend';

  HomeStore _store;
  double labelHeightFactor;
  double itemSize;
  bool twoLineText = true;
  Widget _grid;
  List recommends;

  /// Pass in a [itemData] on grid item tap.
  /// [itemData] should be [GamePlatformEntity] or [GameEntity]
  /// else print warn log and show toast.
  void _onItemTap(dynamic itemData) {
    if (itemData is GamePlatformEntity) {
      widget.onPlatformClicked(itemData);
    } else if (itemData is GameEntity) {
      if (_store == null || _store.hasUser == false) {
        FLToast.showInfo(
          text: localeStr.messageErrorNotLogin,
          showDuration: ToastDuration.DEFAULT.value,
        );
      } else {
        print('opening game: ${itemData.gameUrl}');
        _store.getGameUrl(itemData.gameUrl);
      }
    } else {
      FLToast.showError(
        text: localeStr.messageErrorInternal,
        showDuration: ToastDuration.DEFAULT.value,
      );
      MyLogger.wtf(msg: 'tapped unknown item, data: $itemData', tag: tag);
    }
  }

  void _setFavorite(dynamic entity, bool favor) {
    if (entity is GamePlatformEntity || entity is GameEntity) {
      print('set ${entity.id} favor to $favor');
      _store.postFavorite(entity: entity, favorite: favor);
    }
  }

  @override
  void initState() {
    itemSize = widget.pageMaxWidth / 3 * 0.95;
    labelHeightFactor = 1.5;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('change recommend page');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(HomeDisplayTabRecommend oldWidget) {
    print('update recommend page');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    _store ??= HomeStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message: Failure.internal(FailureCode(type: FailureType.RECOMMENDS))
              .message,
        ),
      );
    }
    return Container(
      child: StreamBuilder<List>(
        stream: _store.recommendStream,
        initialData: _store.recommends,
        builder: (_, snapshot) {
          if (snapshot.data == null) _store.getRecommend();
          if (snapshot != null || snapshot.data != recommends) {
            recommends = snapshot.data;
            _grid = _createGrid();
          }
          _grid ??= Center(child: CircularProgressIndicator());
          return _grid;
        },
      ),
    );
  }

  Widget _createGrid() {
    if (recommends == null || recommends.isEmpty) return SizedBox.shrink();
    twoLineText = recommends.any(
      (element) {
        if (element is GameEntity)
          return element.cname.length >= 5;
        else if (element is GamePlatformEntity)
          return element.label.length >= 5;
        else
          return false;
      },
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GridView.count(
        physics: BouncingScrollPhysics(),
        crossAxisCount: 3,
        childAspectRatio: 0.7,
        shrinkWrap: true,
        children: recommends
            .map<Widget>((entity) => _createGridItem(entity))
            .toList(),
      ),
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

    if (twoLineText)
      textHeight = FontSize.NORMAL.value * labelHeightFactor * 2;
    else
      textHeight = FontSize.NORMAL.value * labelHeightFactor;

    return Container(
      padding: const EdgeInsets.only(top: 6.0),
      constraints: BoxConstraints.tight(Size(
        itemSize,
        itemSize + textHeight,
      )),
      child: GestureDetector(
        onTap: () => _onItemTap(entity),
        child: GridItemMix(
          isPlatform: entity is GamePlatformEntity,
          imgUrl: imgUrl,
          label: label,
          isFavorite: favor,
          itemSize: itemSize,
          textHeight: textHeight,
          twoLineText: twoLineText,
          pluginTapAction: (imgUrl != null && label != null)
              ? (isFavorite) => _setFavorite(entity, isFavorite)
              : null,
        ),
      ),
    );
  }
}
