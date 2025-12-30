import 'package:flutter/material.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:news/Shared/theme/app_colors.dart';
import 'package:news/features/article_details/ui/article_details_screen.dart';

class NewsPreviewBottomSheet extends StatelessWidget {
  final News article;
  const NewsPreviewBottomSheet({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double height = MediaQuery.sizeOf(context).height;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.urlToImage != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.urlToImage!,
                height: height * 0.3,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 8),

          if (article.content != null)
            Text(
              article.content!,
              style: text.titleSmall!.copyWith(color: AppColors.black),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),

          const SizedBox(height: 16),

          // View Full Article Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.black,
              foregroundColor: AppColors.white,
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ArticleDetailsScreen(article: article),
                ),
              );
            },
            child: Text("View Full Article", style: text.titleMedium),
          ),
        ],
      ),
    );
  }
}
