import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/color_circles_line.dart';
import 'package:rawaaj/widgets/filter_size_line.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../themes/colors.dart';
import '../widgets/sort_buttons.dart';
import '../widgets/slider_widget.dart';
import '../widgets/button_row.dart';

class FilterScreen extends StatefulWidget {
  FilterScreen({Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  double _upperValue = 15000;
  double _lowerValue = 1000;

  void submitPriceBounds(List<double> values) {
    setState(() {
      _upperValue = values[1];
      _lowerValue = values[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "Filter"),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Size',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 12),
            FilterSizeLine(),
            SizedBox(height: 24),

            Text(
              'Color',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 12),
            ColorCirclesLine(),
            SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  '${_lowerValue.toInt()}DZD - ${_upperValue.toInt()}DZD',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                )
              ],
            ),
            SliderWidget(
              minValue: 1000,
              maxValue: 15000,
              onSubmit: submitPriceBounds,
            ),
            SizedBox(height: 24),

            // Sorting Section
            Text(
              'Sort by',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 12),
            SortButtons(),
            Spacer(),

            ButtonRow(),
          ],
        ),
      ),
    );
  }
}
