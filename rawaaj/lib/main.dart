import 'package:flutter/material.dart';
import 'package:rawaaj/screens/login_screen.dart';
import 'package:rawaaj/screens/main_screen.dart';
import 'package:rawaaj/screens/password_screen.dart';
import 'package:rawaaj/screens/settings_screen.dart';
import 'package:rawaaj/screens/welcome_screen.dart';
// import 'screens/welcome_screen.dart';
import 'screens/create_account_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      theme: appTheme,
      debugShowCheckedModeBanner: false,
    );
  }
}