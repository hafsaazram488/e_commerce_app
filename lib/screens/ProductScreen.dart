import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductScreen extends StatelessWidget {
  final String categorySlug;

  ProductScreen({required this.categorySlug});

  final RxList<Product> productList = <Product>[].obs;
  final RxBool isLoading = true.obs;

  @override
  Widget build(BuildContext context) {
    fetchProducts();

    return Scaffold(
      appBar: AppBar(title: Text("Products in $categorySlug")),
      body: Obx(() {
        if (isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (productList.isEmpty) {
          return Center(child: Text("No products found"));
        }

        return GridView.builder(
          padding: EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemCount: productList.length,
          itemBuilder: (context, index) {
            var product = productList[index];
            return Card(
              child: Column(
                children: [
                  Image.network(product.thumbnail, height: 100, fit: BoxFit.cover),
                  Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void fetchProducts() async {
    try {
      var products = await ApiService.fetchProductsByCategory(categorySlug);
      productList.assignAll(products);
    } catch (e) {
      print("Error fetching products: $e");
    } finally {
      isLoading(false);
    }
  }
}
