import 'package:generic_enum/generic_enum.dart';

class DealsTypeEnum extends GenericEnum<int> {
  const DealsTypeEnum._(int value) : super(value);

  static const DealsTypeEnum ALL = DealsTypeEnum._(0);
  static const DealsTypeEnum DEPOSIT = DealsTypeEnum._(1);
  static const DealsTypeEnum WITHDRAW = DealsTypeEnum._(2);
  static const DealsTypeEnum BONUS = DealsTypeEnum._(3);

  static const List<DealsTypeEnum> LIST = [
    DealsTypeEnum.ALL,
    DealsTypeEnum.DEPOSIT,
    DealsTypeEnum.WITHDRAW,
    DealsTypeEnum.BONUS,
  ];
}
