import 'package:flutter/material.dart';
import 'package:rawaaj/screens/create_shop_account_screen.dart';
import '../widgets/background_blob.dart';
import '../widgets/create_account_form.dart';
import '../widgets/create_account_image.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const BackgroundBlob(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const CreateAccountImage(
                      isShopAccount: false,
                    ),
                    const SizedBox(height: 32),
                    const CreateAccountForm(
                      isShopAccount: false,
                    ),
                    const SizedBox(height: 4),
                    anotherScreenDirections(
                        context: context,
                        screen: const LoginScreen(),
                        text: 'I already have an account'
                    ),
                    const SizedBox(height: 12),
                    anotherScreenDirections(
                        context: context,
                        screen: const CreateShopAccountScreen(),
                        text: 'Create Shop Account'
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

  GestureDetector anotherScreenDirections(
      {required BuildContext context,
      required Widget screen,
      required String text}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.arrow_forward,
            color: Color(0xFF004BFE),
          ),
        ],
      ),
    );
  }
}
