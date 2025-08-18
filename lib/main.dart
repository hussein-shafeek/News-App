import 'package:flutter/material.dart';
import 'package:news/core/routes/routes.dart';
import 'package:news/features/home/ui/home_screen.dart';

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
      routes: {AppRoutes.homeScreen: (_) => HomeScreen()},
    );
  }
}
