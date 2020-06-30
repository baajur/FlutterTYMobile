import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';
import 'package:flutter_ty_mobile/utils/regex_util.dart';

void main() {
  test('test value int', () {
    expect(stringToInt('100') == 100, true);
    expect(stringToInt('100.00') == 100, true);
    expect(stringToInt('￥100') == 100, true);
    expect(stringToInt('100.50') == 100, true);
  });

  test('test value equal', () {
    expect(valueIsEqual('100.00', '100'), true);
    expect(valueIsEqual('100.50', '100'), false);
    expect(valueIsEqual('100.00', '￥100'), true);
  });

  test('test number format', () {
    var num = 1000.50;
    expect(formatNum(num), '1000.50');
    expect(formatNum(num, addCreditSign: true), '￥1,000.50');
    expect(formatNum(num, floorIfInt: true), '1000.50');
    expect(formatNum(num, floorIfInt: true, addCreditSign: true), '￥1,000.50');

    var num2 = 1000.00;
    expect(formatNum(num2), '1000.00');
    expect(formatNum(num2, addCreditSign: true), '￥1,000.00');
    expect(formatNum(num2, floorIfInt: true), '1000');
    expect(formatNum(num2, floorIfInt: true, addCreditSign: true), '￥1,000');
  });

  test('test credit format', () {
    var value = '￥1000.50';
    print('\ntest: $value');
    print('test format = ${formatValue(value)}');
    print('test credit = ${formatValue(value, creditSign: true)}');
    print('test floorIfInt = ${formatValue(value, floorIfInt: true)}');
    print(
        'test floorIfInt credit = ${formatValue(value, floorIfInt: true, creditSign: true)}');

    var value2 = '￥1000.00';
    print('\ntest2: $value2');
    print('test2 format = ${formatValue(value2)}');
    print('test2 remove credit = ${formatValue(value2, creditSign: false)}');
    print('test2 floor = ${formatValue(value2, floor: true)}');
  });

  test('test string verify', () {
    expect(Global.TEST_BASE_URL.isUrl, true);
    expect('a1234@'.isEmail, false);
    expect('a1234@yahoo.com'.isEmail, true);
    var html =
        '<!DOCTYPE html> <html style="height:100%"> <head> <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"> <title> 404 Not Found</title></head> <body style="color: #444; margin:0;font: normal 14px/20px Arial, Helvetica, sans-serif; height:100%; background-color: #fff;"> <div style="height:auto; min-height:100%; ">     <div style="text-align: center; width:800px; margin-left: -400px; position:absolute; top: 30%; left:50%;"> <h1 style="margin:0; font-size:150px; line-height:150px; font-weight:bold;">404</h1> <h2 style="margin-top:20px;font-size: 30px;">Not Found</h2> <p>The resource requested could not be found on this server!</p></div></div></body></html>';
    expect(html.isHtmlFormat, true);
  });
}
