import 'package:flutter/material.dart';
import 'package:rawaaj/constants/default_cubit_product.dart';
import 'package:rawaaj/screens/add_review_screen.dart';
import 'package:rawaaj/widgets/circular_img.dart';
import 'package:rawaaj/widgets/custom_chip.dart';
import 'package:rawaaj/widgets/rating_row.dart';
import 'package:rawaaj/widgets/review_line.dart';
import 'package:rawaaj/widgets/section_header.dart';

class RatingReviews extends StatelessWidget {
  final double rating;

  const RatingReviews({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Rating & Reviews"),
        Row(
          children: [
            RatingRow(rating: rating),
            const SizedBox(
              width: 8,
            ),
            CustomChip(
                label: rating.toString(),
                color: Colors.blue.withOpacity(0.2),
                width: 6)
          ],
        ),
        SizedBox(height: 16),
        ReviewLine(
            img: greyImage,
            name: "Amine",
            rating: rating,
            comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit..."
        ),
        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => AddReviewScreen()), );
            },
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24),
              child: const Text(
                "Add a Review",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
