import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../modals/user_modal.dart';

class SharedPreferencesHelper {
  static const String keyUser = 'user';

  static Future<void> saveNameAndEmail(User userModal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyUser, jsonEncode(userModal.toJson()));
  }

  static Future<User?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString(keyUser);
    if (user != null) {
      return User.fromJson(jsonDecode(user));
    }
  }

  static Future<void> clearUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
