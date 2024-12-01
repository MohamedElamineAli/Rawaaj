import 'package:flutter/material.dart';

class ColorCircle extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorCircle({Key? key, required this.color, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
        )
      ),
    );
  }
}
