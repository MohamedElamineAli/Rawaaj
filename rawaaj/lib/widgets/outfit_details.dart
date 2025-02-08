import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/outfit_cubit.dart';
import '../cubit/outfits_cubit.dart';

class OutfitDetails extends StatelessWidget {
  final int id;
  final File img;
  final double price;
  final int likesNum;
  final String details;

  const OutfitDetails({
    super.key,
    required this.id,
    required this.img,
    required this.price,
    required this.details,
    required this.likesNum,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.file(
              img,
              width: 300,
              height: 500,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${price.toStringAsFixed(2)} DZD",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  Text(
                    "$likesNum",
                    style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(width: 4),
                  BlocBuilder<OutfitCubit, OutfitState>(
                    builder: (context, state) {
                      bool currentIsLiked = false;

                      if (state is OutfitLoaded) {
                        currentIsLiked = state.outfit.isLiked;
                      }

                      return GestureDetector(
                        onTap: () {
                          final outfitCubit = context.read<OutfitCubit>();
                          outfitCubit.toggleOutfitLike(id);
                          context.read<OutfitsCubit>().toggleOutfitLikeWithoutDB(id);
                        },
                        child: Icon(
                          currentIsLiked
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 28,
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        SizedBox(
          child: Text(
            details,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          width: double.infinity,
        ),
      ],
    );
  }
}
