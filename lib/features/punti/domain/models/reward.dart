import 'package:flutter/material.dart';

/// Categoria premio
enum RewardCategory {
  voucher,
  ppe,
  gadget,
  other;

  String get label {
    switch (this) {
      case RewardCategory.voucher:
        return 'Buoni';
      case RewardCategory.ppe:
        return 'DPI';
      case RewardCategory.gadget:
        return 'Gadget';
      case RewardCategory.other:
        return 'Altro';
    }
  }

  String get labelEn {
    switch (this) {
      case RewardCategory.voucher:
        return 'Vouchers';
      case RewardCategory.ppe:
        return 'PPE';
      case RewardCategory.gadget:
        return 'Gadget';
      case RewardCategory.other:
        return 'Other';
    }
  }

  IconData get icon {
    switch (this) {
      case RewardCategory.voucher:
        return Icons.card_giftcard_rounded;
      case RewardCategory.ppe:
        return Icons.health_and_safety_rounded;
      case RewardCategory.gadget:
        return Icons.devices_other_rounded;
      case RewardCategory.other:
        return Icons.category_rounded;
    }
  }
}

/// Disponibilità premio
enum RewardAvailability {
  available,
  limited,
  outOfStock;

  String get label {
    switch (this) {
      case RewardAvailability.available:
        return 'Disponibile';
      case RewardAvailability.limited:
        return 'Limitato';
      case RewardAvailability.outOfStock:
        return 'Esaurito';
    }
  }

  String get labelEn {
    switch (this) {
      case RewardAvailability.available:
        return 'Available';
      case RewardAvailability.limited:
        return 'Limited';
      case RewardAvailability.outOfStock:
        return 'Out of Stock';
    }
  }

  Color get color {
    switch (this) {
      case RewardAvailability.available:
        return const Color(0xFF4CAF50);
      case RewardAvailability.limited:
        return const Color(0xFFFF9800);
      case RewardAvailability.outOfStock:
        return const Color(0xFF9E9E9E);
    }
  }
}

/// Premio riscattabile
class Reward {
  const Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.cost,
    required this.category,
    required this.availability,
    required this.icon,
    this.imageUrl,
    this.deliveryInfo,
  });

  final String id;
  final String name;
  final String description;
  final int cost;
  final RewardCategory category;
  final RewardAvailability availability;
  final String icon;
  final String? imageUrl;
  final String? deliveryInfo;

  bool canRedeem(int userPoints) =>
      userPoints >= cost && availability != RewardAvailability.outOfStock;

  /// Crea da JSON (risposta RPC get_rewards).
  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      cost: json['cost'] as int? ?? 0,
      category: _parseCategory(json['category'] as String?),
      availability: _parseAvailability(json['availability'] as String?),
      icon: json['icon'] as String? ?? '🎁',
      imageUrl: json['image_url'] as String?,
      deliveryInfo: json['delivery_info'] as String?,
    );
  }

  static RewardCategory _parseCategory(String? value) {
    if (value == null) return RewardCategory.other;
    return RewardCategory.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RewardCategory.other,
    );
  }

  static RewardAvailability _parseAvailability(String? value) {
    if (value == null) return RewardAvailability.available;
    return RewardAvailability.values.firstWhere(
      (e) => e.name == value,
      orElse: () => RewardAvailability.available,
    );
  }

  /// Mock data
  static List<Reward> mockRewards() {
    return const [
      Reward(
        id: 'reward_1',
        name: 'Buono Amazon 10€',
        description: 'Buono regalo Amazon del valore di 10€. '
            'Riceverai il codice via email entro 24 ore.',
        cost: 500,
        category: RewardCategory.voucher,
        availability: RewardAvailability.available,
        icon: '🎁',
        deliveryInfo: 'Codice via email',
      ),
      Reward(
        id: 'reward_2',
        name: 'Zaino lavoro Pro',
        description: 'Zaino professionale con scomparto laptop, '
            'tasche porta attrezzi e rinforzi anti-usura.',
        cost: 900,
        category: RewardCategory.gadget,
        availability: RewardAvailability.available,
        icon: '🎒',
        deliveryInfo: 'Ritiro in azienda',
      ),
      Reward(
        id: 'reward_3',
        name: 'Cuffie antirumore Pro',
        description: 'Cuffie professionali per ridurre il rumore sul lavoro, '
            'leggere e regolabili. Certificazione EN 352-1.',
        cost: 1200,
        category: RewardCategory.ppe,
        availability: RewardAvailability.limited,
        icon: '🎧',
        deliveryInfo: 'Ritiro in azienda',
      ),
      Reward(
        id: 'reward_4',
        name: 'T-shirt aziendale',
        description: 'T-shirt tecnica ad alta visibilità con logo aziendale. '
            'Materiale traspirante.',
        cost: 350,
        category: RewardCategory.gadget,
        availability: RewardAvailability.available,
        icon: '👕',
        deliveryInfo: 'Ritiro in azienda',
      ),
      Reward(
        id: 'reward_5',
        name: 'Borraccia termica',
        description: 'Borraccia in acciaio inox 500ml, mantiene la temperatura '
            'fino a 12 ore. Ideale per il lavoro.',
        cost: 250,
        category: RewardCategory.gadget,
        availability: RewardAvailability.available,
        icon: '🥤',
        deliveryInfo: 'Ritiro in azienda',
      ),
      Reward(
        id: 'reward_6',
        name: 'Buono carburante 20€',
        description: 'Buono carburante Q8/Eni del valore di 20€.',
        cost: 1000,
        category: RewardCategory.voucher,
        availability: RewardAvailability.available,
        icon: '⛽',
        deliveryInfo: 'Codice via email',
      ),
      Reward(
        id: 'reward_7',
        name: 'Guanti da lavoro premium',
        description: 'Guanti antitaglio certificati EN 388, '
            'grip superiore e comfort tutto il giorno.',
        cost: 400,
        category: RewardCategory.ppe,
        availability: RewardAvailability.available,
        icon: '🧤',
        deliveryInfo: 'Ritiro in azienda',
      ),
      Reward(
        id: 'reward_8',
        name: 'Power bank 10000mAh',
        description: 'Caricatore portatile resistente agli urti e alla polvere. '
            'Due porte USB.',
        cost: 600,
        category: RewardCategory.gadget,
        availability: RewardAvailability.limited,
        icon: '🔋',
        deliveryInfo: 'Ritiro in azienda',
      ),
    ];
  }
}
