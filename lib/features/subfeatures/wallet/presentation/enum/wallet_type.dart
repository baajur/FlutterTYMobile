import 'package:generic_enum/generic_enum.dart';

class WalletType extends GenericEnum<String> {
  const WalletType._(String value) : super(value);
  static const WalletType SINGLE = WalletType._('1');
  static const WalletType MULTI = WalletType._('0');
}
