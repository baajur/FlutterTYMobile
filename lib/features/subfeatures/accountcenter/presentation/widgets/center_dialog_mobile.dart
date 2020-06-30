import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';

import '../state/center_store.dart';

class CenterDialogMobile extends StatefulWidget {
  final CenterStore store;
  final String mobile;

  CenterDialogMobile({@required this.store, @required this.mobile});

  @override
  _CenterDialogMobileState createState() => _CenterDialogMobileState();
}

class _CenterDialogMobileState extends State<CenterDialogMobile>
    with AfterLayoutMixin {
  static final GlobalKey<DialogWidgetState> _dialogKey =
      new GlobalKey(debugLabel: 'dialog');
  static final GlobalKey<FormState> _formKey =
      new GlobalKey(debugLabel: 'form');

  final GlobalKey<CustomizeFieldWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<CustomizeFieldWidgetState> _verifyFieldKey =
      new GlobalKey(debugLabel: 'verify');

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      key: _dialogKey,
      heightFactor: 0.4,
      minHeight: (Global.device.width > 360) ? 305 : 330,
      maxHeight: (Global.device.width > 360) ? 350 : 375,
      debug: true,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Text(
                  localeStr.userVerifyButtonText(''),
                  style: TextStyle(
                    color: Themes.defaultAccentColor,
                    fontSize: FontSize.SUBTITLE.value,
                  ),
                ),
              ),
              new Form(
                key: _formKey,
                child: ListView(
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  children: <Widget>[
                    new CustomizeFieldWidget(
                      key: _phoneFieldKey,
                      fieldType: FieldType.Numbers,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.centerTextTitlePhone,
                      titleLetterSpacing: 8,
                      suffixText: localeStr.userVerifyButtonText('\n'),
                      suffixLetterWidth: 3.6,
                      suffixAction: (input) {
                        print('post request: ${widget.store.waitForResponse}');
                        if (widget.store.waitForResponse == false)
                          widget.store.postVerifyRequest(
                              _phoneFieldKey.currentState.getInput);
                      },
                      readOnly: true,
                    ),
                    new CustomizeFieldWidget(
                      key: _verifyFieldKey,
                      fieldType: FieldType.NoChinese,
                      hint: '',
                      persistHint: false,
                      prefixText: localeStr.userVerifyFieldTitle,
                      titleLetterSpacing: 3,
                      maxInputLength: 12,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Icon(
                        Icons.info,
                        color: Themes.hintHighlight,
                        size: 16.0,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        localeStr.userVerifyFieldInfo,
                        style: TextStyle(
                          color: Themes.hintHighlight,
                        ),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ],
                ),
              ),
              /* Login Buttons */
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: RaisedButton(
                  child: Text(localeStr.btnConfirm),
                  textColor: Themes.defaultTextColorBlack,
                  onPressed: () {
                    // clear text field focus
                    FocusScope.of(context).requestFocus(new FocusNode());
                    _validateForm();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
//      print('The user wants to login with $_username and $_password');
      String verifyCode = _verifyFieldKey?.currentState?.getInput ?? '';
      if (verifyCode.isNotEmpty)
        widget.store.postVerify(widget.mobile, verifyCode);
      else
        FLToast.showText(
          text: localeStr.messageInvalidVerify,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _phoneFieldKey.currentState.setInput = widget.mobile;
  }
}
