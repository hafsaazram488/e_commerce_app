import 'package:get/get.dart';
import '../services/api_service.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var categoryList = <String>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var categories = await ApiService.fetchCategories();
      print("Fetched Categories: $categories");
      categoryList.assignAll(categories);
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading(false);
    }
  }
}
