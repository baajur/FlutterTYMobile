import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/widgets/table_cell_text_widget.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';

import '../../data/models/agent_ledger_model.dart';

class AgentDisplayLedgerTable extends StatelessWidget {
  final List<AgentLedgerData> dataList;
  final List<num> sumColumn;

  AgentDisplayLedgerTable({@required this.dataList, @required this.sumColumn});

  static final double basicHeight = Global.TEST_DEVICE_CONTENT_HEIGHT - 24;
  static final double availableHeight =
      Global.device.height.roundToDouble() - Global.APP_TOOLS_HEIGHT - 24;

  final List<String> _headerRowTexts = [
    localeStr.agentLedgerHeaderAccount,
    localeStr.agentLedgerHeaderDeposit,
    localeStr.agentLedgerHeaderWithdraw,
    localeStr.agentLedgerHeaderPromo,
    localeStr.agentLedgerHeaderRefund,
  ];

  @override
  Widget build(BuildContext context) {
    double heightFactor = availableHeight / basicHeight;
//    print('screen height factor: $heightFactor');
    // FontSize.NORMAL.value * 1.8 = font size and line spacing
    // 17 = 8 rows * 2 lines + header line
    double _tableHeight = FontSize.NORMAL.value * 1.8 * 17 * heightFactor;
    double _availableWidth = Global.device.width - 16;
    Map<int, TableColumnWidth> _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(_availableWidth * 0.2),
      1: FixedColumnWidth(_availableWidth * 0.2),
      2: FixedColumnWidth(_availableWidth * 0.2),
      3: FixedColumnWidth(_availableWidth * 0.2),
      4: FixedColumnWidth(_availableWidth * 0.2),
    };

    return Container(
      constraints: BoxConstraints(
        maxWidth: _availableWidth,
        maxHeight: _tableHeight,
      ),
      color: Themes.stackBackgroundColor,
      child: SingleChildScrollView(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          columnWidths: _tableWidthMap,
          border: TableBorder.all(
            color: Themes.defaultBorderColor,
            width: 2.0,
            style: BorderStyle.solid,
          ),
          /* create table header and generate rows */
          children: _buildContent(),
        ),
      ),
    );
  }

  List<TableRow> _buildContent() {
    List<TableRow> rows = _buildContentRows();
    rows.insert(0, _buildHeaderRow());
    rows.add(_buildTotalRow());
    return rows;
  }

  List<TableRow> _buildContentRows() {
    return List.generate(dataList.length, (index) {
      AgentLedgerData data = dataList[index];
      List<dynamic> dataTexts = [
        data.account,
        formatNum(data.deposit),
        formatNum(data.withdraw),
        formatNum(data.preferential),
        formatNum(data.rolling),
      ];
      /* generate cell text */
      return TableRow(
        children: List.generate(
          dataTexts.length,
          (index) => TableCellTextWidget(text: '${dataTexts[index]}'),
        ),
      );
    });
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(text: _headerRowTexts[index]),
      ),
    );
  }

  TableRow _buildTotalRow() {
    List<String> _totalRowTexts;
    if (sumColumn.isEmpty) {
      _totalRowTexts = [localeStr.flowHeaderTextTotal] +
          List.generate(4, (index) => formatValue(0));
    } else
      _totalRowTexts = [
        localeStr.flowHeaderTextTotal,
        formatValue(sumColumn[0]),
        formatValue(sumColumn[1]),
        formatValue(sumColumn[2]),
        formatValue(sumColumn[3]),
      ];
    return TableRow(
      children: List.generate(
        _totalRowTexts.length,
        (index) => TableCellTextWidget(
          text: _totalRowTexts[index],
          shrinkInset: false,
        ),
      ),
    );
  }
}
