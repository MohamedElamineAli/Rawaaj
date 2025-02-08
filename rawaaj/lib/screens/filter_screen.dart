import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/color_circles_line.dart';
import 'package:rawaaj/widgets/filter_size_line.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../cubit/filter_cubit.dart';
import '../themes/colors.dart';
import '../widgets/sort_buttons.dart';
import '../widgets/range_slider_widget.dart';
import '../widgets/button_row.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "Filter"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Size Section
            const Text(
              'Size',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            const FilterSizeLine(),
            const SizedBox(height: 24),

            // Color Section
            const Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            const ColorCirclesLine(),
            const SizedBox(height: 40),

            // Price Section with BlocBuilder
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                BlocBuilder<FilterCubit, FilterState>(
                  builder: (context, state) {
                    print('Price Range Text Rebuilt: ${state.priceRange.lower} - ${state.priceRange.upper}');
                    return Text(
                      '${state.priceRange.lower}DZD - ${state.priceRange.upper}DZD',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ],
            ),
            const RangeSliderWidget(),
            const SizedBox(height: 24),

            const Text(
              'Sort by',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            SortButtons(),
            const Spacer(),

            BlocBuilder<FilterCubit, FilterState>(
              builder: (context, state) {
                return ButtonRow(filterState: state,);
              },
            ),
          ],
        ),
      ),
    );
  }
}
