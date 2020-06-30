import 'package:flutter/material.dart';
import 'package:flutter_ty_mobile/features/general/widgets/dialog_widget.dart';
import 'package:flutter_ty_mobile/features/general_display_widget_export.dart';

typedef OnAgentAdGenerate = void Function(int);

class AgentDisplayAdDialog extends StatelessWidget {
  final int adId;
  final String title;
  final bool isMerged;
  final String pic;
  final OnAgentAdGenerate onGenerate;

  AgentDisplayAdDialog({
    this.adId,
    this.title,
    this.pic,
    this.isMerged = false,
    this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    return DialogWidget(
      children: <Widget>[
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Global.device.height * 0.85,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  (title == null)
                      ? SizedBox(height: 14.0)
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: FontSize.TITLE.value,
                                    color: Themes.defaultAccentColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                  if (!isMerged && onGenerate != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      width: 120,
                      child: RaisedButton(
                        onPressed: () => onGenerate(adId),
                        child: Text(localeStr.agentAdButtonGenerate),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: networkImageBuilder(
                      pic,
                      fill: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
