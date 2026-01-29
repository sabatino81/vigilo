import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Tipo di wallet nel sistema duale Vigilo
enum WalletType {
  elmetto,
  welfare;

  String get label {
    switch (this) {
      case WalletType.elmetto:
        return 'Punti Elmetto';
      case WalletType.welfare:
        return 'Punti Welfare';
    }
  }

  String get labelEn {
    switch (this) {
      case WalletType.elmetto:
        return 'Helmet Points';
      case WalletType.welfare:
        return 'Welfare Points';
    }
  }

  String get shortLabel {
    switch (this) {
      case WalletType.elmetto:
        return 'Elmetto';
      case WalletType.welfare:
        return 'Welfare';
    }
  }

  Color get color {
    switch (this) {
      case WalletType.elmetto:
        return AppTheme.ambra;
      case WalletType.welfare:
        return AppTheme.teal;
    }
  }

  Color get colorDark {
    switch (this) {
      case WalletType.elmetto:
        return AppTheme.ambraDark;
      case WalletType.welfare:
        return AppTheme.tealDark;
    }
  }

  Color get containerColor {
    switch (this) {
      case WalletType.elmetto:
        return AppTheme.ambraContainer;
      case WalletType.welfare:
        return AppTheme.tealContainer;
    }
  }

  IconData get icon {
    switch (this) {
      case WalletType.elmetto:
        return Icons.construction_rounded;
      case WalletType.welfare:
        return Icons.favorite_rounded;
    }
  }

  String get description {
    switch (this) {
      case WalletType.elmetto:
        return 'Punti guadagnati con comportamenti sicuri';
      case WalletType.welfare:
        return 'Budget welfare aziendale';
    }
  }

  String get descriptionEn {
    switch (this) {
      case WalletType.elmetto:
        return 'Points earned through safe behaviors';
      case WalletType.welfare:
        return 'Company welfare budget';
    }
  }
}
