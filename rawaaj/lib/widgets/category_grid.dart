import 'package:flutter/material.dart';
import '../screens/specific_shop_screen.dart';
import 'section_header.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Shirts",
      "Jackets",
      "Shoes",
      "Suits",
      "Jeans",
      "Sportswear"
    ];

    List<String> categoriesImg = [
      "assets/images/shirt ",
      "assets/images/jacket ",
      "assets/images/shoe ",
      "assets/images/suit ",
      "assets/images/jean ",
      "assets/images/sportwear "
    ];

    List<String> categoriesImgsExe = [
      "webp",
      "webp",
      "webp",
      "jpg",
      "jpg",
      "webp"
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SectionHeader(title: "Categories"),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.87,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => SpecificShopScreen(name: categories[index])), );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        spreadRadius: 3, // How far the shadow spreads
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 0.5,
                              mainAxisSpacing: 0.5,
                            ),
                            itemCount: 4,
                            itemBuilder: (context, index2) {
                              print(categoriesImg[index] + "($index2)." + categoriesImgsExe[index]);
                              return categoryImg(categoriesImg[index] + "(${index2 + 1})." + categoriesImgsExe[index]);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                categories[index],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Container(
                                child: Text("564",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget categoryImg(String img) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, top: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.asset(
            img,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
