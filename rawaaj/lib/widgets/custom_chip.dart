import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color color;
  final double width;

  const CustomChip({
    Key? key,
    required this.label,
    required this.color,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 3, horizontal: width),
          child: Text(
            label,
          ),
        ),
      ),
    );
  }
}
