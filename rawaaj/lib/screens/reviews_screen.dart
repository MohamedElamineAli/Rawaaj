import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/review_line.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "Reviews"),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) => ReviewLine(
                img: "assets/images/grey.png",
                name: "Person $index",
                rating: (index + 2) % 6,
                comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit...")
        ),
      ),
    );
  }
}
