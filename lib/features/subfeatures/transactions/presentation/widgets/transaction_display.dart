import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
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
    double availableHeight = Global.device.featureContentHeight -
        Themes.fieldHeight -
        Global.device.comfortButtonHeight -
        48; // 96 = padding and pager
    int availableRows =
        (availableHeight / (FontSize.NORMAL.value * 2.35)).floor();
    print('max height: $availableHeight, available rows: $availableRows');
    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    _tableHeight = FontSize.NORMAL.value * 2.15 * availableRows;

//    bool shrinkDate = Global.device.width < 320;
    bool shrinkDate = true;
    _availableWidth = Global.device.width - 16;
    double remainWidth =
        (shrinkDate) ? _availableWidth - 72 - 90 : _availableWidth - 72 - 140;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(36.0),
      1: FixedColumnWidth((shrinkDate) ? 90.0 : 140.0),
      2: FixedColumnWidth(36.0),
      3: FixedColumnWidth(remainWidth * 0.525),
      4: FixedColumnWidth(remainWidth * 0.475),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_dataList == null) return SizedBox.shrink();
    if (_dataList.isEmpty) {
      return SizedBox(
        height: _tableHeight,
        child: Center(
          child: Text(localeStr.messageWarnNoHistoryData),
        ),
      );
    } else {
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
      return Container(
        constraints: BoxConstraints(
          maxWidth: _availableWidth,
          maxHeight: _tableHeight,
        ),
        child: SingleChildScrollView(
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
                  List.generate(
                    _dataList.length,
                    (index) {
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
                        data.amount,
                      ];
                      /* generate cell text */
                      return TableRow(
                        children: List.generate(
                          dataTexts.length,
                          (index) =>
                              TableCellTextWidget(text: '${dataTexts[index]}'),
                        ),
                      );
                    },
                  ),
            ),
          ),
        ),
      );
    }
  }
}
