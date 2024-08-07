
import 'package:adast_seller/methods/encrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_room_model.dart';
import '../models/message_model.dart';
import 'chat_room_database_services.dart';

class MessagesDatabaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  ChatRoomDatabaseServices chatRoomDatabaseServices =
      ChatRoomDatabaseServices();
  Future sendOrUpdateMessage(MessageModel message,ChatRoomModel chatroom) async {
    try {
     chatroom.lastMessage=message.message;
     chatroom.userUnreadCount++;
     chatroom.time=DateTime.now();
      message.roomId=chatroom.roomId;
      message.messageId = generateMessageId(message);
      await chatRoomDatabaseServices.updateChatRoom(chatroom);
      await firebaseFirestore
          .collection('messages')
          .doc(message.messageId)
          .set(message.toJson());
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String chatRoomId) async* {
    final snapshot = firebaseFirestore
        .collection('messages')
        .where('roomId', isEqualTo: encryptData(chatRoomId));
    yield* snapshot.snapshots();
  }

  String generateChatRoomId(ChatRoomModel chatRoom) {
    List temp = [chatRoom.sellerId, chatRoom.userId];
    temp.sort();
    return temp.join('_');
  }

  String generateMessageId(MessageModel message) {
    List temp = [
      message.senderId,
      message.recieverId,
      message.timestamp.seconds.toString()
    ];
    temp.sort();
    return temp.join('_');
  }
}
