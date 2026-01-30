import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';
import 'package:vigilo/features/shop/presentation/pages/order_detail_page.dart';
import 'package:vigilo/features/shop/presentation/widgets/order_tile.dart';
import 'package:vigilo/features/shop/providers/shop_providers.dart';

/// Lista ordini — ConsumerWidget con dati da Supabase.
class OrdersPage extends ConsumerWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(ordersProvider);

    final orders = ordersAsync.when(
      data: (o) => o,
      loading: () => <Order>[],
      error: (_, __) => <Order>[],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'I miei ordini',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(ordersProvider);
        },
        child: orders.isEmpty
            ? const Center(child: Text('Nessun ordine'))
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
                itemCount: orders.length,
                itemBuilder: (_, i) {
                  final order = orders[i];
                  return OrderTile(
                    order: order,
                    onTap: () => Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(
                        builder: (_) =>
                            OrderDetailPage(order: order),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
