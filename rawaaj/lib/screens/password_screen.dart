import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rawaaj/screens/main_screen.dart';

class PasswordScreen extends StatelessWidget {
  final String username;
  final String password;

  const PasswordScreen({super.key, required this.username, required this.password});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              // SVG Blob
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: CustomPaint(
                  painter: BlobPainter(),
                ),
              ),
              // Main content
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 140),
                      Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[400],
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person_outline_rounded,
                            size: 45,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Text(
                          'Hello, $username!!',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Center(
                        child: Text(
                          'Type your password',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: Pinput(
                          length: password.length,
                          defaultPinTheme: defaultPinTheme,
                          obscureText: true,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          obscuringWidget: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onCompleted: (pin) {
                            if(pin != password) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Wrong password.'),
                                ),
                              );
                              return;
                            }
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => MainScreen()),
                                  (Route<dynamic> route) => false, // This removes all previous routes
                            );
                          },
                        ),
                      ),
                      const Spacer(),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 48),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Not you?',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                                const SizedBox(width: 30),
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF004BFE),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF004BFE).withOpacity(0.25),
                                        blurRadius: 6,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ],
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

class BlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Calculate scale factors based on screen size
    final double scaleX = size.width / 428; // Base width (iPhone 14 Pro Max)
    final double scaleY = size.height / 926; // Base height (iPhone 14 Pro Max)

    // Scale the canvas to maintain proportions
    canvas.scale(scaleX, scaleY);

    // Light blue blob
    Path lightBluePath = Path();
    lightBluePath.moveTo(213.444, 279.004);
    lightBluePath.cubicTo(173.585, 435.118, -7.10811, 270.844, -48.783, 167.695);
    lightBluePath.cubicTo(-90.458, 64.5462, -40.6233, -52.8569, 62.5257, -94.5318);
    lightBluePath.cubicTo(165.675, -136.207, 249.934, -67.0278, 295.434, 23.9722);
    lightBluePath.cubicTo(340.934, 114.972, 253.303, 122.89, 213.444, 279.004);
    lightBluePath.close();

    Paint lightBluePaint = Paint()
      ..color = const Color(0xFFD9E4FF)
      ..style = PaintingStyle.fill;

    // Dark blue blob
    Path darkBluePath = Path();
    darkBluePath.moveTo(55.4357, -118.547);
    darkBluePath.cubicTo(150.874, -248.362, 256.871, -28.3613, 256.871, 82.8886);
    darkBluePath.cubicTo(256.871, 194.138, 166.686, 284.324, 55.4357, 284.324);
    darkBluePath.cubicTo(-55.8142, 284.324, -146, 194.138, -146, 82.8886);
    darkBluePath.cubicTo(-146, -28.3613, -40.0024, 11.2675, 55.4357, -118.547);
    darkBluePath.close();

    Paint darkBluePaint = Paint()
      ..color = const Color(0xFF004BFE)
      ..style = PaintingStyle.fill;

    canvas.drawPath(lightBluePath, lightBluePaint);
    canvas.drawPath(darkBluePath, darkBluePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}