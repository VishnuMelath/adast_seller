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
      return s + (e[0] as int);
    },
  );
  return totalCount - soldCount;
}
