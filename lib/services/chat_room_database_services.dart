import 'package:adast_seller/methods/encrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/chat_room_model.dart';

class ChatRoomDatabaseServices {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future createChatRoomIfDoesNotExists(String userId, String sellerId) async {}

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllChatRooms(
      String sellerId) async* {
    try {
      final snapshots = firebaseFirestore
          .collection('chatrooms')
          .where('sellerId', isEqualTo: encryptData(sellerId))
          .snapshots();

      yield* snapshots;
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future updateChatRoom(ChatRoomModel chatroom) async {
    try {
      final snapshot =
          firebaseFirestore.collection('chatrooms').doc(chatroom.roomId);
      if (!await snapshot.get().then(
            (value) => value.exists,
          )) {
        await snapshot.set(chatroom.toJson());
      }

      await snapshot.update({
        'userUnreadCount': FieldValue.increment(1),
        'lastMessage': encryptData(chatroom.lastMessage),
        'time': chatroom.time
      });
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future updateChatRoomUnseenCount(ChatRoomModel chatroom) async {
    try {
      await firebaseFirestore
          .collection('chatrooms')
          .doc(chatroom.roomId)
          .update({'sellerUnreadCount': 0});
    } on FirebaseException catch (_) {
      rethrow;
    }
  }

  Future checkWheatherChatroomExists(String sellerId, String userId) async {
    try {
      var count = await firebaseFirestore
          .collection('chatrooms')
          .where('userId', isEqualTo: encryptData(userId))
          .get();
      if (count.docs.isEmpty) {
        return ChatRoomModel(
            roomId: '',
            userId: userId,
            sellerId: sellerId,
            sellerUnreadCount: 0,
            userUnreadCount: 0,
            lastMessage: '',
            time: DateTime.now());
      } else {
        return ChatRoomModel.fromSnapShot(count.docs.first);
      }
    } on FirebaseException catch (_) {
      rethrow;
    }
  }
}
