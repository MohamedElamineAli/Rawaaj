import 'package:flutter/material.dart';
import 'package:rawaaj/databases/database_consts.dart';
import 'package:rawaaj/screens/outfit_detail_screen.dart';

class OutfitLine extends StatelessWidget {
  final String title;
  const OutfitLine({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8,),
        Text(title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 8,),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push( context, MaterialPageRoute(builder: (context) => OutfitDetailScreen(id: index)), );
                  },
                  child: SizedBox(
                      width: 120,
                      child: wishlistCard(outfits[index].outfitImage)
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }


  Widget wishlistCard(String img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.asset(
        img,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
