import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart' show IconData;
import 'package:flutter_ty_mobile/features/router/route_page.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'route_list_item.freezed.dart';

@freezed
abstract class RouteListItem with _$RouteListItem {
  const factory RouteListItem({
    String replaceTitle,
    IconData iconData,
    String imageName,
    RoutePage route,
    String webUrl,
    @Default(false) bool isUserOnly,
  }) = _RouteListItem;
}
