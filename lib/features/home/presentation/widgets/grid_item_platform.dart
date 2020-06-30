import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/internal/font_size.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:relative_layout/relative_layout.dart';

import 'grid_plugin_favorite.dart';

class GridItemPlatform extends StatelessWidget {
  final String imgUrl;
  final String label;
  final bool isFavorite;
  final double itemSize;
  final double textHeight;
  final PluginTapAction pluginTapAction;

  GridItemPlatform({
    @required this.imgUrl,
    @required this.label,
    @required this.isFavorite,
    @required this.itemSize,
    @required this.textHeight,
    @required this.pluginTapAction,
  });

  @override
  Widget build(BuildContext context) {
    return RelativeLayout(
      children: <Widget>[
        LayoutId(
          id: RelativeId('img', alignment: Alignment.topCenter),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            constraints: BoxConstraints(
              maxWidth: itemSize,
              maxHeight: itemSize - textHeight,
            ),
            child: (imgUrl != null)
                ? networkImageBuilder(imgUrl, fill: true)
                : Center(child: Icon(Icons.broken_image)),
          ),
        ),
        LayoutId(
          id: RelativeId(
            'lb',
            alignBottom: 'img',
            alignment: Alignment.center,
          ),
          child: Container(
            constraints: BoxConstraints.tightFor(
              width: itemSize * 0.85,
              height: textHeight,
            ),
            child: Text(
              label ?? '?',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: FontSize.SUBTITLE.value,
              ),
            ),
          ),
        ),
        if (pluginTapAction != null)
          LayoutId(
            id: RelativeId('fav', alignment: Alignment.topLeft),
            child: GridPluginFavorite(
              initValue: isFavorite,
              onTap: (checked) => pluginTapAction(checked),
            ),
          ),
      ],
    );
  }
}
