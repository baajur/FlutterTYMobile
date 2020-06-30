import 'package:freezed_annotation/freezed_annotation.dart';

part 'agent_model.freezed.dart';

@freezed
abstract class AgentModel with _$AgentModel {
  const factory AgentModel({
    int code,
    List<dynamic> descendant,
    String qrcode,
    String upline,
    String url,
  }) = _AgentModel;

  static AgentModel jsonToAgentModel(Map<String, dynamic> jsonMap) {
    return _$_AgentModel(
      code: jsonMap['code'] as int,
      descendant: jsonMap['descendant'],
      qrcode: jsonMap['qrcode'] as String,
      upline: jsonMap['upline'] as String,
      url: jsonMap['url'] as String,
    );
  }
}
