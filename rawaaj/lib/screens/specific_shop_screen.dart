import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/grid_section.dart';
import 'package:rawaaj/widgets/header_bar.dart';

import '../widgets/bottom_nav_bar.dart';

class SpecificShopScreen extends StatelessWidget {
  final String name;

  const SpecificShopScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(title: "Shop", isFiltered: true),
      body: SingleChildScrollView(
          child: GridSection(title: name, itemsCount: 10, isSpecial: true,)
      ),
    );
  }
}
