import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/pager_widget.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/data/enum/transaction_date_enum.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/data/models/transaction_model.dart';
import 'package:flutter_ty_mobile/features/subfeatures/transactions/presentation/widgets/transaction_display.dart';

class TestAreaRoute extends StatefulWidget {
  @override
  _TestAreaRouteState createState() => _TestAreaRouteState();
}

class _TestAreaRouteState extends State<TestAreaRoute>
    with AfterLayoutMixin, TickerProviderStateMixin {
  final GlobalKey<CustomizeDropdownWidgetState> _selectorKey =
      new GlobalKey(debugLabel: 'selector');
  final GlobalKey<TransactionDisplayState> contentKey =
      new GlobalKey(debugLabel: 'content');
  final GlobalKey<PagerWidgetState> pagerKey =
      new GlobalKey(debugLabel: 'pager');

  final List<String> _selectorStrings = [
    localeStr.transactionViewSpinnerDate0,
    localeStr.transactionViewSpinnerDate1,
    localeStr.transactionViewSpinnerDate2,
    localeStr.transactionViewSpinnerDate3,
  ];

  final List<TransactionDateSelected> _selectorValues = [
    TransactionDateSelected.all,
    TransactionDateSelected.today,
    TransactionDateSelected.yesterday,
    TransactionDateSelected.month,
  ];

  TransactionDateSelected _selected;

  @override
  void initState() {
    _selected = _selectorValues[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 6.0),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomizeDropdownWidget(
                key: _selectorKey,
                horizontalInset: 16.0,
                prefixTitle: localeStr.transactionViewSpinnerTitle,
                titleLetterSpacing: 4,
                optionValues: _selectorValues,
                optionStrings: _selectorStrings,
                changeNotify: (data) {
                  _selected = data;
                  print('selected: $data');
                },
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(localeStr.btnQueryNow),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.0, 6.0, 2.0, 10.0),
            child: TransactionDisplay(contentKey),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                PagerWidget(pagerKey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    contentKey.currentState.updateContent =
        List.generate(10, (index) => TransactionData(index: index));
    pagerKey.currentState.updateTotalPage = 10;
  }
}
