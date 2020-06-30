import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/customize_widget_export.dart';
import 'package:flutter_ty_mobile/features/subfeatures/betrecord/data/enum/bet_record_time_enum.dart';
import 'package:flutter_ty_mobile/features/subfeatures/betrecord/data/form/bet_record_form.dart';
import 'package:flutter_ty_mobile/features/subfeatures/betrecord/presentation/widgets/bet_record_display_table.dart';

import 'general/widgets/customize_dropdown_widget.dart';
import 'general/widgets/pager_widget.dart';

class TestAreaRoute extends StatefulWidget {
  @override
  _TestAreaRouteState createState() => _TestAreaRouteState();
}

class _TestAreaRouteState extends State<TestAreaRoute>
    with AfterLayoutMixin, TickerProviderStateMixin {
  final GlobalKey<PagerWidgetState> pagerKey =
      new GlobalKey(debugLabel: 'pager');

  final GlobalKey<CustomizeDropdownWidgetState> _platformKey =
      new GlobalKey(debugLabel: 'platform');
  final GlobalKey<CustomizeDropdownWidgetState> _timeKey =
      new GlobalKey(debugLabel: 'time');
  final GlobalKey<CustomizeFieldWidgetState> _startTimeKey =
      new GlobalKey(debugLabel: 'start');
  final GlobalKey<CustomizeFieldWidgetState> _endTimeKey =
      new GlobalKey(debugLabel: 'end');

  List<String> categories = ['slot', 'sport', 'fish', 'casino', 'lottery'];
  List<String> platforms;

  String _category;
  int _categorySelected;
  String _platform;
  int _platformInitIndex;
  BetRecordTimeEnum _timeSelected;
  int totalPage;

  bool layoutReady = false;
  bool shrinkTable = false;
  bool allDataTable = true;

  void getPageData(int page) {
    BetRecordForm form = BetRecordForm(
      categoryId: _categorySelected,
      platform: (_platform == platforms[_platformInitIndex])
          ? 'all'
          : _platform.toLowerCase(),
      time: _timeSelected,
      page: page,
      startTime: (_timeSelected == BetRecordTimeEnum.custom)
          ? _startTimeKey.currentState.getInput
          : null,
      endTime: (_timeSelected == BetRecordTimeEnum.custom)
          ? _endTimeKey.currentState.getInput
          : null,
    );
    print('bet query form: $form');
    if (_platform == platforms[_platformInitIndex] && !allDataTable) {
      allDataTable = true;
      setState(() {});
    } else if (_platform != platforms[_platformInitIndex] &&
        allDataTable != false) {
      allDataTable = false;
      setState(() {});
    }
  }

  void switchCategory(int categoryIndex) {
    if (_categorySelected == categoryIndex) return;
    _categorySelected = categoryIndex;
    _category = categories[_categorySelected];
    platforms = List.generate(4, (index) => '$_category$index');
    _platform = null;
    _platformInitIndex = 0;
    if (_platformKey.currentState != null)
      _platformKey.currentState.setSelected = null;
    if (platforms.isNotEmpty && _platformKey.currentState != null)
      Future.delayed(Duration(milliseconds: 100), () {
        _platformKey.currentState.setSelected = platforms[0];
      });
    _platform = platforms[0];
    setState(() {});
  }

  @override
  void initState() {
    switchCategory(0);
    _timeSelected = BetRecordTimeEnum.today;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 4.0),
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          /* Category Tabs */
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 10.0,
              childAspectRatio: 2.0,
            ),
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ConstrainedBox(
                constraints: const BoxConstraints.tightFor(height: 24),
                child: RaisedButton(
                  color: (_categorySelected == index)
                      ? Themes.defaultAccentColor
                      : Themes.defaultDisabledColor,
                  child: Text(
                    categories[index],
                    style: TextStyle(
                        color: (_categorySelected == index)
                            ? Themes.defaultTextColorBlack
                            : Themes.defaultTextColor),
                  ),
                  onPressed: () => switchCategory(index),
                ),
              );
            },
          ),
          SizedBox(height: 12.0),
          /* Platform Option */
          if (platforms != null && platforms.isNotEmpty)
            CustomizeDropdownWidget(
              key: _platformKey,
              horizontalInset: 12.0,
              prefixText: localeStr.betsSpinnerTitlePlatform,
              titleLetterSpacing: 4,
              optionValues: platforms,
              defaultValueIndex: _platformInitIndex,
              changeNotify: (data) {
                // clear text field focus
                FocusScope.of(context).requestFocus(new FocusNode());
                // set selected data
                _platform = data;
              },
            ),
          /* Time Option */
          CustomizeDropdownWidget(
            key: _timeKey,
            horizontalInset: 12.0,
            prefixText: localeStr.betsSpinnerTitleTime,
            titleLetterSpacing: 4,
            optionValues: BetRecordTimeEnum.list,
            optionStrings:
                BetRecordTimeEnum.list.map((e) => e.value.label).toList(),
            changeNotify: (data) {
              // clear text field focus
              FocusScope.of(context).requestFocus(new FocusNode());
              // set selected data
              _timeSelected = data;
              if (_timeSelected == BetRecordTimeEnum.custom) {
                shrinkTable = true;
                setState(() {});
              }
            },
          ),
          if (_timeSelected == BetRecordTimeEnum.custom)
            /* Start Date Field */
            new CustomizeFieldWidget(
              key: _startTimeKey,
              horizontalInset: 12.0,
              fieldType: FieldType.Date,
              maxInputLength: 10,
              hint: localeStr.centerTextTitleDateHint,
              persistHint: false,
              prefixText: localeStr.betsFieldTitleStartTime,
              titleLetterSpacing: 4,
            ),
          if (_timeSelected == BetRecordTimeEnum.custom)
            /* End Date Field */
            new CustomizeFieldWidget(
              key: _endTimeKey,
              horizontalInset: 12.0,
              fieldType: FieldType.Date,
              maxInputLength: 10,
              hint: localeStr.centerTextTitleDateHint,
              persistHint: false,
              prefixText: localeStr.betsFieldTitleEndTime,
              titleLetterSpacing: 4,
            ),
          /* Query Button */
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(localeStr.btnQueryNow),
                    onPressed: () => getPageData(1),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 0.0),
            child: BetRecordDisplayTable(
              dataList: [],
              isAllData: allDataTable,
            ),
          ),
          SizedBox(
            height: (allDataTable) ? 1 : 30,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  PagerWidget(
                    pagerKey,
                    onAction: (page) => getPageData(page),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    print('after first layout');
  }
}
