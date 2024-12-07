import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCarousel extends StatefulWidget {
  final String img;

  const ProductCarousel({super.key, required this.img});

  @override
  _ProductCarouselState createState() => _ProductCarouselState();
}

class _ProductCarouselState extends State<ProductCarousel> {
  final PageController _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          Positioned.fill(
            child: PageView.builder(
                controller: _controller,
                itemCount: 5, // Replace with dynamic list count
                itemBuilder: (context, index) {
                  return Image.asset(
                    widget.img,
                    fit: BoxFit.cover,
                  );
                },
              ),
          ),// Space between the PageView and the indicators
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: 5, // Replace with dynamic list count
                effect: WormEffect(
                  dotHeight: 12.0,
                  dotWidth: 12.0,
                  activeDotColor: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
