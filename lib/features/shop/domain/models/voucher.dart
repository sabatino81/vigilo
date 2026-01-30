/// Voucher digitale (buono regalo, carburante, ecc.)
class Voucher {
  const Voucher({
    required this.id,
    required this.code,
    required this.productName,
    required this.valueEur,
    required this.issuedAt,
    required this.expiresAt,
    this.isUsed = false,
    this.barcode,
  });

  final String id;
  final String code;
  final String productName;
  final double valueEur;
  final DateTime issuedAt;
  final DateTime expiresAt;
  final bool isUsed;
  final String? barcode;

  bool get isExpired => expiresAt.isBefore(DateTime.now());

  bool get isValid => !isUsed && !isExpired;

  String get formattedValue => '${valueEur.toStringAsFixed(0)} EUR';

  /// Crea da JSON (risposta RPC get_my_vouchers).
  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'] as String,
      code: json['code'] as String? ?? '',
      productName: json['product_name'] as String? ?? '',
      valueEur: (json['value_eur'] as num?)?.toDouble() ?? 0.0,
      issuedAt: json['issued_at'] != null
          ? DateTime.parse(json['issued_at'] as String)
          : DateTime.now(),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'] as String)
          : DateTime.now().add(const Duration(days: 365)),
      isUsed: json['is_used'] as bool? ?? false,
      barcode: json['barcode'] as String?,
    );
  }

  /// Mock data
  static List<Voucher> mockVouchers() {
    final now = DateTime.now();
    return [
      Voucher(
        id: 'vouch_1',
        code: 'AMZ-VIGILO-X8K2P',
        productName: 'Buono Amazon 25 EUR',
        valueEur: 25,
        issuedAt: now.subtract(const Duration(days: 8)),
        expiresAt: now.add(const Duration(days: 357)),
      ),
      Voucher(
        id: 'vouch_2',
        code: 'FUEL-92847-MULTI',
        productName: 'Buono Carburante 50 EUR',
        valueEur: 50,
        issuedAt: now.subtract(const Duration(days: 30)),
        expiresAt: now.add(const Duration(days: 335)),
        barcode: '8012345678901',
        isUsed: true,
      ),
    ];
  }
}
