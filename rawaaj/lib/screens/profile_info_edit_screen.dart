import 'package:flutter/material.dart';
import 'package:rawaaj/themes/colors.dart';
import 'package:rawaaj/widgets/circular_img.dart';
import 'package:rawaaj/widgets/save_button.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../widgets/text_field_widget.dart';

class ProfileInfoEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubScreenAppBar(name: "Profile Your Edit"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Stack(
                children: [
                  CircularImg(img: "assets/images/mohamed.png", radius: 80,),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.edit,
                            color: primaryColor,
                          ),
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 32),
              const CustomTextField(
                label: 'Username',
                hint: "Mohamed",
                hintColor: Colors.black,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Email',
                hint: "Mohamed@example.com",
                hintColor: Colors.black,
              ),
              const SizedBox(height: 16),
              const CustomTextField(
                label: 'Password',
                hint: "**********",
                hintColor: Colors.black,
              ),
              SizedBox(height: 32,),
              const SaveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
