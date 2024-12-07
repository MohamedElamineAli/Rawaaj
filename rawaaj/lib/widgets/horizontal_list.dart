import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rawaaj/databases/database_consts.dart';
import 'package:rawaaj/widgets/product_card.dart';
import 'section_header.dart';

class HorizontalListSection extends StatelessWidget {
  final String title;
  final int itemsCount;
  final double padding;

  const HorizontalListSection({Key? key, required this.title, required this.itemsCount, this.padding = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int r = Random().nextInt(47) + 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          const SizedBox(height: 8),
          SizedBox(
            height: 235,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemsCount,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: 160, // Adjust to your desired card width
                  child: ProductCard(
                    id: (index + r)%47,
                    img: products[(index + r)%47].image,
                    title: products[(index + r)%47].description,
                    price: "${products[(index + r)%47].price} DZD",
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
