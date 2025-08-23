import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsItem extends StatelessWidget {
  const NewsItem({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    DateTime dateTime = DateTime.now().subtract(Duration(minutes: 120));

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.white),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'assets/images/nwes.png',
              height: height * 0.25,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "40-year-old man falls 200 feet to his death while canyoneering at national park",
            style: text.titleMedium,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('By : Jon Haworth', style: text.labelSmall),
              Text(timeago.format(dateTime), style: text.labelSmall),
            ],
          ),
        ],
      ),
    );
  }
}
