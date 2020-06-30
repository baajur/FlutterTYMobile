import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ty_mobile/features/subfeatures/agent/data/models/agent_commission_model.dart';
import 'package:flutter_ty_mobile/utils/json_util.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  Map<String, dynamic> map =
      json.decode(fixture('subfeatures/agent/agent_commission.json'));

  test('test commission ad model', () {
    print('decoded map: $map');
    print('\n\n');
    List<AgentCommissionModel> list = JsonUtil.decodeMapToModelList(map,
        (jsonMap) => AgentCommissionModel.jsonToAgentCommissionModel(jsonMap));
    print('model list: $list');
    expect(list.length, 6);
  });
}
