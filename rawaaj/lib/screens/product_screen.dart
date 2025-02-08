import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/grid_section.dart';
import 'package:rawaaj/widgets/product_details.dart';
import 'package:rawaaj/widgets/product_screen_bottom_bar.dart';
import 'package:rawaaj/widgets/product_shop.dart';
import '../cubit/product_cubit.dart';
import '../widgets/product_carousel.dart';
import '../widgets/product_variations.dart';
import '../widgets/product_specifications.dart';
import '../widgets/rating_reviews.dart';

class ProductScreen extends StatelessWidget {
  final int id;

  const ProductScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<ProductCubit>().fetchProductById(id);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductError) {
                  print("error");
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  );
                } else if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductLoaded) {
                  final product = state.product;
                  return Column(
                    children: [
                      ProductCarousel(imgs: product.images),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProductDetails(
                              price: product.price,
                              description: product.description,
                            ),
                            ProductShop(shopId: state.product.shopId ?? 0,),

                            // ProductVariations(
                            //   variations: product.variation,
                            // ),

                            ProductSpecifications(size: state.product.sizes[0], color: state.product.colors[0],),
                            RatingReviews(rating: state.product.totalRatings,),
                            GridSection(
                              title: "You Might Like",
                              itemsCount: 6,
                              gridPadding: 0,
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
                return const SizedBox.shrink(); // Fallback widget for other states
              },
            )

          ),
          Positioned(
              top: 20,
              left: 0,
              child: IconButton(onPressed: () {Navigator.pop(context);}, icon: Icon(Icons.arrow_back, color: Colors.black, size: 30,))
          )
        ],
      ),
      bottomNavigationBar: ProductBottomBar(productId: id,),
    );
  }
}
