import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/providers/shop_providers.dart';

/// Pagina dettaglio prodotto — ConsumerStatefulWidget con wallet da Supabase.
class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  ConsumerState<ProductDetailPage> createState() =>
      _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  int _quantity = 1;

  /// Sconto massimo Punti Elmetto
  static const _maxElmettoDiscount = 0.20;

  double get _totalPrice => widget.product.displayPrice * _quantity;

  void _addToCart() {
    HapticFeedback.mediumImpact();
    for (var i = 0; i < _quantity; i++) {
      ref.read(cartProvider.notifier).addProduct(widget.product);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Aggiunto al carrello: ${widget.product.name}'
          ' x$_quantity',
        ),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'Vai al carrello',
          onPressed: () {
            // TODO(nav): navigate to cart
          },
        ),
      ),
    );
  }

  void _buyNow() {
    HapticFeedback.heavyImpact();
    // TODO(nav): navigate to checkout
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final product = widget.product;
    final catColor = product.category.color;
    final elmettoPrice = product.displayPrice * (1 - _maxElmettoDiscount);

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF5F5F5),
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        decoration: BoxDecoration(
          color: isDark
              ? const Color(0xFF1E1E1E).withValues(alpha: 0.95)
              : Colors.white.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.4 : 0.15),
              blurRadius: 20,
              offset: const Offset(0, -4),
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.05),
          ),
        ),
        child: SafeArea(
          top: false,
          child: Row(
            children: [
              // Compra ora
              Expanded(
                flex: 3,
                child: GestureDetector(
                  onTap: _buyNow,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFFB800),
                          Color(0xFFFF9500),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFB800)
                              .withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.flash_on_rounded,
                          size: 20,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Compra Ora',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: Colors.black87,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Aggiungi al carrello
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: _addToCart,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF43A047),
                          Color(0xFF2E7D32),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF2E7D32)
                              .withValues(alpha: 0.35),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Carrello',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back_rounded,
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
        ),
        actions: [
          // Categoria pill
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: catColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: catColor.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(product.category.icon, size: 14, color: catColor),
                const SizedBox(width: 6),
                Text(
                  product.category.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: catColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Sfondo con gradiente e glow categoria
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [
                          const Color(0xFF1A1A1A),
                          const Color(0xFF121212),
                          const Color(0xFF0D0D0D),
                        ]
                      : [
                          const Color(0xFFF8F8F8),
                          const Color(0xFFF2F2F2),
                          const Color(0xFFEEEEEE),
                        ],
                ),
              ),
            ),
          ),
          // Glow radiale con colore categoria
          Positioned(
            top: -60,
            right: -40,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    catColor.withValues(alpha: isDark ? 0.12 : 0.08),
                    catColor.withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -80,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF2E7D32)
                        .withValues(alpha: isDark ? 0.10 : 0.06),
                    const Color(0xFF2E7D32).withValues(alpha: 0),
                  ],
                ),
              ),
            ),
          ),
          // Contenuto
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero emoji — grande con sfondo grigio
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Emoji centrato
                  Center(
                    child: Text(
                      product.emoji,
                      style: const TextStyle(fontSize: 120),
                    ),
                  ),
                  // Badge top-right
                  if (product.badge.isVisible)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 56,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: product.badge.color,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: product.badge.color.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          product.badge.label,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  // Sconto % top-left
                  if (product.hasPromo)
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 56,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE53935), Color(0xFFD32F2F)],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFD32F2F)
                                  .withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          '-${product.promoDiscountPercent}%',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Contenuto
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome prodotto
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                      letterSpacing: -0.3,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Fornitore
                  if (product.supplierName != null)
                    Row(
                      children: [
                        Icon(
                          Icons.local_shipping_rounded,
                          size: 14,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          product.supplierName!,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isDark ? Colors.white38 : Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),

                  // Sezione prezzi — card con bordo
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFFFB800).withValues(alpha: 0.4),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFB800)
                              .withValues(alpha: isDark ? 0.08 : 0.06),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quantità
                        Row(
                          children: [
                            Icon(
                              Icons.shopping_bag_rounded,
                              size: 16,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Quantità',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                            const Spacer(),
                            _QuantityButton(
                              icon: Icons.remove_rounded,
                              onTap: _quantity > 1
                                  ? () => setState(() => _quantity--)
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                '$_quantity',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color:
                                      isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                            _QuantityButton(
                              icon: Icons.add_rounded,
                              onTap: _quantity < 10
                                  ? () => setState(() => _quantity++)
                                  : null,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Divider
                        Container(
                          height: 1,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.06),
                        ),
                        const SizedBox(height: 12),

                        // Listino
                        Row(
                          children: [
                            Text(
                              'Listino',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white38 : Colors.black38,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${(product.basePrice * _quantity).toStringAsFixed(2)} EUR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white38 : Colors.black38,
                                decoration: TextDecoration.lineThrough,
                                decorationColor:
                                    isDark ? Colors.white38 : Colors.black38,
                              ),
                            ),
                          ],
                        ),

                        // Scontato (se promo)
                        if (product.hasPromo) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                'Scontato',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color:
                                      isDark ? Colors.white54 : Colors.black45,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFE53935),
                                      Color(0xFFD32F2F),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '-${product.promoDiscountPercent}%',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Text(
                                '${(product.displayPrice * _quantity).toStringAsFixed(2)} EUR',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      isDark ? Colors.white54 : Colors.black45,
                                ),
                              ),
                            ],
                          ),
                        ],

                        const SizedBox(height: 10),
                        // Divider ambra
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                const Color(0xFFFFB800)
                                    .withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Con Sconto Elmetto — in evidenza
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFB800)
                                    .withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.construction_rounded,
                                size: 20,
                                color: Color(0xFFFFB800),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Con Sconto Elmetto',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: isDark
                                        ? Colors.white54
                                        : Colors.black45,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '-${(product.displayPrice * _maxElmettoDiscount * 60 * _quantity).round()} punti',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFFFFB800)
                                        .withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '${(elmettoPrice * _quantity).toStringAsFixed(2)} EUR',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFFFFB800),
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),
                        // Divider
                        Container(
                          height: 1,
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.08)
                              : Colors.black.withValues(alpha: 0.06),
                        ),
                        const SizedBox(height: 12),

                        // Spedizione
                        Row(
                          children: [
                            Icon(
                              Icons.local_shipping_rounded,
                              size: 16,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Spedizione',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '5.90 EUR',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Consegna prevista
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_rounded,
                              size: 16,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Consegna prevista',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '3-7 giorni lavorativi',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isDark ? Colors.white70 : Colors.black54,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),
                        // Divider ambra
                        Container(
                          height: 1,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                const Color(0xFFFFB800)
                                    .withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Totale con spedizione
                        Row(
                          children: [
                            Text(
                              'Totale con spedizione',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color:
                                    isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${(elmettoPrice * _quantity + 5.90).toStringAsFixed(2)} EUR',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color:
                                    isDark ? Colors.white54 : Colors.black45,
                              ),
                            ),
                          ],
                        ),

                        // Klarna 3 rate (se totale > 50 EUR)
                        if (elmettoPrice * _quantity + 5.90 >= 50) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFB8C7)
                                  .withValues(alpha: isDark ? 0.1 : 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: const Color(0xFFFFB8C7)
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFB8C7)
                                        .withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Icon(
                                    Icons.credit_card_rounded,
                                    size: 16,
                                    color: Color(0xFFE91E8C),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Paga in 3 rate con Klarna',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: isDark
                                                    ? const Color(0xFFFFB8C7)
                                                    : const Color(0xFFE91E8C),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            '${((elmettoPrice * _quantity + 5.90) / 3).toStringAsFixed(2)} EUR/mese',
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w800,
                                              color: isDark
                                                  ? const Color(0xFFFFB8C7)
                                                  : const Color(0xFFE91E8C),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Builder(
                                        builder: (_) {
                                          final total =
                                              elmettoPrice * _quantity + 5.90;
                                          final rataBase = total / 3;
                                          final interessi = total * 0.0399;
                                          final rata =
                                              (total + interessi) / 3;
                                          return Row(
                                            children: [
                                              Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: isDark
                                                      ? const Color(
                                                          0xFFFFB8C7,
                                                        ).withValues(
                                                          alpha: 0.5,
                                                        )
                                                      : const Color(
                                                          0xFFE91E8C,
                                                        ).withValues(
                                                          alpha: 0.4,
                                                        ),
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Text(
                                                '3 x ${rata.toStringAsFixed(2)} EUR'
                                                ' (interessi ${interessi.toStringAsFixed(2)} EUR,'
                                                ' TAEG 3.99%)',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w500,
                                                  color: isDark
                                                      ? Colors.white38
                                                      : Colors.black38,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Descrizione
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.05)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.black.withValues(alpha: 0.06),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline_rounded,
                              size: 16,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Descrizione',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: isDark ? Colors.white : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          product.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? Colors.white70 : Colors.black54,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Spazio per i tasti flottanti
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ],
        ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({
    required this.icon,
    this.onTap,
  });

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final enabled = onTap != null;

    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          HapticFeedback.lightImpact();
          onTap!();
        }
      },
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          gradient: enabled
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? [
                          Colors.white.withValues(alpha: 0.15),
                          Colors.white.withValues(alpha: 0.08),
                        ]
                      : [
                          Colors.black.withValues(alpha: 0.06),
                          Colors.black.withValues(alpha: 0.03),
                        ],
                )
              : null,
          color: enabled ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: enabled
                ? (isDark
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.1))
                : (isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.05)),
          ),
        ),
        child: Icon(
          icon,
          size: 18,
          color: enabled
              ? (isDark ? Colors.white70 : Colors.black54)
              : (isDark ? Colors.white12 : Colors.black12),
        ),
      ),
    );
  }
}
