import 'package:flutter/material.dart';

class BackgroundBlob extends StatelessWidget {
  const BackgroundBlob({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: CustomPaint(
        painter: SignUpBlobPainter(),
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