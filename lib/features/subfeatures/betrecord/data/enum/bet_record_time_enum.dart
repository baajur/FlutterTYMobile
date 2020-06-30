import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:generic_enum/generic_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bet_record_time_enum.freezed.dart';

@freezed
abstract class BetRecordTime with _$BetRecordTime {
  const factory BetRecordTime({
    int index,
    String label,
  }) = _BetRecordTime;
}

class BetRecordTimeEnum extends GenericEnum<BetRecordTime> {
  BetRecordTimeEnum._(BetRecordTime value) : super(value);
  static BetRecordTimeEnum today = BetRecordTimeEnum._(
      BetRecordTime(index: 0, label: localeStr.spinnerDateToday));
  static BetRecordTimeEnum yesterday = BetRecordTimeEnum._(
      BetRecordTime(index: 1, label: localeStr.spinnerDateYesterday));
  static BetRecordTimeEnum month = BetRecordTimeEnum._(
      BetRecordTime(index: 2, label: localeStr.spinnerDateMonth));
  static BetRecordTimeEnum all = BetRecordTimeEnum._(
      BetRecordTime(index: 3, label: localeStr.spinnerDateAll));
  static BetRecordTimeEnum custom = BetRecordTimeEnum._(
      BetRecordTime(index: 4, label: localeStr.spinnerDateCustom));
  static List<BetRecordTimeEnum> list = [
    BetRecordTimeEnum.today,
    BetRecordTimeEnum.yesterday,
    BetRecordTimeEnum.month,
    BetRecordTimeEnum.all,
    BetRecordTimeEnum.custom,
  ];
}
