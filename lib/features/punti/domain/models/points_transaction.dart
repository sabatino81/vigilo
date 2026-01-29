import 'package:flutter/material.dart';

/// Tipo di transazione punti
enum TransactionType {
  earned,
  spent,
  bonus,
  penalty;

  bool get isPositive => this == earned || this == bonus;

  Color get color {
    switch (this) {
      case TransactionType.earned:
        return const Color(0xFF4CAF50);
      case TransactionType.spent:
        return const Color(0xFFE53935);
      case TransactionType.bonus:
        return const Color(0xFFFFB300);
      case TransactionType.penalty:
        return const Color(0xFFE53935);
    }
  }

  IconData get icon {
    switch (this) {
      case TransactionType.earned:
        return Icons.add_circle_rounded;
      case TransactionType.spent:
        return Icons.remove_circle_rounded;
      case TransactionType.bonus:
        return Icons.stars_rounded;
      case TransactionType.penalty:
        return Icons.remove_circle_outline_rounded;
    }
  }
}

/// Transazione punti (movimento wallet)
class PointsTransaction {
  const PointsTransaction({
    required this.id,
    required this.amount,
    required this.description,
    required this.createdAt,
    required this.type,
    this.rewardId,
  });

  final String id;
  final int amount;
  final String description;
  final DateTime createdAt;
  final TransactionType type;
  final String? rewardId;

  /// Formatta l'importo con segno
  String get formattedAmount {
    final sign = type.isPositive ? '+' : '-';
    return '$sign${amount.abs()}';
  }

  /// Mock data
  static List<PointsTransaction> mockTransactions() {
    final now = DateTime.now();
    return [
      PointsTransaction(
        id: '1',
        amount: 50,
        description: 'Quiz settimanale',
        createdAt: now.subtract(const Duration(hours: 2)),
        type: TransactionType.earned,
      ),
      PointsTransaction(
        id: '2',
        amount: 30,
        description: 'Segnalazione sicurezza',
        createdAt: now.subtract(const Duration(hours: 5)),
        type: TransactionType.earned,
      ),
      PointsTransaction(
        id: '3',
        amount: 10,
        description: 'Micro-formazione',
        createdAt: now.subtract(const Duration(days: 1)),
        type: TransactionType.earned,
      ),
      PointsTransaction(
        id: '4',
        amount: 80,
        description: 'Buono Amazon 10€',
        createdAt: now.subtract(const Duration(days: 2)),
        type: TransactionType.spent,
        rewardId: 'reward_1',
      ),
      PointsTransaction(
        id: '5',
        amount: 100,
        description: 'Bonus Gira la Ruota',
        createdAt: now.subtract(const Duration(days: 3)),
        type: TransactionType.bonus,
      ),
      PointsTransaction(
        id: '6',
        amount: 20,
        description: 'Sondaggio completato',
        createdAt: now.subtract(const Duration(days: 4)),
        type: TransactionType.earned,
      ),
    ];
  }
}
