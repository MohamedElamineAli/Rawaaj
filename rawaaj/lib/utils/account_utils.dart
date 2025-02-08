import '../databases/UserPreferences.dart';

class AccountUtils {
  static final UserPreferences _userPreferences = UserPreferences();

  static Future<bool> isLoggedIn() async {
    final userId = await _userPreferences.getUserId();
    return userId != null;
  }

  static Future<int?> getUserId() async {
    return await _userPreferences.getUserId();
  }

  static Future<bool?> isShop() async {
    return await _userPreferences.getIsShop();
  }

  static Future<void> saveUserIdAndIsShop(int userId, bool isShop) async {
    await _userPreferences.saveUserId(userId);
    await _userPreferences.saveIsShop(isShop);
  }
}
