import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/product_card.dart';
import '../cubit/products_cubit.dart';
import '../models/summarized_product_model.dart';
import 'section_header.dart';

class GridSection extends StatelessWidget {
  final String title;
  final int itemsCount;
  final double gridPadding;
  final int headerType;
  final int categoryNum;
  final int shopId;
  final String? searchValue;

  const GridSection({
    super.key,
    required this.title,
    required this.itemsCount,
    this.gridPadding = 16,
    this.headerType = 0,
    this.categoryNum = 0,
    this.shopId = 1,
    this.searchValue,
  });

  @override
  Widget build(BuildContext context) {
    if (title == "New Items") {
      context.read<ProductsCubit>().fetchProductsByContextType('new');
    } else if (title == "Just For You") {
      context.read<ProductsCubit>().fetchProductsByContextType('just_for_you');
    } else if (title == "Top Products") {
      context.read<ProductsCubit>().fetchProductsByContextType('top');
    } else if (title == "Recently Viewed") {
      context.read<ProductsCubit>().fetchProductsByContextType('history');
    } else if (title == "shop") {
      context.read<ProductsCubit>().fetchProductsByShopId(shopId);
    } else if (title == "Search") {
      context.read<ProductsCubit>().fetchProductsBySearch(searchValue ?? '');
    } else if (categoryNum != 0) {
      context.read<ProductsCubit>().fetchProductsByCategoryId(categoryNum);
    } else if (title != "Filter") {
      context.read<ProductsCubit>().fetchProducts();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gridPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (headerType == 0)
              ? SectionHeader(title: title)
              : (headerType == 1)
              ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          )
              : const SizedBox(),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                );
              } else if (state is ProductsList) {
                return BlocSelector<ProductsCubit, ProductsState, List<SummarizedProduct>>(
                  selector: (state) {
                    if (state is ProductsList) {
                      if (title == "New Items") {
                        return state.productsMap['new'] ?? [];
                      } else if (title == "Just For You") {
                        return state.productsMap['just_for_you'] ?? [];
                      } else if (title == "Top Products") {
                        return state.productsMap['top'] ?? [];
                      } else if (title == "Recently Viewed") {
                        return state.productsMap['history'] ?? [];
                      } else if (title == 'shop') {
                        return state.productsMap['shop'] ?? [];
                      } else if (title == 'Search') {
                        return state.productsMap['search'] ?? [];
                      } else if (title == 'Filter') {
                        return state.productsMap['filter'] ?? [];
                      } else if (categoryNum != 0) {
                        return state.productsMap['category_$categoryNum'] ?? [];
                      }
                      return state.productsMap['all'] ?? []; // Default case
                    }
                    return [];
                  },
                  builder: (context, filteredProducts) {
                    if (filteredProducts.isEmpty) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 0.7,
                      ),
                      itemCount: min(filteredProducts.length, itemsCount),
                      itemBuilder: (context, index) {
                        return ProductCard(
                          id: filteredProducts[index].id,
                          img: filteredProducts[index].image,
                          title: filteredProducts[index].description,
                          price: filteredProducts[index].getFormattedPrice(),
                        );
                      },
                    );
                  },
                );
              }

              // Show a loading indicator while fetching data
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
