import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';

import '../../data/models/transaction_model.dart';

class TransactionDisplay extends StatefulWidget {
  TransactionDisplay(Key key) : super(key: key);

  @override
  TransactionDisplayState createState() => TransactionDisplayState();
}

class TransactionDisplayState extends State<TransactionDisplay> {
  double _availableWidth;
  double _tableHeight;
  List<TransactionData> _dataList;
  Map<int, TableColumnWidth> _tableWidthMap;
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
    double basicHeight = 785.0 - Global.APP_BAR_HEIGHT * 2 - 32;
    double availableHeight =
        Global.device.height.roundToDouble() - Global.APP_BAR_HEIGHT * 2 - 32;
    double screenHeightFactor = availableHeight / basicHeight;
    print('screen height factor: $screenHeightFactor');
    // FontSize.NORMAL.value * 1.8 = font size and line spacing
    // 17 = 8 rows * 2 lines + header line
    _tableHeight = FontSize.NORMAL.value * 1.8 * 17 * screenHeightFactor;

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
    _headerRow ??= TableRow(
      children: <Widget>[
        Center(child: Text('序号')),
        Center(child: Text('日期')),
        Center(child: Text('类别')),
        Center(child: Text('说明')),
        Center(child: Text('金额')),
      ],
    );
    if (_dataList.isEmpty)
      return SizedBox(
        height: _tableHeight,
        child: Center(
          child: Text(localeStr.messageWarnNoHistoryData),
        ),
      );
    else
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: _availableWidth,
          maxHeight: _tableHeight,
        ),
        child: SingleChildScrollView(
          child: Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: _tableWidthMap,
            border: TableBorder.all(
              color: Themes.stackBackgroundColorLight,
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
                      5,
                      (index) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text('${dataTexts[index]}'),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
  }
}
