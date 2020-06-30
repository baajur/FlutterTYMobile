import 'package:freezed_annotation/freezed_annotation.dart';

part 'flow_model.freezed.dart';

@freezed
abstract class FlowModel with _$FlowModel {
  const factory FlowModel({
    String code,
    @JsonKey(name: 'fundindex') String index,
    @JsonKey(name: 'amountlocal') String amount,
    @JsonKey(name: 'ledgerdatetime') String ledgerDatetime,
    @JsonKey(name: 'withdrawal_valid') String withdrawalValid,
    @JsonKey(name: 'promoindex') num promoIndex,
    @JsonKey(name: 'multiply') num multiply,
    @JsonKey(name: 'bind_ledgerindex') String ledgerIndex,
    @JsonKey(name: 'promosimplified') String promoSimplified,
    @JsonKey(name: 'betreslut') String betResult,
    @JsonKey(name: 'starttime') String startTime,
    @JsonKey(name: 'turnover') String turnOver,
    @JsonKey(name: 'endtime') String endTime,
    @JsonKey(name: 'rollover') String rollOver,
    dynamic key,
  }) = _FlowModel;

  static FlowModel jsonToFlowModel(Map<String, dynamic> jsonMap) {
    return _$_FlowModel(
      code: jsonMap['code'] as String,
      index: jsonMap['fundindex'] as String,
      amount: jsonMap['amountlocal'] as String,
      ledgerDatetime: jsonMap['ledgerdatetime'] as String,
      withdrawalValid: jsonMap['withdrawal_valid'] as String,
      promoIndex: jsonMap['promoindex'] as num,
      multiply: jsonMap['multiply'] as num,
      ledgerIndex: jsonMap['bind_ledgerindex'] as String,
      promoSimplified: jsonMap['promosimplified'] as String,
      betResult: jsonMap['betreslut'] as String,
      startTime: jsonMap['starttime'] as String,
      turnOver: jsonMap['turnover'] as String,
      endTime: jsonMap['endtime'] as String,
      rollOver: jsonMap['rollover'] as String,
      key: jsonMap['key'],
    );
  }
}
