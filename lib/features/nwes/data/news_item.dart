import 'package:flutter/material.dart';
import 'package:news/core/models/news_response/news.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/features/article_details/ui/article_details_screen.dart';
import 'package:news/features/article_details/ui/news_preview_bottom_sheet.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  News news;
  NewsItem(this.news, {super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double height = MediaQuery.sizeOf(context).height;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => NewsPreviewBottomSheet(article: news),
        );
      },

      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.white),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                news.urlToImage ??
                    'https://imgs.search.brave.com/7TGFRapp-whdkRzNWwDnlvDDPfK-X1Oc0neKk49TlWg/rs:fit:500:0:1:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS12ZWN0b3Iv/aGFuZC1kcmF3bi1u/by1waG90by1zaWdu/XzIzLTIxNDkyNzgy/MTMuanBnP3NlbXQ9/YWlzX2h5YnJpZCZ3/PTc0MCZxPTgw',
                height: height * 0.25,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 20),
            Text(news.title!, style: text.titleMedium),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('By : ${news.source!.name}', style: text.labelSmall),
                Text(timeago.format(news.publishedAt!), style: text.labelSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
