import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/custom_chip.dart';

class ProductSpecifications extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<String> materials = ["Cotton 95%", "Nylon 5%"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Specifications",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text("Materials",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        SizedBox(height: 4),
        Row(
          children: [
            for (String s in materials)
              CustomChip(
                label: s,
                color: Colors.red.withOpacity(0.1),
                width: 8,
              ),
          ],
        ),
        buildSpecification(
            name: "Origin",
            label: "EU",
            color: Colors.blue.withOpacity(0.1),
            width: 16
        ),
        buildSpecification(
            name: "Size",
            label: "M",
            color: Colors.green.withOpacity(0.1),
            width: 16
        ),
        buildSpecification(
            name: "Color",
            label: "Light brown",
            color: Colors.grey.withOpacity(0.1),
            width: 4
        ),
      ],
    );
  }

  Widget buildSpecification({
    required String name,
    required String label,
    required Color color,
    required double width,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
        const SizedBox(height: 4),
        CustomChip(label: label, color: color, width: width)
      ],
    );
  }
}
