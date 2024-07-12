import 'dart:async';

import 'package:adast_seller/models/user_model.dart';
import 'package:adast_seller/services/user_database_services.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../models/chat_room_model.dart';
import '../../../../services/chat_room_database_services.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  List<ChatRoomModel> chatrooms=[];
  Set<String> users = {};
  Map<String ,UserModel> loadedUsers={};
  ChatListBloc() : super(ChatListInitial()) {
    on<ChatListLoadingEvent>(chatListLoadingEvent);
    on<ChatListTileLoadingEvent>(chatListTileLoadingEvent);
  }

  FutureOr<void> chatListLoadingEvent(
      ChatListLoadingEvent event, Emitter<ChatListState> emit) async {
    emit(ChatListLoadingState());
   
   await emit.forEach(
     ChatRoomDatabaseServices().getAllChatRooms(event.sellerId),
      onData: (data) {
        chatrooms.clear();
        for (var element in data.docs) {
          chatrooms.add(ChatRoomModel.fromSnapShot(element));
        }
        chatrooms.sort((a, b) => b.time.compareTo(a.time),);
        users.clear();
        users.addAll(chatrooms.map((e) => e.userId,));
        return ChatListLoadedState();
      },
    );
  }

  FutureOr<void> chatListTileLoadingEvent(ChatListTileLoadingEvent event, Emitter<ChatListState> emit) async{
    var user=await UserDatabaseServices().getUserData(event.userId);
    loadedUsers[event.userId]=user;
    emit(ChatListTileLoadedState());
  }
}
