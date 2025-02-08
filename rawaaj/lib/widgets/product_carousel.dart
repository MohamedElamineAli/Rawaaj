import 'dart:io';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductCarousel extends StatefulWidget {
  final List<File> imgs;

  const ProductCarousel({super.key, required this.imgs});

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
                itemCount: widget.imgs.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    widget.imgs[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Visibility(
                visible: widget.imgs.length > 1,
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: widget.imgs.length, // Replace with dynamic list count
                  effect: WormEffect(
                    dotHeight: 12.0,
                    dotWidth: 12.0,
                    activeDotColor: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
