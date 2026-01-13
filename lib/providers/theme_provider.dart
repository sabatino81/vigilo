import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kThemeKey = 'theme_mode';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    // Load persisted theme asynchronously; don't block the UI
    // ignore: discarded_futures
    _loadTheme();
    return ThemeMode.dark; // Default: dark theme
  }

  Future<void> _loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(_kThemeKey);
      if (stored != null) {
        switch (stored) {
          case 'light':
            state = ThemeMode.light;
          case 'dark':
            state = ThemeMode.dark;
          default:
            state = ThemeMode.system;
        }
      }
    } on Object catch (_) {}
  }

  void setThemeMode(ThemeMode mode) {
    state = mode;
    // Persist asynchronously; don't block the UI
    // ignore: discarded_futures
    _persistTheme(mode);
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
    } else {
      setThemeMode(ThemeMode.light);
    }
  }

  Future<void> _persistTheme(ThemeMode mode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String value;
      switch (mode) {
        case ThemeMode.light:
          value = 'light';
        case ThemeMode.dark:
          value = 'dark';
        case ThemeMode.system:
          value = 'system';
      }
      await prefs.setString(_kThemeKey, value);
    } on Object catch (_) {}
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
