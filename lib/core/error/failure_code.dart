import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:generic_enum/generic_enum.dart';

part 'failure_code.freezed.dart';

@freezed
abstract class FailureCode with _$FailureCode {
  factory FailureCode({
    @Default(FailureTypeCode.NOT_DEFINED) FailureTypeCode typeCode,
    @Default(0) int code,
  }) = _FailureCode;

  @late
  int get errorCode => typeCode.value + code;
}

class FailureTypeCode extends GenericEnum<int> {
  const FailureTypeCode._(int value) : super(value);

  static const FailureTypeCode LOGIN = FailureTypeCode._(0100);
  static const FailureTypeCode REGISTER = FailureTypeCode._(0200);
  static const FailureTypeCode WEB = FailureTypeCode._(0500);
  static const FailureTypeCode WEB_URL = FailureTypeCode._(0600);

  static const FailureTypeCode HOME = FailureTypeCode._(1000);
  static const FailureTypeCode BANNER = FailureTypeCode._(1100);
  static const FailureTypeCode MARQUEE = FailureTypeCode._(1200);
  static const FailureTypeCode GAMES = FailureTypeCode._(1300);
  static const FailureTypeCode PROMO = FailureTypeCode._(1400);
  static const FailureTypeCode SERVICE = FailureTypeCode._(1500);
  static const FailureTypeCode MORE = FailureTypeCode._(1600);

  static const FailureTypeCode MEMBER = FailureTypeCode._(2000);
  static const FailureTypeCode DEPOSIT = FailureTypeCode._(2100);
  static const FailureTypeCode TRANSFER = FailureTypeCode._(2200);
  static const FailureTypeCode BANKCARD = FailureTypeCode._(2300);
  static const FailureTypeCode WITHDRAW = FailureTypeCode._(2400);
  static const FailureTypeCode BALANCE = FailureTypeCode._(2500);
  static const FailureTypeCode WALLET = FailureTypeCode._(2600);
  static const FailureTypeCode MESSAGE = FailureTypeCode._(2700);
  static const FailureTypeCode CENTER = FailureTypeCode._(2800);
  static const FailureTypeCode TRANSACTIONS = FailureTypeCode._(2900);
  static const FailureTypeCode BETS = FailureTypeCode._(2910);
  static const FailureTypeCode DEALS = FailureTypeCode._(2920);
  static const FailureTypeCode FLOWS = FailureTypeCode._(2930);

  static const FailureTypeCode SIDE_MENU = FailureTypeCode._(3000);
  static const FailureTypeCode DOWNLOAD_AREA = FailureTypeCode._(3100);
  static const FailureTypeCode TUTORIAL = FailureTypeCode._(3200);
  static const FailureTypeCode NOTICE = FailureTypeCode._(3300);
  static const FailureTypeCode VIP_LEVEL = FailureTypeCode._(3400);
  static const FailureTypeCode STORE = FailureTypeCode._(3500);
  static const FailureTypeCode AGENT = FailureTypeCode._(3600);

  static const FailureTypeCode TASK = FailureTypeCode._(8000);

  static const FailureTypeCode NOT_DEFINED = FailureTypeCode._(9000);
}
