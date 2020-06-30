import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/error/failures.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/message_display.dart';
import 'package:flutter_ty_mobile/features/subfeatures/deposit/data/form/deposit_form.dart';
import 'package:flutter_ty_mobile/features/subfeatures/deposit/data/model/payment_freezed.dart';
import 'package:flutter_ty_mobile/features/subfeatures/deposit/presentation/widgets/payment_tutorial.dart';
import 'package:flutter_ty_mobile/mylogger.dart';
import 'package:flutter_ty_mobile/utils/value_range.dart';
import 'package:intl/intl.dart' show NumberFormat;

/// Content View for all other types of Payment
///@author H.C.CHIANG
///@version 2020/3/26
class PaymentContentOnline extends StatefulWidget {
  final List<PaymentFreezed> dataList;
  final Function depositFuncCall;
  final List tutorial;

  PaymentContentOnline({
    this.dataList,
    this.depositFuncCall,
    this.tutorial,
  });

  @override
  _PaymentContentOnlineState createState() => _PaymentContentOnlineState();
}

class _PaymentContentOnlineState extends State<PaymentContentOnline> {
  final String tag = 'PaymentContentOnline';
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _amountFieldKey =
      new GlobalKey(debugLabel: 'amount');

  PaymentDataOther _otherData;
  int _bankSelectedIndex = -1;
  int _bankSelectedId = -1;
  int _methodSelected;
  String _depositAmount = '';

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      if (_otherData.amountOption != null && _otherData.amountOption.isNotEmpty)
        _depositAmount = _amountFieldKey?.currentState?.inputText ?? '0';
//      print('The user wants to login with $_username and $_password');
      DepositDataForm dataForm = DepositDataForm(
        bankIndex: _bankSelectedIndex,
        methodId: _methodSelected,
        bankId: _bankSelectedId,
        amount: _depositAmount,
      );
      print('deposit form: ${dataForm.toJson()}');
      widget.depositFuncCall(dataForm);
    }
  }

  @override
  void initState() {
    _otherData = widget.dataList[0];
    _methodSelected = _otherData.amountType;
    _bankSelectedId = _otherData.bankAccountId;
    _bankSelectedIndex = _otherData.sb[0];
    _depositAmount =
        (_otherData.amountOption != null && _otherData.amountOption.isNotEmpty)
            ? _otherData.amountOption[0].toString()
            : '0';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dataList == null || widget.dataList.isEmpty) {
      return Center(
        child: MessageDisplay(
          message: Failure.dataSource().message,
        ),
      );
    } else {
      return InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          children: <Widget>[
//            Text(widget.dataList.toString()),
//            SizedBox(height: 8.0),
            new Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  /* Bank Option */
                  CustomizeDropdownWidget(
                    prefixTitle: localeStr.depositPaymentSpinnerTitleBank,
                    spacing: 4,
                    optionValues: widget.dataList
                        .map((item) => item.bankAccountId)
                        .toList(),
                    optionStrings:
                        widget.dataList.map((item) => item.type).toList(),
                    changeNotify: (data) {
                      if (data is PaymentDataOther) {
                        if (_otherData == data) return;
                        print('change method: $data');
                        _methodSelected = _otherData.amountType;
                        _bankSelectedId = _otherData.bankAccountId;
                        _bankSelectedIndex = _otherData.sb[0];
                        setState(() {
                          _otherData = data;
                        });
                      }
                    },
                  ),
                  /* Amount Input Field */
                  (_otherData.amountOption != null &&
                          _otherData.amountOption.isNotEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: CustomizeDropdownWidget(
                            prefixTitle:
                                localeStr.depositPaymentEditTitleAmount,
                            spacing: 4,
                            optionValues: _otherData.amountOption,
                            changeNotify: (data) {
                              print('change amount: $data');
                              if (_depositAmount != data.toString())
                                setState(() {
                                  _depositAmount = data.toString();
                                });
                            },
                          ),
                        )
                      : new CustomizeFieldWidget(
                          key: _amountFieldKey,
                          fieldType: FieldType.Numbers,
                          hint:
                              localeStr.depositPaymentEditTitleAmountHintRange(
                            _otherData.min ?? 1,
                            _otherData.max,
                          ),
                          persistHint: false,
                          prefixTitle: localeStr.depositPaymentEditTitleAmount,
                          errorMsg: localeStr.messageInvalidDepositAmount,
                          validCondition: (value) =>
                              value.contains('.') == false &&
                              rangeCheck(
                                value:
                                    (value.isNotEmpty) ? int.parse(value) : 0,
                                min: _otherData.min ?? 1,
                                max: _otherData.max,
                              ),
                          parentWidth: MediaQuery.of(context).size.width,
                          spacing: 4,
                          maxInputLength: _otherData.max.toString().length,
                        ),
                  /* Amount Limit Hint */
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(4.0, 2.0, 4.0, 10.0),
                        child: Text(
                          localeStr.depositHintTextAmount(
                              NumberFormat.simpleCurrency(decimalDigits: 0)
                                  .format(_otherData.max)),
                          style: TextStyle(color: Themes.hintHighlight),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            /* Confirm Button */
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(localeStr.btnConfirm),
                    color: Themes.defaultAccentColor,
                    textColor: Themes.defaultTextColorBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    onPressed: () {
                      try {
                        _validateForm();
                      } catch (e) {
                        MyLogger.error(
                            msg: 'form error: $e', error: e, tag: tag);
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            /* Tutorial Button */
            (widget.tutorial != null)
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child:
                              Text(localeStr.depositPaymentButtonTitleTutorial),
                          color: Themes.buttonSubColor,
                          textColor: Themes.defaultTextColorBlack,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) => new PaymentTutorial(
                                tutorialData: widget.tutorial,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      );
    }
  }
}
