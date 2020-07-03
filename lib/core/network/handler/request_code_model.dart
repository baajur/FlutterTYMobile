import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_code_model.freezed.dart';

@freezed
abstract class RequestCodeModel with _$RequestCodeModel {
  factory RequestCodeModel({
    int code,
    dynamic data,
    String msg,
  }) = _RequestCodeModel;

  static RequestCodeModel jsonToCodeModel(Map<String, dynamic> jsonMap) {
    return _$_RequestCodeModel(
      code: jsonMap['code'] as int,
      data: jsonMap['data'],
      msg: jsonMap['msg'] as String,
    );
  }

  @late
  bool get isSuccess => code == 0;
}
