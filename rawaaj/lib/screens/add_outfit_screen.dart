import 'package:flutter/material.dart';
import 'package:rawaaj/widgets/save_button.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../widgets/image_upload_widget.dart';
import '../widgets/description_input_widget.dart';
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
              const ImageUploadWidget(),
              const SizedBox(height: 20),

              const CustomTextField(label: "Description",),
        
              const SizedBox(height: 20),
        
              const Text(
                "Add Outfit Components",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              OutfitComponents(),
              const SizedBox(height: 10),
              SaveButton()
            ],
          ),
        ),
      ),
    );
  }
}
