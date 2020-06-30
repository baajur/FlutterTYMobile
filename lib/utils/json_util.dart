import 'dart:convert';

import 'package:flutter_ty_mobile/core/error/exceptions.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/regex_util.dart';

class JsonUtil {
  static const String debugTag = 'JsonDecodeUtil';

  static String getRawJson(dynamic jsonStr) =>
      (jsonStr != null) ? '$jsonStr' : '';

  /// trim json [str] to prevent data error while decoding
  static String trimJson(dynamic str) {
    final trimRegex = RegExp(r"\s+\b|\b\s|\n|\r\n|\r|\s|\t");
    final trimRegexSimple = RegExp('r"\n|\r\n|\r|\t"');
    final tagRegex = RegExp('>\\s*<');
    String jsonStr = """$str""";
    bool hasHtmlTag = jsonStr.contains(tagRegex);
    String strBody = (hasHtmlTag)
        ? jsonStr.replaceAll(trimRegexSimple, "").replaceAll('> <', "><")
        : jsonStr.replaceAll(trimRegex, "");
//    print("trimmed: $strBody");
    if (strBody.isHtmlFormat) throw LocationException();
    return strBody;
  }

  /// Decode json array [str] into [dynamic] List
  static List decodeArray(
    dynamic str, {
    bool returnNullOnError = false,
    bool trim = true,
    String tag = debugTag,
  }) {
    final trimmed = (trim) ? trimJson(str) : str;
    if (trimmed.isEmpty) return [];
    try {
      List decoded = jsonDecode(trimmed);
//      print("Decoded type: ${decoded.runtimeType} Json: $decoded");
      if (decoded.isEmpty && trimmed.isNotEmpty)
        MyLogger.warn(msg: 'decoded data list is empty!!', tag: tag);
      return decoded;
    } catch (e, s) {
      if (returnNullOnError) {
        print('decode json array error:\n$e');
        return null;
      } else {
        print('decode json array error:\n$s');
        throw JsonFormatException(trimmed);
      }
    }
  }

  ///
  /// Decode json array into list of [T]
  ///
  /// [data] = json data, can be a decoded list or json string
  /// [jsonToModel] = function that transforms the mapped json to model
  /// [tag] = logger tag
  ///
  static List<T> decodeArrayToModel<T>(
    dynamic data,
    Function(Map<String, dynamic> jsonMap) jsonToModel,
    bool trim,
    String tag,
  ) {
    MyLogger.debug(msg: 'start decoding array data to $T...', tag: tag);
    print('data type: ${data.runtimeType}, data is List: ${data is List}');
    List<dynamic> list;
    if (data is List)
      list = data;
    else if (data is String)
      list = decodeArray(data, trim: trim, tag: tag);
    else
      throw UnknownConditionException();
    // mapped decoded data to model data list
    final dataList = list.map((model) => jsonToModel(model) as T).toList();
    if (dataList.isEmpty) {
      MyLogger.error(
          msg: 'mapped model list error!! data: $data\nmapped json: $list',
          tag: tag);
      throw MapJsonDataException();
    } else {
//      for (int index = 0; index < dataList.length; index++) {
//        print('mapped data $index: ${dataList[index]}');
//      }
      return dataList;
    }
  }

  ///
  /// Decode json array into list of [T]
  ///
  /// [data] = json data, can be a decoded list or json string
  /// [jsonToModel] = function that transforms the mapped json to model
  /// [tag] = logger tag
  ///
  static List<T> decodeMapToModelList<T>(
    dynamic map,
    Function(Map<String, dynamic> jsonMap) jsonToModel,
    bool trim,
    String tag,
  ) {
    print('decodeMapToModelList: $map, type: ${map.runtimeType}');
    if (map == null || map is Map == false) return [];
    MyLogger.debug(msg: 'start decoding map to $T list...', tag: tag);
    List<T> dataList = new List();
    map.forEach((key, value) {
      dataList.add(jsonToModel(value).copyWith(key: key));
    });
    if (dataList.isEmpty) {
      MyLogger.error(
          msg: 'mapped model list error!! mapped json: $map', tag: tag);
      throw MapJsonDataException();
    } else {
//      for (int index = 0; index < dataList.length; index++) {
//        print('mapped data $index: ${dataList[index]}');
//      }
      return dataList;
    }
  }

  ///
  /// Decode json into data [T]
  ///
  /// [str] = json string
  /// [jsonToModel] = function that transforms the mapped json to model
  /// [tag] = logger tag
  ///
  static T decodeToModel<T>(
    dynamic str,
    Function(Map<String, dynamic> jsonMap) jsonToModel,
    bool trim,
    String tag,
  ) {
    var trimmed = (trim) ? trimJson(str) : str;
    MyLogger.debug(msg: 'start decoding data to $T...', tag: tag);
    Map<String, dynamic> map = jsonDecode(trimmed);
    // transfer decoded data to model data
    try {
      return jsonToModel(map) as T;
    } catch (e, s) {
      print(s);
      MyLogger.error(
          msg: 'mapped model error!! data: $trimmed\nmapped json: $map',
          tag: tag);
      throw MapJsonDataException();
    }
  }

  static List encodeToJsonArray(List<dynamic> list) {
    List jsonList = List();
    list.map((item) => jsonList.add(jsonEncode(item))).toList();
    return jsonList;
  }
}
