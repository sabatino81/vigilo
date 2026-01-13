import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

const _kSettingsBox = 'settings';
const _kThemeKey = 'theme_mode';

class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    try {
      final box = Hive.isBoxOpen(_kSettingsBox)
          ? Hive.box<dynamic>(_kSettingsBox)
          : null;
      final stored = box?.get(_kThemeKey) as String?;
      if (stored != null) {
        switch (stored) {
          case 'light':
            return ThemeMode.light;
          case 'dark':
            return ThemeMode.dark;
          default:
            return ThemeMode.system;
        }
      }
    } on Object catch (_) {}
    return ThemeMode.dark; // Default: dark theme
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
      final box = Hive.isBoxOpen(_kSettingsBox)
          ? Hive.box<dynamic>(_kSettingsBox)
          : await Hive.openBox<dynamic>(_kSettingsBox);
      String value;
      switch (mode) {
        case ThemeMode.light:
          value = 'light';
        case ThemeMode.dark:
          value = 'dark';
        case ThemeMode.system:
          value = 'system';
      }
      await box.put(_kThemeKey, value);
    } on Object catch (_) {}
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
