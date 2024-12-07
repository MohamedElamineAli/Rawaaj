import 'package:flutter/material.dart';
import 'package:rawaaj/themes/colors.dart';
import 'package:rawaaj/widgets/save_button.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../widgets/text_field_widget.dart';

class AddressEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubScreenAppBar(name: "Shipping Address"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Address',
                hint: "Required",
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Town / City',
                hint: "Required",
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Postcode',
                hint: "Required",
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Phone Number',
                hint: "Required",
              ),
              const SizedBox(height: 32),
              const SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
