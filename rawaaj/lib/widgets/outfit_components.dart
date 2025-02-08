import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/cubit/products_cubit.dart';
import '../cubit/add_outfit_cubit.dart';
import '../models/summarized_product_model.dart';
import '../screens/add_outfit_componet_screen.dart';

class OutfitComponents extends StatelessWidget {
  const OutfitComponents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final outfitCubit = context.read<AddOutfitCubit>();

    return BlocBuilder<AddOutfitCubit, AddOutfitState>(
      builder: (context, state) {
        final components = state.outfit.outfitComponents ?? [];

        return SizedBox(
          height: 200,
          child: BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              context.read<ProductsCubit>().fetchProductsByIds(components);

              if (state is ProductsError) {
                return Center(child: Text(state.message));
              } else if (state is ProductsList) {
                final products = state.productsMap['selected'] ?? [];

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length + 1,
                  // Add button is always included
                  itemBuilder: (context, index) {
                    final isAddButton =
                        index == products.length; // Last item is Add Button
                    final productImage =
                        isAddButton ? File('') : products[index].image;
                    return _buildComponentItem(context, index, productImage,
                        isAddButton, components, outfitCubit, products);
                  },
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        );
      },
    );
  }

  Widget _buildComponentItem(
    BuildContext context,
    int index,
    File image,
    bool isAddButton,
    List<int> components,
    AddOutfitCubit outfitCubit,
    List<SummarizedProduct> products,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: isAddButton
            ? GestureDetector(
                onTap: () => _addItem(context, outfitCubit, products),
                child: const Center(
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 100,
                    color: Color(0xFFD9D9D9),
                  ),
                ),
              )
            : Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        image, // Placeholder image
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: GestureDetector(
                      onTap: () => _removeItem(index, outfitCubit, products),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> _addItem(
    BuildContext context,
    AddOutfitCubit outfitCubit,
    List<SummarizedProduct> products,
  ) async {
    final selectedProductId = await Navigator.push<int?>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddOutfitComponent(),
      ),
    );

    if (selectedProductId != null) {
      final currentComponents = outfitCubit.state.outfit.outfitComponents ?? [];

      // Ensure the product is not already in the list
      if (!currentComponents.contains(selectedProductId)) {
        outfitCubit
            .updateOutfitComponents([...currentComponents, selectedProductId]);
        outfitCubit.updateTotalPrice(
            products.fold(0.0, (sum, product) => sum + product.price));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('This product is already added to the outfit.')),
        );
      }
    }
  }

  void _removeItem(
    int index,
    AddOutfitCubit outfitCubit,
    List<SummarizedProduct> products,
  ) {
    final components = outfitCubit.state.outfit.outfitComponents ?? [];
    if (index < components.length) {
      final updatedComponents = List<int>.from(components)..removeAt(index);
      outfitCubit.updateOutfitComponents(updatedComponents);
      outfitCubit.updateTotalPrice(
          products.fold(0.0, (sum, product) => sum + product.price));
    }
  }
}
