import 'package:flutter/material.dart';
import '../widgets/background_blob.dart';
import '../widgets/create_account_form.dart';
import '../widgets/create_account_image.dart';

class CreateShopAccountScreen extends StatelessWidget {
  const CreateShopAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          BackgroundBlob(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    CreateAccountImage(
                      isShopAccount: false,
                    ),
                    SizedBox(height: 32),
                    CreateAccountForm(
                      isShopAccount: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}