import 'package:flutter/material.dart';
import 'package:rawaaj/screens/home_screen.dart';
import 'package:rawaaj/screens/map_screen.dart';
import 'package:rawaaj/screens/outfits_screen.dart';
import 'package:rawaaj/screens/profile_screen.dart';
import 'package:rawaaj/screens/wishlist_screen.dart';
import 'package:rawaaj/widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // List of screens
  final List<Widget> _screens = [
    HomeScreen(),
    WishlistScreen(),
    OutfitsScreen(),
    MapScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(selected: _currentIndex, changeIndex: changeIndex)
    );
  }

  void changeIndex(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
