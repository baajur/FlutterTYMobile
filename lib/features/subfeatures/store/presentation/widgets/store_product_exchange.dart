import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/features/exports_for_display_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_dropdown_widget.dart';
import 'package:flutter_ty_mobile/features/general/widgets/customize_field_widget.dart';

import '../../data/form/store_exchange_form.dart';
import '../../data/models/store_product_model.dart';
import '../state/point_store.dart';

class StoreProductExchange extends StatefulWidget {
  final PointStore store;
  final StoreProductModel product;
  final int memberPoints;
  final double maxWidth;

  StoreProductExchange({
    @required this.store,
    @required this.product,
    @required this.memberPoints,
    @required this.maxWidth,
  });

  @override
  _StoreProductExchangeState createState() => _StoreProductExchangeState();
}

class _StoreProductExchangeState extends State<StoreProductExchange> {
  static final _formKey = new GlobalKey<FormState>();
  final GlobalKey<CustomizeFieldWidgetState> _nameFieldKey =
      new GlobalKey(debugLabel: 'name');
  final GlobalKey<CustomizeFieldWidgetState> _phoneFieldKey =
      new GlobalKey(debugLabel: 'phone');
  final GlobalKey<CustomizeFieldWidgetState> _postcodeFieldKey =
      new GlobalKey(debugLabel: 'code');
  final GlobalKey<CustomizeFieldWidgetState> _addressFieldKey =
      new GlobalKey(debugLabel: 'address');

  // Dropdowns
  final GlobalKey<CustomizeDropdownWidgetState> _provinceKey =
      new GlobalKey(debugLabel: 'city');
  final GlobalKey<CustomizeDropdownWidgetState> _cityKey =
      new GlobalKey(debugLabel: 'city');
  final GlobalKey<CustomizeDropdownWidgetState> _areaKey =
      new GlobalKey(debugLabel: 'area');

  List<ReactionDisposer> _disposers;
  Map<String, String> provinceMap;
  Map<String, String> cityMap;
  Map<String, String> areaMap;

  bool _waitForProvinceMap = true;
  String _provinceSelected;
  String _citySelected;
  String _areaSelected;

