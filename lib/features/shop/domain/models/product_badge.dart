import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Badge speciale su un prodotto
enum ProductBadge {
  gratis,
  scontato,
  promo,
  none;

  String get label {
    switch (this) {
      case ProductBadge.gratis:
        return 'GRATIS';
      case ProductBadge.scontato:
        return 'SCONTATO';
      case ProductBadge.promo:
        return 'PROMO';
      case ProductBadge.none:
        return '';
    }
  }

  Color get color {
    switch (this) {
      case ProductBadge.gratis:
        return AppTheme.teal;
      case ProductBadge.scontato:
        return AppTheme.ambra;
      case ProductBadge.promo:
        return AppTheme.danger;
      case ProductBadge.none:
        return Colors.transparent;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case ProductBadge.gratis:
        return AppTheme.tealContainer;
      case ProductBadge.scontato:
        return AppTheme.ambraContainer;
      case ProductBadge.promo:
        return AppTheme.dangerContainer;
      case ProductBadge.none:
        return Colors.transparent;
    }
  }

  bool get isVisible => this != ProductBadge.none;
}
