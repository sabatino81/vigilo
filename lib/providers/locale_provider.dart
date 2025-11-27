import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

const _kSettingsBox = 'settings';
const _kLocaleKey = 'locale';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    // Read persisted locale from Hive if available
    try {
      final box = Hive.isBoxOpen(_kSettingsBox)
          ? Hive.box<dynamic>(_kSettingsBox)
          : null;
      final stored = box?.get(_kLocaleKey) as String?;
      if (stored != null && stored.isNotEmpty) {
        final parts = stored.split('-');
        return Locale(parts[0]);
      }
    } on Object catch (_) {
      // ignore and fallback to default
    }
    return const Locale('en');
  }

  void setLocale(Locale locale) {
    state = locale;
    // persist asynchronously; don't block the UI
    // ignore: discarded_futures
    _persistLocale(locale.languageCode);
  }

  Future<void> _persistLocale(String code) async {
    try {
      final box = Hive.isBoxOpen(_kSettingsBox)
          ? Hive.box<dynamic>(_kSettingsBox)
          : await Hive.openBox<dynamic>(_kSettingsBox);
      await box.put(_kLocaleKey, code);
    } on Object catch (_) {
      // ignore persistence errors
    }
  }
}

final localeProvider = NotifierProvider<LocaleNotifier, Locale>(
  LocaleNotifier.new,
);
