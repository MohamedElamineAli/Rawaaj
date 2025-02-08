import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/horizontal_list.dart';
import 'package:rawaaj/widgets/outfit_line.dart';

import '../cubit/outfit_cubit.dart';
import '../widgets/outfit_details.dart';

class OutfitDetailScreen extends StatelessWidget {
  final int id;

  const OutfitDetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    context.read<OutfitCubit>().fetchOutfitById(id);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: BlocBuilder<OutfitCubit, OutfitState>(
              builder: (context, state) {
                if (state is OutfitLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OutfitLoaded) {
                  final outfit = state.outfit;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 24.0,
                        horizontal: 12,
                      ),
                      child: Column(
                        children: [
                          OutfitDetails(
                            id: outfit.id,
                            img: outfit.outfitImage,
                            price: outfit.totalPrice,
                            details: outfit.description +
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor",
                            likesNum: outfit.numOfLikes,
                          ),
                          HorizontalListSection(
                            title: "Outfit Components",
                            itemsCount: 5,
                            padding: 0,
                          ),
                          const OutfitLine(title: "Related Outfits"),
                        ],
                      ),
                    ),
                  );
                } else if (state is OutfitError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  );
                }
                return const Center(
                  child: Text("Select an outfit to view details."),
                );
              },
            ),
          ),
          Positioned(
              left: 0,
              top: 20,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios_new_rounded)))
        ],
      ),
    );
  }
}
