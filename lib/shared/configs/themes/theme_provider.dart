import 'package:flutter/material.dart'
    show Brightness, ChangeNotifier, ThemeData, ThemeMode, WidgetsBinding;
import 'package:mymy_m1/utils/dependency_inj/get_it.dart' show getIt;
import 'package:mymy_m1/utils/logger/logger_tool.dart' show LoggerTool;
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;
import 'package:mymy_m1/shared/configs/themes/theme_collections.dart'
    show ThemeCollections;

class ThemeProvider with ChangeNotifier {
  final LoggerTool _loggerTool = getIt<LoggerTool>();
  ThemeMode _themeMode = ThemeMode.system;
  String _currentThemeName = 'original';
  late SharedPreferences _prefs;

  ThemeProvider() {
    loadFromPrefs();
  }

  List<String> get availableThemes => ThemeCollections.availableThemes;
  ThemeMode get themeMode => _themeMode;
  String get currentThemeName => _currentThemeName;

  ThemeData get lightTheme =>
      ThemeCollections.getThemeByName(_currentThemeName, isDark: false);
  ThemeData get darkTheme =>
      ThemeCollections.getThemeByName(_currentThemeName, isDark: true);

  Future<bool> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    await _saveToPrefs();
    return true;
  }

  Future<bool> setTheme(String themeName) async {
    if (availableThemes.contains(themeName)) {
      _currentThemeName = themeName;
      notifyListeners();
      await _saveToPrefs();
      return true;
    }
    return false;
  }

  Future<void> loadFromPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _themeMode =
        ThemeMode.values[_prefs.getInt('themeMode') ?? ThemeMode.system.index];
    _currentThemeName = _prefs.getString('themeName') ?? 'original';

    // Apply user preference before falling back to system default
    if (_themeMode == ThemeMode.system) {
      final brightness =
          WidgetsBinding.instance.platformDispatcher.platformBrightness;
      _themeMode =
          brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }

    notifyListeners();
  }

  Future<void> _saveToPrefs() async {
    await _prefs.setInt('themeMode', _themeMode.index);
    await _prefs.setString('themeName', _currentThemeName);
    _loggerTool.i(
        infoMsg:
            "\t New Prefs: Theme name: $_currentThemeName | Theme mode: ${ThemeMode.values[_prefs.getInt('themeMode') ?? ThemeMode.system.index].toString().split('.').last} ");
  }
}
