import 'package:flutter/material.dart';

import '../state/message_store.dart';
import 'message_display_item.dart';

class MessageDisplay extends StatefulWidget {
  final MessageStore store;

  MessageDisplay(this.store);

  @override
  _MessageDisplayState createState() => _MessageDisplayState();
}

class _MessageDisplayState extends State<MessageDisplay> {
  List<GlobalKey<MessageDisplayItemState>> itemKeys;
  List<MessageDisplayItem> listItems;

  @override
  Widget build(BuildContext context) {
    itemKeys ??= new List();
    listItems ??= widget.store.messageList.map((message) {
      GlobalKey<MessageDisplayItemState> key =
          new GlobalKey<MessageDisplayItemState>(debugLabel: 'm${message.id}');
      itemKeys.add(key);
      return MessageDisplayItem(
        key,
        data: message,
        onItemTap: (id) => widget.store.updateMessageStatus(id),
      );
    }).toList();

    return ListView.builder(
      itemCount: listItems.length,
      itemBuilder: (_, index) {
        return listItems[index];
      },
    );
  }
}
