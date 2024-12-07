import 'package:flutter/material.dart';
import 'package:rawaaj/screens/add_product_screen.dart';
import '../screens/add_outfit_screen.dart';

class AddFloatingBtn extends StatelessWidget {
  final bool isProduct;

  const AddFloatingBtn({super.key, required this.isProduct});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push( context, MaterialPageRoute(builder: (context) => isProduct ? AddProductScreen() : AddOutfitScreen()), );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Icon(Icons.add, size: 35,),
        ),
      ),
    );
  }
}
