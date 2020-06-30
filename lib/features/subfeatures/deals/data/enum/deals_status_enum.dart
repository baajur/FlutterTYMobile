import 'package:generic_enum/generic_enum.dart';

class DealsStatusEnum extends GenericEnum<int> {
  const DealsStatusEnum._(int value) : super(value);

  static const DealsStatusEnum ALL = DealsStatusEnum._(0);
  static const DealsStatusEnum SUCCESS = DealsStatusEnum._(1);
  static const DealsStatusEnum FAIL = DealsStatusEnum._(2);
  static const DealsStatusEnum PROCESSING = DealsStatusEnum._(3);
  static const DealsStatusEnum NEW_DEAL = DealsStatusEnum._(4);

  static const List<DealsStatusEnum> LIST = [
    DealsStatusEnum.ALL,
    DealsStatusEnum.SUCCESS,
    DealsStatusEnum.FAIL,
    DealsStatusEnum.PROCESSING,
    DealsStatusEnum.NEW_DEAL,
  ];
}
