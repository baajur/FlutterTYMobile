import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show
        LengthLimitingTextInputFormatter,
        TextInputFormatter,
        WhitelistingTextInputFormatter;
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/utils/regex_util.dart' show RegexExtension;

part '../enum/input_field_type.dart';

typedef ValidCondition = bool Function(String);
typedef SuffixTapCall = void Function(String);

///
///
/// TODO separate prefix and suffix widget
///
class CustomizeFieldWidget extends StatefulWidget {
  /* Field Settings */
  final FieldType fieldType;
  final String hint;
  final bool persistHint;
  final bool coloredHint;
  final bool centerFieldText;
  final bool useSameBgColor;
  final bool readOnly;

  /* Field Validate Settings */
  final int maxInputLength;
  final ValidCondition validCondition;
  final String errorMsg;

  /* Container Settings */
  final double parentWidth;
  final double horizontalInset;
  final EdgeInsetsGeometry padding;
  final double minusHeight;

  /* Decoration Widget Settings */
  final String prefixText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final String suffixText;
  final SuffixTapCall suffixAction;
  final double titleWidthFactor;
  final double titleLetterSpacing;
  final double iconWidthFactor;
  final double suffixLetterWidth;

  /* Other Settings */
  final bool debug;

  CustomizeFieldWidget({
    Key key,
    this.fieldType = FieldType.Normal,
    this.hint = '',
    this.persistHint = true,
    this.coloredHint = false,
    this.centerFieldText = false,
    this.useSameBgColor = false,
    this.readOnly = false,
    this.maxInputLength = 16,
    this.validCondition,
    this.errorMsg,
    this.parentWidth,
    this.horizontalInset = 32.0,
    this.minusHeight = 0,
    this.padding,
    this.prefixText,
    this.prefixIconData,
    this.suffixText,
    this.suffixIconData,
    this.suffixAction,
    this.titleLetterSpacing = 12.0,
    this.titleWidthFactor = Themes.prefixTextWidthFactor,
    this.iconWidthFactor = Themes.prefixIconWidthFactor,
    this.suffixLetterWidth = 2.4,
    this.debug = false,
  }) : super(key: key);

  @override
  CustomizeFieldWidgetState createState() => CustomizeFieldWidgetState();
}

class CustomizeFieldWidgetState extends State<CustomizeFieldWidget> {
  final TextEditingController _controller = new TextEditingController();
  final GlobalKey<FormFieldState> _fieldKey = new GlobalKey();
  int lastTextLength = 0;
  bool _isValid = true;
  double prefixWidth;
  double suffixWidth;
  Widget prefixWidget;
  Widget suffixWidget;
  BoxConstraints prefixConstraints;
  BoxConstraints suffixConstraints;
  double smallWidgetHeight;
  EdgeInsetsGeometry fieldInset;
  TextStyle fieldTextStyle;

  String get inputText => _controller.text;

  set setInput(String text) {
    _controller.text = text;
    if (text.isNotEmpty) {
      // Android on change resets cursor position(cursor goes to 0)
      // so you have to check if it reset, then put in the end(just on android)
      // as IOS bugs if you simply put it in the end
      _controller.selection =
          new TextSelection.fromPosition(new TextPosition(offset: text.length));
    }
    setState(() {});
  }

  @override
  void initState() {
    double viewWidth =
        (widget.parentWidth ?? Global.device.width).roundToDouble() -
            widget.horizontalInset;

    prefixWidth = (widget.prefixText != null)
        ? viewWidth * widget.titleWidthFactor
        : viewWidth * widget.iconWidthFactor;

    suffixWidth = FontSize.NORMAL.value * widget.suffixLetterWidth;
    if (Platform.isIOS) suffixWidth += 8.0;

    smallWidgetHeight =
        ((Platform.isAndroid) ? Themes.fieldHeight : Themes.fieldHeight + 8) -
            widget.minusHeight;

    double fieldInsetHeight =
        (widget.persistHint) ? 8 : (smallWidgetHeight - 21.6) / 2;

    fieldInset = (widget.centerFieldText)
        ? EdgeInsets.only(left: 2.0)
        : EdgeInsets.symmetric(horizontal: 8.0, vertical: fieldInsetHeight);

    fieldTextStyle = TextStyle(
      fontSize:
          (widget.readOnly) ? FontSize.NORMAL.value : FontSize.SUBTITLE.value,
      color: (widget.readOnly)
          ? Themes.defaultTextColor
          : Themes.defaultTextColorWhite,
    );

    if (widget.debug) {
      print(
          'screen width: ${Global.device.width}, view width: ${widget.parentWidth}');
      print('field prefix width: $prefixWidth');
    }
    super.initState();
  }

