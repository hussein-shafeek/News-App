import 'package:flutter/material.dart';
import 'package:news/features/home/logic/category_model.dart';

class CategoriesItem extends StatelessWidget {
  CategoryModel category;
  CategoriesItem(this.category);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Image.asset(
        'assets/images/${category.imageName}.png',
        height: height * 0.25,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
