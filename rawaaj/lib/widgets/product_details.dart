import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final double price;
  final String description;

  const ProductDetails({super.key, required this.price, required this.description});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 100,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$price DZD",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  elevation: 0,
                  backgroundColor: Colors.redAccent.withOpacity(0.1)
                ),
                onPressed: () {
                },
                child: Icon(Icons.share, size: 20, color: Colors.grey,),
              ),
            ],
          ),
          Text( description +
              ": Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
          )
        ],
      ),
    );
  }
}
