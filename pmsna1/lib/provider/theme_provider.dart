import 'package:flutter/material.dart';
import 'package:flutter_application_1/settings/styles_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData? _themeData;

  ThemeProvider(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      final themeName = prefs.getString('theme');
      if (themeName != null) {
        setThemeData(themeName, context);
      }
    });
  }

  getThemeData() => this._themeData;

  Future<void> setThemeData(String? themeName, BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    switch (themeName) {
      case 'dark':
        _themeData = StylesSettings.darkTheme(context);
        await sharedPreferences.setString('theme', 'dark');
        break;
      case 'light':
        _themeData = StylesSettings.lightTheme(context);
        await sharedPreferences.setString('theme', 'light');
        break;
      case 'chill':
        _themeData = StylesSettings.chillTheme(context);
        await sharedPreferences.setString('theme', 'chill');
        break;
      default:
        _themeData = StylesSettings.lightTheme(context);
        await sharedPreferences.setString('theme', 'light');
        break;
    }

    notifyListeners();
  }
}
