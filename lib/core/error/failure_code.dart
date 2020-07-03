import 'package:vnum/vnum.dart';
import 'package:dataclass/dataclass.dart';

part 'failure_code.g.dart';

@dataClass
class FailureCode extends _$FailureCode {
  final FailureType type;
  final int code;

  const FailureCode({this.type = FailureType.NOT_DEFINED, this.code = 0});
}

@VnumDefinition
class FailureType extends Vnum<int> {
  /// Case Definition
  static const FailureType LOGIN = const FailureType.define(0100);
  static const FailureType REGISTER = const FailureType.define(0200);
  static const FailureType WEB = const FailureType.define(0500);
  static const FailureType WEB_URL = const FailureType.define(0600);

  static const FailureType HOME = const FailureType.define(1000);
  static const FailureType BANNER = const FailureType.define(1100);
  static const FailureType MARQUEE = const FailureType.define(1200);
  static const FailureType GAMES = const FailureType.define(1300);
  static const FailureType RECOMMENDS = const FailureType.define(1400);
  static const FailureType FAVORITE = const FailureType.define(1500);
  static const FailureType MOVIE = const FailureType.define(1600);
  static const FailureType PROMO = const FailureType.define(1700);
  static const FailureType SERVICE = const FailureType.define(1800);
  static const FailureType MORE = const FailureType.define(1900);

  static const FailureType MEMBER = const FailureType.define(2000);
  static const FailureType DEPOSIT = const FailureType.define(2100);
  static const FailureType TRANSFER = const FailureType.define(2200);
  static const FailureType BANKCARD = const FailureType.define(2300);
  static const FailureType WITHDRAW = const FailureType.define(2310);
  static const FailureType BALANCE = const FailureType.define(2400);
  static const FailureType WALLET = const FailureType.define(2500);
  static const FailureType MESSAGE = const FailureType.define(2600);
  static const FailureType CENTER = const FailureType.define(2700);
  static const FailureType TRANSACTIONS = const FailureType.define(2800);
  static const FailureType BETS = const FailureType.define(2810);
  static const FailureType DEALS = const FailureType.define(2820);
  static const FailureType FLOWS = const FailureType.define(2830);
  static const FailureType AGENT = const FailureType.define(2900);

  static const FailureType SIDE_MENU = const FailureType.define(3000);
  static const FailureType DOWNLOAD_AREA = const FailureType.define(3100);
  static const FailureType TUTORIAL = const FailureType.define(3200);
  static const FailureType NOTICE = const FailureType.define(3300);
  static const FailureType VIP_LEVEL = const FailureType.define(3400);
  static const FailureType STORE = const FailureType.define(3500);
  static const FailureType ROLLER = const FailureType.define(3600);

  static const FailureType TASK = const FailureType.define(8000);
  static const FailureType JSON = const FailureType.define(8100);
  static const FailureType REPO = const FailureType.define(8200);

  static const FailureType NOT_DEFINED = const FailureType.define(9000);

  /// Used for defining cases
  const FailureType.define(int fromValue) : super.define(fromValue);
}
