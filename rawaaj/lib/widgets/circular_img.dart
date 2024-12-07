import 'package:flutter/material.dart';

class CircularImg extends StatelessWidget {
  final String img;
  final double radius;
  const CircularImg({super.key, required this.img, this.radius = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: radius,
        height: radius,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        child: ClipOval(
          child: Image.asset(
            img,
            fit: BoxFit.cover,
          ),
        ));
  }
}
