import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/product_card.dart';
import '../databases/database_consts.dart';
import 'section_header.dart';

class GridSection extends StatelessWidget {
  final String title;
  final int itemsCount;
  final double gridPadding;
  final bool isSpecial;

  const GridSection(
      {Key? key,
      required this.title,
      required this.itemsCount,
      this.gridPadding = 16,
      this.isSpecial = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int r = Random().nextInt(47) + 1;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gridPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isSpecial
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.close))
                    ],
                  ),
                )
              : SectionHeader(title: title),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: itemsCount,
            itemBuilder: (context, index) {
              return ProductCard(
                id: (index + r)%47,
                img: products[(index + r)%47].image,
                title: products[(index + r)%47].description,
                price: "${products[(index + r)%47].price} DZD",
              );
            },
          ),
        ],
      ),
    );
  }
}
