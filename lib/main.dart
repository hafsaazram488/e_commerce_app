import 'package:flutter/material.dart';
import 'package:flutter_task/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'controllers/favorites_controller.dart';
import 'controllers/product_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(FavoritesController());
  Get.put(ProductController());
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
