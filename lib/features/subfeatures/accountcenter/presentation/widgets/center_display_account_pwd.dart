import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';

import '../../data/form/center_password_form.dart';
import '../state/center_store.dart';

class CenterDisplayAccountPassword extends StatefulWidget {
  final CenterStore store;

  CenterDisplayAccountPassword({@required this.store});

  @override
  _CenterDisplayAccountPasswordState createState() =>
      _CenterDisplayAccountPasswordState();
}

class _CenterDisplayAccountPasswordState
    extends State<CenterDisplayAccountPassword> {
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _oldPwdFieldKey =
      new GlobalKey(debugLabel: 'oldpwd');
  final GlobalKey<CustomizeFieldWidgetState> _newPwdFieldKey =
      new GlobalKey(debugLabel: 'newpwd');
  final GlobalKey<CustomizeFieldWidgetState> _conPwdFieldKey =
      new GlobalKey(debugLabel: 'conpwd');

  @override
  void initState() {
    widget.store.initLoginDataBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(typeCode: FailureTypeCode.CENTER))
                  .message,
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: InkWell(
        // to dismiss the keyboard when the user tabs out of the TextField
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 30.0, 16.0, 8.0),
          child: new Form(
            key: _formKey,
            child: ListView(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              children: <Widget>[
                new CustomizeFieldWidget(
                  key: _oldPwdFieldKey,
                  fieldType: FieldType.Password,
                  hint: localeStr.userPwdFieldHintOld,
                  prefixText: localeStr.userPwdFieldTitleOld,
                  titleLetterSpacing: 8,
                  maxInputLength: 20,
                  errorMsg: localeStr.messageInvalidPassword,
                  validCondition: (value) =>
                      rangeCheck(value: value.length, min: 6, max: 20),
                ),
                new CustomizeFieldWidget(
                  key: _newPwdFieldKey,
                  fieldType: FieldType.Password,
                  hint: localeStr.userPwdFieldHintNew,
                  prefixText: localeStr.userPwdFieldTitleNew,
                  titleLetterSpacing: 8,
                  maxInputLength: 20,
                  errorMsg: localeStr.messageInvalidPasswordNew,
                  validCondition: (value) =>
                      rangeCheck(value: value.length, min: 8, max: 20),
                ),
                new CustomizeFieldWidget(
                  key: _conPwdFieldKey,
                  fieldType: FieldType.Password,
                  hint: localeStr.userPwdFieldHintConfirm,
                  prefixText: localeStr.userPwdFieldTitleConfirm,
                  titleLetterSpacing: 3,
                  maxInputLength: 20,
                  errorMsg: localeStr.messageInvalidConfirmPassword,
                  validCondition: (value) =>
                      _conPwdFieldKey.currentState.getInput ==
                      _newPwdFieldKey.currentState.getInput,
                ),
                /* Change Buttons */
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          child: Text(localeStr.centerTextButtonChangePwd),
                          textColor: Themes.defaultTextColorBlack,
                          onPressed: () {
                            // clear text field focus
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            _validateForm();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      CenterPasswordForm pwdForm = CenterPasswordForm(
        oldPwd: _oldPwdFieldKey.currentState.getInput,
        newPwd: _newPwdFieldKey.currentState.getInput,
        confirmPwd: _conPwdFieldKey.currentState.getInput,
      );
      if (pwdForm.isValid)
        widget.store.postPassword(pwdForm);
      else
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
    }
  }
}
