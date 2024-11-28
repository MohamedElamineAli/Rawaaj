import 'package:flutter/material.dart';
import '../widgets/sale_banner.dart';
import '../widgets/category_grid.dart';
import '../widgets/horizontal_list.dart';
import '../widgets/flash_sale_slider.dart';
import '../widgets/section_header.dart';
import '../widgets/grid_section.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text('Shop', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
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
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
