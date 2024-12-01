import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/filter_size_line.dart';
import '../themes/colors.dart';
import '../widgets/color_circle.dart';
import '../widgets/sort_button.dart';
import '../widgets/slider_widget.dart';
import '../widgets/button_row.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Filter',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 28,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
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
            FilterSizeLine(),
            const SizedBox(height: 24),

            // Color Section
            const Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                for (var color in [
                  Colors.grey.withOpacity(0.1),
                  Colors.black,
                  Colors.blue,
                  Colors.red,
                  Colors.teal,
                  Colors.amber,
                  Colors.purple
                ])
                  ColorCircle(color: color, isSelected: color == Colors.white),
              ],
            ),
            const SizedBox(height: 24),

            // Price Section
            const Text(
              'Price',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            const SliderWidget(minValue: '1000DZD', maxValue: '15000DZD'),
            const SizedBox(height: 24),

            // Sorting Section
            const Text(
              'Sort by',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                SortButton(label: 'Popular', isSelected: true),
                SortButton(label: 'Newest'),
                SortButton(label: 'Price High to Low'),
                // SortButton(label: 'Price Low to High'),
              ],
            ),
            const Spacer(),

            // Bottom Buttons
            const ButtonRow(),
          ],
        ),
      ),
    );
  }
}
