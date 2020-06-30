import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ty_mobile/core/base/usecase_export.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/general/bloc_widget_export.dart'
    show ToastError;
import 'package:flutter_ty_mobile/features/general/toast_widget_export.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_ty_mobile/features/route_page_export.dart'
    show localeStr, sl;
import 'package:flutter_ty_mobile/features/users/data/form/login_form.dart';
import 'package:flutter_ty_mobile/features/users/presentation/bloc/bloc_user_export.dart';
import 'package:flutter_ty_mobile/features/users/presentation/widgets/fast_login_widget.dart';
import 'package:flutter_ty_mobile/features/users/presentation/widgets/user_display.dart';
import 'package:flutter_ty_mobile/utils/value_range.dart';

/// Main View of [Router.loginRoute]
///@author H.C.CHIANG
///@version 2020/4/14
class LoginDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> with AfterLayoutMixin {
  UserLoginBloc _bloc;
//  final TextEditingController _passwordController = new TextEditingController();
  static final GlobalKey<DialogWidgetState> _dialogKey =
      new GlobalKey(debugLabel: 'dialog');
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _pwdFieldKey =
      new GlobalKey(debugLabel: 'pwd');
  final GlobalKey<FastLoginWidgetState> _fastKey =
      new GlobalKey(debugLabel: 'fast');

  bool _buildComplete = false;
  bool _useFastLoginData = false;
  UserLoginHiveForm _hiveForm;

  void updateDialog() {
    if (!_useFastLoginData &&
        _hiveForm != null &&
        _nameFieldKey != null &&
        _pwdFieldKey != null) {
      _useFastLoginData = true;
      try {
        _fastKey.currentState.setChecked = _hiveForm.fastLogin;
        if (_hiveForm.fastLogin) {
          Future.delayed(Duration(milliseconds: 150), () {
            _nameFieldKey.currentState.setInput = _hiveForm.account;
          });
          Future.delayed(Duration(milliseconds: 300), () {
            _pwdFieldKey.currentState.setInput = _hiveForm.password;
          });
        }
      } catch (e) {
        MyLogger.error(msg: 'update dialog failed!!', error: e);
      }
    }
  }

  @override
  void initState() {
    _bloc ??= sl.get<UserLoginBloc>();
    // Set storage data listener
    _bloc.fastLoginStream.listen((event) {
      _hiveForm = event;
      MyLogger.debug(msg: 'Received Fast Login Data: $event');
      if (_buildComplete) updateDialog();
    });
    // Get user login data from storage
    _bloc.initBox();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.close();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _buildComplete = true;
    updateDialog();
  }

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      key: _dialogKey,
      child: Stack(
        children: <Widget>[
          /* Login State */
          Positioned(
            top: 14,
            right: 42,
            child: BlocProvider(
              create: (_) => _bloc,
              child: BlocBuilder<UserLoginBloc, UserLoginState>(
                builder: (context, state) {
                  return state.when(
                    uInitial: (_) => SizedBox.shrink(),
                    uLoading: (_) => Container(
                      constraints:
                          BoxConstraints.tightFor(width: 18, height: 18),
                      child: CircularProgressIndicator(),
                    ),
                    uLoaded: (_) {
                      if (_fastKey.currentState.fastLogin) {
                        _bloc.saveToBox(_hiveForm);
                      }
                      return UserDisplay(
                        user: state.props.first,
                        isDialog: true,
                      );
                    },
                    uError: (_) => ToastError(message: state.props.first),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 30.0, 16.0, 8.0),
            child: new Form(
              key: _formKey,
              child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                children: <Widget>[
                  /* Login Hint Text*/
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      localeStr.hintTitleLogin,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Themes.defaultHintColor),
                    ),
                  ),
                  new CustomizeFieldWidget(
                    key: _nameFieldKey,
                    fieldType: FieldType.Normal,
                    hint: localeStr.hintAccount,
                    prefixIconData:
                        const IconData(0xf2bd, fontFamily: 'FontAwesome'),
                    errorMsg: localeStr.messageInvalidAccount,
                    validCondition: (value) =>
                        rangeCheck(value: value.length, min: 6, max: 12),
                    parentWidth: MediaQuery.of(context).size.width,
                  ),
                  new CustomizeFieldWidget(
                    key: _pwdFieldKey,
                    fieldType: FieldType.Password,
                    hint: localeStr.hintAccountPassword,
                    prefixIconData:
                        const IconData(0xf13e, fontFamily: 'FontAwesome'),
                    maxInputLength: 20,
                    errorMsg: localeStr.messageInvalidPassword,
                    validCondition: (value) =>
                        rangeCheck(value: value.length, min: 6, max: 20),
                    parentWidth: MediaQuery.of(context).size.width,
                  ),
                  /* Login CheckBox */
                  FastLoginWidget(
                    key: _fastKey,
                    initValue: _hiveForm?.fastLogin ?? false,
                  ),
                  /* Login Buttons */
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            child: Text('Login'),
                            textColor: Themes.defaultTextColorBlack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            onPressed: () => _validateForm(),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: RaisedButton(
                            child: Text(localeStr.btnResetPassword),
                            color: Themes.buttonDisabledColor,
                            textColor: Themes.buttonDisabledTextColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            onPressed: () => FLToast.showInfo(
                                text: localeStr.workInProgress),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 2.0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      _hiveForm = UserLoginHiveForm(
        account: _nameFieldKey.currentState.inputText,
        password: _pwdFieldKey.currentState.inputText,
        fastLogin: _fastKey.currentState.fastLogin,
      );
      _bloc.add(GetUserEvent(form: _hiveForm.simple));
    }
  }
}
