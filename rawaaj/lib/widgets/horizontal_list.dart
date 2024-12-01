import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/product_card.dart';
import 'section_header.dart';

class HorizontalListSection extends StatelessWidget {
  final String title;
  final int itemsCount;

  const HorizontalListSection({Key? key, required this.title, required this.itemsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                    imageUrl: 'https://via.placeholder.com/150',
                    title: "Item ${index + 1}: Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu",
                    price: "150 DZD",
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
