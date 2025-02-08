import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/filter_cubit.dart';
import '../cubit/products_cubit.dart';
import '../screens/specific_shop_screen.dart';

class ButtonRow extends StatelessWidget {
  final FilterState filterState;

  const ButtonRow({super.key, required this.filterState});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(
          onPressed: () {
            context.read<FilterCubit>().resetFilters();
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.blue, width: 2.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
          ),
          child: const Text(
            'Clear',
            style: TextStyle(
                color: Colors.blue, fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              context.read<ProductsCubit>().fetchProductsByFilter(
                  filterState.size,
                  filterState.color,
                  filterState.priceRange.lower.toDouble(),
                  filterState.priceRange.upper.toDouble(),
                  filterState.sortType);
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SpecificShopScreen(
                        name: 'Filter', searchType: 0)),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'Apply',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ],
    );
  }
}
