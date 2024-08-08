import 'dart:developer';

import 'package:adast_seller/methods/encrypt.dart';
import 'package:adast_seller/models/cloth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addItem(ClothModel item) async {
    try {
      final sellersCollection = firestore.collection('items');
      await sellersCollection.add(item.toMap());

    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
  Future<void> updateItem(ClothModel item) async {
    try {
      final document = firestore.collection('items').doc(item.id);
      await document.set(item.toMap());
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
    Future<void> updateItemReserved(String id,String size) async {
    try {
      final document = firestore.collection('items').doc(id);
      await document.update({'reservedCount.$size':FieldValue.increment(-1),});
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
    Future<void> updateItemRevenue(String id,int revenueInc,String size,[bool check=true]) async {
    try {
      log(revenueInc.toString());
      final document = firestore.collection('items').doc(id);
      await document.update({'revenue':FieldValue.increment(revenueInc),'soldCount.$size':check?FieldValue.increment(1):1});
    } on FirebaseException catch (e) {
      log(e.toString());
    }
  }
  Future<ClothModel> getItem(String itemid)async
  {
    try {
      final snapshot=await firestore.collection('items').doc(itemid).get();
      return ClothModel.fromJson(snapshot.data()!,snapshot.id);
    }on FirebaseException catch (_) {
      rethrow;
    }
  }
  Future<void> deleteItem(String id) async
  {
    try {
      final document = firestore.collection('items').doc(id);
     await document.delete();
    } on FirebaseException catch (e) {
      log(e.toString());
    }

  }

  Future<List<ClothModel>> getAllItems(String email) async {
    try {
      final sellersCollection = firestore.collection('items');
      Query userQuery = sellersCollection.where('sellerID', isEqualTo: encryptData(email)).orderBy('date',descending: true);
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
          log(e.id.toString());
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List<ClothModel>> getSortedList(
      {required String sortby,
      required bool descending,
      required String email}) async {
    try {
      final sellersCollection =
          firestore.collection('items').orderBy(sortby, descending: descending);
      Query userQuery = sellersCollection.where('sellerID', isEqualTo: encryptData(email));
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException  catch (e) {
      log(e.toString());
      rethrow;
    }
  }


//todo function  not completed
  Future<List<ClothModel>> getFilteredSortedList(
      {required String? sortby,
      required bool descending,
      required Map<String, dynamic> filters,
      required String email}) async {
    try {
      late dynamic sellersCollection;
      if(sortby!=null)
      {
         sellersCollection =
          firestore.collection('items').orderBy(sortby, descending: descending);

      }
      else
      {
        sellersCollection = firestore.collection('items');
      }
      late Query userQuery;
       userQuery = sellersCollection.where('sellerID', isEqualTo: email);
      QuerySnapshot<Object?> itemsnap = await userQuery.get();
      return itemsnap.docs.map(
        (e) {
          return ClothModel.fromJson(e.data() as Map<String, dynamic>,e.id);
        },
      ).toList();
    }on FirebaseException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  
}
