import 'package:flutter/material.dart';
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
            onPressed: () {},
            child: Row(
              children: [
                Text("See All", style: TextStyle(color: Colors.black, fontSize: 18),),
                SizedBox(width: 10,),
                Icon(Icons.arrow_circle_right_rounded, color: primaryColor, size: 36,)
              ],
            )
        ),
      ],
    );
  }
}
