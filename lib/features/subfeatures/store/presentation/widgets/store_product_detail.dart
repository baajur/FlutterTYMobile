import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';

import '../../data/models/store_product_model.dart';

class StoreProductDetail extends StatelessWidget {
  final StoreProductModel product;
  final bool canExchange;
  final double maxWidth;
  final double imageSize;
  final Function onExchange;

  StoreProductDetail({
    @required this.product,
    @required this.canExchange,
    @required this.maxWidth,
    @required this.imageSize,
    @required this.onExchange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            constraints: BoxConstraints.tight(
                Size(imageSize + 24, Global.device.comfortButtonHeight + 8.0)),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Themes.defaultWidgetColor),
              borderRadius: const BorderRadius.all(const Radius.circular(36.0)),
            ),
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: localeStr.storeProductWindowTextRemain + '   ',
                    style: TextStyle(
                      fontSize: FontSize.SUBTITLE.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${product.remain}',
                    style: TextStyle(
                      color: Themes.hintHighlightOrangeStrong,
                      fontSize: FontSize.SUBTITLE.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: maxWidth - 20,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          color: Themes.defaultWidgetColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            localeStr.storeTextItemHint,
            style: TextStyle(
              fontSize: FontSize.SUBTITLE.value,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: localeStr.storeProductWindowHint2,
                    style: TextStyle(fontSize: FontSize.SUBTITLE.value),
                  ),
                  TextSpan(
                    text: '${product.point}',
                    style: TextStyle(
                      color: Themes.hintHighlightOrangeStrong,
                      fontSize: FontSize.SUBTITLE.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: localeStr.storeProductWindowHint3,
                    style: TextStyle(
                      fontSize: FontSize.SUBTITLE.value,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(36.0),
                  ),
                  onPressed: (!canExchange) ? null : () => onExchange(),
                  child: Text(
                    (canExchange)
                        ? localeStr.storeTextItemButton
                        : localeStr.storeTextItemButtonDisabled,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
