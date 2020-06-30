import 'package:freezed_annotation/freezed_annotation.dart';

part 'withdraw_model.freezed.dart';
part 'withdraw_model.g.dart';

@freezed
abstract class WithdrawModel with _$WithdrawModel {
  const factory WithdrawModel({
    int code,
    String data,
    String msg,
}) = _WithdrawModel;

  factory WithdrawModel.fromJson(Map<String, dynamic> json) =>
      _$WithdrawModelFromJson(json);

  static WithdrawModel jsonToWithdrawModel(Map<String, dynamic> jsonMap) =>
      WithdrawModel.fromJson(jsonMap);
}