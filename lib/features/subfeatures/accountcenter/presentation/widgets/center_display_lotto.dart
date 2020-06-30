import 'dart:math' show Random;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/error/failures.dart';
import 'package:flutter_ty_mobile/core/internal/font_size.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/bloc_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/customize_widget_export.dart';
import 'package:flutter_ty_mobile/features/route_page_export.dart';

import '../state/center_store.dart';
import 'center_store_inherit_widget.dart';

class CenterDisplayLotto extends StatefulWidget {
  @override
  _CenterDisplayLottoState createState() => _CenterDisplayLottoState();
}

class _CenterDisplayLottoState extends State<CenterDisplayLotto> {
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'lottoform');

  final Key _streamKey = new Key('lottostream');

  /// field keys has to be final
  /// else when keyboard pops, will trigger [didUpdateWidget] and clear the old keys,
  /// then the field can not be updated by setState.
  final GlobalKey<CustomizeFieldWidgetState> _lotto0 =
      new GlobalKey(debugLabel: 'lotto0');
  final GlobalKey<CustomizeFieldWidgetState> _lotto1 =
      new GlobalKey(debugLabel: 'lotto1');
  final GlobalKey<CustomizeFieldWidgetState> _lotto2 =
      new GlobalKey(debugLabel: 'lotto2');
  final GlobalKey<CustomizeFieldWidgetState> _lotto3 =
      new GlobalKey(debugLabel: 'lotto3');
  final GlobalKey<CustomizeFieldWidgetState> _lotto4 =
      new GlobalKey(debugLabel: 'lotto4');
  final GlobalKey<CustomizeFieldWidgetState> _lotto5 =
      new GlobalKey(debugLabel: 'lotto5');
  final GlobalKey<CustomizeFieldWidgetState> _lotto6 =
      new GlobalKey(debugLabel: 'lotto6');

  CenterStore _store;
  List<int> _storeData;
  List<GlobalKey<CustomizeFieldWidgetState>> _fieldKeys;
  List<int> _randomNumbers;
  bool skipped = true;
  Widget contentWidget;

  void _generateNumbers() {
    var rng = new Random();
    _randomNumbers = new List();
    // generate with no repeat number
    while (_randomNumbers.length < 7) {
      var newNum = rng.nextInt(48) + 1;
      if (_randomNumbers.contains(newNum))
        continue;
      else
        _randomNumbers.add(newNum);
    }
    _randomNumbers.sort((a, b) => a.compareTo(b));
    print('random: $_randomNumbers');
    // apply numbers to fields
    for (int i = 0; i < _fieldKeys.length; i++) {
      _fieldKeys[i].currentState.setInput = _randomNumbers[i].toString();
      print('set field $i to ${_randomNumbers[i]}');
    }
    setState(() {});
  }

  void _validateForm() {
    if (_store == null) return;
    if (_store.waitForResponse) {
      FLToast.showInfo(
        text: localeStr.messageWait,
        position: FLToastPosition.center,
        showDuration: ToastDuration.SHORT.value,
      );
      return;
    }

    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      List<int> numbers =
          _fieldKeys.map((e) => e.currentState.inputText.strToInt).toList();
      print('validating lotto numbers: $numbers');
      if (numbers.every((num) => rangeCheck(value: num, min: 1, max: 49)))
        _store.postLucky(numbers); //FIXME response data error
      else
        FLToast.showInfo(
          text: localeStr.centerLuckyNumberError,
          position: FLToastPosition.center,
          showDuration: ToastDuration.DEFAULT.value,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    _store ??= CenterStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(typeCode: FailureTypeCode.CENTER))
                  .message,
        ),
      );
    }
    return StreamBuilder(
      key: _streamKey,
      stream: _store.lottoStream,
      builder: (_, snapshot) {
        print('lotto stream snapshot: $snapshot');
        if (contentWidget == null || _storeData != _store.accountLotto) {
          _storeData = _store.accountLotto;
          if (_storeData == null || _storeData.isEmpty) {
            _fieldKeys ??= [
              _lotto0,
              _lotto1,
              _lotto2,
              _lotto3,
              _lotto4,
              _lotto5,
              _lotto6,
            ];
            contentWidget = _buildBinder();
          } else {
            contentWidget = _buildGrid();
          }
        }
        return contentWidget;
      },
    );
  }

  Widget _buildBinder() {
    return Container(
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  localeStr.centerLuckyTitle,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    fontWeight: FontWeight.bold,
                    color: Themes.defaultHintColorDark,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            child: Form(
              key: _formKey,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  crossAxisSpacing: 6,
                  childAspectRatio: 1,
                ),
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 7,
                itemBuilder: (_, index) {
                  return CustomizeFieldWidget(
                    key: _fieldKeys[index],
                    fieldType: FieldType.Numbers,
                    hint: '',
                    persistHint: false,
                    titleLetterSpacing: 0,
                    centerFieldText: true,
//                    validCondition: (value) => rangeCheck(value: value.strToInt, min: 1, max: 49),
//                    errorMsg: 'x',
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Icon(
                    Icons.info,
                    color: Themes.defaultHintColorDark,
                    size: 16.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    localeStr.centerLuckyHint,
                    style: TextStyle(
                      color: Themes.defaultHintColorDark,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  child: Text(
                    localeStr.centerLuckyButtonGenerate,
                    style: TextStyle(color: Themes.defaultTextColorBlack),
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _generateNumbers();
                  },
                ),
                RaisedButton(
                  child: Text(
                    localeStr.centerLuckyButtonBind,
                    style: TextStyle(color: Themes.defaultTextColorBlack),
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    skipped = false;
                    _validateForm();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
      child: GridView.count(
        physics: ClampingScrollPhysics(),
        crossAxisCount: 7,
        crossAxisSpacing: 6.0,
        childAspectRatio: 0.75,
        shrinkWrap: true,
        children: _storeData.map((num) => _generateNumberChip(num)).toList(),
      ),
    );
  }

  Widget _generateNumberChip(int number) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: Themes.defaultAccentColor,
          width: 3.0,
        ),
        color: Themes.defaultBackgroundColor,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Themes.defaultTextColorWhite),
        ),
      ),
    );
  }
}
