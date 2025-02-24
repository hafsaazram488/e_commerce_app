import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favorites_controller.dart';

class FavoritesScreen extends StatelessWidget {
  final FavoritesController favoritesController =
      Get.find<FavoritesController>();
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourites",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search in favorites...",
                prefixIcon: Icon(Icons.search),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (value) {
                searchQuery.value = value.toLowerCase();
              },
            ),
            SizedBox(height: 10),
            Obx(() {
              var filteredFavorites = favoritesController.favoriteProducts
                  .where((product) =>
                      product.title.toLowerCase().contains(searchQuery.value))
                  .toList();
              return Text(
                "${filteredFavorites.length} results found",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              );
            }),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                var filteredFavorites = favoritesController.favoriteProducts
                    .where((product) =>
                        product.title.toLowerCase().contains(searchQuery.value))
                    .toList();

                if (filteredFavorites.isEmpty) {
                  return Center(child: Text("No favorites found!"));
                }

                return ListView.builder(
                  itemCount: filteredFavorites.length,
                  itemBuilder: (context, index) {
                    var product = filteredFavorites[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: NetworkImage(product.thumbnail),
                          ),
                          title: Text(
                            product.title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("\$${product.price}",
                                  style: TextStyle(fontSize: 14)),
                              Row(
                                children: [
                                  Text(
                                    product.rating.toString(),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(width: 4),
                                  Icon(Icons.star,
                                      color: Colors.amber, size: 14),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.favorite, color: Colors.red),
                            onPressed: () =>
                                favoritesController.toggleFavorite(product),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
