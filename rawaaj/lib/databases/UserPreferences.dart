import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String _keyUserId = 'user_id';
  static const String _isShop = 'is_shop';

  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyUserId, userId);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyUserId);
  }

  Future<void> removeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
  }

  Future<void> saveIsShop(bool isShop) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isShop, isShop);
  }

  Future<bool?> getIsShop() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isShop);
  }

  Future<void> removeIsShop() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_isShop);
  }
}
