import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/favorites_controller.dart';
import '../controllers/product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  ProductDetailScreen({required this.productId});

  final ProductController productController = Get.put(ProductController());
  final FavoritesController favoritesController =
      Get.find<FavoritesController>();

  @override
  Widget build(BuildContext context) {
    productController.fetchProductDetails(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product Details",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return Center(child: CircularProgressIndicator()); // Show loader
        }

        var product = productController.product.value;
        if (product == null) return Center(child: Text("Product not found"));

        return SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Product Image
              Image.network(
                product.thumbnail,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Image.asset(
                  "assets/placeholder.png",
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      product.title,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Obx(() => IconButton(
                        icon: Icon(
                          favoritesController.isFavorite(product.id)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favoritesController.isFavorite(product.id)
                              ? Colors.red
                              : Colors.black,
                          size: 28,
                        ),
                        onPressed: () =>
                            favoritesController.toggleFavorite(product),
                      )),
                ],
              ),

              SizedBox(height: 10),

              //  Product Information
              detailText("Price", "\$${product.price}"),
              detailText("Category", product.category),
              detailText("Brand", product.brand),
              detailText("Stock", "${product.stock}"),
              detailText("Rating", "${product.rating} ★"),
              SizedBox(height: 10),

              // Product Description
              Text("Description:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 5),
              Text(product.description,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700])),
              SizedBox(height: 20),

              //  Product Gallery
              Text("Product Gallery:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              SizedBox(height: 10),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.images[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            "assets/placeholder.png",
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget detailText(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$label: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(child: Text(value, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
