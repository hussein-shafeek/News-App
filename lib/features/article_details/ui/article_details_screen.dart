import 'package:flutter/material.dart';
import 'package:news/core/models/news_response/news.dart';
import 'package:intl/intl.dart';
import 'package:news/core/theme/app_colors.dart';
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
            // العنوان
            Text(article.title ?? '', style: text.headlineLarge),
            const SizedBox(height: 8),

            // الوصف
            if (article.description != null)
              Text(article.description!, style: text.labelSmall),
            const SizedBox(height: 16),

            // المؤلف والتاريخ
            RichText(
              text: TextSpan(
                style: text.labelSmall, // ستايل الأساس (By:)
                children: [
                  const TextSpan(text: "By: "), // كلمة By بنفس اللون العادي
                  TextSpan(
                    text: article.author ?? "Unknown", // اسم الكاتب
                    style: text.labelSmall?.copyWith(
                      color: Colors.blue, // أزرق
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold, // تحته خط
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

            // صورة المقال
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
            SizedBox(height: 20),

            // المحتوى
            if (article.content != null)
              Text(cleanText(article.content), style: text.titleMedium),
          ],
        ),
      ),
    );
  }
}
