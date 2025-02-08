import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/models/summarized_product_model.dart';
import '../cubit/products_cubit.dart';
import 'section_header.dart';
import 'product_card.dart';

class HorizontalListSection extends StatelessWidget {
  final String title; // the cubit type depends on the title "Top Products", "Recently Viewed"
  final int itemsCount;
  final double padding;

  const HorizontalListSection({
    Key? key,
    required this.title,
    required this.itemsCount,
    this.padding = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetching products based on title
    if (title == "Top Products") {
      context.read<ProductsCubit>().fetchProductsByContextType('top');
    } else if (title == "Recently Viewed") {
      context.read<ProductsCubit>().fetchProductsByContextType('history');
    } else {
      context.read<ProductsCubit>().fetchProducts();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          const SizedBox(height: 8),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              if (state is ProductsError) {
                return Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              } else if (state is ProductsList) {
                return BlocSelector<ProductsCubit, ProductsState, List<SummarizedProduct>>(
                  selector: (state) {
                    if (state is ProductsList) {
                      if (title == "Top Products") {
                        return state.productsMap['top'] ?? [];
                      } else if (title == "Recently Viewed") {
                        return state.productsMap['history'] ?? [];
                      }
                      return state.productsMap['all'] ?? []; // Default case
                    }
                    return [];
                  },
                  builder: (context, filteredProducts) {
                    if (filteredProducts.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return SizedBox(
                      height: 235,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: min(filteredProducts.length, itemsCount),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 160, // Adjust to your desired card width
                            child: ProductCard(
                              id: filteredProducts[index].id,
                              img: filteredProducts[index].image,
                              title: filteredProducts[index].description,
                              price: filteredProducts[index].getFormattedPrice(),
                            ),
                          );
                        },
                      ),
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

