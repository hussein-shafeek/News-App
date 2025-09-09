import 'package:flutter/material.dart';
import 'package:news/core/models/news_response/news.dart';
import 'package:news/core/services/api/api_service.dart';
import 'package:news/features/home/logic/category_model.dart';
import 'package:news/features/nwes/data/news_item.dart';
import 'package:news/core/models/sources_response/source.dart';

class NewsSearchDelegate extends SearchDelegate<CategoryModel?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      // لا تعرض أي شيء إذا كان الاستعلام فارغًا
      return const SizedBox.shrink();
    }

    return FutureBuilder(
      future: ApiService.searchNews(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("حدث خطأ ما."));
        } else if (snapshot.data?.newsList?.isEmpty ?? true) {
          return const Center(child: Text("لا توجد أخبار مطابقة."));
        } else {
          final newsList = snapshot.data!.newsList!;
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              return NewsItem(newsList[index]);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      // لا تعرض أي شيء إذا كان الاستعلام فارغًا
      return const SizedBox.shrink();
    }

    final categorySuggestions = CategoryModel.categories.where((category) {
      return category.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: categorySuggestions.length,
      itemBuilder: (context, index) {
        final category = categorySuggestions[index];
        return ListTile(
          title: Text(category.name),
          onTap: () {
            close(context, category);
          },
        );
      },
    );
  }
}
