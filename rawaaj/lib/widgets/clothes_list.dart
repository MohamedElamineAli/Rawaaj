import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../models/summarized_product_model.dart';
import '../screens/product_screen.dart';
import '../cubit/main_index_cubit.dart';

class ClothesList extends StatelessWidget {
  const ClothesList({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProductsCubit>().fetchProductsByContextType('isLiked');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        const Text(
          "Clothes",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
                    // Filter products based on isLiked
                    return state.productsMap['isLiked'] ?? [];
                  }
                  return [];
                },
                builder: (context, likedProducts) {
                  if (likedProducts.isEmpty) {
                    return const Center(child: Text("No liked products yet."));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: likedProducts.length,
                    itemBuilder: (context, index) {
                      final product = likedProducts[index];
                      return ClotheLine(
                        context,
                        product.id,
                        product.image,
                        "${product.description} Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                        product.price,
                      );
                    },
                  );
                },
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }

  Widget ClotheLine(
      BuildContext context, int id, File img, String details, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(id: id),
              ));
        },
        child: SizedBox(
          height: 105,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.file(
                      img,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 120,
                right: 0,
                child: Text(
                  details,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 120,
                child: Text(
                  '${price.toStringAsFixed(2)} DZD',
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: IconButton(
                  onPressed: () {
                    context.read<MainIndexCubit>().changeMainIndex(3);
                  },
                  icon: const Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

