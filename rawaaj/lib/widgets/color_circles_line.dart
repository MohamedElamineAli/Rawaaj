import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/color_circle.dart';

class ColorCirclesLine extends StatefulWidget {
  ColorCirclesLine({Key? key}) : super(key: key);

  @override
  State<ColorCirclesLine> createState() => _ColorCirclesLineState();
}

class _ColorCirclesLineState extends State<ColorCirclesLine> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    List<Color> colorTypes = [
      Colors.grey.withOpacity(0.1),
      Colors.black,
      Colors.blue,
      Colors.red,
      Colors.teal,
      Colors.amber,
      Colors.purple
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 0; i < colorTypes.length; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                selected = i;
              });
            },
            child: ColorCircle(color: colorTypes[i], isSelected: i == selected),
          ),
      ],
    );
  }
}
