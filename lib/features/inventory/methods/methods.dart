import 'package:adast_seller/models/cloth_model.dart';

int totalItemsLeft(ClothModel clothModel) {
  var soldCount = clothModel.soldCount.isEmpty
      ? 0
      : clothModel.soldCount.values.fold<int>(
          0,
          (s, e) {
            return s + e as int;
          },
        );
  var totalCount = clothModel.size.values.fold<int>(
    0,
    (s, e) {
      return s + int.parse(e.toString());
    },
  );
  return totalCount - soldCount;
}

int itemsLeftForSelectedSize(ClothModel item, String size)
{
  return int.parse(item.size[size].toString())-(item.soldCount.containsKey(size)?int.parse(item.soldCount[size].toString()):0);
}