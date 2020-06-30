import 'package:vnum/vnum.dart';

class PromoCategory {
  final int id;
  final String category;
  final String label;
  final String iconUrl;

  const PromoCategory(this.id, this.category, this.label, this.iconUrl);
}

@VnumDefinition
class PromoCategoryEnum extends Vnum<PromoCategory> {
  /// Case Definition
  static const PromoCategoryEnum all = const PromoCategoryEnum.define(
      const PromoCategory(0, 'All', '全部', 'images/index/all.png'));
  static const PromoCategoryEnum fish = const PromoCategoryEnum.define(
      const PromoCategory(1, 'fish', '捕鱼', 'images/index/fish.png'));
  static const PromoCategoryEnum slot = const PromoCategoryEnum.define(
      const PromoCategory(2, 'slot', '电子', 'images/index/slot.png'));
  static const PromoCategoryEnum live = const PromoCategoryEnum.define(
      const PromoCategory(3, 'live', '真人', 'images/index/casino.png'));
  static const PromoCategoryEnum sport = const PromoCategoryEnum.define(
      const PromoCategory(4, 'sports', '体育', 'images/index/sport.png'));
  static const PromoCategoryEnum lottery = const PromoCategoryEnum.define(
      const PromoCategory(5, 'lotto', '彩票', 'images/index/lottery.png'));
  static const PromoCategoryEnum other = const PromoCategoryEnum.define(
      const PromoCategory(6, 'other', '其他', 'images/index/icon-other.png'));

  /// Used for defining cases
  const PromoCategoryEnum.define(PromoCategory fromValue)
      : super.define(fromValue);

  /// Used for loading enum using value
  factory PromoCategoryEnum(PromoCategory value) =>
      Vnum.fromValue(value, PromoCategoryEnum);

  /// Iterating cases
  Iterable get listAll => Vnum.allCasesFor(PromoCategoryEnum);

  /// (optional) Extend your Vnums
  //PromoCategory example() {
  //  switch(value) {
  //    default:
  //      return PromoCategoryEnum.example.value;
  //  };
  //}
}
