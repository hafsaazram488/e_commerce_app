import 'package:get/get.dart';

import '../models/product_model.dart';

class FavoritesController extends GetxController {
  var favoriteProducts = <Product>[].obs;

  void toggleFavorite(Product product) {
    if (favoriteProducts.any((p) => p.id == product.id)) {
      favoriteProducts.removeWhere((p) => p.id == product.id);
    } else {
      favoriteProducts.add(product);
    }
  }

  bool isFavorite(int productId) {
    return favoriteProducts.any((p) => p.id == productId);
  }
}
