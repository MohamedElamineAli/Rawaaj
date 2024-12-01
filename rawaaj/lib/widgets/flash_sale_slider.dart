import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class FlashSaleSlider extends StatelessWidget {
  const FlashSaleSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> flashSaleItems = [
      {"name": "Item 1", "price": "2000 DZD", "discount": "-20%"},
      {"name": "Item 2", "price": "3000 DZD", "discount": "-20%"},
      {"name": "Item 3", "price": "4000 DZD", "discount": "-20%"},
      {"name": "Item 4", "price": "5000 DZD", "discount": "-20%"},
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Flash Sale",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          CarouselSlider(
            options: CarouselOptions(
              height: 250,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
            ),
            items: flashSaleItems.map((item) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  color: Colors.grey[200],
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.image, size: 100),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            item["discount"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["name"],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item["price"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
