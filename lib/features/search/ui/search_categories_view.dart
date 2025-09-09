// في ملف lib/features/home/ui/search_categories_view.dart

import 'package:flutter/material.dart';
import 'package:news/features/home/logic/category_model.dart';
import 'package:news/features/home/data/categories_item.dart';

class SearchCategoriesView extends StatelessWidget {
  final Function(CategoryModel) onCategorySelected;
  final List<CategoryModel> categories;

  const SearchCategoriesView({
    super.key,
    required this.onCategorySelected,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // هنا مش بنحط جملة Good Morning
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.only(top: 16),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onCategorySelected(categories[index]);
                },
                child: CategoriesItem(categories[index]),
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 16),
              itemCount: categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
