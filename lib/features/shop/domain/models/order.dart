import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';

/// Stato di un ordine
enum OrderStatus {
  confirmed,
  processing,
  shipped,
  delivered,
  cancelled;

  String get label {
    switch (this) {
      case OrderStatus.confirmed:
        return 'Confermato';
      case OrderStatus.processing:
        return 'In lavorazione';
      case OrderStatus.shipped:
        return 'Spedito';
      case OrderStatus.delivered:
        return 'Consegnato';
      case OrderStatus.cancelled:
        return 'Annullato';
    }
  }

  String get labelEn {
    switch (this) {
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get color {
    switch (this) {
      case OrderStatus.confirmed:
        return AppTheme.tertiary;
      case OrderStatus.processing:
        return AppTheme.ambra;
      case OrderStatus.shipped:
        return AppTheme.primary;
      case OrderStatus.delivered:
        return AppTheme.secondary;
      case OrderStatus.cancelled:
        return AppTheme.danger;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case OrderStatus.confirmed:
        return AppTheme.tertiaryContainer;
      case OrderStatus.processing:
        return AppTheme.ambraContainer;
      case OrderStatus.shipped:
        return AppTheme.primaryContainer;
      case OrderStatus.delivered:
        return AppTheme.secondaryContainer;
      case OrderStatus.cancelled:
        return AppTheme.dangerContainer;
    }
  }

  IconData get icon {
    switch (this) {
      case OrderStatus.confirmed:
        return Icons.check_circle_outline_rounded;
      case OrderStatus.processing:
        return Icons.inventory_2_rounded;
      case OrderStatus.shipped:
        return Icons.local_shipping_rounded;
      case OrderStatus.delivered:
        return Icons.done_all_rounded;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }
}

/// Ordine ecommerce
class Order {
  const Order({
    required this.id,
    required this.orderCode,
    required this.items,
    required this.totalEur,
    required this.companyPaysEur,
    required this.elmettoPointsUsed,
    required this.elmettoDiscountEur,
    required this.finalPriceEur,
    required this.shippingEur,
    required this.status,
    required this.createdAt,
    this.trackingCode,
    this.estimatedDelivery,
    this.usedBnpl = false,
  });

  final String id;
  final String orderCode;
  final List<CartItem> items;
  final double totalEur;
  final double companyPaysEur;
  final int elmettoPointsUsed;
  final double elmettoDiscountEur;
  final double finalPriceEur;
  final double shippingEur;
  final OrderStatus status;
  final DateTime createdAt;
  final String? trackingCode;
  final DateTime? estimatedDelivery;
  final bool usedBnpl;

  int get itemCount =>
      items.fold(0, (sum, item) => sum + item.quantity);

  /// Mock data
  static List<Order> mockOrders() {
    final now = DateTime.now();
    final products = Product.mockProducts();

    return [
      Order(
        id: 'ord_1',
        orderCode: 'VIG-2025-00142',
        items: [
          CartItem(product: products[5], quantity: 1),
        ],
        totalEur: 34.00,
        companyPaysEur: 20.00,
        elmettoPointsUsed: 280,
        elmettoDiscountEur: 2.80,
        finalPriceEur: 11.20,
        shippingEur: 4.90,
        status: OrderStatus.shipped,
        createdAt: now.subtract(const Duration(days: 2)),
        trackingCode: 'CJ1234567890IT',
        estimatedDelivery: now.add(const Duration(days: 3)),
      ),
      Order(
        id: 'ord_2',
        orderCode: 'VIG-2025-00138',
        items: [
          CartItem(product: products[10]),
        ],
        totalEur: 25.00,
        companyPaysEur: 25.00,
        elmettoPointsUsed: 0,
        elmettoDiscountEur: 0,
        finalPriceEur: 0,
        shippingEur: 0,
        status: OrderStatus.delivered,
        createdAt: now.subtract(const Duration(days: 8)),
      ),
      Order(
        id: 'ord_3',
        orderCode: 'VIG-2025-00151',
        items: [
          CartItem(product: products[2]),
          CartItem(product: products[7]),
        ],
        totalEur: 87.50,
        companyPaysEur: 50.00,
        elmettoPointsUsed: 750,
        elmettoDiscountEur: 7.50,
        finalPriceEur: 30.00,
        shippingEur: 6.90,
        status: OrderStatus.confirmed,
        createdAt: now.subtract(const Duration(hours: 3)),
        usedBnpl: true,
      ),
    ];
  }
}
