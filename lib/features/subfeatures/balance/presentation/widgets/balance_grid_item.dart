import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/subfeatures/balance/presentation/enum/balance_grid_action.dart';
import 'package:flutter_ty_mobile/utils/value_util.dart';

import 'balance_action_dialog.dart';

class BalanceGridItem extends StatefulWidget {
  final String platform;
  final BalanceGridCall onTapAction;

  BalanceGridItem(
    Key key,
    this.platform, {
    this.onTapAction,
  }) : super(key: key);

  @override
  BalanceGridItemState createState() => BalanceGridItemState();
}

class BalanceGridItemState extends State<BalanceGridItem>
    with TickerProviderStateMixin {
  static final String btn1Text = localeStr.balanceTransferOutText;
  static final String btn2Text = localeStr.balanceTransferInText;

  AnimationController _controller;
  TickerFuture tickerFuture;

  set setCredit(String credit) {
    stopAnim();
    if (_credit == credit) return;
    _credit = credit;
    var dCredit = _credit.strToDouble;
    canTransferOut = dCredit > 0.0;
    if (credit == 'x' || dCredit < 0) canTransferIn = false;
    setState(() {});
    print('${widget.platform} credit updated');
  }

  String _credit = '---';
  bool canTransferOut = true;
  bool canTransferIn = true;
  bool canRefresh = true;

  void startAnim() {
    canRefresh = false;
    tickerFuture = _controller.repeat();
    tickerFuture.timeout(Duration(seconds: 5), onTimeout: () {
      stopAnim();
    });
  }

  void stopAnim() {
    if (_controller.isAnimating) {
      print('stop anim');
      _controller.forward(from: 0);
      _controller.stop(canceled: true);
    }
    setState(() {
      canRefresh = true;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
//    _controller.addListener(() {
//      setState(() {
//        if (_controller.status == AnimationStatus.completed)
//          _controller.repeat();
//      });
//    });
    _controller.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6.0),
      child: Container(
        decoration: BoxDecoration(
          color: Themes.dialogBgColor,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        margin: const EdgeInsets.only(bottom: 3.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                widget.platform.toUpperCase(),
                style: TextStyle(
                  color: Themes.hintHighlightOrange,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  GestureDetector(
                    child: Text(
                      btn1Text,
                      style: TextStyle(
                        color: (canTransferOut)
                            ? Themes.hintHighlightLightYellow
                            : Themes.defaultDisabledColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => new BalanceActionDialog(
                          targetPlatform: widget.platform,
                          isTransferIn: false,
                          onConfirm: () {
                            if (widget.onTapAction != null)
                              widget.onTapAction(
                                BalanceGridAction.transferOut,
                                widget.platform,
                              );
                          },
                        ),
                      );
                    },
                  ),
                  Text(
                    ' / ',
                    style: TextStyle(
                      color: (canTransferOut || canTransferIn)
                          ? Themes.hintHighlightLightYellow
                          : Themes.defaultDisabledColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    child: Text(
                      btn2Text,
                      style: TextStyle(
                        color: (canTransferIn)
                            ? Themes.hintHighlightLightYellow
                            : Themes.defaultDisabledColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => new BalanceActionDialog(
                          targetPlatform: widget.platform,
                          isTransferIn: true,
                          onConfirm: () {
                            if (widget.onTapAction != null)
                              widget.onTapAction(
                                BalanceGridAction.transferIn,
                                widget.platform,
                              );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _credit,
                      style: TextStyle(
                        color: Themes.defaultHintColorDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    child: RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                      child: Icon(
                        Icons.refresh,
                        color: (canRefresh)
                            ? Themes.defaultWidgetColor
                            : Themes.defaultDisabledColor,
                        size: 18,
                      ),
                    ),
                    onTap: () {
                      if (widget.onTapAction != null && canRefresh) {
                        startAnim();
                        widget.onTapAction(
                          BalanceGridAction.refresh,
                          widget.platform,
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
