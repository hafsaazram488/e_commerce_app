import 'package:flutter/material.dart';
import 'package:flutter_task/screens/account_screen.dart';
import 'package:flutter_task/screens/favorites_screen.dart';
import 'package:get/get.dart';

import 'category_screen.dart';
import 'product_screen.dart';

class MainScreen extends StatelessWidget {
  final RxInt selectedIndex = 0.obs;

  final List<Widget> pages = [
    HomeScreen(),
    CategoryScreen(),
    FavoritesScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
            index: selectedIndex.value,
            children: pages,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            currentIndex: selectedIndex.value,
            onTap: (index) => selectedIndex.value = index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.store), label: "Products"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view), label: "Categories"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border), label: "Favourites"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Mitt konto"),
            ],
          )),
    );
  }
}
