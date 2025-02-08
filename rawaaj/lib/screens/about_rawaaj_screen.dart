import 'package:flutter/material.dart';

import '../widgets/sub_screen_app_bar.dart';

class AboutRawaajScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "About Rawaaj"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Icon
            SizedBox(height: 64),

            Center(
              child: Image.asset(
                "assets/icons/rawaaj.png",
                height: 110,
              ),
            ),

            SizedBox(height: 64),
            // Title
            Text(
              'About Rawaaj',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 16),

            // Description
            Text(
              "Rawaaj is your go-to platform for discovering local fashion and transforming the shopping experience. By connecting local clothing stores with shoppers, Rawaaj bridges the gap between traditional retail and modern digital convenience. Our app offers real-time inventory updates, price comparisons, and personalized style recommendations, making it easier for you to find unique styles while saving time and effort. Whether you're a busy professional, a parent, or a fashion enthusiast, Rawaaj helps you shop smarter and support local businesses. Together, we celebrate sustainable fashion, community growth, and the joy of discovering something truly special.",
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),

            // Contact Information
            Text(
              'Rawaaj@contact.com',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
