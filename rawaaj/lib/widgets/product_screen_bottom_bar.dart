import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/cubit/map_cubit.dart';
import 'package:rawaaj/cubit/shop_cubit.dart';
import '../cubit/main_index_cubit.dart';
import '../cubit/product_cubit.dart';

class ProductBottomBar extends StatelessWidget {
  final int productId;

  const ProductBottomBar({
    super.key,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              // Handle different states of the ProductCubit
              if (state is ProductLoaded) {
                final isFavorite = state.product.isLiked;
                return ElevatedButton(
                  onPressed: () {
                    context.read<ProductCubit>().toggleProductLike(productId);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFEFEFEF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: isFavorite
                      ? const Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : const Icon(
                          Icons.favorite_border,
                          color: Colors.black,
                        ),
                );
              } else if (state is ProductLoading) {
                // Show a loading indicator while the state is loading
                return ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFEFEFEF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const CircularProgressIndicator(),
                );
              } else {
                // Fallback UI in case of an error or initial state
                return ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: const Color(0xFFEFEFEF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Icon(
                    Icons.error_outline,
                    color: Colors.black,
                  ),
                );
              }
            },
          ),
          BlocBuilder<ShopCubit, ShopState>(
            builder: (context, state) {
              if (state is ShopLoading) {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: SizedBox(
                      height: 32,
                      width: 120,
                      child: const Center(child: CircularProgressIndicator())),
                );
              } else if (state is ShopLoaded) {
                return ElevatedButton(
                  onPressed: () {
                    context.read<MapCubit>().setTargetShop(state.shop.name, state.shop.long, state.shop.lat);
                    context.read<MainIndexCubit>().changeMainIndex(3);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    "Go to Purchase",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
