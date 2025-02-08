import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rawaaj/themes/colors.dart';
import 'package:rawaaj/widgets/circular_img.dart';
import 'package:rawaaj/widgets/save_button.dart';
import 'package:rawaaj/widgets/sub_screen_app_bar.dart';
import '../constants/default_cubit_product.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/text_field_widget.dart';

class ProfileInfoEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SubScreenAppBar(name: "Profile Edit"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Stack(
                children: [
                  CircularImg(img: mohamedImage, radius: 80),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
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
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded || state is ProfileUpdated) {
                    final username = state is ProfileLoaded
                        ? state.username
                        : (state as ProfileUpdated).username;
                    final email = state is ProfileLoaded
                        ? state.email
                        : (state as ProfileUpdated).email;
                    final password = state is ProfileLoaded
                        ? state.password
                        : (state as ProfileUpdated).password;

                    return Column(
                      children: [
                        CustomTextField(
                          label: 'Username',
                          hint: username,
                          hintColor: Colors.black,
                          onChanged: (value) {
                            context.read<ProfileCubit>().updateUsername(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Email',
                          hint: email,
                          hintColor: Colors.black,
                          onChanged: (value) {
                            context.read<ProfileCubit>().updateEmail(value);
                          },
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          label: 'Password',
                          hint: password,
                          hintColor: Colors.black,
                          onChanged: (value) {
                            context.read<ProfileCubit>().updatePassword(value);
                          },
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
              const SizedBox(height: 32),
              SaveButton(
                onPressed: context.read<ProfileCubit>().saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
