import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('test char to unicode', () {
    String str = '一';
    print('${str.codeUnits}');
    print('${str.runes}');
    print('${utf8.encode(str)}');
    print(covertStringToUnicode(str));

    String eng = 'a';
    print('${eng.codeUnits}');
    print('${eng.runes}');
    print('${utf8.encode(eng)}');
    print(covertStringToUnicode(eng));
  });
}

String covertStringToUnicode(String content) {
  String regex = "\\u";
  int offset = content.indexOf(regex) + regex.length;
  while (offset > -1 + regex.length) {
    int limit = offset + 4;
    String str = content.substring(offset, limit);
    if (str != null && str.isNotEmpty) {
      String code = String.fromCharCode(int.parse(str, radix: 16));
      content = content.replaceFirst(str, code, offset);
    }
    offset = content.indexOf(regex, limit) + regex.length;
  }
  return content.replaceAll(regex, "");
}
