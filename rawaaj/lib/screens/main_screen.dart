import 'package:flutter/material.dart';
import 'package:rawaaj/cubit/main_index_cubit.dart';
import 'package:rawaaj/screens/home_screen.dart';
import 'package:rawaaj/screens/map_screen.dart';
import 'package:rawaaj/screens/outfits_screen.dart';
import 'package:rawaaj/screens/profile_screen.dart';
import 'package:rawaaj/screens/wishlist_screen.dart';
import 'package:rawaaj/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final List<Widget> _screens = [
    HomeScreen(),
    WishlistScreen(),
    OutfitsScreen(),
    MapScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainIndexCubit, MainIndexState>(
      builder: (context, state) {
        return Scaffold(
            body: IndexedStack(
              index: state.index,
              children: _screens,
            ),
            bottomNavigationBar:
            BottomNavBar(selected: state.index));
      },
    );
  }

}
