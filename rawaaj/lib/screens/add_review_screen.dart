import 'package:flutter/material.dart';
import 'package:rawaaj/themes/colors.dart';
import 'package:rawaaj/widgets/add_rating_row.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import 'package:rawaaj/widgets/text_field_widget.dart';

class AddReviewScreen extends StatelessWidget {
  const AddReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "Add Review"),
      body: SingleChildScrollView(
        child: Container(
          // height: 800,
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Rating",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              AddRatingRow(),
              SizedBox(height: 12),
              CustomTextField(label: "Your Comment", maxLines: 4,),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the bottom sheet after submission
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Say it!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
