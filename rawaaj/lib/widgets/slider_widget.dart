import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  final String minValue;
  final String maxValue;

  const SliderWidget({Key? key, required this.minValue, required this.maxValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(minValue),
            Text(maxValue),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Colors.blue,
            inactiveTrackColor: Colors.blue.shade100,
            thumbColor: Colors.blue,
            overlayColor: Colors.blue.withOpacity(0.2),
          ),
          child: Slider(
            value: 0.5,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
