import 'package:rawaaj/services/user_account_service.dart';

Future<Map<String, dynamic>> getPassword(String username) async {
  final userAccountService =  UserAccountService();
  return userAccountService.getPasswordByUsername(username);
}