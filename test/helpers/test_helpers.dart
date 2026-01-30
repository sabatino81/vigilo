import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vigilo/features/checkin/data/checkin_repository.dart';
import 'package:vigilo/features/punti/data/wallet_repository.dart';
import 'package:vigilo/features/punti/domain/models/elmetto_wallet.dart';
import 'package:vigilo/features/punti/domain/models/points_transaction.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';
import 'package:vigilo/features/shop/data/order_repository.dart';
import 'package:vigilo/features/shop/data/product_repository.dart';
import 'package:vigilo/features/shop/domain/models/cart_item.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_badge.dart';
import 'package:vigilo/features/shop/domain/models/product_category.dart';
import 'package:vigilo/features/shop/domain/models/product_variant.dart';
import 'package:vigilo/features/streak/domain/models/streak.dart';

// ============================================================
// Mock repositories
// ============================================================

class MockProductRepository extends Mock implements ProductRepository {}

class MockOrderRepository extends Mock implements OrderRepository {}

class MockWalletRepository extends Mock implements WalletRepository {}

class MockCheckinRepository extends Mock implements CheckinRepository {}

// ============================================================
// ProviderContainer helper
// ============================================================

ProviderContainer createContainer({List<Override> overrides = const []}) {
  return ProviderContainer(overrides: overrides);
}

// ============================================================
// Model factory helpers
// ============================================================

Product makeProduct({
  String id = 'prod_test',
  String name = 'Prodotto Test',
  String description = 'Descrizione test',
  ProductCategory category = ProductCategory.casa,
  double basePrice = 50.0,
  String emoji = '🎁',
  ProductBadge badge = ProductBadge.none,
  int? promoDiscountPercent,
  String? supplierName,
}) {
  return Product(
    id: id,
    name: name,
    description: description,
    category: category,
    basePrice: basePrice,
    emoji: emoji,
    badge: badge,
    promoDiscountPercent: promoDiscountPercent,
    supplierName: supplierName,
  );
}

ProductVariant makeVariant({
  String id = 'var_test',
  String variantLabel = 'Standard',
  Map<String, dynamic> attributes = const {},
  double? price,
}) {
  return ProductVariant(
    id: id,
    variantLabel: variantLabel,
    attributes: attributes,
    price: price,
  );
}

CartItem makeCartItem({
  Product? product,
  ProductVariant? variant,
  int quantity = 1,
}) {
  final p = product ?? makeProduct();
  return CartItem(
    product: p,
    variant: variant ?? p.defaultVariant,
    quantity: quantity,
  );
}

ElmettoWallet makeWallet({
  int puntiElmetto = 1800,
  bool welfareActive = false,
  String? companyName,
  List<PointsTransaction>? transactions,
}) {
  return ElmettoWallet(
    puntiElmetto: puntiElmetto,
    welfareActive: welfareActive,
    companyName: companyName,
    transactions: transactions ?? [],
  );
}

UserProfile makeProfile({
  String id = 'user_test',
  String name = 'Test User',
  String email = 'test@test.com',
  WorkerCategory category = WorkerCategory.operaio,
  TrustLevel trustLevel = TrustLevel.base,
  int safetyScore = 80,
  int streakDays = 5,
  int reportsCount = 3,
  int puntiElmetto = 1800,
  bool welfareActive = false,
  String companyName = 'Test S.r.l.',
  String? avatarUrl,
}) {
  return UserProfile(
    id: id,
    name: name,
    email: email,
    category: category,
    trustLevel: trustLevel,
    safetyScore: safetyScore,
    streakDays: streakDays,
    reportsCount: reportsCount,
    puntiElmetto: puntiElmetto,
    welfareActive: welfareActive,
    companyName: companyName,
    avatarUrl: avatarUrl,
  );
}

Streak makeStreak({
  int currentDays = 14,
  int bestStreak = 28,
  List<int>? calendarDays,
}) {
  return Streak(
    currentDays: currentDays,
    bestStreak: bestStreak,
    calendarDays: calendarDays ?? [1, 2, 3, 4, 5],
  );
}
