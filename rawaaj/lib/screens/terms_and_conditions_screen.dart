import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubScreenAppBar(name: "Terms and Conditions"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              "Terms and Conditions",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "1. Acceptance of Terms\n"
              "By accessing this application, you agree to comply with and be bound by these terms and conditions.\n\n"
              "2. Use of the Application\n"
              "You agree to use this application for lawful purposes only.\n\n"
              "3. Intellectual Property Rights\n"
              "All content, trademarks, and data on this app, including but not limited to software, text, graphics, icons, and hyperlinks, are the property of the company.\n\n"
              "4. User Responsibilities\n"
              "You are responsible for maintaining the confidentiality of your account information.\n\n"
              "5. Disclaimer of Liability\n"
              "The application is provided on an 'as is' basis without any warranties.\n\n"
              "6. Modifications to Terms\n"
              "The company reserves the right to amend these terms at any time.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
