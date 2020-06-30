import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/exports_for_route_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/pager_widget.dart';

import '../data/enum/deals_date_enum.dart';
import '../data/enum/deals_status_enum.dart';
import '../data/enum/deals_type_enum.dart';
import '../data/form/deals_form.dart';
import 'state/deals_store.dart';
import 'widgets/deals_display.dart';

class DealsRoute extends StatefulWidget {
  @override
  _DealsRouteState createState() => _DealsRouteState();
}

class _DealsRouteState extends State<DealsRoute> {
  DealsStore _store;
  List<ReactionDisposer> _disposers;
  Function toastDismiss;

//  final GlobalKey<CustomizeDropdownWidgetState> _selectorKey =
//      new GlobalKey(debugLabel: 'selector');
  final GlobalKey<DealsDisplayState> contentKey =
      new GlobalKey(debugLabel: 'content');
  final GlobalKey<PagerWidgetState> pagerKey =
      new GlobalKey(debugLabel: 'pager');

  final List<String> _selectorDateStrings = [
    localeStr.spinnerDateToday,
    localeStr.spinnerDateYesterday,
    localeStr.spinnerDateMonth,
    localeStr.spinnerDateAll,
  ];
  final List<String> _selectorTypeStrings = [
    localeStr.dealsViewSpinnerType0,
    localeStr.dealsViewSpinnerType1,
    localeStr.dealsViewSpinnerType2,
    localeStr.dealsViewSpinnerType3,
  ];
  final List<String> _selectorStatusStrings = [
    localeStr.dealsViewSpinnerStatus0,
    localeStr.dealsViewSpinnerStatus1,
    localeStr.dealsViewSpinnerStatus2,
    localeStr.dealsViewSpinnerStatus3,
    localeStr.dealsViewSpinnerStatus4,
  ];

  DealsDateEnum _selectedDate;
  DealsTypeEnum _selectedType;
  DealsStatusEnum _selectedStatus;

  void getPageData(int page) {
    if (_store == null) return;
    _store.getRecord(DealsForm(
      page: page,
      time: _selectedDate.value,
      type: _selectedType.value,
      status: _selectedStatus.value,
    ));
  }

  @override
  void initState() {
    _store ??= sl.get<DealsStore>();
    _selectedDate = DealsDateEnum.LIST[0];
    _selectedType = DealsTypeEnum.LIST[0];
    _selectedStatus = DealsStatusEnum.LIST[0];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.errorMessage,
        // Run some logic with the content of the observed field
        (String message) {
          if (message != null && message.isNotEmpty) {
            Future.delayed(Duration(milliseconds: 200)).then(
              (value) => FLToast.showError(
                text: message,
                showDuration: ToastDuration.DEFAULT.value,
              ),
            );
          }
        },
      ),
      /* Reaction on search action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => _store.waitForPageData,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait deals: $wait');
          if (wait) {
            toastDismiss = FLToast.showLoading(
              text: localeStr.messageWait,
            );
          } else if (toastDismiss != null) {
            toastDismiss();
            toastDismiss = null;
            if (_store.dataModel != null) {
              print(
                  'updating deals record, page: ${_store.dataModel.currentPage}');
              try {
                if (_store.dataModel.total > 0) {
                  pagerKey.currentState.updateTotalPage =
                      _store.dataModel.lastPage;
                  pagerKey.currentState.updateCurrentPage =
                      _store.dataModel.currentPage;
                } else {
                  pagerKey.currentState.updateTotalPage = 0;
                }
                contentKey.currentState.updateContent = _store.dataModel.data;
              } on Exception {
                FLToast.showError(
                  text: localeStr.messageActionFailed,
                  showDuration: ToastDuration.DEFAULT.value,
                );
              }
            }
          }
        },
      ),
    ];
  }

  @override
  void dispose() {
    if (toastDismiss != null) {
      toastDismiss();
      toastDismiss = null;
    }
    _disposers.forEach((d) => d());
    super.dispose();
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
              Expanded(
                flex: 1,
                child: CustomizeDropdownWidget(
                  fixedWidget: false,
                  optionValues: DealsDateEnum.LIST,
                  optionStrings: _selectorDateStrings,
                  changeNotify: (data) {
                    _selectedDate = data;
                    print('selected date: $data');
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomizeDropdownWidget(
                  fixedWidget: false,
                  optionValues: DealsTypeEnum.LIST,
                  optionStrings: _selectorTypeStrings,
                  changeNotify: (data) {
                    _selectedType = data;
                    print('selected type: $data');
                  },
                ),
              ),
              Expanded(
                flex: 1,
                child: CustomizeDropdownWidget(
                  fixedWidget: false,
                  optionValues: DealsStatusEnum.LIST,
                  optionStrings: _selectorStatusStrings,
                  changeNotify: (data) {
                    _selectedStatus = data;
                    print('selected status: $data');
                  },
                ),
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
                  child: SizedBox(
                    height: Global.device.comfortButtonHeight,
                    child: RaisedButton(
                      child: Text(localeStr.btnQueryNow),
                      onPressed: () => getPageData(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(2.0, 6.0, 2.0, 10.0),
            child: DealsDisplay(contentKey),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              PagerWidget(
                pagerKey,
                onAction: (page) => getPageData(page),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
