import 'package:vigilo/features/punti/domain/models/points_transaction.dart';

/// Wallet unico Punti Elmetto.
///
/// Un solo punteggio per tutti. La differenza è al checkout:
/// - Senza welfare: sconto max 20% (Vigilo assorbe dal margine)
/// - Con welfare: sconto fino al 100% (azienda fatturata per la parte
///   non pagata dal lavoratore)
class ElmettoWallet {
  const ElmettoWallet({
    required this.puntiElmetto,
    required this.welfareActive,
    required this.companyName,
    required this.transactions,
  });

  /// Saldo Punti Elmetto (punti interi)
  final int puntiElmetto;

  /// Se l'azienda ha attivato il welfare
  final bool welfareActive;

  /// Nome azienda (per label welfare)
  final String? companyName;

  /// Storico transazioni
  final List<PointsTransaction> transactions;

  /// Crea da JSON (risposta RPC get_my_wallet).
  factory ElmettoWallet.fromJson(Map<String, dynamic> json) {
    final txList = json['transactions'];
    final transactions = <PointsTransaction>[];
    if (txList is List) {
      for (final item in txList) {
        if (item is Map<String, dynamic>) {
          transactions.add(PointsTransaction.fromJson(item));
        }
      }
    }
    return ElmettoWallet(
      puntiElmetto: json['punti_elmetto'] as int? ?? 0,
      welfareActive: json['welfare_active'] as bool? ?? false,
      companyName: json['company_name'] as String?,
      transactions: transactions,
    );
  }

  // ============================================
  // CONVERSIONE ELMETTO
  // ============================================

  /// Tasso di conversione: 60 Punti Elmetto = 1 EUR
  /// Valore facciale annuo: ~18.000 pts = ~€300
  static const int elmettoPerEur = 60;

  /// Sconto massimo SENZA welfare (20%)
  static const int maxDiscountNoWelfare = 20;

  /// Sconto massimo CON welfare (100%)
  static const int maxDiscountWithWelfare = 100;

  /// Valore in EUR dei Punti Elmetto
  double get elmettoValueEur => puntiElmetto / elmettoPerEur;

  /// Cap sconto in base allo stato welfare
  int get maxDiscountPercent =>
      welfareActive ? maxDiscountWithWelfare : maxDiscountNoWelfare;

  // ============================================
  // CALCOLI CHECKOUT
  // ============================================

  /// Calcola il breakdown di pagamento per un importo dato.
  ///
  /// - Senza welfare: sconto max 20%, lavoratore paga il resto
  /// - Con welfare: sconto fino a 100%, azienda fatturata per la differenza
  CheckoutBreakdown calculateCheckout(double totalEur) {
    // 1. Calcola sconto massimo applicabile (% del prezzo)
    final maxDiscount = totalEur * maxDiscountPercent / 100;

    // 2. Lo sconto effettivo è il minore tra punti disponibili e cap
    final elmettoDiscountEur =
        elmettoValueEur >= maxDiscount ? maxDiscount : elmettoValueEur;
    final elmettoPointsUsed = (elmettoDiscountEur * elmettoPerEur).round();

    // 3. Quanto paga il lavoratore
    final workerPays = totalEur - elmettoDiscountEur;

    // 4. Se welfare attivo: la parte non pagata dal lavoratore
    //    oltre il 20% base viene fatturata all'azienda
    final baseDiscount = totalEur * maxDiscountNoWelfare / 100;
    final companyPays = welfareActive && elmettoDiscountEur > baseDiscount
        ? elmettoDiscountEur - baseDiscount
        : 0.0;

    return CheckoutBreakdown(
      totalEur: totalEur,
      elmettoDiscountEur: elmettoDiscountEur,
      elmettoPointsUsed: elmettoPointsUsed,
      workerPaysEur: workerPays,
      companyPaysEur: companyPays,
      welfareActive: welfareActive,
      isFullyFree: workerPays <= 0,
    );
  }

  /// Mock data
  static ElmettoWallet mockWallet({bool welfare = true}) {
    final now = DateTime.now();
    return ElmettoWallet(
      puntiElmetto: 1800,
      welfareActive: welfare,
      companyName: welfare ? 'Costruzioni Rossi S.r.l.' : null,
      transactions: [
        PointsTransaction(
          id: 'e1',
          amount: 50,
          description: 'Quiz settimanale',
          createdAt: now.subtract(const Duration(hours: 2)),
          type: TransactionType.earned,
        ),
        PointsTransaction(
          id: 'e2',
          amount: 30,
          description: 'Segnalazione sicurezza',
          createdAt: now.subtract(const Duration(hours: 5)),
          type: TransactionType.earned,
        ),
        PointsTransaction(
          id: 'e3',
          amount: 10,
          description: 'Check-in benessere',
          createdAt: now.subtract(const Duration(days: 1)),
          type: TransactionType.earned,
        ),
        PointsTransaction(
          id: 'e4',
          amount: 100,
          description: 'Bonus Gira la Ruota',
          createdAt: now.subtract(const Duration(days: 3)),
          type: TransactionType.bonus,
        ),
        PointsTransaction(
          id: 'e5',
          amount: 360,
          description: 'Sconto acquisto Spaccio (-€6)',
          createdAt: now.subtract(const Duration(days: 4)),
          type: TransactionType.spent,
        ),
        PointsTransaction(
          id: 'e6',
          amount: 540,
          description: 'Acquisto welfare Spaccio (-€9)',
          createdAt: now.subtract(const Duration(days: 6)),
          type: TransactionType.spent,
        ),
      ],
    );
  }
}

/// Breakdown del checkout con wallet unico
class CheckoutBreakdown {
  const CheckoutBreakdown({
    required this.totalEur,
    required this.elmettoDiscountEur,
    required this.elmettoPointsUsed,
    required this.workerPaysEur,
    required this.companyPaysEur,
    required this.welfareActive,
    required this.isFullyFree,
  });

  final double totalEur;
  final double elmettoDiscountEur;
  final int elmettoPointsUsed;
  final double workerPaysEur;

  /// Importo fatturato all'azienda (welfare)
  final double companyPaysEur;
  final bool welfareActive;
  final bool isFullyFree;

  /// Verifica se BNPL e' disponibile (min 50 EUR)
  bool get isBnplAvailable => workerPaysEur >= 50;
}
