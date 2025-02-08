import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/clothes_list.dart';
import 'package:rawaaj/widgets/header_bar.dart';

import '../widgets/outfit_line.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: "Wishlist",
        isFiltered: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 12.0),
          child: Column(
            children: [
              OutfitLine(
                title: "Outfits",
              ),
              ClothesList()
            ],
          ),
        ),
      ),
    );
  }
}
