import 'package:shared_preferences/shared_preferences.dart';

class PrefsUtil {
  static late SharedPreferences _prefs;
  static const String _kFirstTimeUser = 'isFirstTimeUser';

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static bool get isFirstTimeUser {
    // Default to true if not set
    return _prefs.getBool(_kFirstTimeUser) ?? true;
  }

  static Future<void> setFirstTimeUser(bool value) async {
    await _prefs.setBool(_kFirstTimeUser, value);
  }
}
