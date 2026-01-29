import 'package:vigilo/features/punti/domain/models/points_transaction.dart';
import 'package:vigilo/features/punti/domain/models/wallet_type.dart';
import 'package:vigilo/features/punti/domain/models/welfare_plan.dart';

/// Wallet duale: Punti Elmetto (engagement) + Punti Welfare (budget aziendale)
class DualWallet {
  const DualWallet({
    required this.puntiElmetto,
    required this.welfarePlan,
    required this.elmettoTransactions,
    required this.welfareTransactions,
  });

  /// Saldo Punti Elmetto (punti interi)
  final int puntiElmetto;

  /// Piano welfare aziendale con budget in EUR
  final WelfarePlan welfarePlan;

  /// Transazioni wallet Elmetto
  final List<PointsTransaction> elmettoTransactions;

  /// Transazioni wallet Welfare
  final List<PointsTransaction> welfareTransactions;

  // ============================================
  // CONVERSIONE ELMETTO
  // ============================================

  /// Tasso di conversione: 10 Punti Elmetto = 1 EUR
  /// Valore facciale annuo: ~18.000 pts = ~€1.800
  static const int elmettoPerEur = 10;

  /// Sconto massimo Elmetto sugli acquisti (20%)
  static const int maxElmettoDiscountPercent = 20;

  /// Valore in EUR dei Punti Elmetto
  double get elmettoValueEur => puntiElmetto / elmettoPerEur;

  // ============================================
  // CALCOLI CHECKOUT
  // ============================================

  /// Calcola il breakdown di pagamento per un importo dato.
  /// Ordine: welfare prima (EUR), poi sconto Elmetto (%) sul resto.
  CheckoutBreakdown calculateCheckout(double totalEur) {
    // 1. Welfare copre fino al 100% del totale
    final welfareAvailable = welfarePlan.remainingEur;
    final welfareUsed =
        welfareAvailable >= totalEur ? totalEur : welfareAvailable;
    final afterWelfare = totalEur - welfareUsed;

    // 2. Elmetto sconta fino al 20% del resto
    final maxElmettoDiscount =
        afterWelfare * maxElmettoDiscountPercent / 100;
    final elmettoDiscountEur =
        elmettoValueEur >= maxElmettoDiscount
            ? maxElmettoDiscount
            : elmettoValueEur;
    final elmettoPointsUsed = (elmettoDiscountEur * elmettoPerEur).round();

    // 3. Resto da pagare
    final cashToPay = afterWelfare - elmettoDiscountEur;

    return CheckoutBreakdown(
      totalEur: totalEur,
      welfareUsedEur: welfareUsed,
      elmettoDiscountEur: elmettoDiscountEur,
      elmettoPointsUsed: elmettoPointsUsed,
      cashToPayEur: cashToPay,
      isFullyFree: cashToPay <= 0,
    );
  }

  /// Mock data
  static DualWallet mockWallet() {
    final now = DateTime.now();
    return DualWallet(
      puntiElmetto: 2850,
      welfarePlan: WelfarePlan.mockPlan(),
      elmettoTransactions: [
        PointsTransaction(
          id: 'e1',
          amount: 50,
          description: 'Quiz settimanale',
          createdAt: now.subtract(const Duration(hours: 2)),
          type: TransactionType.earned,
          walletType: WalletType.elmetto,
        ),
        PointsTransaction(
          id: 'e2',
          amount: 30,
          description: 'Segnalazione sicurezza',
          createdAt: now.subtract(const Duration(hours: 5)),
          type: TransactionType.earned,
          walletType: WalletType.elmetto,
        ),
        PointsTransaction(
          id: 'e3',
          amount: 10,
          description: 'Check-in benessere',
          createdAt: now.subtract(const Duration(days: 1)),
          type: TransactionType.earned,
          walletType: WalletType.elmetto,
        ),
        PointsTransaction(
          id: 'e4',
          amount: 100,
          description: 'Bonus Gira la Ruota',
          createdAt: now.subtract(const Duration(days: 3)),
          type: TransactionType.bonus,
          walletType: WalletType.elmetto,
        ),
        PointsTransaction(
          id: 'e5',
          amount: 160,
          description: 'Sconto acquisto Spaccio (-€16)',
          createdAt: now.subtract(const Duration(days: 4)),
          type: TransactionType.spent,
          walletType: WalletType.elmetto,
        ),
      ],
      welfareTransactions: [
        PointsTransaction(
          id: 'w1',
          amount: 25,
          description: 'Acquisto guanti premium',
          createdAt: now.subtract(const Duration(days: 1)),
          type: TransactionType.spent,
          walletType: WalletType.welfare,
        ),
        PointsTransaction(
          id: 'w2',
          amount: 22,
          description: 'Buono carburante',
          createdAt: now.subtract(const Duration(days: 5)),
          type: TransactionType.spent,
          walletType: WalletType.welfare,
        ),
        PointsTransaction(
          id: 'w3',
          amount: 150,
          description: 'Budget mensile accreditato',
          createdAt: now.subtract(const Duration(days: 10)),
          type: TransactionType.earned,
          walletType: WalletType.welfare,
        ),
      ],
    );
  }
}

/// Breakdown del checkout con wallet duale
class CheckoutBreakdown {
  const CheckoutBreakdown({
    required this.totalEur,
    required this.welfareUsedEur,
    required this.elmettoDiscountEur,
    required this.elmettoPointsUsed,
    required this.cashToPayEur,
    required this.isFullyFree,
  });

  final double totalEur;
  final double welfareUsedEur;
  final double elmettoDiscountEur;
  final int elmettoPointsUsed;
  final double cashToPayEur;
  final bool isFullyFree;

  /// Verifica se BNPL e' disponibile (min 50 EUR)
  bool get isBnplAvailable => cashToPayEur >= 50;
}
