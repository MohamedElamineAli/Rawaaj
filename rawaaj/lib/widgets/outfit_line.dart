import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/outfits_cubit.dart';
import '../models/summarized_outfit_model.dart';
import '../screens/outfit_detail_screen.dart';

class OutfitLine extends StatelessWidget {
  final String title; // "Outfits" -> depends on .isLiked of "all" contextType, "Recently Viewed Outfits" -> depends on "history" contextType

  const OutfitLine({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    if (title == "Outfits") {
      context.read<OutfitsCubit>().fetchOutfitsByContextType('isLiked');
    } else if (title == "Recently Viewed Outfits") {
      context.read<OutfitsCubit>().fetchOutfitsByContextType('history');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        BlocSelector<OutfitsCubit, OutfitsState, List<SummarizedOutfit>>(
          selector: (state) {
            if (state is OutfitsList) {
              if (title == "Outfits") {
                return state.outfitsMap['isLiked'] ?? [];
              } else if (title == "Recently Viewed Outfits") {
                return state.outfitsMap['history'] ?? [];
              }
            }
            return [];
          },
          builder: (context, outfits) {
            if (outfits.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: outfits.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                OutfitDetailScreen(id: outfits[index].id),
                          ),
                        );
                      },
                      child: SizedBox(
                        width: 120,
                        child: wishlistCard(outfits[index].outfitImage),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget wishlistCard(File img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: Image.file(
        img,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
