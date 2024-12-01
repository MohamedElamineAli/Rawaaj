import 'package:flutter/material.dart';
import 'package:rawaaj/screens/filter_screen.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const FilterScreen(),
      theme: appTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}