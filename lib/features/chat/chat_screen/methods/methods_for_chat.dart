import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../../ themes/themes.dart';
import '../../../../methods/common_methods.dart';
import '../../../../models/message_model.dart';
import '../UI/widgets/message_tile.dart';

Map<DateTime, List<MessageModel>> group(List<MessageModel> messages) {
  Map<DateTime, List<MessageModel>> listedMessages = {};
  for (var message in messages) {
    var date = message.timestamp.toDate();
    var temp = DateTime(date.year, date.month, date.day);
    listedMessages[temp] = listedMessages[temp] ?? [];
    listedMessages[temp]!.add(message);
  }
  return listedMessages;
}

List<Widget> convertToWidget(Map<DateTime, List<MessageModel>> map) {
  log(map.toString());
  List<Widget> widgets = [];
  for (var element in map.keys) {
    // log()
    
    for (var element1 in map[element]!) {
      widgets.add(MessageTile(
        messageModel: element1,
      ))
      ;
    }
    widgets.add(Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(dateString(element),style: greyTextStyle,),
          ),
          const Expanded(child: Divider()),
        ],
      ),
    ));
  }
  return widgets;
}
