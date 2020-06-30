import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show Clipboard, ClipboardData;
import 'package:flutter_ty_mobile/features/general_display_widget_export.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_extend/share_extend.dart';

import '../state/agent_store.dart';
import '../../data/models/agent_model.dart';
import 'agent_inherit_widget.dart';

class AgentDisplayInfo extends StatefulWidget {
  @override
  _AgentDisplayInfoState createState() => _AgentDisplayInfoState();
}

class _AgentDisplayInfoState extends State<AgentDisplayInfo>
    with AfterLayoutMixin {
  static final Key _streamKey = new Key('agentstream');
  final GlobalKey<CustomizeFieldWidgetState> _codeFieldKey =
      new GlobalKey(debugLabel: 'code');
  final GlobalKey<CustomizeFieldWidgetState> _linkFieldKey =
      new GlobalKey(debugLabel: 'link');
  final GlobalKey<CustomizeFieldWidgetState> _agentsFieldKey =
      new GlobalKey(debugLabel: 'agents');

  AgentStore _store;
  AgentModel _storeData;
  String _agentUrl;
  int _agentCode;
  bool _hasDescendant = false;
  List<String> _descendants;
  bool _layoutReady = false;

  void updateField() {
    if (_store == null || _storeData == null) return;
    _agentCode = _storeData.code;
    _agentUrl = _storeData.url;
    _descendants = _storeData.descendant.map((item) => '$item').toList();
    _hasDescendant = _descendants != null && _descendants.isNotEmpty;
    print(
        'agent code: $_agentCode\nagent qr: $_agentUrl\nagent has descendant: $_hasDescendant');
    _codeFieldKey.currentState.setInput = '$_agentCode';
    _linkFieldKey.currentState.setInput = _agentUrl;
    _agentsFieldKey.currentState.setInput = _descendants.join(', ');
    print('agent field updated');
  }

  @override
  Widget build(BuildContext context) {
    _store ??= AgentStoreInheritedWidget.of(context).store;
    if (_store == null) {
      return Center(
        child: WarningDisplay(
          message:
              Failure.internal(FailureCode(typeCode: FailureTypeCode.AGENT))
                  .message,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 4.0),
      child: StreamBuilder<AgentModel>(
        key: _streamKey,
        stream: _store.agentStream,
        builder: (context, snapshot) {
          if (_storeData != snapshot.data) {
            print('agent stream snapshot: $snapshot');
            _storeData = snapshot.data;
            if (_layoutReady) updateField();
          }
          return Column(
            children: <Widget>[
              new CustomizeFieldWidget(
                key: _codeFieldKey,
                horizontalInset: 12.0,
                fieldType: FieldType.Numbers,
                hint: '',
                persistHint: false,
                prefixText: localeStr.agentInfoFieldCode,
                titleLetterSpacing: 8,
                suffixText: (_agentCode == null)
                    ? localeStr.agentInfoFieldButtonGetCode
                    : null,
                suffixLetterWidth: 6,
                suffixAction: (_) => _store.getAgentQr(),
                readOnly: true,
              ),
              new CustomizeFieldWidget(
                key: _linkFieldKey,
                horizontalInset: 12.0,
                hint: '',
                persistHint: false,
                prefixText: localeStr.agentInfoFieldLink,
                titleLetterSpacing: 4,
                minusHeight:
                    (_agentUrl != null && _agentUrl.isNotEmpty) ? -8 : 8,
                suffixIconData: (_agentUrl != null && _agentUrl.isNotEmpty)
                    ? Icons.content_copy
                    : null,
                suffixText: (_agentUrl != null && _agentUrl.isNotEmpty)
                    ? localeStr.agentButtonTextShare
                    : null,
                suffixLetterWidth: 4,
                suffixAction: (input) {
                  try {
                    ShareExtend.share(
                      _agentUrl,
                      'text',
                      subject: localeStr.agentInfoFieldLink,
                    );
                  } on Exception {
                    FLToast.showInfo(
                      text: localeStr.workInProgress,
                      showDuration: ToastDuration.DEFAULT.value,
                    );
                  }
                },
                suffixAction2: (input) {
                  Clipboard.setData(new ClipboardData(text: input));
                  Future.delayed(Duration(milliseconds: 200)).then(
                    (value) => FLToast.showText(
                      text: localeStr.messageCopy,
                      showDuration: ToastDuration.DEFAULT.value,
                      position: FLToastPosition.top,
                    ),
                  );
                },
                readOnly: true,
                maxLines:
                    (_agentUrl != null && _agentUrl.isNotEmpty) ? 2 : null,
              ),
              new CustomizeFieldWidget(
                key: _agentsFieldKey,
                horizontalInset: 12.0,
                hint: '',
                persistHint: false,
                prefixText: localeStr.agentInfoFieldAgents,
                titleLetterSpacing: 8,
                suffixText: (_hasDescendant) ? localeStr.btnShow : null,
                suffixAction: (input) {
                  print('show agents');
                },
                useSameBgColor: !_hasDescendant,
                readOnly: true,
              ),
              if (_agentUrl != null && _agentUrl.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    height: 120,
                    width: 120,
                    color: Colors.white,
                    child: QrImage(
                      data: _agentUrl,
                      version: QrVersions.auto,
                      size: 120.0,
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _layoutReady = true;
    updateField();
    setState(() {});
  }
}
