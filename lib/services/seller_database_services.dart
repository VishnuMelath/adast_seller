import 'dart:developer';
import 'package:adast_seller/methods/encrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/seller_model.dart';

class SellerDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addSeller(SellerModel user) async {
    try {
      final sellersCollection = firestore.collection('sellers');
      await sellersCollection.add(user.toMap());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<SellerModel> getSeller(String email) async {
    final query =
        firestore.collection('sellers').where('emailaddress', isEqualTo: encryptData(email));
    final list = await query.get();

    return SellerModel.fromJson(list.docs.first);
  }

  Future<SellerModel> getSellerData(String email) async {
    try {
      log('h ' +email);
      final sellersCollection = firestore.collection('sellers');
      Query userQuery =
          sellersCollection.where('emailaddress', isEqualTo: encryptData(email));
      QuerySnapshot<Object?> sellersnap = await userQuery.get();
      
      var userdata =
          sellersnap.docs.first;
      var seller = SellerModel.fromJson(userdata);
      return seller;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future updateSellerWallet(int amount, String sellerId) async {
    final sellersCollection = firestore.collection('sellers');
    Query userQuery =
        sellersCollection.where('emailaddress', isEqualTo: encryptData(sellerId));
    QuerySnapshot<Object?> sellersnap = await userQuery.get();
    await firestore.collection('sellers').doc(sellersnap.docs.first.id).update({
      'wallet': FieldValue.increment(amount),
     
    });
  }Future updateSeller(SellerModel sellerData) async {
    final seller = firestore.collection('sellers').doc(sellerData.id);
   seller.update({
    'image':encryptData(sellerData.image!),
    'name':encryptData(sellerData.name),
    'place':encryptData(sellerData.place)
   });
  }
}
