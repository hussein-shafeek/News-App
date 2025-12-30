import 'package:flutter/material.dart';
import 'package:news/features/news/data/models/news_response/news.dart';
import 'package:intl/intl.dart';
import 'package:news/Shared/theme/app_colors.dart';
import 'package:news/features/article_details/logic/clean_text.dart';

class ArticleDetailsScreen extends StatelessWidget {
  final News article;
  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(title: Text(article.source?.name ?? "Article Details")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Text(article.title ?? '', style: text.headlineLarge),
            const SizedBox(height: 8),

            // Description
            if (article.description != null)
              Text(article.description!, style: text.labelSmall),
            const SizedBox(height: 16),

            // Author and Date
            RichText(
              text: TextSpan(
                style: text.labelSmall,
                children: [
                  const TextSpan(text: "By: "),
                  TextSpan(
                    text: article.author ?? "Unknown",
                    style: text.labelSmall?.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              article.publishedAt != null
                  ? DateFormat(
                      "MMMM d, yyyy hh:mm a",
                    ).format(article.publishedAt!)
                  : '',
              style: text.labelSmall,
            ),
            const SizedBox(height: 16),

            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                article.urlToImage ??
                    "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png",
                height: height * 0.3,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Content
            if (article.content != null)
              Text(cleanText(article.content), style: text.titleMedium),
          ],
        ),
      ),
    );
  }
}
