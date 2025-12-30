import 'package:flutter/material.dart';
import 'package:news/Shared/routes/routes.dart';
import 'package:news/Shared/theme/app_theme.dart';
import 'package:news/features/home/view/screens/home_screen.dart';

void main() {
  runApp(NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeScreen,
      darkTheme: AppTheme.CustomeDarkTheme,
      theme: AppTheme.CustomeDarkTheme,
      themeMode: ThemeMode.light,
      routes: {AppRoutes.homeScreen: (_) => HomeScreen()},
    );
  }
}
