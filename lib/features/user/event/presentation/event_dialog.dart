import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_ty_mobile/core/internal/global.dart';
import 'package:flutter_ty_mobile/core/internal/local_strings.dart';
import 'package:flutter_ty_mobile/core/internal/themes.dart';
import 'package:flutter_ty_mobile/features/export_internal_file.dart';
import 'package:flutter_ty_mobile/features/general/widgets/cached_network_image.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_ty_mobile/features/user/data/models/event_model.dart';

typedef EventSignFunction = Future<bool> Function();
typedef EventErrorFunction = String Function();

class EventDialog extends StatefulWidget {
  final EventData event;
  final int signCount;
  final Function onDialogClose;
  final EventSignFunction onSign;
  final EventErrorFunction onSignError;

  EventDialog({
    this.event,
    this.signCount,
    this.onDialogClose,
    this.onSign,
    this.onSignError,
  });

  @override
  _EventDialogState createState() => _EventDialogState();
}

class _EventDialogState extends State<EventDialog> {
  bool signed = false;
  int count;

  @override
  void initState() {
    count = (widget.signCount >= 0) ? widget.signCount : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double dialogWidth =
        (Global.device.width >= 352) ? 320 : Global.device.width - 32;
    return DialogWidget(
      noBackground: true,
      canClose: false,
      constraints: BoxConstraints(
        maxHeight: 364,
        maxWidth: dialogWidth,
      ),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          margin: const EdgeInsets.only(bottom: 64.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0),
                ),
                child: networkImageBuilder(widget.event.pic),
              ),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!signed)
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: dialogWidth / 4),
                              child: RaisedButton(
                                materialTapTargetSize:
                                    MaterialTapTargetSize.padded,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(24.0),
                                ),
                                child: Text(
                                  localeStr.btnSignUp,
                                  style: TextStyle(
                                    color: Themes.defaultTextColorBlack,
                                    fontSize: FontSize.SUBTITLE.value,
                                  ),
                                ),
                                onPressed: () async {
                                  final result = await widget.onSign();
                                  print('sign event result = $result');
                                  if (result) {
                                    signed = true;
                                    count += 1;
                                    setState(() {});
                                  } else {
                                    FLToast.showError(
                                      text: widget.onSignError(),
                                      showDuration: ToastDuration.DEFAULT.value,
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (signed)
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: HexColor.fromHex('#6dc854'),
                          ),
                          Text(
                            localeStr.eventButtonSignUpSuccess,
                            style: TextStyle(
                              color: HexColor.fromHex('#6dc854'),
                              fontSize: FontSize.TITLE.value,
                            ),
                          )
                        ],
                      ),
                    SizedBox(height: 12.0),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: localeStr.eventSignUpHint1,
                            style: TextStyle(
                              color: Themes.defaultTextColorGrey,
                              fontSize: FontSize.SUBTITLE.value,
                            ),
                          ),
                          TextSpan(
                            text: ' $count ',
                            style: TextStyle(
                              color: HexColor.fromHex('#ff7eb8'),
                              fontSize: FontSize.MESSAGE.value,
                            ),
                          ),
                          TextSpan(
                            text: localeStr.eventSignUpHint2,
                            style: TextStyle(
                              color: Themes.defaultTextColorGrey,
                              fontSize: FontSize.SUBTITLE.value,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: dialogWidth / 2 - 25,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints.tight(Size(50.0, 50.0)),
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 48.0,
                  ),
                  onPressed: () {
                    widget.onDialogClose();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
