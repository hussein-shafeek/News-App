import 'package:flutter/material.dart';
import 'package:news/features/categories/view/widgets/data/models/category_model.dart';
import 'package:news/features/categories/view/widgets/categories_item.dart';

class CategoriesView extends StatelessWidget {
  final void Function(CategoryModel) onCategorySelected;
  const CategoriesView({super.key, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    // double width = MediaQuery.sizeOf(context).width; // Unused
    // double height = MediaQuery.sizeOf(context).height; // Unused
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning \nHere is Some News For You',
            style: text.titleLarge,
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onCategorySelected(CategoryModel.categories[index]);
                },
                child: CategoriesItem(CategoryModel.categories[index]),
              ),
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemCount: CategoryModel.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
