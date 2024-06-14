
class ClothModel {
  final String name;
  final String description;
  final String category;
  final String fit;
  final List<String> size;
  final List<String> images;
  final int totalPeices;
  final int reservedCount;
  final int soldCount;
  final String brand;
  final String material;
  final int price;
  final String tags;
  final String metaTitle;
  final String metaDescription;
  final int maxReservable;

  ClothModel(
      {required this.name,
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

      Map<String , dynamic> toMap()
      {
        return {
          'name':name,
          'description':description,
          'category':category,
          'fit':fit,
        };
      }
}
