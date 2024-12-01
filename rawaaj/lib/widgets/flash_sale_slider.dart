import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rawaaj/themes/colors.dart';

class FlashSaleSlider extends StatelessWidget {
  const FlashSaleSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> flashSaleItems = [
      {
        "name": "Item 1",
        "price": "2000 DZD",
        "discount": "-20%",
        "img": "https://via.placeholder.com/150"
      },
      {
        "name": "Item 2",
        "price": "3000 DZD",
        "discount": "-20%",
        "img": "https://via.placeholder.com/150"
      },
      {
        "name": "Item 3",
        "price": "4000 DZD",
        "discount": "-20%",
        "img": "https://via.placeholder.com/150"
      },
      {
        "name": "Item 4",
        "price": "5000 DZD",
        "discount": "-20%",
        "img": "https://via.placeholder.com/150"
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Flash Sale",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.watch_later_outlined,
                    color: primaryColor,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  buildTimeUnit("15"),
                  buildTimeUnit("15"),
                  buildTimeUnit("47"),
                ],
              )
            ],
          ),
          const SizedBox(height: 8),
          CarouselSlider(
            options: CarouselOptions(
              height: 320,
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 0.8,
            ),
            items: flashSaleItems.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          child: Center(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      item["img"],
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, bottom: 5.0),
                                child: Text(
                                  item["name"],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5.0, bottom: 5.0),
                                child: Text(
                                  item["price"],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )),
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

  Padding buildTimeUnit(String time) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFECECEC),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            time,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
