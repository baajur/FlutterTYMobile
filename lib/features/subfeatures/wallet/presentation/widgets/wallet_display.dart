import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/res.dart';

import '../../../../route_page_export.dart';
import '../enum/wallet_type.dart';
import '../state/wallet_store.dart';
import 'wallet_dialog.dart';

class WalletDisplay extends StatefulWidget {
  final WalletStore store;

  WalletDisplay({@required this.store});

  @override
  _WalletDisplayState createState() => _WalletDisplayState();
}

class _WalletDisplayState extends State<WalletDisplay> {
  List<ReactionDisposer> _disposers;
  final GlobalKey _optionListKey = new GlobalKey(debugLabel: 'options');
  final GlobalKey _creditBoxKey = new GlobalKey(debugLabel: 'box');

  double _bgHeight;
  double _bgMaxHeight;
  double _bgWidth;
  String _credit;
  WalletType _selected;
  WalletType _walletType;

  @override
  void didChangeDependencies() {
    print('didChangeDependencies');
    super.didChangeDependencies();
    _disposers ??= [
      /* Reaction on transfer action */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.waitForTransfer,
        // Run some logic with the content of the observed field
        (bool wait) {
          print('reaction on wait wallet transfer: $wait');
          if (wait == null) return;
          if (wait && widget.store.showingDialog != true) {
            widget.store.showingDialog = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => new WalletDialog(store: widget.store),
            );
          }
        },
      ),
      /* Reaction on wallet data change */
      reaction(
        // Observe in page
        // Tell the reaction which observable to observe
        (_) => widget.store.wallet,
        // Run some logic with the content of the observed field
        (wallet) {
          print('reaction on wallet changed: $wallet');
          if (wallet == null) return;
          String newCredit = widget.store.wallet.credit;
          WalletType newWalletType =
              (widget.store.wallet.auto == WalletType.SINGLE.value)
                  ? WalletType.SINGLE
                  : WalletType.MULTI;
          print('new wallet type: $newWalletType, current: $_walletType');
          if (newWalletType != _walletType)
            _optionListKey.currentState.setState(() {
              _walletType = newWalletType;
            });
          if (newCredit != _credit)
            _creditBoxKey.currentState.setState(() {
              _credit = newCredit;
            });
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
  void initState() {
    _bgHeight = Global.device.height * 0.6;
    _bgMaxHeight = (_bgHeight > 480.0)
        ? 480.0
        : _bgHeight; //TODO need to test max height on small screen
    if (_bgHeight > _bgMaxHeight) _bgHeight = _bgMaxHeight;
    _bgWidth = Global.device.width - 28.0;
    _credit = widget.store.wallet.credit;
    _walletType = (widget.store.wallet.auto == WalletType.SINGLE.value)
        ? WalletType.SINGLE
        : WalletType.MULTI;
    _selected = _walletType;
    super.initState();
  }

  @override
  void didUpdateWidget(WalletDisplay oldWidget) {
    _credit = widget.store.wallet.credit;
    _walletType = (widget.store.wallet.auto == WalletType.SINGLE.value)
        ? WalletType.SINGLE
        : WalletType.MULTI;
    _selected = _walletType;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14.0, 10.0, 14.0, 90.0),
        child: Container(
          alignment: Alignment.topCenter,

          ///Background Container
          constraints: BoxConstraints(
            minHeight: _bgHeight,
            maxHeight: _bgMaxHeight,
            maxWidth: _bgWidth,
          ),
          decoration: BoxDecoration(
            color: Themes.defaultBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 0.7,
                blurRadius: 3.5,
                offset: Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              Row(
                /// Background Top Icon
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 120, // same as icon height
                      decoration: BoxDecoration(
                        color: Themes.stackBackgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Image.asset(
                        Res.walletBgIcon,
                        alignment: Alignment.topLeft,
                        fit: BoxFit.none,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 8.0,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: _bgHeight - 24,
                    maxHeight: _bgMaxHeight - 24,
                    maxWidth: _bgWidth - 16,
                  ),
                  child: Column(
                    /// Wallet Content
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(Res.walletBgIconSmall),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              localeStr.walletViewTitleMy,
                              style: TextStyle(fontSize: FontSize.LARGE.value),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 8.0),
                        child: _buildWalletBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildOptions(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Build wallet box content
  ///
  Widget _buildWalletBox() {
    return Container(
      constraints: BoxConstraints(
        minHeight: _bgHeight * 0.325,
        maxHeight: _bgMaxHeight * 0.325,
        minWidth: _bgWidth - 32,
      ),
      decoration: BoxDecoration(
        color: Themes.stackBackgroundColorDark,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            spreadRadius: 0.6,
            blurRadius: 3,
            offset: Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          /// Wallet Credit
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  localeStr.walletViewTitleRemain,
                  style: TextStyle(color: Themes.hintHighlightOrange),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Themes.iconColorGrey,
                  ),
                  child: Icon(
                    IconData(0xf155, fontFamily: 'FontAwesome'),
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                _credit,
                style: TextStyle(
                  fontSize: FontSize.XLARGE.value,
                  fontWeight: FontWeight.bold,
                  color: Themes.defaultAccentColor,
                ),
                overflow: TextOverflow.visible,
              ),
            ],
          ),

          /// Transfer Button
          SizedBox(
            width: _bgWidth / 3,
            child: RaisedButton(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              child: Text(
                localeStr.walletViewButtonOneClick,
                style: TextStyle(
                  color: Themes.defaultTextColorBlack,
                ),
              ),
              onPressed: () {
                if (widget.store.waitForTransfer != true)
                  widget.store.postWalletTransfer();
              },
            ),
          ),

          /// Transfer Hint
          Text(localeStr.walletViewHintOneClick),
        ],
      ),
    );
  }

  ///
  /// Build Radio options and hints
  ///
  Widget _buildOptions() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: _bgHeight * 0.25,
        // (_bgHeight * 0.325) = wallet box
        // 64 = parent padding and items above
        // 60 = child padding and font line space
        maxHeight: _bgMaxHeight - (_bgMaxHeight * 0.325) - 64 - 60,
      ),
      child: Scrollbar(
        child: ListView.builder(
          key: _optionListKey,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (_, index) {
            switch (index) {
              case 0:
              case 2:
                String radioLabel = (index == 0)
                    ? localeStr.walletViewTitleWalletSingle
                    : localeStr.walletViewTitleWalletMulti;
                WalletType radioValue =
                    (index == 0) ? WalletType.SINGLE : WalletType.MULTI;
                return Row(
                  /// Radio Options
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Radio(
                      visualDensity: VisualDensity.compact,
                      value: radioValue,
                      groupValue: _selected,
                      onChanged: (value) {
                        setState(() {
                          _selected = value;
                        });
                        print('selected: $_selected');
                      },
                    ),
                    Text(
                      radioLabel,
                      style: TextStyle(
                        fontSize: FontSize.TITLE.value,
                        color: (_selected == radioValue)
                            ? Themes.defaultAccentColor
                            : Themes.buttonDisabledTextColor,
                      ),
                    ),
                    if (_walletType == radioValue)
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 2.0),
                        child: Icon(
                          Icons.check_circle,
                          color: Themes.defaultWidgetColor,
                          size: 14,
                        ),
                      )
                  ],
                );
                break;
              case 1:
              case 3:
                String radioHint = (index == 1)
                    ? localeStr.walletViewHintWalletSingle
                    : localeStr.walletViewHintWalletMulti;
                return Padding(
                  /// Radio Hints
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 36.0,
                    right: 6.0,
                  ),
                  child: Text(
                    radioHint,
                    style: TextStyle(
                      color: Themes.defaultHintColorDark,
                    ),
                  ),
                );
                break;
              case 4:
                return Row(
                  /// Action Button
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: _bgWidth / 3,
                      child: RaisedButton(
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        child: Text(localeStr.btnConfirm),
                        textColor: Themes.defaultTextColorBlack,
                        onPressed: () {
                          if (widget.store.waitForTypeChange) {
                            FLToast.showText(
                              text: localeStr.messageWait,
                              showDuration: ToastDuration.DEFAULT.value,
                              position: FLToastPosition.top,
                            );
                          } else if (_walletType != _selected) {
                            if (_selected == WalletType.SINGLE)
                              widget.store.postWalletTransfer(toSingle: true);
                            else
                              widget.store.postWalletType(false);
                          }
                        },
                      ),
                    ),
                  ],
                );
                break;
              default:
                return SizedBox.shrink();
                break;
            }
          },
        ),
      ),
    );
  }
}
