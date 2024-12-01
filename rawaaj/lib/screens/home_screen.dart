import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/header_bar.dart';
import '../widgets/sale_banner.dart';
import '../widgets/category_grid.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/flash_sale_slider.dart';
import '../widgets/grid_section.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            SaleBanner(),
            SizedBox(height: 16),
            CategoryGrid(),
            SizedBox(height: 16),
            HorizontalListSection(title: "Top Products", itemsCount: 6),
            SizedBox(height: 16),
            GridSection(title: "New Items", itemsCount: 4),
            SizedBox(height: 16),
            FlashSaleSlider(),
            SizedBox(height: 16),
            HorizontalListSection(title: "Recently Viewed", itemsCount: 6),
            SizedBox(height: 16),
            GridSection(title: "Just For You", itemsCount: 4),
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selected: 0,),
    );
  }
}
