import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class ClothModel {
  String? id;
  String sellerID;
   String name;
   String description;
   String category;
   String fit;
   DateTime date;
   Map<String,dynamic> size;
   List images;
    Map<String,dynamic> reservedCount;
   Map<String, dynamic> soldCount ;
   String brand;
   String material;
   int price;
   String tags;
   String metaTitle;
   String metaDescription;
  

  ClothModel(
      {
      this.id,
      required this.date,
        required this.sellerID,
        required this.name,
      required this.description,
      required this.category,
      required this.fit,
      required this.size,
      required this.images,
      this.reservedCount =const{},
      this.soldCount = const{},
      required this.brand,
      required this.material,
      required this.price,
      required this.tags,
      required this.metaTitle,
      required this.metaDescription,});

  Map<String, dynamic> toMap() {
    return {
      'sellerID':sellerID,
      'name': name,
      'description': description,
      'category': category,
      'fit': fit,
      'size': size,
      'images': images,
      'reservedCount': reservedCount,
      'soldCount': soldCount,
      'brand': brand,
      'material': material,
      'price': price,
      'tags': tags,
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
      'date':Timestamp.fromDate(date)
    };
  }

  factory ClothModel.fromJson(Map<String, dynamic> map,String id) {
    log(map['size'].toString());
    return ClothModel(
      id:id,
      sellerID: map['sellerID'],
        name: map['name'],
        brand: map['brand'],
        date: map['date'].toDate(),
        category: map['category'],
        description: map['description'],
        fit: map['fit'],
        images: map['images'] ,
        material: map['material'],
        metaDescription: map['metaDescription'],
        metaTitle: map['metaTitle'],
        price: map['price'],
        size: map['size'],
        tags: map['tags'],
        reservedCount: map['reservedCount'],
        soldCount: map['soldCount']);
  }
}
