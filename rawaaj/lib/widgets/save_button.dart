import 'package:flutter/material.dart';
import 'package:rawaaj/themes/colors.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          padding: const EdgeInsets.all(8.0),
          backgroundColor: primaryColor,
        ),
        onPressed: () {
        },
        child: const Text(
          'Save Changes',
          style: TextStyle(fontSize: 22, color: Colors.white, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
