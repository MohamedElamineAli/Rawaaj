import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/color_circle.dart';

class ColorSelectorWidget extends StatefulWidget {
  const ColorSelectorWidget({Key? key}) : super(key: key);

  @override
  _ColorSelectorWidgetState createState() => _ColorSelectorWidgetState();
}

class _ColorSelectorWidgetState extends State<ColorSelectorWidget> {
  final List<Color> colors = [
    Colors.grey,
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.teal,
    Colors.yellow,
    Colors.purple,
  ];
  final Set<Color> selectedColors = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      children: colors.map((color) {
        final isSelected = selectedColors.contains(color);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedColors.remove(color);
              } else {
                selectedColors.add(color);
              }
            });
          },
          child: ColorCircle(color: color, isSelected: isSelected),
        );
      }).toList(),
    );
  }
}
