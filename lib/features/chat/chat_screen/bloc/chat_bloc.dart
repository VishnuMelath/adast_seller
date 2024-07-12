
import 'dart:async';
import 'dart:developer';

import 'package:adast_seller/models/user_model.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../../../models/chat_room_model.dart';
import '../../../../services/chat_room_database_services.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UserModel userModel;
  final ChatRoomModel chatRoomModel;
  ChatBloc({required this.userModel,required this.chatRoomModel}) : super(ChatInitial()) {
   on<ChatSetSellerUnseenCountZero>(chatSetSellerUnseenCountZero);
  }

  FutureOr<void> chatSetSellerUnseenCountZero(ChatSetSellerUnseenCountZero event, Emitter<ChatState> emit) async{
    try {
      chatRoomModel.sellerUnreadCount=0;
       ChatRoomDatabaseServices().updateChatRoomUnseenCount(chatRoomModel);
    } on FirebaseException catch (e) {
      log(e.code);
      
    }
  }
}
