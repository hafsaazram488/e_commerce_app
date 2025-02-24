import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_list_controller.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  final ProductListController controller = Get.put(ProductListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search products...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.filteredProducts.isEmpty) {
                return Center(child: Text("No products found"));
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                itemCount: controller.filteredProducts.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                      product: controller.filteredProducts[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
