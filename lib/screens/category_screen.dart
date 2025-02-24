import 'package:flutter/material.dart';
import 'package:flutter_task/screens/product_by_category.dart';
import 'package:get/get.dart';

import '../controllers/category_controller.dart';
import '../widgets/category_card.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryController controller = Get.put(CategoryController());
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final Map<String, String> categoryImages = {
    "beauty": "assets/beauty.jpg",
    "furniture": "assets/furniture.jpg",
    "groceries": "assets/groceries.jpg",
    "home decoration": "assets/home decoration.jpg",
    "smartphones": "assets/smartphones.jpg",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Categories",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search categories...",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onChanged: (value) {
                searchQuery.value = value;
              },
            ),
          ),

          // Category Grid
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }

              if (controller.categoryList.isEmpty) {
                return Center(child: Text("No categories found"));
              }

              // Filter categories based on the search query
              final filteredCategories = controller.categoryList
                  .where((category) => category
                      .toLowerCase()
                      .contains(searchQuery.value.toLowerCase()))
                  .toList();

              if (filteredCategories.isEmpty) {
                return Center(child: Text("No matching categories found"));
              }

              return GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  String category = filteredCategories[index];

                  // Get the asset image path for the category
                  final imagePath = categoryImages[category.toLowerCase()] ??
                      "assets/placeholder.png"; // Default placeholder

                  return GestureDetector(
                    onTap: () {
                      Get.to(() => ProductListScreen(category: category));
                    },
                    child: CategoryCard(
                      category: category,
                      imageUrl: imagePath,
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
