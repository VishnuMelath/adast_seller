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
  Map<String, dynamic> size;
  List images;
  Map<String, dynamic> reservedCount;
  Map<String, dynamic> reservableCount;
  Map<String, dynamic> soldCount;
  String brand;
  String material;
  int price;
  String tags;
  String metaTitle;
  String metaDescription;
  int revenue;

  ClothModel({
    this.id,
    required this.reservableCount,
    required this.date,
    required this.sellerID,
    required this.name,
    required this.description,
    required this.category,
    required this.fit,
    required this.size,
    required this.images,
    this.reservedCount = const {},
    this.soldCount = const {},
    required this.brand,
    required this.material,
    required this.price,
    required this.tags,
    required this.metaTitle,
    required this.metaDescription,
    required this.revenue,
  });

  Map<String, dynamic> toMap() {
    return {
      'sellerID': sellerID,
      'name': name,
      'description': description,
      'category': category,
      'fit': fit,
      'size': size,
      'images': images,
      'reservedCount': reservedCount,'reservableCount':reservableCount,
      'soldCount': soldCount,
      'brand': brand,
      'material': material,
      'price': price,
      'tags': tags,
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
      'date': Timestamp.fromDate(date),
      'revenue': revenue
    };
  }

  factory ClothModel.fromJson(Map<String, dynamic> map, String id) {
    log(map['size'].toString());
    return ClothModel(
        id: id,
        sellerID: map['sellerID'],
        name: map['name'],
        brand: map['brand'],
        date: map['date'].toDate(),reservableCount: map['reservableCount'],
        category: map['category'],
        description: map['description'],
        fit: map['fit'],
        images: map['images'],
        material: map['material'],
        metaDescription: map['metaDescription'],
        metaTitle: map['metaTitle'],
        price: map['price'],
        size: map['size'],
        tags: map['tags'],
        reservedCount: map['reservedCount'],
        soldCount: map['soldCount'],
        revenue: map.containsKey('revenue') ? map['revenue'] : 0);
  }
}
