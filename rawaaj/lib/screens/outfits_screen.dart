import 'package:flutter/material.dart';
import 'package:rawaaj/databases/database_consts.dart';
import 'package:rawaaj/screens/add_outfit_screen.dart';
import 'package:rawaaj/screens/add_product_screen.dart';
import 'package:rawaaj/widgets/add_floating_btn.dart';
import 'package:rawaaj/widgets/bottom_nav_bar.dart';
import 'package:rawaaj/widgets/header_bar.dart';
import 'package:rawaaj/widgets/outfit_card.dart';

class OutfitsScreen extends StatelessWidget {
  const OutfitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AddFloatingBtn(isProduct: false),
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: "Outfits",
        isFiltered: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 0,
            childAspectRatio: 0.6,
          ),
          itemCount: 8,
          itemBuilder: (context, index) {
            return OutfitCard(
              id: index,
              img: outfits[index].outfitImage,
              price: (index + 1) * 10000,
              isLiked: outfits[index].isLiked,
            );
          },
        ),
      ),
    );
  }
}
