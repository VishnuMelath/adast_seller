
import 'package:adast_seller/features/chat/chat_screen/UI/widgets/appbar_chatroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';
import '../../../../models/message_model.dart';
import '../../../../services/messages_database_services.dart';
import '../bloc/chat_bloc.dart';
import '../methods/methods_for_chat.dart';
import 'widgets/textbox_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ChatBloc chatBloc = context.read();
    ScrollController scrollController = ScrollController();
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          appBar:appBarChatRoom(chatBloc.userModel),
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: MessagesDatabaseServices()
                        .getMessages(chatBloc.chatRoomModel.roomId),
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        Map<DateTime, List<MessageModel>> dateMessages = {};
                        List<MessageModel> messages = snapshots.data!.docs
                            .map(
                              (e) => MessageModel.fromJson(e.data()),
                            )
                            .toList();messages.sort(
                          (a, b) => b.timestamp.compareTo(a.timestamp),
                        );
                        dateMessages = group(messages);
                        chatBloc.add(ChatSetSellerUnseenCountZero());
                        return ListView(
                          reverse: true,
                          controller: scrollController,
                          children: convertToWidget(dateMessages),
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: TextboxMessage(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
