import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var product = Rx<Product?>(null);

  void fetchProductDetails(int productId) async {
    isLoading.value = true;
    product.value = await ApiService.fetchProductById(productId);
    isLoading.value = false;
  }
}
