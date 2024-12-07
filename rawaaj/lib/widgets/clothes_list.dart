import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:rawaaj/databases/database_consts.dart';
import 'package:rawaaj/screens/porduct_screen.dart';

class ClothesList extends StatelessWidget {
  const ClothesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          "Clothes",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (context, index) => ClotheLine(
              context,
              4 + index,
              products[index+4].image,
              products[index+4].description + "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
              products[index+4].price),
        ),
      ],
    );
  }

  Widget ClotheLine(
      BuildContext context, int id, String img, String details, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductScreen(id: id),
              ));
        },
        child: SizedBox(
          height: 105,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                child: Container(
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4), // Shadow position
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      img,
                      width: 100, // Set a fixed width for the image
                      height: 100, // Set a fixed height for the image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: 120,
                right: 0,
                child: Text(
                  details,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 120,
                child: Text(
                  "$price DZD",
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Positioned(
                  right: 0,
                  bottom: 0,
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
