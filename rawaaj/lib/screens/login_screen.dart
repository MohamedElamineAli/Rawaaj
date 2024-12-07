import 'package:flutter/material.dart';
import 'package:rawaaj/screens/password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              // SVG Blob
              SizedBox(
                width: screenWidth,
                height: screenHeight,
                child: CustomPaint(
                  painter: LoginBlobPainter(),
                ),
              ),
              // Main content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: screenHeight/3.4),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Row(
                        children: [
                          Text(
                            'Good to see you back! ',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            '❤️',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF5F5F5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push( context, MaterialPageRoute(builder: (context) => PasswordScreen(),) );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004BFE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Next',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
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

class LoginBlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Calculate scale factors based on screen size
    final double scaleX = size.width / 428; // Base width (iPhone 14 Pro Max)
    final double scaleY = size.height / 926; // Base height (iPhone 14 Pro Max)
    
    // Scale the canvas to maintain proportions
    canvas.scale(scaleX, scaleY);

    // Light blue top blob
    Path lightBlueTopPath = Path();
    lightBlueTopPath.moveTo(190.444, 268.004);
    lightBlueTopPath.cubicTo(150.585, 424.118, -30.1081, 259.844, -71.783, 156.695);
    lightBlueTopPath.cubicTo(-113.458, 53.5462, -63.6233, -63.8569, 39.5257, -105.532);
    lightBlueTopPath.cubicTo(142.675, -147.207, 226.934, -78.0278, 272.434, 12.9722);
    lightBlueTopPath.cubicTo(317.934, 103.972, 230.303, 111.89, 190.444, 268.004);
    lightBlueTopPath.close();

    Paint lightBluePaint = Paint()
      ..color = const Color(0xFFD9E4FF)
      ..style = PaintingStyle.fill;

    // Dark blue top blob
    Path darkBlueTopPath = Path();
    darkBlueTopPath.moveTo(32.4357, -129.547);
    darkBlueTopPath.cubicTo(127.874, -259.362, 233.871, -39.3612, 233.871, 71.8886);
    darkBlueTopPath.cubicTo(233.871, 183.138, 143.686, 273.324, 32.4357, 273.324);
    darkBlueTopPath.cubicTo(-78.8142, 273.324, -169, 183.138, -169, 71.8886);
    darkBlueTopPath.cubicTo(-169, -39.3612, -63.0024, 0.267532, 32.4357, -129.547);
    darkBlueTopPath.close();

    // Light blue bottom blob
    Path lightBlueBottomPath = Path();
    lightBlueBottomPath.moveTo(522.028, 739.322);
    lightBlueBottomPath.cubicTo(615.997, 870.204, 374.009, 903.029, 268.204, 868.651);
    lightBlueBottomPath.cubicTo(162.399, 834.273, 104.497, 720.632, 138.875, 614.827);
    lightBlueBottomPath.cubicTo(173.253, 509.023, 280.407, 488.944, 379.364, 512.583);
    lightBlueBottomPath.cubicTo(478.321, 536.221, 428.059, 608.44, 522.028, 739.322);
    lightBlueBottomPath.close();

    // Dark blue middle blob
    Path darkBlueMiddlePath = Path();
    darkBlueMiddlePath.moveTo(339.568, 394.554);
    darkBlueMiddlePath.cubicTo(291.769, 421.793, 289.259, 338.447, 304.71, 303.745);
    darkBlueMiddlePath.cubicTo(320.16, 269.042, 360.817, 253.436, 395.519, 268.886);
    darkBlueMiddlePath.cubicTo(430.221, 284.337, 445.828, 324.993, 430.377, 359.695);
    darkBlueMiddlePath.cubicTo(414.927, 394.398, 387.367, 367.315, 339.568, 394.554);
    darkBlueMiddlePath.close();

    Paint darkBluePaint = Paint()
      ..color = const Color(0xFF004BFE)
      ..style = PaintingStyle.fill;

    Paint lightBlueBottomPaint = Paint()
      ..color = const Color(0xFFF2F5FE)
      ..style = PaintingStyle.fill;

    // Draw all blobs in correct order
    canvas.drawPath(lightBlueBottomPath, lightBlueBottomPaint);
    canvas.drawPath(darkBlueMiddlePath, darkBluePaint);
    canvas.drawPath(lightBlueTopPath, lightBluePaint);
    canvas.drawPath(darkBlueTopPath, darkBluePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
