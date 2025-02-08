import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/grid_section.dart';
import 'package:rawaaj/widgets/header_bar.dart';

class SpecificShopScreen extends StatelessWidget {
  final String name;
  final int categoryNum;
  final String? searchValue;
  final int searchType;

  const SpecificShopScreen(
      {super.key,
      required this.name,
      this.categoryNum = 0,
      this.searchValue,
      this.searchType = 0});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const HeaderBar(title: "Shop", isFiltered: true),
      body: SingleChildScrollView(
          child: GridSection(
        title: name,
        itemsCount: 10,
        headerType: 1,
        categoryNum: categoryNum,
        searchValue: searchValue,
      )),
    );
  }
}
