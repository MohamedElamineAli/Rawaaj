import 'package:flutter/material.dart';

class SaleBanner extends StatelessWidget {
  const SaleBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          color: Colors.yellow[700],
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 20,
                child: Text(
                  'Big Sale',
                  style: TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 30,
                child: Text(
                  'Up to 50%',
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 10,
                child: Text(
                  'Happening Now',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
