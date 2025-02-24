import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com/products';

  // Fetch All Products
  static Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('https://dummyjson.com/products'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final productsJson = jsonResponse['products'] as List;
      return productsJson
          .map((productJson) => Product.fromJson(productJson))
          .toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Fetch Single Product by ID
  static Future<Product> fetchProductById(int id) async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/$id'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return Product.fromJson(data);
      } else {
        throw Exception("Failed to load product");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }

  //category
  static Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map<String>((item) => item['name'].toString())
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<Product>> fetchProductsByCategory(String category) async {
    final response = await http.get(Uri.parse('$_baseUrl/category/$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['products'] is List) {
        final List productsJson = data['products'];
        return productsJson.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format.');
      }
    } else {
      throw Exception('Failed to load products for category $category');
    }
  }
}
