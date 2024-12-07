import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:rawaaj/databases/database_consts.dart';
import 'package:rawaaj/widgets/grid_section.dart';
import 'package:rawaaj/widgets/product_details.dart';
import 'package:rawaaj/widgets/product_screen_bottom_bar.dart';
import '../widgets/product_carousel.dart';
import '../widgets/product_variations.dart';
import '../widgets/product_specifications.dart';
import '../widgets/rating_reviews.dart';

class ProductScreen extends StatelessWidget {
  final int id;

  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                ProductCarousel(img: products[id].image,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductDetails(
                        price: products[id].price,
                        description: products[id].description,
                      ),
                      ProductVariations(
                        variations: products[id].variation,
                      ),
                      ProductSpecifications(),
                      RatingReviews(),
                      GridSection(
                        title: "You Might Like",
                        itemsCount: 6,
                        gridPadding: 0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 20,
              left: 0,
              child: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,))
          )
        ],
      ),
      bottomNavigationBar: ProductBottomBar(),
    );
  }
}
