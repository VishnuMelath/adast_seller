import 'package:adast_seller/models/cloth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class SellerModel {
   String name;
   String email;
   String? image;
   GeoPoint? latLng;
   List<ClothModel> items;

  SellerModel(
      {this.items = const[],
      this.image,
      required this.name,
      required this.email,
      this.latLng});

  Map<String, dynamic> toMap() {
    return {
      'emailaddress': email,
      'image': image,
      'name': name,
      'latlng':latLng,
      // 'items':items
    };
  }
}
