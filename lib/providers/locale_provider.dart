import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleKey = 'locale';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Load persisted locale asynchronously; don't block the UI
    // ignore: discarded_futures
    _loadLocale();
    return const Locale('en');
  }

  Future<void> _loadLocale() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_kLocaleKey);
      if (code != null && code.isNotEmpty) {
        state = Locale(code);
      }
    } on Object catch (_) {
      // ignore and keep default
    }
  }

  void setLocale(Locale locale) {
    state = locale;
    // persist asynchronously; don't block the UI
    // ignore: discarded_futures
    _persistLocale(locale.languageCode);
  }

  Future<void> _persistLocale(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kLocaleKey, code);
    } on Object catch (_) {
      // ignore persistence errors
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
