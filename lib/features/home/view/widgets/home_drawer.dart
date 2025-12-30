import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news/Shared/theme/app_colors.dart';

class HomeDrawer extends StatelessWidget {
  VoidCallback onGoToHome;
  HomeDrawer({required this.onGoToHome});

  @override
  Widget build(BuildContext context) {
    TextTheme text = Theme.of(context).textTheme;
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    return Container(
      width: width * 0.7,
      color: AppColors.black,
      child: Column(
        children: [
          Container(
            color: AppColors.white,
            width: double.infinity,
            height: height * 0.2,
            alignment: Alignment.center,
            child: Text(
              'News App',
              style: text.titleLarge!.copyWith(
                color: AppColors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                onGoToHome();
                Navigator.of(context).pop();
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/home.svg'),
                  SizedBox(width: 8),
                  Text('Go To Home', style: text.labelLarge),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
