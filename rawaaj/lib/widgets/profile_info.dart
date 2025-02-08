import 'package:flutter/material.dart';
import 'package:rawaaj/constants/default_cubit_product.dart';
import 'package:rawaaj/screens/settings_screen.dart';
import 'package:rawaaj/themes/colors.dart';
import 'package:rawaaj/widgets/circular_img.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircularImg(img: mohamedImage, radius: 60,),
            SizedBox(width: 8,),
            Text("Hello, Mohamed", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), ),
          ],
        ),
        IconButton(onPressed: () {
          Navigator.push( context, MaterialPageRoute(builder: (context) => SettingsScreen(),) );
        }, icon: Icon(Icons.settings, color: primaryColor, size: 30,))
      ],
    );
  }
}
