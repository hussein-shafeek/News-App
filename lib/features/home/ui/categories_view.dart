import 'package:flutter/material.dart';
import 'package:news/features/home/logic/category_model.dart';
import 'package:news/features/home/data/categories_item.dart';

class CategoriesView extends StatelessWidget {
  void Function(CategoryModel) onCategorySelected;
  CategoriesView({required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
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
              padding: EdgeInsets.only(top: 16),
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  onCategorySelected(CategoryModel.categories[index]);
                },
                child: CategoriesItem(CategoryModel.categories[index]),
              ),
              separatorBuilder: (_, _) => SizedBox(height: 16),
              itemCount: CategoryModel.categories.length,
            ),
          ),
        ],
      ),
    );
  }
}
