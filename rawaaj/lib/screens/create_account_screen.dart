import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:rawaaj/screens/login_screen.dart';
import 'package:rawaaj/screens/main_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  PhoneNumber? selectedCountry;
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    selectedCountry = PhoneNumber(
      isoCode: 'DZ',
      phoneNumber: '',
      dialCode: '+213',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: SignUpBlobPainter(),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    // Title and image picker section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create\nAccount',
                          style: TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.w900,
                            height: 1.0,
                            letterSpacing: 0.8,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: () async {},
                          child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF004BFE),
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: Color(0xFF004BFE),
                                size: 38,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Form fields section
                    Column(
                      children: [
                        // Email field
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Password field
                        TextField(
                          obscureText: !isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: const Color(0xFFF5F5F5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Phone number row (Algeria only)
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              setState(() {
                                selectedCountry = number;
                              });
                            },
                            initialValue: selectedCountry,
                            countries: const ['DZ'], // Only allow Algeria
                            selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              setSelectorButtonAsPrefixIcon: true,
                              leadingPadding: 16,
                              useEmoji: false,
                              showFlags: true,
                            ),
                            spaceBetweenSelectorAndTextField: 0,
                            ignoreBlank: false,
                            autoValidateMode: AutovalidateMode.disabled,
                            formatInput: true,
                            selectorTextStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                            textStyle: const TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                            ),
                            inputDecoration: InputDecoration(
                              hintText: 'Phone Number',
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Buttons section
                    Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push( context, MaterialPageRoute(builder: (context) => MainScreen(),) );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF004BFE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Done',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push( context, MaterialPageRoute(builder: (context) => LoginScreen(),) );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'I already have an account',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF004BFE),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class SignUpBlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / 428;
    final double scaleY = size.height / 926;

    canvas.scale(scaleX, scaleY);

    Path lightBluePath = Path();
    lightBluePath.moveTo(149.237, 157.191);
    lightBluePath.cubicTo(116.215, 286.524, -45.9053, 161.1, -68.0058, 64.9771);
    lightBluePath.cubicTo(-90.1062, -31.1457, -61.2458, -117.74, 24.2082, -152.265);
    lightBluePath.cubicTo(109.662, -186.791, 179.466, -129.479, 217.161, -54.0904);
    lightBluePath.cubicTo(254.855, 21.2987, 182.258, 27.8584, 149.237, 157.191);
    lightBluePath.close();

    Path darkBluePath = Path();
    darkBluePath.moveTo(405.962, 64.9734);
    darkBluePath.cubicTo(463.48, -13.2613, 527.361, 119.325, 527.361, 186.372);
    darkBluePath.cubicTo(527.361, 253.418, 473.009, 307.77, 405.962, 307.77);
    darkBluePath.cubicTo(338.916, 307.77, 275.716, 256.724, 284.564, 186.372);
    darkBluePath.cubicTo(293.413, 116.02, 348.445, 143.208, 405.962, 64.9734);
    darkBluePath.close();

    Paint lightBluePaint = Paint()
      ..color = const Color(0xFFF2F5FE)
      ..style = PaintingStyle.fill;

    Paint darkBluePaint = Paint()
      ..color = const Color(0xFF004BFE)
      ..style = PaintingStyle.fill;

    canvas.drawPath(lightBluePath, lightBluePaint);
    canvas.drawPath(darkBluePath, darkBluePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
