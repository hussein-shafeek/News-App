// في ملف lib/features/home/ui/home_screen.dart

import 'package:flutter/material.dart';
import 'package:news/core/models/news_response/news.dart';
import 'package:news/core/services/api/api_service.dart';
import 'package:news/features/home/logic/category_model.dart';
import 'package:news/features/home/ui/categories_view.dart';
import 'package:news/features/home/ui/home_drawer.dart';
import 'package:news/features/nwes/data/news_item.dart';
import 'package:news/features/nwes/ui/news_view.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/home/data/categories_item.dart';
import 'package:news/features/search/ui/search_categories_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoryModel? selectedCategory;
  bool isSearching = false;
  bool isLoading = false;
  final TextEditingController _searchController = TextEditingController();
  List<CategoryModel> categorySuggestions = [];
  List<News>? searchResults;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: isSearching
            ? null
            : Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).openAppDrawerTooltip,
                  );
                },
              ),
        title: isSearching
            ? TextField(
                controller: _searchController,
                autofocus: true,
                style: const TextStyle(color: AppColors.white),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.black,
                  hintText: 'Search',
                  hintStyle: const TextStyle(color: AppColors.gray),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search, color: AppColors.white),
                    onPressed: () {
                      if (selectedCategory == null) {
                        _updateCategorySuggestions(_searchController.text);
                      } else {
                        _performNewsSearch(_searchController.text);
                      }
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(color: AppColors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: AppColors.white,
                      width: 1.2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close, color: AppColors.white),
                    onPressed: () {
                      _searchController.clear();
                      setState(() {
                        isSearching = false;
                        categorySuggestions.clear();
                        searchResults = null;
                      });
                    },
                  ),
                ),
                onSubmitted: (query) {
                  if (selectedCategory == null) {
                    _updateCategorySuggestions(query);
                  } else {
                    _performNewsSearch(query);
                  }
                },
                onChanged: (query) {
                  if (selectedCategory == null) {
                    _updateCategorySuggestions(query);
                  }
                },
              )
            : Text(selectedCategory == null ? 'Home' : selectedCategory!.name),
        actions: [
          if (!isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  isSearching = true;
                });
              },
            ),
        ],
      ),
      drawer: HomeDrawer(onGoToHome: resetSelectedCategory),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (isSearching &&
        selectedCategory == null &&
        categorySuggestions.isNotEmpty) {
      return SearchCategoriesView(
        onCategorySelected: onCategorySelected,
        categories: categorySuggestions,
      );
    } else if (isSearching &&
        searchResults != null &&
        searchResults!.isNotEmpty) {
      return ListView.builder(
        itemCount: searchResults!.length,
        itemBuilder: (context, index) {
          return NewsItem(searchResults![index]);
        },
      );
    } else if (isSearching &&
        _searchController.text.isNotEmpty &&
        (searchResults == null || searchResults!.isEmpty)) {
      return const Center(child: Text('No results found.'));
    } else {
      return selectedCategory == null
          ? CategoriesView(onCategorySelected: onCategorySelected)
          : NewsView(categoryId: selectedCategory!.id);
    }
  }

  void _performNewsSearch(String query) async {
    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
      searchResults = null;
      categorySuggestions.clear();
    });

    try {
      var response;
      if (selectedCategory != null) {
        response = await ApiService.searchNewsByCategory(
          query,
          selectedCategory!.id,
        );
      } else {
        response = await ApiService.searchNews(query);
      }

      setState(() {
        searchResults = response.newsList;
        isLoading = false;
      });
    } catch (e) {
      print('Error during news search: $e');
      setState(() {
        isLoading = false;
        searchResults = null;
      });
    }
  }

  void _updateCategorySuggestions(String query) {
    if (query.isEmpty) {
      setState(() {
        categorySuggestions.clear();
      });
    } else {
      final filteredList = CategoryModel.categories.where((category) {
        return category.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
      setState(() {
        categorySuggestions = filteredList;
      });
    }
  }

  void onCategorySelected(CategoryModel category) {
    setState(() {
      selectedCategory = category;
      isSearching = false;
      _searchController.clear();
    });
  }

  void resetSelectedCategory() {
    if (selectedCategory == null) return;
    selectedCategory = null;
    setState(() {});
  }
}
