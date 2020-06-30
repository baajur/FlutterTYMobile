import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/widgets/table_cell_text_widget.dart';

import '../../data/models/transaction_model.dart';

class TransactionDisplay extends StatefulWidget {
  TransactionDisplay(Key key) : super(key: key);

  @override
  TransactionDisplayState createState() => TransactionDisplayState();
}

class TransactionDisplayState extends State<TransactionDisplay> {
  double _availableWidth;
  double _tableHeight;
  Map<int, TableColumnWidth> _tableWidthMap;

  List<TransactionData> _dataList;
  List<String> _headerRowTexts;
  TableRow _headerRow;

  set updateContent(List<TransactionData> list) {
    print('transaction list length: ${list.length}');
    if (_dataList != list) {
      _dataList = list;
      setState(() {});
    }
  }

  @override
  void initState() {
    double basicHeight = Global.TEST_DEVICE_CONTENT_HEIGHT - 24;
    double availableHeight =
        Global.device.height.roundToDouble() - Global.APP_TOOLS_HEIGHT - 24;
    double heightFactor = availableHeight / basicHeight;
//    print('screen height factor: $heightFactor');
    // FontSize.NORMAL.value * 1.8 = font size and line spacing
    // 17 = 8 rows * 2 lines + header line
    _tableHeight = FontSize.NORMAL.value * 1.8 * 17 * heightFactor;

    _availableWidth = Global.device.width - 16;
    double remainWidth = _availableWidth - 72;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(36.0),
      1: FixedColumnWidth(remainWidth * 0.425),
      2: FixedColumnWidth(36.0),
      3: FixedColumnWidth(remainWidth * 0.35),
      4: FixedColumnWidth(remainWidth * 0.225),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_dataList == null) return SizedBox.shrink();
    _headerRowTexts ??= [
      localeStr.transactionHeaderSerial,
      localeStr.transactionHeaderDate,
      localeStr.transactionHeaderType,
      localeStr.transactionHeaderDesc,
      localeStr.transactionHeaderAmount,
    ];
    _headerRow ??= TableRow(
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(text: _headerRowTexts[index]),
      ),
    );
    if (_dataList.isEmpty)
      return SizedBox(
        height: _tableHeight,
        child: Center(
          child: Text(localeStr.messageWarnNoHistoryData),
        ),
      );
    else
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
            children: <TableRow>[_headerRow] +
                List.generate(_dataList.length, (index) {
                  TransactionData data = _dataList[index];
                  String explanation =
                      (data.type == localeStr.transferViewTitleIn)
                          ? '${data.type} ${data.to}'
                          : '${data.from} ${data.type}';
                  List<dynamic> dataTexts = [
                    data.key,
                    data.date,
                    data.type,
                    explanation,
                    data.amount
                  ];
                  /* generate cell text */
                  return TableRow(
                    children: List.generate(
                      dataTexts.length,
                      (index) =>
                          TableCellTextWidget(text: '${dataTexts[index]}'),
                    ),
                  );
                }),
          ),
        ),
      );
  }
}