  @override
  void didUpdateWidget(CustomizeFieldWidget oldWidget) {
    if (widget.debug) print('update custom field: ${widget.prefixText}');
    if (widget.prefixText == null && widget.prefixIconData == null)
      prefixWidget = null;
    if (widget.suffixText == null && widget.suffixIconData == null)
      suffixWidget = null;
    fieldTextStyle = TextStyle(
      fontSize:
          (widget.readOnly) ? FontSize.NORMAL.value : FontSize.SUBTITLE.value,
      color: (widget.readOnly)
          ? Themes.defaultTextColor
          : Themes.defaultTextColorWhite,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    prefixConstraints ??= BoxConstraints(
      minWidth: prefixWidth,
      maxWidth: prefixWidth,
      minHeight: smallWidgetHeight,
    );
    suffixConstraints ??= BoxConstraints(
      minWidth: suffixWidth,
      maxWidth: suffixWidth,
      minHeight: smallWidgetHeight,
    );
    if (prefixWidget == null &&
        (widget.prefixText != null || widget.prefixIconData != null)) {
      _buildPrefix();
    }
    if (suffixWidget == null &&
        (widget.suffixText != null || widget.suffixIconData != null)) {
      _buildSuffix();
    }
    if (prefixWidget == null && suffixWidget == null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 2),
          constraints: BoxConstraints(
            minHeight: smallWidgetHeight,
          ),
          child: new TextFormField(
            key: _fieldKey,
            controller: _controller,
            keyboardType: _keyboardType(),
            inputFormatters: _formatterList(),
            obscureText: widget.fieldType == FieldType.Password,
            readOnly: widget.readOnly,
            onChanged: (value) {
              _isValid = widget.validCondition(value) ?? true;
              if (widget.debug)
                print('${widget.hint} input: $value, valid: $_isValid');
              setState(() {});
            },
            style: fieldTextStyle,
            textAlign:
                (widget.centerFieldText) ? TextAlign.center : TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              labelText: (widget.persistHint) ? widget.hint : null,
              hintText: (widget.persistHint) ? null : widget.hint,
              hintStyle: (widget.coloredHint)
                  ? TextStyle(color: Themes.hintHighlight)
                  : null,
              isDense: true,
              contentPadding: fieldInset,
              errorText: (_isValid) ? null : widget.errorMsg,
            ),
            maxLines: null,
            expands: true,
          ),
        ),
      );
    } else {
      return Padding(
        padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 2),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: new TextFormField(
            key: _fieldKey,
            controller: _controller,
            keyboardType: _keyboardType(),
            inputFormatters: _formatterList(),
            obscureText: widget.fieldType == FieldType.Password,
            readOnly: widget.readOnly,
            onChanged: (value) {
              if (widget.fieldType == FieldType.Date) {
                if (_dateInputChecked(value) == false) return;
              }
              _isValid = widget.validCondition(value) ?? true;
              if (widget.debug) {
                print(
                    '${widget.hint} input: $value, code: ${value.codeUnits}, valid: $_isValid');
              }
              setState(() {});
            },
            style: fieldTextStyle,
            textAlign:
                (widget.centerFieldText) ? TextAlign.center : TextAlign.start,
            textAlignVertical: TextAlignVertical.center,
            decoration: InputDecoration(
              labelText: (widget.persistHint) ? widget.hint : null,
              hintText: (widget.persistHint) ? null : widget.hint,
              hintStyle: (widget.coloredHint)
                  ? TextStyle(color: Themes.hintHighlight)
                  : null,
              isDense: true,
              fillColor: (widget.useSameBgColor)
                  ? Themes.defaultWidgetBgColor
                  : Themes.fieldInputBgColor,
              contentPadding: fieldInset,
              prefixIconConstraints: (prefixWidget != null)
                  ? prefixConstraints
                  : BoxConstraints.tightFor(width: 6, height: 0),
              prefixIcon: (prefixWidget != null)
                  ? Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      color: Themes.defaultWidgetBgColor,
                      child: prefixWidget,
                    )
                  : SizedBox.shrink(),
              suffixIconConstraints: (suffixWidget != null)
                  ? suffixConstraints
                  : BoxConstraints.tightFor(width: 6, height: 0),
              suffixIcon:
                  (suffixWidget != null) ? suffixWidget : SizedBox.shrink(),
              errorText: (_isValid) ? null : widget.errorMsg,
            ),
          ),
        ),
      );
    }
  }

  void _buildPrefix() {
    if (widget.prefixText != null && widget.prefixIconData != null) {
      prefixWidget = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: Icon(
              widget.prefixIconData,
              size: Themes.fieldIconSize,
              color: Themes.iconColorLightGrey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 6.0),
            child: Text(
              widget.prefixText,
              style: TextStyle(
//                fontSize: FontSize.SUBTITLE.value,
                wordSpacing: widget.titleLetterSpacing / 2,
                letterSpacing: widget.titleLetterSpacing / 4,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else if (widget.prefixText != null) {
      prefixWidget = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 6.0 - widget.titleLetterSpacing / 2),
            child: Text(
              widget.prefixText,
              style: TextStyle(
//              fontSize: FontSize.SUBTITLE.value,
                wordSpacing: widget.titleLetterSpacing,
                letterSpacing: widget.titleLetterSpacing,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else if (widget.prefixIconData != null) {
      prefixWidget = Center(
        child: Icon(
          widget.prefixIconData,
          size: Themes.fieldIconSize,
          color: Themes.iconColorLightGrey,
        ),
      );
    }
  }

  void _buildSuffix() {
    if (widget.suffixIconData != null) {
      suffixWidget = Center(
        child: GestureDetector(
          child: Icon(
            widget.suffixIconData,
            size: Themes.fieldIconSize * 0.625,
            color: Themes.dialogTitleColor,
          ),
          onTap: () => (widget.suffixAction != null)
              ? widget.suffixAction(_controller.text)
              : print(_controller.text),
        ),
      );
    } else if (widget.suffixText != null) {
      suffixWidget = Center(
        child: Container(
          margin: const EdgeInsets.only(right: 4.0),
          child: GestureDetector(
            child: Text(
              widget.suffixText,
              style: TextStyle(color: Themes.dialogTitleColor),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
              maxLines: 2,
            ),
            onTap: () => (widget.suffixAction != null)
                ? widget.suffixAction(_controller.text)
                : print(_controller.text),
          ),
        ),
      );
    }
  }

  TextInputType _keyboardType() {
    switch (widget.fieldType) {
      case FieldType.Numbers:
        return TextInputType.number;
      case FieldType.Email:
        return TextInputType.emailAddress;
      case FieldType.Date:
        return TextInputType.datetime;
      default:
        return TextInputType.text;
    }
  }

  List<TextInputFormatter> _formatterList() {
    switch (widget.fieldType) {
      case FieldType.ChineseOnly:
        return [
          _chineseInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength ~/ 2),
        ];
      case FieldType.NoEnglish:
        return [
          _withoutEngInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength ~/ 2),
        ];
      case FieldType.Numbers:
        return [
          _numbersInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      case FieldType.Date:
        return [
          _dateInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      case FieldType.Email:
        return [
          _emailInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      case FieldType.NoChinese:
      case FieldType.Password:
        return [
          _withoutChineseInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
      default:
        return [
          _normalInputFormatter,
          LengthLimitingTextInputFormatter(widget.maxInputLength),
        ];
    }
  }

  final dateMask = 'xxxx-xx-xx';

  final dateSeparator = '-';

  bool _dateInputChecked(String input) {
    if (input.isValidDate || input.length < 4) {
      lastTextLength = input.length;
      print('field date checked');
      return true;
    }
    if (input.length < lastTextLength) {
      // is deleting
      print('date helper deleting: $input');
      // delete separator
      if (input.endsWith(dateSeparator)) {
        _controller.text = input.substring(0, input.length - 1);
      }
      print('date helper new text: ${_controller.text}');
    } else if (input.length > lastTextLength) {
      // is typing
      print('date helper typing: $input');
      var position = input.length;

      if (position < dateMask.length && dateMask[position] == dateSeparator) {
        _controller.text = input + dateSeparator;
        print('date helper new text: ${_controller.text}');
      }
      if (position == 5 && input.contains(dateSeparator) == false) {
        _controller.text = input.replaceRange(
            position - 1, position, dateSeparator + input[position - 1]);
      }
    }
    lastTextLength = _controller.text.length;
    if (input == _controller.text) return true;
    try {
      _fieldKey.currentState.didChange(_controller.text);
      setInput = _controller.text;
    } on Exception catch (e) {
      print('field state error: $e');
      setState(() {});
    }
    return false;
  }
}
