import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/widgets/table_cell_text_widget.dart';

import '../../data/models/deals_model.dart';

class DealsDisplay extends StatefulWidget {
  DealsDisplay(Key key) : super(key: key);

  @override
  DealsDisplayState createState() => DealsDisplayState();
}

class DealsDisplayState extends State<DealsDisplay> {
  final List<String> _headerRowTexts = [
    localeStr.dealsHeaderSerial,
    localeStr.dealsHeaderDate,
    localeStr.dealsHeaderType,
    localeStr.dealsHeaderDetail,
    localeStr.dealsHeaderStatus,
    localeStr.dealsHeaderAmount,
  ];

  double _availableWidth;
  double _tableHeight;
  Map<int, TableColumnWidth> _tableWidthMap;

  List<DealsData> _dataList;
  TableRow _headerRow;

  set updateContent(List<DealsData> list) {
    print('deals list length: ${list.length}');
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
        48; // 48 = padding and pager
    int availableRows =
        (availableHeight / (FontSize.NORMAL.value * 2.35)).floor();
    print('max height: $availableHeight, available rows: $availableRows');
    // FontSize.NORMAL.value * 2 = font size * 2 line + space
    _tableHeight = FontSize.NORMAL.value * 2.15 * availableRows;

    _availableWidth = Global.device.width - 16;
    double remainWidth = _availableWidth - 90;
    _tableWidthMap = {
      //指定索引及固定列宽
      0: FixedColumnWidth(54.0),
      1: FixedColumnWidth(remainWidth * 0.325),
      2: FixedColumnWidth(36.0),
      3: FixedColumnWidth(remainWidth * 0.225),
      4: FixedColumnWidth(remainWidth * 0.2),
      5: FixedColumnWidth(remainWidth * 0.25),
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
                  List.generate(_dataList.length, (index) {
                    DealsData data = _dataList[index];
                    List<dynamic> dataTexts = [
                      data.id,
                      data.date,
                      data.action,
                      data.type,
                      data.status,
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
        ),
      );
    }
  }
}
