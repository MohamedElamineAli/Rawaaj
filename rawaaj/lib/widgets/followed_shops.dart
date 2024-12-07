import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/circular_img.dart';

class FollowedShops extends StatelessWidget {
  final List<String> shopImages = [
    'assets/images/shop1.jpg',
    'assets/images/shop2.jpg',
    'assets/images/shop3.jpg',
    'assets/images/shop4.jpg',
    'assets/images/shop5.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Followed Shops',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: shopImages.map((image) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CircularImg(img: image, radius: 60,)
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
