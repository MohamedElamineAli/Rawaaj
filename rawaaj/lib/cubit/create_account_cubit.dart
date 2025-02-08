import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rawaaj/databases/UserPreferences.dart';
import 'package:rawaaj/services/user_account_service.dart';

part 'create_account_state.dart';

class CreateAccountCubit extends Cubit<CreateAccountState> {
  CreateAccountCubit()
      : super(CreateAccountState(
            isPasswordVisible: false, isShop: false, serviceEnabled: false));

  void updateImage(String image) {
    emit(state.copyWith(image: image));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleIsShop() {
    emit(state.copyWith(isShop: true));
  }

  void updatePhoneNumber(String phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void updateUsername(String username) {
    emit(state.copyWith(username: username));
  }

  void updateEmail(String email) {
    emit(state.copyWith(email: email));
  }

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  void updateShopName(String shopName) {
    emit(state.copyWith(shopName: shopName));
  }

  Future<void> updateCoordination() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    emit(state.copyWith(serviceEnabled: true));

    Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(
            accuracy: LocationAccuracy.high,
            distanceFilter: 100
        )
    );

    emit(state.copyWith(
        longitude: position.longitude,
        latitude: position.latitude
    ));
  }

  String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  String? validateEmail(String email) {
    if (email.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  String? validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Phone number cannot be empty';
    }
    if (phoneNumber.length < 9) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validateShopName(String shopName) {
    if (shopName.isEmpty) {
      return 'Username cannot be empty';
    }
    return null;
  }

  Future<bool> createUserAccount() async {
    final userAccountService = UserAccountService();
    final isUserTaken =
        await userAccountService.isUsernameTaken(state.username);

    if (isUserTaken) {
      print('user is taken');
      return false;
    }

    final userId = await userAccountService.addUserAccount(
      username: state.username,
      email: state.email,
      password: state.password,
      userImage: File(state.image),
      phoneNumber: state.phoneNumber,
    );

    if(userId == null) {
      return false;
    }

    final userPreferences = UserPreferences();
    userPreferences.saveUserId(userId);
    userPreferences.saveIsShop(false);

    return true;
  }

  Future<bool> createShopAccount() async {
    final userAccountService = UserAccountService();
    final isUserTaken =
        await userAccountService.isUsernameTaken(state.username);

    if(state.latitude == null || state.longitude == null || state.shopName == null ) {
      return false;
    }

    if (isUserTaken) {
      print('user is taken');
      return false;
    }

    final userId = await userAccountService.addShopAccount(
      username: state.username,
      email: state.email,
      password: state.password,
      userImage: File(state.image),
      latitude: state.latitude!,
      longitude: state.longitude!,
      shopName: state.shopName!,
      phoneNumber: state.phoneNumber,
    );

    if(userId == null) {
      return false;
    }

    final userPreferences = UserPreferences();
    userPreferences.saveUserId(userId);
    userPreferences.saveIsShop(true);

    return true;
  }
}
