import 'dart:developer';

import 'package:adast_seller/models/cloth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addItem(ClothModel item) async {
    try {
      final sellersCollection = firestore.collection('items');
      await sellersCollection.add(item.toMap());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<List<ClothModel>> getAllItems(String email) async {
    try {
      final sellersCollection = firestore.collection('items');
      Query userQuery =
          sellersCollection.where('emailaddress', isEqualTo: email);
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      List<Map<String, dynamic>> items =
          itemsnap.docs as List<Map<String, dynamic>>;
      return items.map(
        (item) {
          return ClothModel.fromJson(item);
        },
      ).toList();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
