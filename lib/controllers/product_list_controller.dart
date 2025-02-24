import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductListController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await ApiService.fetchProducts();
      //API response
      for (var product in products) {
        print("Product: ${product.title}, Image: ${product.thumbnail}");
      }
      productList.assignAll(products);
    } catch (e) {
      print("Error fetching product list: $e");
    } finally {
      isLoading(false);
    }
  }

  List<Product> get filteredProducts {
    if (searchQuery.isEmpty) return productList;
    return productList.where((p) =>
        p.title.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
  }
}
