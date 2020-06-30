import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/widgets/table_cell_span_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/table_cell_text_widget.dart';

import '../../data/models/store_exchange_model.dart';

class StoreDisplayRecordTable extends StatelessWidget {
  final StoreExchangeModel tableData;
  final double availableHeight;

  StoreDisplayRecordTable({
    @required this.tableData,
    this.availableHeight,
  });

  final List<String> _headerRowTexts = [
    localeStr.storeRecordTableTitleNo,
    localeStr.storeRecordTableTitleProduct,
    localeStr.storeRecordTableTitlePoint,
    localeStr.storeRecordTableTitleDate,
    localeStr.storeRecordTableTitleState,
  ];

  @override
  Widget build(BuildContext context) {
    double availableWidth = Global.device.width - 24;
    bool hasData = tableData != null &&
        tableData.data != null &&
        tableData.data.isNotEmpty;
    Map<int, TableColumnWidth> _tableWidthMap = (hasData)
        ? {
            //指定索引及固定列宽
            0: FixedColumnWidth(availableWidth * 0.075),
            1: FixedColumnWidth(availableWidth * 0.625),
            2: FixedColumnWidth(availableWidth * 0.075),
            3: FixedColumnWidth(availableWidth * 0.15),
            4: FixedColumnWidth(availableWidth * 0.075),
          }
        : {
            //指定索引及固定列宽
            0: FixedColumnWidth(availableWidth * 0.15),
            1: FixedColumnWidth(availableWidth * 0.4),
            2: FixedColumnWidth(availableWidth * 0.15),
            3: FixedColumnWidth(availableWidth * 0.15),
            4: FixedColumnWidth(availableWidth * 0.15),
          };

    return ColoredBox(
      color: Themes.stackBackgroundColor,
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        columnWidths: _tableWidthMap,
        border: TableBorder.all(
          color: Themes.defaultBorderColor,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        /* create table header and generate rows */
        children: (hasData)
            ? <TableRow>[_buildHeaderRow()] + _buildContentRows()
            : <TableRow>[_buildHeaderRow()],
      ),
    );
  }

  List<TableRow> _buildContentRows() {
    return List.generate(tableData.data.length, (index) {
      StoreExchangeData data = tableData.data[index];
      List<dynamic> dataTexts = [
        tableData.from + index,
        data.product,
        data.point,
        data.date,
        data.status,
      ];
      /* generate cell text */
      return TableRow(
        children: List.generate(
          dataTexts.length,
          (index) {
            if (index == 1) {
              return TableCellSpanWidget(
                span: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: '${dataTexts[index]}\n'),
                    TextSpan(
                      text:
                          '${localeStr.storeRecordTableDetailName(data.name)}; ',
                      style: TextStyle(color: Themes.defaultHintColorDark),
                    ),
                    TextSpan(
                      text:
                          '${localeStr.storeRecordTableDetailPhone(data.phone)};\n',
                      style: TextStyle(color: Themes.defaultHintColorDark),
                    ),
                    TextSpan(
                      text:
                          '${localeStr.storeRecordTableDetailPostCode(data.code)}; ',
                      style: TextStyle(color: Themes.defaultHintColorDark),
                    ),
                    TextSpan(
                      text:
                          '${localeStr.storeRecordTableDetailAddress(data.address)};',
                      style: TextStyle(color: Themes.defaultHintColorDark),
                    ),
                  ],
                ),
              );
            } else if (index == 4) {
              return TableCellTextWidget(
                text: (dataTexts[index] == '1')
                    ? localeStr.storeRecordTableStatusPending
                    : dataTexts[index],
              );
            } else {
              return TableCellTextWidget(text: '${dataTexts[index]}');
            }
          },
        ),
      );
    });
  }

  TableRow _buildHeaderRow() {
    return TableRow(
      decoration: BoxDecoration(
        color: Themes.defaultAccentColor,
      ),
      children: List.generate(
        _headerRowTexts.length,
        (index) => TableCellTextWidget(
          text: _headerRowTexts[index],
        ),
      ),
    );
  }
}
