import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/seller_model.dart';

class SellerDatabaseServices{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addSeller(SellerModel user) async {
    try {
      final sellersCollection = firestore.collection('sellers');
      await sellersCollection.add(user.toMap());
    } on Exception catch (e) {
      log(e.toString());
    }
  }
    Future<SellerModel> getSeller(String email) async
  {
    final query=firestore.collection('sellers').where('emailaddress',isEqualTo: email);
    final list=await query.get();

    return SellerModel.fromJson(list.docs.first);
  }

  Future<SellerModel> getSellerData(String email) async {
    try {
      final sellersCollection = firestore.collection('sellers');
      Query userQuery =
          sellersCollection.where('emailaddress', isEqualTo: email);
      QuerySnapshot<Object?> sellersnap = await userQuery.get();
      Map<String, dynamic> userdata =
          sellersnap.docs.first.data() as Map<String, dynamic>;
      var seller = SellerModel(
          name: userdata['name'],
          email: userdata['emailaddress'],
          image: userdata['image'],
          latLng: userdata['latlang'], place: userdata['place'],);
      return seller;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
Future updateSellerWallet(int amount,String sellerId)
  async 
  {
    final sellersCollection = firestore.collection('sellers');
      Query userQuery =
          sellersCollection.where('emailaddress', isEqualTo: sellerId);
      QuerySnapshot<Object?> sellersnap = await userQuery.get();
    await firestore.collection('sellers').doc(sellersnap.docs.first.id).update({'wallet':FieldValue.increment(amount)});
  }
 
}
