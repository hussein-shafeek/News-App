import 'package:flutter/material.dart';
import 'package:news/features/categories/view/widgets/data/models/category_model.dart';

class CategoriesItem extends StatelessWidget {
  final CategoryModel category;
  const CategoriesItem(this.category, {super.key});

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
