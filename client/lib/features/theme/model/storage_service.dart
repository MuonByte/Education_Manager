import 'package:hive_ce_flutter/hive_flutter.dart';

class StorageService {
  static const String _themeBox = 'themeBox';
  static const String _isDarkKey = 'isDark';
  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_themeBox);
  }
  Future<void> saveThemePreference(bool isDarkMode) async {
    final box = Hive.box(_themeBox);
    await box.put(_isDarkKey, isDarkMode);
  }
  Future<bool> getThemePreference() async {
    final box = Hive.box(_themeBox);
    return box.get(_isDarkKey, defaultValue: false);
  }
}