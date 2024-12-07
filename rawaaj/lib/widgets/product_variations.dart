import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/section_header.dart';

class ProductVariations extends StatelessWidget {
  final List<String> variations;

  const ProductVariations({super.key, required this.variations});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: "Variations"),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: (context, index) {
              return SizedBox(
                width: 130,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: Image.asset( variations[index], fit: BoxFit.cover, ),
                  ),
                )
              );
            },
          ),
        ),
        const SizedBox(height: 20,)
      ],
    );
  }
}
