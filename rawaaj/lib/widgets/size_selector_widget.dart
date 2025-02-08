import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/add_product_cubit.dart';

class SizeSelectorWidget extends StatelessWidget {
  const SizeSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sizes = [
      {'id': 1, 'label': 'XS'},
      {'id': 2, 'label': 'S'},
      {'id': 3, 'label': 'M'},
      {'id': 4, 'label': 'L'},
      {'id': 5, 'label': 'XL'},
      {'id': 6, 'label': 'XXL'},
    ];


    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        final selectedSizes = state.product.sizes.toSet();

        return Wrap(
          spacing: 10,
          children: sizes.map((size) {
            final isSelected = selectedSizes.contains(size['id']);
            return GestureDetector(
              onTap: () {
                final cubit = context.read<AddProductCubit>();
                final updatedSizes = List<int>.from(state.product.sizes);

                if (isSelected) {
                  updatedSizes.remove(size['id']);
                } else {
                  updatedSizes.add(size['id']);
                }

                cubit.updateSizes(updatedSizes);
              },
              child: Container(
                height: 30,
                width: 52,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? Colors.blue : Colors.transparent,
                    width: 1.5,
                  ),
                  color: const Color(0xFFF4F4F4),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Center(
                  child: Text(
                    size['label'],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            );
          }).toList(),
        );

      },
    );
  }
}
