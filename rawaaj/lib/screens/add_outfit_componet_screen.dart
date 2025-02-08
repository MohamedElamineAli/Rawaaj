import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/grid_section.dart';
import 'package:rawaaj/widgets/header_bar.dart';
import 'package:rawaaj/widgets/select_grid_section.dart';

class AddOutfitComponent extends StatelessWidget {
  const AddOutfitComponent({super.key,});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: HeaderBar(title: "Add Outfit", isFiltered: true),
      body: SingleChildScrollView(
          child: SelectGridSection(title: "Select Component")
      ),
    );
  }
}
