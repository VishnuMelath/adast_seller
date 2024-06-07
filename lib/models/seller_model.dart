import 'package:adast_seller/models/cloth_model.dart';
import 'package:latlong2/latlong.dart';

class SellerModel {
  final String name;
  final String email;
  final String? image;
  final LatLng? latLng;
   List<ClothModel> items;

  SellerModel(
      {this.items = const[],
      this.image,
      required this.name,
      required this.email,
      this.latLng});

  Map<String, String?> toMap() {
    return {
      'emailaddress': email,
      'image': image,
      'name': name,
    };
  }
}
