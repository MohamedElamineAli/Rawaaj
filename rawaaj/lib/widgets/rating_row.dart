import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  final double rating;
  final Color starColor = Colors.amber;
  final Color chipColor = Colors.blue.withOpacity(0.2);
  final double chipWidth = 6.0;
  final double starSize;

  RatingRow({
    Key? key,
    required this.rating,
    this.starSize = 26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    int emptyStars = 5 - fullStars - (hasHalfStar ? 1 : 0);

    return Row(
      children: [
        for (int i = 0; i < fullStars; i++)
          Icon(Icons.star, color: starColor, size: starSize,),
        if (hasHalfStar) Icon(Icons.star_half, color: starColor, size: starSize,),
        for (int i = 0; i < emptyStars; i++)
          Icon(Icons.star_border, color: starColor, size: starSize,),
      ],
    );
  }
}
