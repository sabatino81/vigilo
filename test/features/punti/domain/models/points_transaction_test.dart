import 'package:test/test.dart';
import 'package:vigilo/features/punti/domain/models/points_transaction.dart';

void main() {
  group('TransactionType.isPositive', () {
    test('earned is positive', () {
      expect(TransactionType.earned.isPositive, isTrue);
    });

    test('bonus is positive', () {
      expect(TransactionType.bonus.isPositive, isTrue);
    });

    test('spent is not positive', () {
      expect(TransactionType.spent.isPositive, isFalse);
    });

    test('penalty is not positive', () {
      expect(TransactionType.penalty.isPositive, isFalse);
    });
  });

  group('PointsTransaction.formattedAmount', () {
    test('shows + for earned', () {
      final tx = PointsTransaction(
        id: '1',
        amount: 50,
        description: 'Quiz',
        createdAt: DateTime(2025, 1, 15),
        type: TransactionType.earned,
      );
      expect(tx.formattedAmount, '+50');
    });

    test('shows - for spent', () {
      final tx = PointsTransaction(
        id: '2',
        amount: 80,
        description: 'Reward',
        createdAt: DateTime(2025, 1, 15),
        type: TransactionType.spent,
      );
      expect(tx.formattedAmount, '-80');
    });

    test('shows + for bonus', () {
      final tx = PointsTransaction(
        id: '3',
        amount: 100,
        description: 'Bonus',
        createdAt: DateTime(2025, 1, 15),
        type: TransactionType.bonus,
      );
      expect(tx.formattedAmount, '+100');
    });

    test('shows - for penalty', () {
      final tx = PointsTransaction(
        id: '4',
        amount: 20,
        description: 'Penalty',
        createdAt: DateTime(2025, 1, 15),
        type: TransactionType.penalty,
      );
      expect(tx.formattedAmount, '-20');
    });
  });

  group('PointsTransaction.fromJson', () {
    test('parses complete JSON', () {
      final json = {
        'id': 'tx_1',
        'amount': 50,
        'description': 'Quiz settimanale',
        'created_at': '2025-01-15T10:00:00Z',
        'type': 'earned',
        'source_id': 'reward_1',
      };

      final tx = PointsTransaction.fromJson(json);
      expect(tx.id, 'tx_1');
      expect(tx.amount, 50);
      expect(tx.description, 'Quiz settimanale');
      expect(tx.type, TransactionType.earned);
      expect(tx.rewardId, 'reward_1');
    });

    test('defaults type to earned for unknown value', () {
      final json = {
        'id': 'tx_2',
        'amount': 10,
        'description': 'Test',
        'created_at': '2025-01-15T10:00:00Z',
        'type': 'unknown_type',
      };

      final tx = PointsTransaction.fromJson(json);
      expect(tx.type, TransactionType.earned);
    });
  });
}
