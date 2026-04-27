import 'package:shared_preferences/shared_preferences.dart';

class PrefsService {
  static SharedPreferences? _prefs;

  // 🔹 Initialize
  static Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception("Prefs initialization failed: $e");
    }
  }

  // 🔹 Safety getter
  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception("Prefs not initialized. Call PrefsService.init()");
    }
    return _prefs!;
  }

  static Future<void> saveThemeMode(String mode) async {
    try {
      await prefs.setString('themeMode', mode);
    } catch (e) {
      throw Exception("Failed to save theme: $e");
    }
  }

  static String getThemeMode() {
    return prefs.getString('themeMode') ?? 'system';
  }
}