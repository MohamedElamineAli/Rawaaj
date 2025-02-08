import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/shop_cubit.dart';
import '../screens/shop_profile_screen.dart';
import 'circular_img.dart';

class ProductShop extends StatelessWidget {
  final int shopId;

  const ProductShop({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if(state is! ShopLoaded || state.shop.id != shopId) {
          context.read<ShopCubit>().fetchShopById(shopId);
        }

        if (state is ShopLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShopLoaded) {
          return Visibility(
            visible: shopId != 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShopProfileScreen(
                                shopId: shopId,
                              ),
                            ),
                          );
                        },
                        child:
                            CircularImg(img: state.shop.shopImage, radius: 50)),
                    const SizedBox(width: 10),
                    Text(
                      state.shop.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        } else if (state is ShopError) {
          return Center(child: Text(state.message));
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
