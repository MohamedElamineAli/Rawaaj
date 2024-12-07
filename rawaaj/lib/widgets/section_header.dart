import 'package:flutter/material.dart';
import 'package:rawaaj/screens/categories_screen.dart';
import 'package:rawaaj/screens/reviews_screen.dart';
import 'package:rawaaj/screens/specific_shop_screen.dart';
import 'package:rawaaj/themes/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        TextButton(
            onPressed: () {
              switch (title) {
                case "Categories":
                  Navigator.push( context, MaterialPageRoute(builder: (context) => CategoriesScreen()), );
                  break;
                case "Rating & Reviews":
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ReviewsScreen()), );
                  break;
                case "Top Products":
                  Navigator.push( context, MaterialPageRoute(builder: (context) => SpecificShopScreen(name: "Top Products")), );
                  break;
                case "New Items":
                  Navigator.push( context, MaterialPageRoute(builder: (context) => SpecificShopScreen(name: "New Items")), );
                  break;
                case "Recently Viewed":
                  Navigator.push( context, MaterialPageRoute(builder: (context) => SpecificShopScreen(name: "Recently Viewed")), );
                  break;
                case "Just For You":
                  Navigator.push( context, MaterialPageRoute(builder: (context) => SpecificShopScreen(name: "Just For You")), );
                  break;
                default:
                  break;
              }
            },
            child: Row(
              children: [
                Text("See All", style: TextStyle(color: Colors.black, fontSize: 18),),
                SizedBox(width: 10,),
                Icon(Icons.arrow_circle_right_rounded, color: primaryColor, size: 36,),
              ],
            )
        ),
      ],
    );
  }
}
