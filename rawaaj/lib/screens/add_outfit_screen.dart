import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/widgets/save_button.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../cubit/add_outfit_cubit.dart';
import '../widgets/image_upload_widget.dart';
import '../widgets/outfit_components.dart';
import '../widgets/text_field_widget.dart';

class AddOutfitScreen extends StatelessWidget {
  const AddOutfitScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: SubScreenAppBar(name: "Add Outfit"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AddOutfitCubit, AddOutfitState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ImageUploadWidget(),
                      if (state.outfit.outfitImage.path.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Please upload an image.",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              BlocBuilder<AddOutfitCubit, AddOutfitState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextField(
                        label: "Description",
                        hint: "Enter outfit description",
                        onChanged: (value) {
                          context.read<AddOutfitCubit>().updateDescription(value);
                        },
                      ),
                      if (state.outfit.description.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Description cannot be empty.",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 20),

              const Text(
                "Add Outfit Components",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),

              BlocBuilder<AddOutfitCubit, AddOutfitState>(
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const OutfitComponents(),
                      if (state.outfit.outfitComponents == null || state.outfit.outfitComponents!.length < 2)
                        const Padding(
                          padding: EdgeInsets.only(top: 5),
                          child: Text(
                            "Please add at least 2 components.",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 10),

              BlocBuilder<AddOutfitCubit, AddOutfitState>(
                builder: (context, state) {
                  return SaveButton(
                    isLoading: state.isLoading,
                    onPressed: () async {
                      final cubit = context.read<AddOutfitCubit>();
                      if (cubit.canAddOutfit()) {
                        final isOutfitAdded = await cubit.addOutfit();
                        if (isOutfitAdded) {
                          Navigator.pop(context);
                        }
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
