import 'package:flutter/material.dart';
import 'package:news/features/home/logic/category_model.dart';
import 'package:news/features/home/ui/categories_view.dart';
import 'package:news/features/home/ui/home_drawer.dart';
import 'package:news/features/nwes/ui/news_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            selectedCategory == null ? 'Home' : selectedCategory!.name,
          ),
        ),
      ),
      drawer: HomeDrawer(onGoToHome: resetSelectedCategory),
      body: selectedCategory == null
          ? CategoriesView(onCategorySelected: onCategorySelected)
          : NewsView(categoryId: selectedCategory!.id),
    );
  }

  void onCategorySelected(CategoryModel category) {
    selectedCategory = category;
    setState(() {});
  }

  void resetSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }
}
