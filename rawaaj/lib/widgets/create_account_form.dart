import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../cubit/create_account_cubit.dart';
import '../screens/login_screen.dart';
import '../screens/main_screen.dart';

class CreateAccountForm extends StatelessWidget {
  final bool isShopAccount;

  const CreateAccountForm({super.key, required this.isShopAccount});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cubit = context.read<CreateAccountCubit>();
    final formKey = GlobalKey<FormState>();
    if (isShopAccount) {
      cubit.updateCoordination();
      cubit.toggleIsShop();
    }

    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: cubit.updateUsername,
            validator: (value) => cubit.validateUsername(value ?? ''),
            decoration: InputDecoration(
              hintText: 'Username',
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          Visibility(
              visible: isShopAccount,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  TextFormField(
                    onChanged: cubit.updateShopName,
                    validator: (value) => cubit.validateShopName(value ?? ''),
                    decoration: InputDecoration(
                      hintText: 'Shop Name',
                      filled: true,
                      fillColor: const Color(0xFFF5F5F5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 12),
          TextFormField(
            onChanged: cubit.updateEmail,
            validator: (value) => cubit.validateEmail(value ?? ''),
            decoration: InputDecoration(
              hintText: 'Email',
              filled: true,
              fillColor: const Color(0xFFF5F5F5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
          const SizedBox(height: 12),
          BlocBuilder<CreateAccountCubit, CreateAccountState>(
            builder: (context, state) {
              return TextFormField(
                obscureText: !cubit.state.isPasswordVisible,
                onChanged: cubit.updatePassword,
                validator: (value) => cubit.validatePassword(value ?? ''),
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  suffixIcon: IconButton(
                    icon: Icon(
                      cubit.state.isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onPressed: cubit.togglePasswordVisibility,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(18),
            ),
            child: InternationalPhoneNumberInput(
              onInputChanged: (phoneNumber) =>
                  cubit.updatePhoneNumber(phoneNumber.phoneNumber ?? ''),
              validator: (value) => cubit.validatePhoneNumber(value ?? ''),
              initialValue: PhoneNumber(
                isoCode: 'DZ',
                phoneNumber: '',
                dialCode: '+213',
              ),
              countries: const ['DZ'],
              // Only allow Algeria
              selectorConfig: const SelectorConfig(
                selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                setSelectorButtonAsPrefixIcon: true,
                leadingPadding: 16,
                useEmoji: false,
                showFlags: true,
              ),
              spaceBetweenSelectorAndTextField: 0,
              ignoreBlank: false,
              autoValidateMode: AutovalidateMode.disabled,
              formatInput: true,
              selectorTextStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              textStyle: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
              inputDecoration: InputDecoration(
                hintText: 'Phone Number',
                border: InputBorder.none,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: isShopAccount ? screenWidth - 105 : screenWidth - 48,
                height: 48,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState?.validate() ?? false) {
                      final bool isUserCreated;
                      if(isShopAccount) {
                        if(!cubit.state.serviceEnabled) {
                          return;
                        }
                        isUserCreated = await cubit.createShopAccount();
                      } else {
                        isUserCreated = await cubit.createUserAccount();
                      }
                      if (isUserCreated) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainScreen()),
                              (Route<dynamic> route) => false, // This removes all previous routes
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF004BFE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Visibility(
                  visible: isShopAccount,
                  child: BlocBuilder<CreateAccountCubit, CreateAccountState>(
                    builder: (context, state) {
                      return SizedBox(
                          height: 48,
                          width: 48,
                          child: Container(
                            decoration: BoxDecoration(
                                color: state.serviceEnabled
                                    ? Colors.green
                                    : Colors.red,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 30,
                            ),
                          ));
                    },
                  ))
            ],
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
