import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/color_circle.dart';
import '../cubit/filter_cubit.dart';

class ColorCirclesLine extends StatelessWidget {
  const ColorCirclesLine({super.key});

  @override
  Widget build(BuildContext context) {
    List<Color> colorTypes = [
      Colors.grey.withOpacity(0.1),
      Colors.black,
      Colors.blue,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.purple,
    ];

    return BlocBuilder<FilterCubit, FilterState>(
      builder: (context, state) {
        int selected = state.color;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < colorTypes.length; i++)
              GestureDetector(
                onTap: () {
                  context.read<FilterCubit>().changeColor(i);
                },
                child: ColorCircle(color: colorTypes[i], isSelected: i == selected),
              ),
          ],
        );
      },
    );
  }
}
