import 'package:flutter/material.dart';
import 'section_header.dart';

class HorizontalListSection extends StatelessWidget {
  final String title;
  final int itemsCount;

  const HorizontalListSection({Key? key, required this.title, required this.itemsCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: title),
          const SizedBox(height: 8),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: itemsCount,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.image, size: 50),
                      const SizedBox(height: 4),
                      Text("Item ${index + 1}"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
