import 'package:generic_enum/generic_enum.dart';

class DealsDateEnum extends GenericEnum<int> {
  const DealsDateEnum._(int value) : super(value);

  static const DealsDateEnum TODAY = DealsDateEnum._(0);
  static const DealsDateEnum YESTERDAY = DealsDateEnum._(1);
  static const DealsDateEnum MONTH = DealsDateEnum._(2);
  static const DealsDateEnum ALL = DealsDateEnum._(3);

  static const List<DealsDateEnum> LIST = [
    DealsDateEnum.TODAY,
    DealsDateEnum.YESTERDAY,
    DealsDateEnum.MONTH,
    DealsDateEnum.ALL,
  ];
}
