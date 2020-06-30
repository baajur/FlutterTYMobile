import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ty_mobile/features/home/data/form/platform_game_form.dart';

final String jsonString = '{"category":"casino","platform":"eg"}';

final PlatformGameForm form = PlatformGameForm(
  category: 'casino',
  platform: 'eg',
);

void main() {
  test('test json encode', () {
    final testJson = form.toJson();
    final decode = jsonDecode(jsonString);
    print(testJson);
    expect(testJson, decode);
  });
}
