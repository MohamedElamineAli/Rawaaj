part of 'create_account_cubit.dart';

class CreateAccountState {
  final bool isPasswordVisible;
  final String image;
  final String phoneNumber;
  final String username;
  final String email;
  final String password;
  final bool isShop;
  final bool serviceEnabled;
  final String? shopName;
  final double? longitude;
  final double? latitude;


  CreateAccountState({
    this.image = '',
    required this.isPasswordVisible,
    this.phoneNumber = '',
    this.username = '',
    this.email = '',
    this.password = '',
    required this.isShop,
    this.shopName,
    required this.serviceEnabled,
    this.longitude,
    this.latitude,
  });

  CreateAccountState copyWith({
    String? image,
    bool? isPasswordVisible,
    String? phoneNumber,
    String? username,
    String? email,
    String? password,
    bool? isShop,
    bool? serviceEnabled,
    String? shopName,
    double? longitude,
    double? latitude,
  }) {
    return CreateAccountState(
      image: image ?? this.image,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isShop: isShop ?? this.isShop,
      serviceEnabled: serviceEnabled ?? this.serviceEnabled,
      shopName: shopName ?? this.shopName,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

}
