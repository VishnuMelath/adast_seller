
import 'package:adast_seller/features/login_screen/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../ themes/colors_shemes.dart';
import '../bloc/chat_list_bloc.dart';
import 'widgets/loading_tile.dart';
import 'widgets/reciever_tile.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChatListBloc chatListBloc = context.read<ChatListBloc>()
      ..add(ChatListLoadingEvent(
          sellerId: context.read<LoginBloc>().sellerModel!.email));
    return Container(
      color: white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: backgroundColor,
          
          body: BlocBuilder<ChatListBloc, ChatListState>(
            builder: (context, state) {
              if(state is ChatListLoadingState)
              {
                return const Center(child: CircularProgressIndicator(),);
              }
              else
              {
                return ListView(
                children: [
                  ...chatListBloc.users.map((e){
                    if(chatListBloc.loadedUsers.keys.contains(e))
                    {
                      return RecieverTile(userModel: chatListBloc.loadedUsers[e]!);

                    }
                    else
                    {
                      chatListBloc.add(ChatListTileLoadingEvent(userId: e));
                      return const LoadingTile();
                    }
                  },),

                  
                ],
              );
              }

              
            },
          ),
        ),
      ),
    );
  }
}
