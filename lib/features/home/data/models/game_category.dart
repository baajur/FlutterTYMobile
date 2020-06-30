part of 'game_category_model.dart';

class GameCategoryInfo {
  final String iconUrl;
  final String label;

  const GameCategoryInfo(this.iconUrl, this.label);
}

@VnumDefinition
class GameCategory extends Vnum<GameCategoryInfo> {
  /// Case Definition
  static const GameCategory casino = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_casino.png', '真人娱乐'));
  static GameCategory slot = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_slot.png', '电子游戏'));
  static GameCategory sport = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_sport.png', '体育竞技'));
  static GameCategory fish = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_fish.png', '捕鱼电玩'));
  static GameCategory lottery = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_lottery.png', '彩票投注'));
  static GameCategory card = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_card.png', '热门棋牌'));
  static GameCategory gift = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_gift.png', '礼物'));

  static GameCategory movie = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_movie.png', '影城'));
  static GameCategory egMovie = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_movie.png', 'EG影城'));
  static GameCategory newMovie = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_movie.png', '新影城'));

  static GameCategory recommend = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_recommend.png', '站长推荐'));
  static GameCategory favorite = const GameCategory.define(
      const GameCategoryInfo('images/index/tbico_love.png', '我的最爱'));

  /// Used for defining cases
  const GameCategory.define(GameCategoryInfo fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory GameCategory(GameCategoryInfo value) =>
      Vnum.fromValue(value, GameCategory);
}

Map<String, GameCategoryInfo> _categoryMap = {
  'casino': GameCategory.casino.value,
  'slot': GameCategory.slot.value,
  'sport': GameCategory.sport.value,
  'fish': GameCategory.fish.value,
  'lottery': GameCategory.lottery.value,
  'card': GameCategory.card.value,
  'gift': GameCategory.gift.value,
  'movie': GameCategory.movie.value,
  'eg_movie': GameCategory.egMovie.value,
  'new_movie': GameCategory.newMovie.value,
  'recommend': GameCategory.recommend.value,
  'fav': GameCategory.favorite.value,
};
