import 'package:flutter_ty_mobile/core/base/data_operator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'game_platform.freezed.dart';
part 'game_platform.g.dart';

typedef HomeSearchPlatformClicked = void Function(GamePlatformEntity);

@freezed
abstract class GamePlatform with _$GamePlatform {
  const factory GamePlatform.model({
    @required int id,
    @JsonKey(name: 'class', fromJson: decodePlatformClassName) String className,
    @JsonKey(fromJson: decodePlatformChName) String ch,
    int cid,
    @required String site,
    String site2,
    @JsonKey(name: 'type', required: true) String category,
    int sort,
    String status,
    @Default('0') String favorite,
  }) = GamePlatformModel;

  @HiveType(typeId: 104)
  @Implements(DataOperator)
  const factory GamePlatform.entity({
    @HiveField(0) @required int id,
    @HiveField(1)
    @JsonKey(name: 'class', fromJson: decodePlatformClassName)
        String className,
    @HiveField(2) @JsonKey(fromJson: decodePlatformChName) String ch,
    @HiveField(3) @required String site,
    @HiveField(4) @JsonKey(name: 'type', required: true) String category,
    @Default('0') String favorite,
  }) = GamePlatformEntity;

  factory GamePlatform.fromJson(Map<String, dynamic> json) =>
      _$GamePlatformFromJson(json);

  static GamePlatformModel jsonToGamePlatformModel(
      Map<String, dynamic> jsonMap) {
    jsonMap['runtimeType'] = 'model';
    return _$GamePlatformFromJson(jsonMap);
  }

  static GamePlatformEntity jsonToGamePlatformEntity(
      Map<String, dynamic> jsonMap) {
    jsonMap['runtimeType'] = 'entity';
    return _$GamePlatformFromJson(jsonMap);
  }

//  @override
//  String operator [](String key) {
//    return className.toString();
//  }
}

String decodePlatformClassName(dynamic str) => (str.containsKey('class'))
    ? '${str['class']}'
    : '${str['site']}-${str['type']}';

String decodePlatformChName(dynamic str) => (str.containsKey('ch'))
    ? '${str['ch']}'
    : '${'${str['site']}'.toUpperCase()} ${str['type']}';

extension GamePlatformModelExtension on GamePlatformModel {
  GamePlatformEntity get entity => GamePlatformEntity(
        id: id,
        className: className,
        ch: ch,
        site: site,
        category: category,
        favorite: favorite,
      );
}

extension GamePlatformEntityExtension on GamePlatformEntity {
  bool get isGameHall => ['casino', 'sport', 'lottery'].contains(category);
  String get iconUrl => '/images/index/logo/${site.toUpperCase()}.png';
  String get imageUrl => '/images/index/nav_${site}_$category.png';
  String get gameUrl => '$site/$category/0';
  String get label {
    switch (category) {
      case 'casino':
        return '${site.toUpperCase()}真人';
      case 'slot':
        return '${site.toUpperCase()}电子';
      case 'sport':
        return '${site.toUpperCase()}体育';
      case 'fish':
        return '${site.toUpperCase()}捕鱼';
      case 'lottery':
        return '${site.toUpperCase()}彩票';
      case 'card':
        return '${site.toUpperCase()}棋牌';
      default:
        return ch;
    }
  }
}
