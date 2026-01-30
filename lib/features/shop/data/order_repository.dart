import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';
import 'package:vigilo/features/shop/domain/models/voucher.dart';

/// Repository per ordini e voucher via Supabase RPC.
class OrderRepository extends BaseRepository {
  const OrderRepository(super.client);

  /// Preview checkout breakdown (no side effects).
  Future<Map<String, dynamic>> calculateCheckout({
    required List<String> variantIds,
    required List<int> quantities,
  }) async {
    return await rpc<Map<String, dynamic>>(
      'calculate_checkout',
      params: {
        'p_variant_ids': variantIds,
        'p_quantities': quantities,
      },
    );
  }

  /// Piazza ordine (crea ordine + deduce punti).
  Future<Map<String, dynamic>> placeOrder({
    required List<String> variantIds,
    required List<int> quantities,
    bool useBnpl = false,
  }) async {
    return await rpc<Map<String, dynamic>>(
      'place_order',
      params: {
        'p_variant_ids': variantIds,
        'p_quantities': quantities,
        'p_use_bnpl': useBnpl,
      },
    );
  }

  /// Storico ordini utente con items.
  Future<List<Order>> getMyOrders({
    int limit = 20,
    int offset = 0,
  }) async {
    final json = await rpc<List<dynamic>>(
      'get_my_orders',
      params: {'p_limit': limit, 'p_offset': offset},
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(Order.fromJson)
        .toList();
  }

  /// Voucher digitali dell'utente.
  Future<List<Voucher>> getMyVouchers() async {
    final json = await rpc<List<dynamic>>('get_my_vouchers');
    return json
        .whereType<Map<String, dynamic>>()
        .map(Voucher.fromJson)
        .toList();
  }
}
