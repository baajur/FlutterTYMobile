import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/table_cell_text_widget.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';

import '../../data/models/flow_model.dart';

class FlowsDisplay extends StatefulWidget {
  FlowsDisplay(Key key) : super(key: key);

  @override
  FlowsDisplayState createState() => FlowsDisplayState();
}

class FlowsDisplayState extends State<FlowsDisplay> {
  double _availableWidth;
  double _tableHeight;
  Map<int, TableColumnWidth> _tableWidthMap;

  List<FlowModel> _dataList;
  List<String> _headerRowTexts;
  TableRow _headerRow;
  List<String> _totalRowTexts;
  TableRow _totalRow;

  double totalAmount = 0;
  double totalTurnOver = 0;
  double totalRollOver = 0;
  double totalBetResult = 0;

  set updateContent(List<FlowModel> list) {
    print('flow list length: ${list.length}');
    if (_dataList != list) {
      _dataList = list;
      if (_dataList.isNotEmpty) countTotal();
      setState(() {});
    }
  }

  void countTotal() {
    totalAmount = 0;
    totalTurnOver = 0;
    totalRollOver = 0;
    totalBetResult = 0;
    _dataList.forEach((data) {
      totalAmount += data.amount.strToDouble;
      totalTurnOver += data.turnOver.strToDouble;
      totalRollOver += data.rollOver.strToDouble;
      totalBetResult += data.betResult.strToDouble;
    });
    _totalRow = updateTotalRow();
  }

  TableRow updateTotalRow() {
    _totalRowTexts = [
      localeStr.flowHeaderTextTotal,
      '',
      '',
      formatValue(totalAmount, floorIfInt: true, creditSign: true),
      '',
      '',
      formatValue(totalTurnOver, floorIfInt: true, creditSign: true),
      formatValue(totalRollOver, floorIfInt: true, creditSign: true),
      formatValue(totalBetResult, floorIfInt: true, creditSign: true),
    ];
    return TableRow(
      children: List.generate(
        _totalRowTexts.length,
        (index) => TableCellTextWidget(text: _totalRowTexts[index]),
      ),
    );
  }

  @override
  void initState() {
    int availableRows = ((Global.device.featureContentHeight - 16) /
            (FontSize.NORMAL.value * 2.35))
        .floor();
    print('available rows: $availableRows');
    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    _tableHeight = FontSize.NORMAL.value * 2.15 * availableRows;

    _availableWidth = Global.device.width - 16;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(_availableWidth * 0.175),
      1: FixedColumnWidth(_availableWidth * 0.125),
      2: FixedColumnWidth(_availableWidth * 0.075),
      3: FixedColumnWidth(_availableWidth * 0.125),
      4: FixedColumnWidth(_availableWidth * 0.075),
      5: FixedColumnWidth(_availableWidth * 0.075),
      6: FixedColumnWidth(_availableWidth * 0.1),
      7: FixedColumnWidth(_availableWidth * 0.1),
      8: FixedColumnWidth(_availableWidth * 0.15),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _headerRowTexts ??= [
      localeStr.flowHeaderTextTime,
      localeStr.flowHeaderTextCode,
      localeStr.flowHeaderTextType,
      localeStr.flowHeaderTextAmount,
      localeStr.flowHeaderTextMultiple,
      localeStr.flowHeaderTextPromo,
      localeStr.flowHeaderTextRequire,
      localeStr.flowHeaderTextCurrent,
      localeStr.flowHeaderTextNeed,
    ];
    _headerRow ??= TableRow(
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(text: _headerRowTexts[index]),
      ),
    );
    _totalRow ??= updateTotalRow();

    bool isEmptyTable = _dataList == null || _dataList.isEmpty;
    return Container(
      constraints: BoxConstraints(
        maxWidth: (isEmptyTable) ? _availableWidth : _availableWidth * 2,
        maxHeight: _tableHeight,
      ),
      child: (isEmptyTable) ? _buildEmptyTable() : _buildTable(),
    );
  }

  Widget _buildEmptyTable() {
    return SingleChildScrollView(
      child: ColoredBox(
        color: Themes.stackBackgroundColor,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: _tableWidthMap,
          border: TableBorder.all(
            color: Themes.defaultBorderColor,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          /* create table header and generate rows */
          children: <TableRow>[_headerRow, _totalRow],
        ),
      ),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      child: ColoredBox(
        color: Themes.stackBackgroundColor,
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: _tableWidthMap,
          border: TableBorder.all(
            color: Themes.defaultBorderColor,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          /* create table header and generate rows */
          children: <TableRow>[_headerRow] +
              List.generate(_dataList.length, (index) {
                FlowModel data = _dataList[index];
                List<dynamic> dataTexts = [
                  "${data.startTime}\n｜\n${data.endTime}",
                  data.code,
                  data.index,
                  formatValue(data.amount, creditSign: true),
                  '${data.multiply}',
                  '${data.promoSimplified}',
                  formatValue(data.turnOver, creditSign: true),
                  formatValue(data.rollOver, creditSign: true),
                  formatValue(data.betResult, creditSign: true),
                ];
                /* generate cell text */
                return TableRow(
                  children: List.generate(
                    dataTexts.length,
                    (index) => TableCellTextWidget(text: '${dataTexts[index]}'),
                  ),
                );
              }) +
              <TableRow>[_totalRow],
        ),
      ),
    );
  }
}
