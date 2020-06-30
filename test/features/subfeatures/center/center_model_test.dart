import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ty_mobile/features/subfeatures/accountcenter/data/models/center_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/accountcenter/data/models/center_vip_setting_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/accountcenter/data/entity/center_vip_entity.dart';

import '../../../fixtures/fixture_reader.dart';

void main() {
  final map = json.decode(fixture('subfeatures/center/center.json'));

  final mapSetting =
      json.decode(fixture('subfeatures/center/center_vip_setting.json'));

  test('test vip setting item decode step', () {
    print(mapSetting);
    var data = mapSetting['1'];
    print(data);
    print(data.runtimeType);
    var setting = data['setting'];
    print(setting);
    CenterVipSettingItem item =
        CenterVipSettingModel.jsonToCenterVipSettingItem(setting);
    print(item);
  });

  test('test vip setting decode', () {
    CenterModel model = CenterModel.jsonToCenterModel(map);
    print('\n$model\n\n');
    print('${model.vipOption}\n\n');
    print('${model.vipSetting}\n\n');

    print('Level Keys:\n');
    print('${model.vipOption.keys.toList()}\n\n');

    print('Block Titles:\n');
    print('${model.vipOption.values.toList()}\n\n');

    var setting = jsonEncode(model.vipSetting);
    print('Setting:\n');
    print('$setting\n\n');

    Map<String, dynamic> mapped = jsonDecode(setting);
    print('Mapped Setting:\n');
    print('$mapped\n\n');

    List levelRequirement = new List();
    List levelTitles = mapped.values.map((value) {
      var content = jsonDecode(jsonEncode(value));
      print('$content');
      CenterVipSettingItem item =
          CenterVipSettingModel.jsonToCenterVipSettingItem(content['setting']);
      print('-> $item');
      levelRequirement.add(item);
      return content['title'];
    }).toList();

    print('\nLevel Titles:\n');
    print('$levelTitles\n\n');

    print('Level Requirements:\n');
    print('$levelRequirement\n\n');
  });

  test('simplfy for decoding', () {
    CenterModel model = CenterModel.jsonToCenterModel(map);
//    String setting = jsonEncode(model.vipSetting);
    List<String> levelTitles = new List();
    Map<String, CenterVipSettingItem> mapped =
        Map<String, CenterVipSettingItem>.from(
            model.vipSetting.map((key, value) {
      levelTitles.add(value['title']);
      return MapEntry(key.toString(),
          CenterVipSettingModel.jsonToCenterVipSettingItem(value['setting']));
    }));

    print('Block Keys:\n');
    List<String> blockKeys =
        new List.from(model.vipOption.keys.map((value) => '$value'));
    print('$blockKeys\n\n');
    expect(blockKeys, isA<List<String>>());

    print('Block Titles:\n');
    List<String> blockTitles =
        new List.from(model.vipOption.values.map((value) => '$value'));
    print('$blockTitles\n\n');
    expect(blockTitles, isA<List<String>>());

    print('Level Titles:\n');
    print('$levelTitles\n\n');

    print('Mapped Setting:\n');
    print('$mapped\n\n');
    expect(mapped, isA<Map<String, CenterVipSettingItem>>());
  });

  test('test vip entity extension', () {
    CenterModel model = CenterModel.jsonToCenterModel(map);
    CenterVipEntity entity = model.wrapVipData;

    print('Block Keys:\n');
    List<String> blockKeys = entity.getBlockKeys;
    print('$blockKeys\n\n');
    expect(blockKeys, isA<List<String>>());

    print('Block Titles:\n');
    List<String> blockTitles = entity.getBlockTitles;
    print('$blockTitles\n\n');
    expect(blockTitles, isA<List<String>>());

    print('Level Titles:\n');
    List<String> levelTitles = entity.getLevelLabels;
    print('$levelTitles\n\n');
    expect(levelTitles, isA<List<String>>());

    print('Level Requirements:\n');
    Map<String, CenterVipSettingItem> levelRequirements =
        entity.getLevelRequirements;
    print('$levelRequirements\n\n');
    expect(levelRequirements, isA<Map<String, CenterVipSettingItem>>());
  });
}
