import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/punti/domain/models/elmetto_wallet.dart';

void main() {
  ElmettoWallet _wallet({
    int puntiElmetto = 0,
    bool welfareActive = false,
  }) {
    return ElmettoWallet(
      puntiElmetto: puntiElmetto,
      welfareActive: welfareActive,
      companyName: welfareActive ? 'TestCorp' : null,
      transactions: const [],
    );
  }

  group('ElmettoWallet computed properties', () {
    test('elmettoValueEur converts points at 60:1 rate', () {
      final wallet = _wallet(puntiElmetto: 1800);
      expect(wallet.elmettoValueEur, 30.0);
    });

    test('elmettoValueEur is 0 for 0 points', () {
      final wallet = _wallet(puntiElmetto: 0);
      expect(wallet.elmettoValueEur, 0.0);
    });

    test('maxDiscountPercent is 20 when welfare inactive', () {
      final wallet = _wallet(welfareActive: false);
      expect(wallet.maxDiscountPercent, 20);
    });

    test('maxDiscountPercent is 100 when welfare active', () {
      final wallet = _wallet(welfareActive: true);
      expect(wallet.maxDiscountPercent, 100);
    });
  });

  group('calculateCheckout - no welfare', () {
    test('caps discount at 20% of total', () {
      // 1800 pts = 30 EUR value, total = 100, 20% cap = 20 EUR
      final wallet = _wallet(puntiElmetto: 1800);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.elmettoDiscountEur, 20.0);
      expect(breakdown.workerPaysEur, 80.0);
    });

    test('uses all points when value < 20% cap', () {
      // 300 pts = 5 EUR value, total = 100, 20% cap = 20 EUR
      final wallet = _wallet(puntiElmetto: 300);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.elmettoDiscountEur, 5.0);
      expect(breakdown.workerPaysEur, 95.0);
    });

    test('companyPaysEur is always 0 without welfare', () {
      final wallet = _wallet(puntiElmetto: 6000);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.companyPaysEur, 0.0);
    });

    test('isFullyFree is false without welfare even with many points', () {
      // 60000 pts = 1000 EUR value, but cap is 20% = 20 EUR on 100 total
      final wallet = _wallet(puntiElmetto: 60000);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.isFullyFree, false);
      expect(breakdown.workerPaysEur, 80.0);
    });

    test('elmettoPointsUsed is correct', () {
      // 1800 pts, total 100, cap 20 EUR discount -> 20 * 60 = 1200 pts used
      final wallet = _wallet(puntiElmetto: 1800);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.elmettoPointsUsed, 1200);
    });
  });

  group('calculateCheckout - with welfare', () {
    test('allows up to 100% discount', () {
      // 6000 pts = 100 EUR value, total = 100, welfare cap = 100%
      final wallet = _wallet(puntiElmetto: 6000, welfareActive: true);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.elmettoDiscountEur, 100.0);
      expect(breakdown.workerPaysEur, 0.0);
    });

    test('companyPays covers portion above 20% base', () {
      // total = 100, discount = 100, base 20% = 20 -> company = 80
      final wallet = _wallet(puntiElmetto: 6000, welfareActive: true);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.companyPaysEur, 80.0);
    });

    test('isFullyFree is true when worker pays 0', () {
      final wallet = _wallet(puntiElmetto: 6000, welfareActive: true);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.isFullyFree, true);
    });

    test('partial welfare: points only cover 10 EUR', () {
      // 600 pts = 10 EUR value, total = 100, welfare cap = 100 EUR
      // discount = min(10, 100) = 10, worker = 90
      // base 20% = 20, discount 10 < 20 -> company = 0
      final wallet = _wallet(puntiElmetto: 600, welfareActive: true);
      final breakdown = wallet.calculateCheckout(100.0);

      expect(breakdown.elmettoDiscountEur, 10.0);
      expect(breakdown.workerPaysEur, 90.0);
      expect(breakdown.companyPaysEur, 0.0);
    });
  });

  group('CheckoutBreakdown.isBnplAvailable', () {
    test('true when workerPaysEur >= 50', () {
      final wallet = _wallet(puntiElmetto: 0);
      final breakdown = wallet.calculateCheckout(100.0);

      // worker pays 100 (no points)
      expect(breakdown.isBnplAvailable, true);
    });

    test('false when workerPaysEur < 50', () {
      // 300 pts = 5 EUR, total = 50, cap 20% = 10, discount = 5, worker = 45
      final wallet = _wallet(puntiElmetto: 300);
      final breakdown = wallet.calculateCheckout(50.0);

      expect(breakdown.workerPaysEur, 45.0);
      expect(breakdown.isBnplAvailable, false);
    });
  });

  group('ElmettoWallet.fromJson', () {
    test('parses complete JSON', () {
      final json = <String, dynamic>{
        'punti_elmetto': 1800,
        'welfare_active': true,
        'company_name': 'Acme Corp',
        'transactions': <Map<String, dynamic>>[
          {
            'id': 'tx1',
            'amount': 50,
            'description': 'Quiz',
            'created_at': '2025-01-01T10:00:00Z',
            'type': 'earned',
          },
        ],
      };

      final wallet = ElmettoWallet.fromJson(json);

      expect(wallet.puntiElmetto, 1800);
      expect(wallet.welfareActive, true);
      expect(wallet.companyName, 'Acme Corp');
      expect(wallet.transactions.length, 1);
      expect(wallet.transactions.first.id, 'tx1');
    });

    test('handles missing fields with defaults', () {
      final json = <String, dynamic>{};
      final wallet = ElmettoWallet.fromJson(json);

      expect(wallet.puntiElmetto, 0);
      expect(wallet.welfareActive, false);
      expect(wallet.companyName, isNull);
      expect(wallet.transactions, isEmpty);
    });

    test('handles empty transactions list', () {
      final json = <String, dynamic>{
        'punti_elmetto': 500,
        'welfare_active': false,
        'transactions': <dynamic>[],
      };

      final wallet = ElmettoWallet.fromJson(json);

      expect(wallet.transactions, isEmpty);
      expect(wallet.puntiElmetto, 500);
    });
  });
}
