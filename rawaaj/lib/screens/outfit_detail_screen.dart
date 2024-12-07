import 'package:flutter/material.dart';
import 'package:rawaaj/databases/database_consts.dart';
import 'package:rawaaj/widgets/horizontal_list.dart';
import 'package:rawaaj/widgets/outfit_line.dart';

import '../widgets/outfit_details.dart';

class OutfitDetailScreen extends StatelessWidget {
  final int id;

  const OutfitDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
              child: Column(
                children: [
                  OutfitDetails(
                      img: outfits[id].outfitImage,
                      price: (id+1)*1000,
                      isLiked: false,
                      details:
                        outfits[id].description + "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                      likesNum: 5),
                  HorizontalListSection(
                    title: "Outfit Components",
                    itemsCount: 4,
                    padding: 0,
                  ),
                  OutfitLine(title: "Related Outfits")
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              top: 20,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded)))
        ],
      ),
    );
  }
}
