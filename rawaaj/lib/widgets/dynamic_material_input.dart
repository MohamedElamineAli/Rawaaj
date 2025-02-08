import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/add_product_cubit.dart';
import 'text_field_widget.dart';

class DynamicMaterialsInput extends StatelessWidget {
  final int maxMaterials;

  const DynamicMaterialsInput({Key? key, this.maxMaterials = 10})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProductCubit, AddProductState>(
      builder: (context, state) {
        final materials = state.product.materials;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < materials.length; i++)
              Stack(
                children: [
                  CustomTextField(
                    hint: 'Enter material',
                    hintColor: defaultHintColor,
                    onChanged: (value) {
                      context
                          .read<AddProductCubit>()
                          .updateMaterialAtIndex(i, value);
                    },
                  ),
                  Positioned(
                    right: 5,
                    bottom: 10,
                    child: GestureDetector(
                      onTap: () {
                        context.read<AddProductCubit>().removeMaterialAtIndex(i);
                      },
                      child: const Icon(Icons.remove, size: 30, color: Colors.red),
                    ),
                  ),
                ],
              ),
            if (materials.length < maxMaterials)
              Stack(
                children: [
                  CustomTextField(
                    hint: 'Enter material',
                    onChanged: (value) {
                      if (value.trim().isNotEmpty) {
                        context
                            .read<AddProductCubit>()
                            .addMaterial(value.trim());
                      }
                    },
                  ),
                  Positioned(
                    right: 5,
                    bottom: 10,
                    child: GestureDetector(
                      onTap: () {
                        // Add an empty material (alternative trigger for adding)
                        context
                            .read<AddProductCubit>()
                            .addMaterial('');
                      },
                      child: const Icon(Icons.add, size: 30, color: Colors.green),
                    ),
                  ),
                ],
              ),
            if (materials.length < maxMaterials)
              Text(
                'You can add up to ${maxMaterials - materials.length} more materials.',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
          ],
        );
      },
    );
  }
}
