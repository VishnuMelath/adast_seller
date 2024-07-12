
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ themes/colors_shemes.dart';
import '../../../../../ themes/themes.dart';
import '../../../../../models/message_model.dart';
import '../../../../../services/messages_database_services.dart';
import '../../bloc/chat_bloc.dart';

class TextboxMessage extends StatelessWidget {
  const TextboxMessage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    ChatBloc chatBloc = context.read();
    return Container(
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          color: white,
          border: Border.all(color: greentransparent.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        style: blackPlainTextStyle,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () async {
                  MessageModel messageModel = MessageModel(
                    roomId: chatBloc.chatRoomModel.roomId,
                      seen: false,
                      message: controller.text,
                      senderId:
                          context.read<LoginBloc>().sellerModel!.email,
                      recieverId: chatBloc.userModel.email,
                      timestamp: Timestamp.fromDate(DateTime.now()),
                      messageId: '');
                       controller.clear();
                 await MessagesDatabaseServices().sendOrUpdateMessage(messageModel,chatBloc.chatRoomModel);

                 
                },
                icon: const Icon(
                  Icons.send,
                  color: grey,
                )),
            counterStyle: greenTextStyle,
            border: InputBorder.none,
            hintStyle: greyMediumTextStyle,
            hintText: 'Message...'),
      ),
    );
  }
}
