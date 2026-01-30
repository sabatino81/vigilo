import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/shop/domain/models/order.dart';

void main() {
  Map<String, dynamic> _makeOrderJson({
    String id = 'ord_1',
    String? orderCode = 'VIG-2025-00100',
    List<Map<String, dynamic>>? items,
    double totalEur = 50.0,
    double companyPaysEur = 20.0,
    int elmettoPointsUsed = 300,
    double elmettoDiscountEur = 3.0,
    double finalPriceEur = 27.0,
    double shippingEur = 4.90,
    String? status = 'confirmed',
    String createdAt = '2025-06-15T10:00:00.000Z',
    String? trackingCode,
    String? estimatedDelivery,
    bool? usedBnpl,
  }) {
    return {
      'id': id,
      'order_code': orderCode,
      'items': items ??
          [
            {
              'product_id': 'prod_1',
              'product_name': 'Test Product',
              'product_category': 'tech',
              'unit_price': 25.0,
              'product_emoji': '🔋',
              'quantity': 2,
            },
          ],
      'total_eur': totalEur,
      'company_pays_eur': companyPaysEur,
      'elmetto_points_used': elmettoPointsUsed,
      'elmetto_discount_eur': elmettoDiscountEur,
      'final_price_eur': finalPriceEur,
      'shipping_eur': shippingEur,
      'status': status,
      'created_at': createdAt,
      'tracking_code': trackingCode,
      'estimated_delivery': estimatedDelivery,
      'used_bnpl': usedBnpl,
    };
  }

  group('Order.fromJson', () {
    test('parses complete order with nested items', () {
      final json = _makeOrderJson(
        items: [
          {
            'product_id': 'p1',
            'product_name': 'Widget A',
            'product_category': 'casa',
            'unit_price': 15.0,
            'product_emoji': '🛁',
            'quantity': 3,
          },
          {
            'product_id': 'p2',
            'product_name': 'Widget B',
            'product_category': 'tech',
            'unit_price': 30.0,
            'product_emoji': '💻',
            'quantity': 1,
          },
        ],
      );

      final order = Order.fromJson(json);
      expect(order.id, 'ord_1');
      expect(order.orderCode, 'VIG-2025-00100');
      expect(order.items.length, 2);
      expect(order.items[0].product.name, 'Widget A');
      expect(order.items[0].quantity, 3);
      expect(order.items[1].product.name, 'Widget B');
      expect(order.items[1].quantity, 1);
      expect(order.totalEur, 50.0);
      expect(order.companyPaysEur, 20.0);
      expect(order.elmettoPointsUsed, 300);
      expect(order.elmettoDiscountEur, 3.0);
      expect(order.finalPriceEur, 27.0);
      expect(order.shippingEur, 4.90);
      expect(order.status, OrderStatus.confirmed);
      expect(order.createdAt.year, 2025);
      expect(order.usedBnpl, false);
    });

    test('handles empty items list', () {
      final json = _makeOrderJson(items: []);
      final order = Order.fromJson(json);
      expect(order.items, isEmpty);
      expect(order.itemCount, 0);
    });

    test('handles null items list', () {
      final json = _makeOrderJson();
      json['items'] = null;
      final order = Order.fromJson(json);
      expect(order.items, isEmpty);
    });

    test('defaults status to confirmed for unknown value', () {
      final json = _makeOrderJson(status: 'bogus_status');
      final order = Order.fromJson(json);
      expect(order.status, OrderStatus.confirmed);
    });

    test('defaults status to confirmed for null', () {
      final json = _makeOrderJson(status: null);
      final order = Order.fromJson(json);
      expect(order.status, OrderStatus.confirmed);
    });

    test('parses all known statuses', () {
      for (final s in OrderStatus.values) {
        final json = _makeOrderJson(status: s.name);
        final order = Order.fromJson(json);
        expect(order.status, s, reason: 'Failed to parse status ${s.name}');
      }
    });

    test('parses tracking_code and estimated_delivery', () {
      final json = _makeOrderJson(
        trackingCode: 'CJ1234567890IT',
        estimatedDelivery: '2025-06-20T12:00:00.000Z',
      );
      final order = Order.fromJson(json);
      expect(order.trackingCode, 'CJ1234567890IT');
      expect(order.estimatedDelivery, isNotNull);
      expect(order.estimatedDelivery!.day, 20);
    });

    test('handles missing optional fields', () {
      final json = _makeOrderJson(
        orderCode: null,
        trackingCode: null,
        estimatedDelivery: null,
        usedBnpl: null,
      );
      final order = Order.fromJson(json);
      expect(order.orderCode, '');
      expect(order.trackingCode, isNull);
      expect(order.estimatedDelivery, isNull);
      expect(order.usedBnpl, false);
    });

    test('parses usedBnpl true', () {
      final json = _makeOrderJson(usedBnpl: true);
      final order = Order.fromJson(json);
      expect(order.usedBnpl, true);
    });

    test('item product gets correct fields from JSON', () {
      final json = _makeOrderJson(
        items: [
          {
            'product_id': 'p99',
            'product_name': 'Special Item',
            'product_category': 'sport',
            'unit_price': 19.90,
            'product_emoji': '🏋️',
            'quantity': 2,
          },
        ],
      );
      final order = Order.fromJson(json);
      final product = order.items.first.product;
      expect(product.id, 'p99');
      expect(product.name, 'Special Item');
      expect(product.basePrice, closeTo(19.90, 0.001));
      expect(product.emoji, '🏋️');
    });
  });

  group('OrderStatus', () {
    test('all status values have non-empty label', () {
      for (final s in OrderStatus.values) {
        expect(s.label, isNotEmpty, reason: '${s.name} has empty label');
        expect(s.labelEn, isNotEmpty, reason: '${s.name} has empty labelEn');
      }
    });

    test('all status values have a color', () {
      for (final s in OrderStatus.values) {
        // color getter should not throw
        expect(s.color, isNotNull, reason: '${s.name} has null color');
      }
    });

    test('all status values have an icon', () {
      for (final s in OrderStatus.values) {
        expect(s.icon, isNotNull, reason: '${s.name} has null icon');
      }
    });
  });

  group('Order.itemCount', () {
    test('sums quantities across all cart items', () {
      final json = _makeOrderJson(
        items: [
          {
            'product_id': 'p1',
            'product_name': 'A',
            'product_category': 'casa',
            'unit_price': 10.0,
            'product_emoji': '🎁',
            'quantity': 2,
          },
          {
            'product_id': 'p2',
            'product_name': 'B',
            'product_category': 'tech',
            'unit_price': 20.0,
            'product_emoji': '🎁',
            'quantity': 3,
          },
          {
            'product_id': 'p3',
            'product_name': 'C',
            'product_category': 'sport',
            'unit_price': 5.0,
            'product_emoji': '🎁',
            'quantity': 1,
          },
        ],
      );
      final order = Order.fromJson(json);
      expect(order.itemCount, 6);
    });

    test('returns 0 for empty items', () {
      final json = _makeOrderJson(items: []);
      final order = Order.fromJson(json);
      expect(order.itemCount, 0);
    });
  });
}
