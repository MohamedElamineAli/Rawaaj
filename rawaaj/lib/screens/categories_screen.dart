import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> clothingCategories = [
      'Tops',
      'Bottoms',
      'Dresses',
      'Outerwear',
      'Accessories',
      'Footwear',
      'Activewear',
      'Sleepwear',
      'Formalwear',
      'Loungewear',
      'Workwear',
      'Sportswear',
      'Traditional Clothing',
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "All Categorie"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
            itemCount: clothingCategories.length,
            itemBuilder: (context, index) {
              return CategorieTile(
                  "assets/images/grey.png", clothingCategories[index]);
            }),
      ),
    );
  }

  Padding CategorieTile(String imgUrl, String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4), // Shadow position
            ),
          ],
        ),
        height: 48,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: Image.asset(
                  imgUrl,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
