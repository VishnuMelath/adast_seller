
import 'package:adast_seller/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../ themes/colors_shemes.dart';
import '../../../../../ themes/themes.dart';
import '../../../../../methods/common_methods.dart';
import '../../../../../models/chat_room_model.dart';
import '../../../../../services/chat_room_database_services.dart';
import '../../../chat_screen/UI/chat_screen.dart';
import '../../../chat_screen/bloc/chat_bloc.dart';
import '../../bloc/chat_list_bloc.dart';

class RecieverTile extends StatelessWidget {
  final UserModel userModel;
  const RecieverTile({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    ChatListBloc chatListBloc = context.read<ChatListBloc>();
    ChatRoomModel chatRoomModel = chatListBloc.chatrooms.firstWhere(
      (element) => userModel.email == element.userId,
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        onTap: () async {
          chatRoomModel.sellerUnreadCount = 0;
           ChatRoomDatabaseServices().updateChatRoomUnseenCount(chatRoomModel);
          Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ChatBloc(
                          userModel: userModel,
                          chatRoomModel: chatListBloc.chatrooms.firstWhere(
                            (element) => element.userId == userModel.email,
                          )),
                      child: const ChatScreen(),
                    ),
                  ));
        },
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: CachedNetworkImage(width: 40, imageUrl: userModel.image!)),
        title: Text(
          capitalize(userModel.name),
          style: blackTextStyle,
        ),
        subtitle: Text(
          chatRoomModel.lastMessage,
          style: greySmallTextStyle,
        ),
        trailing: Visibility(
          visible: chatRoomModel.sellerUnreadCount > 0,
          child: Container(
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: green, borderRadius: BorderRadius.circular(15)),
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Text(
                  chatRoomModel.sellerUnreadCount.toString(),
                  style: whiteTextStyle,
                ),
              )),
        ),
      ),
    );
  }
}
