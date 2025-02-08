import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/products_cubit.dart';
import '../widgets/product_card.dart';

class SelectGridSection extends StatelessWidget {
  final String title;
  final double gridPadding;

  const SelectGridSection({
    Key? key,
    required this.title,
    this.gridPadding = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Fetch all products
    context.read<ProductsCubit>().fetchProducts();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: gridPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Use BlocBuilder to display products
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
                // Filter all products from the state
                final allProducts = state.productsMap['all'] ?? [];

                if (allProducts.isEmpty) {
                  return const Center(
                    child: Text("No products available"),
                  );
                }

                // Display the grid of products
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: allProducts.length,
                  itemBuilder: (context, index) {
                    final product = allProducts[index];
                    return GestureDetector(
                      onTap: () {
                        // Return the product's ID when clicked
                        Navigator.pop(context, product.id);
                      },
                      child: AbsorbPointer(
                        absorbing: true, // Prevent clicks from propagating
                        child: ProductCard(
                          id: product.id,
                          img: product.image,
                          title: product.description,
                          price: product.getFormattedPrice(),
                        ),
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
