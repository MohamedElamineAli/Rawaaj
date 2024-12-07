import 'package:flutter/material.dart';

class AddRatingRow extends StatefulWidget {
  @override
  _AddRatingRowState createState() => _AddRatingRowState();
}

class _AddRatingRowState extends State<AddRatingRow> {
  int selectedRating = 0; // Track the currently selected rating (0 = no rating)

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedRating = index + 1; // Update the rating (1-based index)
              });
            },
            child: Icon(
              index < selectedRating
                  ? Icons.star // Filled star
                  : Icons.star_border, // Outlined star
              size: 40,
              color: Colors.amber,
            ),
          ),
        );
      }),
    );
  }
}
