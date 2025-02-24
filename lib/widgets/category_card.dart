import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';

class CategoryCard extends StatelessWidget {
  final String category;
  final String imageUrl;

  CategoryCard({required this.category, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Image.network(
            imageUrl,
            height: 120,
            width: 150,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(imageUrl,
                  height: 120, width: 150, fit: BoxFit.cover);
            },
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              category.capitalizeFirst ?? '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                backgroundColor: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
