import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/circular_img.dart';
import 'package:rawaaj/widgets/rating_row.dart';

class ReviewLine extends StatelessWidget {
  final String img;
  final String name;
  final double rating;
  final String comment;

  const ReviewLine(
      {super.key,
      required this.img,
      required this.name,
      required this.rating,
      required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircularImg(img: img),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.w500),),
                RatingRow(rating: rating, starSize: 20,),
                Text(comment)
              ],
            ),
          )
        ],
      ),
    );
  }
}
