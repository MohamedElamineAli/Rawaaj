import 'package:flutter/material.dart';
import 'section_header.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> categories = ["Shirts", "Jackets", "Shoes", "Suits", "Jeans", "Sportsware"];
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
              return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2), // Shadow color
                        spreadRadius: 3, // How far the shadow spreads
                        blurRadius: 5, // How soft the shadow looks
                        // offset: const Offset(0, 3), // Offset in the x and y direction
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            categorieImg(),
                            categorieImg(),
                          ],
                        ),
                        Row(
                          children: [
                            categorieImg(),
                            categorieImg(),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(categories[index], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                              Container(
                                child: Text("564", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget categorieImg() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, top: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            'https://via.placeholder.com/150',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
