import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_product_cubit.dart';
import 'color_circle.dart';

class ColorSelectorWidget extends StatelessWidget {
  const ColorSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the list of colors with corresponding database IDs
    final List<Map<String, dynamic>> colors = [
      {'id': 1, 'color': Colors.grey},
      {'id': 2, 'color': Colors.black},
      {'id': 3, 'color': Colors.blue},
      {'id': 4, 'color': Colors.red},
      {'id': 5, 'color': Colors.teal},
      {'id': 6, 'color': Colors.yellow},
      {'id': 7, 'color': Colors.purple},
    ];

    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        // Convert the list of selected IDs to a set of colors
        final selectedColors = state.product.colors.toSet();

        return Wrap(
          spacing: 10,
          children: colors.map((colorEntry) {
            final colorId = colorEntry['id'] as int;
            final colorValue = colorEntry['color'] as Color;
            final isSelected = selectedColors.contains(colorId);

            return GestureDetector(
              onTap: () {
                final cubit = context.read<AddProductCubit>();
                final updatedColors = List<int>.from(state.product.colors);

                if (isSelected) {
                  updatedColors.remove(colorId);
                } else {
                  updatedColors.add(colorId);
                }

                cubit.updateColors(updatedColors);
              },
              child: ColorCircle(color: colorValue, isSelected: isSelected),
            );
          }).toList(),
        );
      },
    );
  }
}