  void _validateForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      StoreExchangeForm dataForm = StoreExchangeForm(
        productId: widget.product.productId,
        name: _nameFieldKey.currentState.getInput,
        phone: _phoneFieldKey.currentState.getInput,
        postCode: _postcodeFieldKey.currentState.getInput,
        province: _provinceSelected,
        city: _citySelected,
        area: _areaSelected,
        address: _addressFieldKey.currentState.getInput,
      );
      if (dataForm.isValid) {
        if (_phoneFieldKey.currentState.getInput.length < 13 ||
            _postcodeFieldKey.currentState.getInput.length < 5) {
          FLToast.showText(
            text: localeStr.messageInvalidFormat,
            position: FLToastPosition.top,
            showDuration: ToastDuration.DEFAULT.value,
          );
          return;
        }
        widget.store.exchangeProduct(dataForm);
      } else {
        FLToast.showText(
          text: localeStr.messageActionFillForm,
          position: FLToastPosition.top,
          showDuration: ToastDuration.DEFAULT.value,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.store.getProvinces();
  }

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    _disposers ??= [
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.provinceMap,
        // Run some logic with the content of the observed field
        (map) {
          print('province map changed, size: ${map.keys.length}');
          provinceMap = map;
          _waitForProvinceMap = false;
          setState(() {});
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.cityMap,
        // Run some logic with the content of the observed field
        (map) {
          print('city map changed, size: ${map.keys.length}');
          cityMap = map;
          _citySelected = cityMap.keys.first;
          setState(() {});
        },
      ),
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.areaMap,
        // Run some logic with the content of the observed field
        (map) {
          print('area map changed, size: ${map.keys.length}');
          areaMap = map;
          _areaSelected = areaMap.keys.first;
          setState(() {});
        },
      ),
    ];
  }

  @override
  void dispose() {
    _disposers.forEach((d) => d());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: localeStr.storeRequestWindowPoints,
                  style: TextStyle(
                    fontSize: FontSize.SUBTITLE.value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text:
                      '${localeStr.storeTextItemPoint(widget.memberPoints)} - '
                      '${localeStr.storeTextItemPoint(widget.product.point)}',
                  style: TextStyle(
                    color: Themes.hintHighlightOrangeStrong,
                    fontSize: FontSize.SUBTITLE.value,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: widget.maxWidth - 20,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          color: Themes.defaultWidgetColor,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 6.0),
          child: Text(
            localeStr.storeRequestWindowHint,
            style: TextStyle(
              fontSize: FontSize.SUBTITLE.value,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        (!_waitForProvinceMap)
            ? Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 12.0),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: widget.maxWidth - 40),
                  child: new Form(
                    key: _formKey,
                    child: ListView(
                      primary: false,
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: <Widget>[
                        _buildInput(0),
                        _buildInput(1),
                        _buildInput(2),
                        _buildAreaSelectors(),
                        _buildInput(3),
                      ],
                    ),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 12.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints.tight(
                    Size(widget.maxWidth, 120),
                  ),
                  child: Center(
                    child: SizedBox(
                      width: 18.0,
                      height: 18.0,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
              ),
        Container(
          height: 0.5,
          width: widget.maxWidth - 20,
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 10.0,
          ),
          color: Themes.defaultWidgetColor,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(36.0),
                  ),
                  onPressed: () => _validateForm(),
                  child: Text(localeStr.btnConfirmSend),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInput(int index) {
    String title;
    GlobalKey fieldKey;
    FieldType fieldType;
    int maxLength;
    switch (index) {
      case 0:
        title = localeStr.storeRequestWindowFieldTitleName;
        fieldKey = _nameFieldKey;
        fieldType = FieldType.ChineseOnly;
        maxLength = 12;
        break;
      case 1:
        title = localeStr.storeRequestWindowFieldTitlePhone;
        fieldKey = _phoneFieldKey;
        fieldType = FieldType.Numbers;
        maxLength = 13;
        break;
      case 2:
        title = localeStr.storeRequestWindowFieldTitlePostno;
        fieldKey = _postcodeFieldKey;
        fieldType = FieldType.Numbers;
        maxLength = 6;
        break;
      default:
        title = '';
        fieldKey = _addressFieldKey;
        fieldType = FieldType.NoEnglish;
        maxLength = 30;
        break;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /* Title Text */
          Expanded(
            flex: 2,
            child: (title.isNotEmpty)
                ? RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: ' *  ',
                          style: TextStyle(
                            color: Themes.hintHighlightRed,
                            fontSize: FontSize.SUBTITLE.value,
                          ),
                        ),
                        TextSpan(
                          text: title,
                          style: TextStyle(
                            color: Themes.defaultHintColor,
                            fontSize: FontSize.SUBTITLE.value,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ),
          /* Input Field */
          Expanded(
            flex: 5,
            child: new CustomizeFieldWidget(
              key: fieldKey,
              fieldType: fieldType,
              hint: '',
              persistHint: false,
              maxInputLength: maxLength,
              minusHeight: 20,
              whiteField: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaSelectors() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /* Title Text */
          Expanded(
            flex: 2,
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: ' *  ',
                    style: TextStyle(
                      color: Themes.hintHighlightRed,
                      fontSize: FontSize.SUBTITLE.value,
                    ),
                  ),
                  TextSpan(
                    text: localeStr.storeRequestWindowFieldTitleAddress,
                    style: TextStyle(
                      color: Themes.defaultHintColor,
                      fontSize: FontSize.SUBTITLE.value,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                /* Province Option */
                Expanded(
                  flex: 1,
                  child: CustomizeDropdownWidget(
                    key: _provinceKey,
                    optionValues:
                        (provinceMap != null) ? provinceMap.keys.toList() : [],
                    optionStrings: (provinceMap != null)
                        ? provinceMap.values.toList()
                        : [],
                    changeNotify: (data) {
                      // clear text field focus
                      FocusScope.of(context).requestFocus(new FocusNode());
                      // set selected data
                      _provinceSelected = data;
                      // clear dropdown value that's relative
                      cityMap = null;
                      _citySelected = null;
                      areaMap = null;
                      _areaSelected = null;
                      // request cities map
                      widget.store.getCities(data);
                    },
                    clearValueOnMenuChanged: true,
                    minusHeight: 16.0,
                    whiteBox: true,
                    scaleText: true,
                  ),
                ),
                /* City Option */
                Expanded(
                  flex: 1,
                  child: (cityMap != null)
                      ? CustomizeDropdownWidget(
                          key: _cityKey,
                          optionValues: cityMap.keys.toList(),
                          optionStrings: cityMap.values.toList(),
                          changeNotify: (data) {
                            // clear text field focus
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // set selected data
                            _citySelected = data;
                            // clear dropdown value that's relative
                            areaMap = null;
                            _areaSelected = null;
                            // request areas map
                            widget.store.getAreas(data);
                          },
                          clearValueOnMenuChanged: true,
                          minusHeight: 16.0,
                          whiteBox: true,
                          scaleText: true,
                        )
                      : Container(),
                ),
                /* Area Option */
                Expanded(
                  flex: 1,
                  child: (areaMap != null)
                      ? CustomizeDropdownWidget(
                          key: _areaKey,
                          optionValues: areaMap.keys.toList(),
                          optionStrings: areaMap.values.toList(),
                          changeNotify: (data) {
                            // clear text field focus
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            // set selected data
                            _areaSelected = data;
                          },
                          clearValueOnMenuChanged: true,
                          minusHeight: 16.0,
                          whiteBox: true,
                          scaleText: true,
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
