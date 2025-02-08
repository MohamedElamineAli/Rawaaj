import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/add_floating_btn.dart';
import 'package:rawaaj/widgets/header_bar.dart';
import 'package:rawaaj/widgets/outfit_card.dart';
import '../cubit/outfits_cubit.dart';
import '../models/summarized_outfit_model.dart';

class OutfitsScreen extends StatelessWidget {
  const OutfitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OutfitsCubit>().fetchOutfits();

    return Scaffold(
      floatingActionButton: AddFloatingBtn(isProduct: false),
      backgroundColor: Colors.white,
      appBar: HeaderBar(
        title: "Outfits",
        isFiltered: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocSelector<OutfitsCubit, OutfitsState, List<SummarizedOutfit>>(
          selector: (state) {
            if (state is OutfitsList) {
              return state.outfitsMap['all'] ?? [];
            }
            return [];
          },
          builder: (context, outfits) {
            if (outfits.isEmpty) {
              return const Center(
                child: Text("No outfits available"),
              );
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 8,
                childAspectRatio: 0.6,
              ),
              itemCount: min(outfits.length, 6),
              itemBuilder: (context, index) {
                return OutfitCard(
                  index: index,
                  id: outfits[index].id,
                  img: outfits[index].outfitImage,
                  price: outfits[index].totalPrice,
                  // isLiked: outfits[index].isLiked,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
