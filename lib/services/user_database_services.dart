import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/seller_model.dart';

class UserDatabaseServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addSeller(SellerModel user) async {
    try {
      final sellersCollection = firestore.collection('sellers');
      await sellersCollection.add(user.toMap());
    } on Exception catch (e) {
      log(e.toString());
    }
  }

  Future<SellerModel> getSellerData(String email) async {
    try {
      final sellersCollection = firestore.collection('sellers');
      Query userQuery =
          sellersCollection.where('emailaddress', isEqualTo: email);
      QuerySnapshot<Object?> sellersnap = await userQuery.get();
      Map<String, dynamic> userdata =
          sellersnap.docs.first.data() as Map<String, dynamic>;
      var user = SellerModel(
          name: userdata['name'],
          email: userdata['emailaddress'],
          image: userdata['image'],
          latLng: userdata['latlang'],);
      return user;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

 
}
