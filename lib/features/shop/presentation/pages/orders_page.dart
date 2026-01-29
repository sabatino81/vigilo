import 'package:flutter/material.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';
import 'package:vigilo/features/shop/presentation/pages/order_detail_page.dart';
import 'package:vigilo/features/shop/presentation/widgets/order_tile.dart';

/// Lista ordini
class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = Order.mockOrders();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'I miei ordini',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? const Center(child: Text('Nessun ordine'))
          : ListView.builder(
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
    );
  }
}
