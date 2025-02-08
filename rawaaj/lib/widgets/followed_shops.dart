import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/cubit/shops_cubit.dart';
import 'package:rawaaj/screens/shop_profile_screen.dart';
import 'package:rawaaj/widgets/circular_img.dart';

class FollowedShops extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ShopsCubit>().fetchShops();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My Followed Shops',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<ShopsCubit, ShopsState>(
            builder: (context, state) {
              if (state is ShopsList) {
                return Row(
                  children: state.shops.map((shop) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShopProfileScreen(shopId: shop.id,),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: CircularImg(img: shop.shopImage, radius: 60),
                      ),
                    );
                  }).toList(),
                );
              } else if (state is ShopsError) {
                // Display an error message if fetching fails
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else {
                // Show a loading spinner while data is being fetched
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
