import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/cubit/shop_cubit.dart';
import 'package:rawaaj/widgets/grid_section.dart';
import '../widgets/profile_header.dart';
import '../widgets/shop_profile_app_bar.dart';
import '../widgets/stats_section.dart';

class ShopProfileScreen extends StatelessWidget {
  final int shopId;

  const ShopProfileScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    context.read<ShopCubit>().fetchShopById(shopId);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ShopProfileAppBar(),
      body: BlocBuilder<ShopCubit, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ShopLoaded) {
            final shop = state.shop;

            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    ProfileHeader(
                      shopImg: shop.shopImage,
                      shopName: shop.name,
                      shopLocation: shop.location,
                    ),
                    const SizedBox(height: 32),
                    StatsSection(
                      followersNum: shop.followersNum,
                      productsNum: shop.productsNum,
                      isFollowed: shop.isFollowed,
                      shopId: shop.id,
                    ),
                    const SizedBox(height: 32),
                    GridSection(
                      title: "shop",
                      itemsCount: 30,
                      gridPadding: 0,
                      headerType: 2,
                      shopId: shopId,
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          } else if (state is ShopError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(
              child: Text('Failed to load shop data.'),
            );
          }
        },
      ),
    );
  }
}
