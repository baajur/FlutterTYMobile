import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ty_mobile/features/general/customize_widget_export.dart';
import 'package:flutter_ty_mobile/features/general_route_widget_export.dart';

import '../data/form/login_form.dart';
import 'bloc/bloc_user_export.dart';
import '../../general/widgets/checkbox_widget.dart';
import 'widgets/user_display.dart';

/// Main View of [Router.loginRoute]
///@author H.C.CHIANG
///@version 2020/4/14
class LoginRoute extends StatefulWidget {
  final bool returnHomeAfterLogin;
  final bool isDialog;

  LoginRoute({this.returnHomeAfterLogin = false, this.isDialog = false});

  @override
  State<StatefulWidget> createState() => new _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> with AfterLayoutMixin {
  UserLoginBloc _bloc;
//  final TextEditingController _passwordController = new TextEditingController();
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _pwdFieldKey =
      new GlobalKey(debugLabel: 'pwd');
  final GlobalKey<CheckboxWidgetState> _fastKey =
      new GlobalKey(debugLabel: 'fast');

  bool _buildComplete = false;
  bool _useFastLoginData = false;
  UserLoginHiveForm _hiveForm;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      _hiveForm = UserLoginHiveForm(
        account: _nameFieldKey.currentState.getInput,
        password: _pwdFieldKey.currentState.getInput,
        fastLogin: _fastKey.currentState.boxChecked,
      );
      if (_hiveForm.isValid)
        _bloc.add(GetUserEvent(form: _hiveForm.simple));
      else
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
    }
  }

  void _updateFields() {
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
      if (_buildComplete) _updateFields();
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
    _updateFields();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // to dismiss the keyboard when the user tabs out of the TextField
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Stack(
        children: <Widget>[
          /* Login State */
          Positioned(
            top: (widget.isDialog == false) ? 34 : 14,
            right: (widget.isDialog == false) ? 16 : 42,
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
                      if (_fastKey.currentState.boxChecked) {
                        _bloc.saveToBox(_hiveForm);
                      } else {
                        _bloc.cleanBox();
                      }
                      return UserDisplay(
                        user: state.props.first,
                        returnHome: widget.returnHomeAfterLogin,
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
                  ),
                  /* Login CheckBox */
                  CheckboxWidget(
                    key: _fastKey,
                    label: localeStr.btnFastLogin,
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
                            child: Text(localeStr.btnLogin),
                            textColor: Themes.defaultTextColorBlack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            onPressed: () {
                              // clear text field focus
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                              _validateForm();
                            },
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
                              onPressed: () {
                                // clear text field focus
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                RouterNavigate.navigateToPage(
                                    RoutePage.service);
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
