class ClothModel {
  String sellerID;
   String name;
   String description;
   String category;
   String fit;
   List<String> size;
   List<String> images;
   int totalPeices;
   int reservedCount;
   int soldCount;
   String brand;
   String material;
   int price;
   String tags;
   String metaTitle;
   String metaDescription;
   int maxReservable;

  ClothModel(
      {
        required this.sellerID,
        required this.name,
      required this.description,
      required this.category,
      required this.fit,
      required this.size,
      required this.images,
      required this.totalPeices,
      this.reservedCount = 0,
      this.soldCount = 0,
      required this.brand,
      required this.material,
      required this.price,
      required this.tags,
      required this.metaTitle,
      required this.metaDescription,
      required this.maxReservable});

  Map<String, dynamic> toMap() {
    return {
      'sellerID':sellerID,
      'name': name,
      'description': description,
      'category': category,
      'fit': fit,
      'size': size,
      'images': images,
      'totalPeices': totalPeices,
      'reservedCount': reservedCount,
      'soldCount': soldCount,
      'brand': brand,
      'material': material,
      'price': price,
      'tags': tags,
      'metaTitle': metaTitle,
      'metaDescription': metaDescription,
      'maxReservabel': maxReservable
    };
  }

  factory ClothModel.fromJson(Map<String, dynamic> map) {
    return ClothModel(
      sellerID: map['sellerID'],
        name: map['name'],
        brand: map['brand'],
        category: map['category'],
        description: map['description'],
        fit: map['fit'],
        images: map['images'],
        material: map['material'],
        maxReservable: map['maxReservable'],
        metaDescription: map['metaDescription'],
        metaTitle: map['metaTitle'],
        price: map['price'],
        size: map['size'],
        tags: map['tags'],
        totalPeices: map['totalPeices'],
        reservedCount: map['reservedCount'],
        soldCount: map['soldCount']);
  }
}
