import 'package:flutter/material.dart';

/// Categoria prodotto ecommerce
enum ProductCategory {
  casa,
  abbigliamento,
  tech,
  consumabili,
  sport,
  voucher;

  String get label {
    switch (this) {
      case ProductCategory.casa:
        return 'Casa';
      case ProductCategory.abbigliamento:
        return 'Abbigliamento';
      case ProductCategory.tech:
        return 'Tech';
      case ProductCategory.consumabili:
        return 'Consumabili';
      case ProductCategory.sport:
        return 'Sport';
      case ProductCategory.voucher:
        return 'Voucher';
    }
  }

  String get labelEn {
    switch (this) {
      case ProductCategory.casa:
        return 'Home';
      case ProductCategory.abbigliamento:
        return 'Clothing';
      case ProductCategory.tech:
        return 'Tech';
      case ProductCategory.consumabili:
        return 'Consumables';
      case ProductCategory.sport:
        return 'Sport';
      case ProductCategory.voucher:
        return 'Vouchers';
    }
  }

  IconData get icon {
    switch (this) {
      case ProductCategory.casa:
        return Icons.home_rounded;
      case ProductCategory.abbigliamento:
        return Icons.checkroom_rounded;
      case ProductCategory.tech:
        return Icons.devices_rounded;
      case ProductCategory.consumabili:
        return Icons.local_grocery_store_rounded;
      case ProductCategory.sport:
        return Icons.fitness_center_rounded;
      case ProductCategory.voucher:
        return Icons.card_giftcard_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ProductCategory.casa:
        return const Color(0xFF8D6E63);
      case ProductCategory.abbigliamento:
        return const Color(0xFFAB47BC);
      case ProductCategory.tech:
        return const Color(0xFF42A5F5);
      case ProductCategory.consumabili:
        return const Color(0xFF66BB6A);
      case ProductCategory.sport:
        return const Color(0xFFEF5350);
      case ProductCategory.voucher:
        return const Color(0xFFFFB300);
    }
  }

  String get emoji {
    switch (this) {
      case ProductCategory.casa:
        return '🏠';
      case ProductCategory.abbigliamento:
        return '👕';
      case ProductCategory.tech:
        return '💻';
      case ProductCategory.consumabili:
        return '🛒';
      case ProductCategory.sport:
        return '⚽';
      case ProductCategory.voucher:
        return '🎁';
    }
  }
}
