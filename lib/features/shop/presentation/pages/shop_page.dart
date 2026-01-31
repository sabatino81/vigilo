import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';
import 'package:vigilo/features/shop/domain/models/product_category.dart';
import 'package:vigilo/features/shop/presentation/pages/product_detail_page.dart';
import 'package:vigilo/features/shop/presentation/widgets/category_filter_bar.dart';
import 'package:vigilo/features/shop/presentation/widgets/product_card.dart';
import 'package:vigilo/features/shop/providers/shop_providers.dart';

/// Pagina catalogo prodotti — ConsumerStatefulWidget con dati da Supabase.
class ShopPage extends ConsumerStatefulWidget {
  const ShopPage({super.key});

  @override
  ConsumerState<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends ConsumerState<ShopPage>
    with SingleTickerProviderStateMixin {
  ProductCategory? _selectedCategory;
  String _searchQuery = '';
  late final AnimationController _shimmerCtrl;
  final ScrollController _scrollCtrl = ScrollController();
  final FocusNode _searchFocus = FocusNode();
  final TextEditingController _searchCtrl = TextEditingController();

  /// Quanti prodotti mostrare per "pagina"
  static const _pageSize = 10;
  int _visibleCount = _pageSize;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _shimmerCtrl.dispose();
    _searchFocus.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_loadingMore) return;
    final maxScroll = _scrollCtrl.position.maxScrollExtent;
    final current = _scrollCtrl.position.pixels;
    // Carica altri quando mancano 200px al fondo
    if (current >= maxScroll - 200) {
      _loadMore();
    }
  }

  void _loadMore() {
    if (_loadingMore) return;
    setState(() => _loadingMore = true);
    // Simula un breve delay per UX (anche con dati locali)
    Future<void>.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          _visibleCount += _pageSize;
          _loadingMore = false;
        });
      }
    });
  }

  List<Product> _filterProducts(List<Product> allProducts) {
    var products = allProducts;
    if (_selectedCategory != null) {
      products = products
          .where((p) => p.category == _selectedCategory)
          .toList();
    }
    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      products = products
          .where(
            (p) =>
                p.name.toLowerCase().contains(query) ||
                p.description.toLowerCase().contains(query),
          )
          .toList();
    }
    return products;
  }

  void _openProduct(Product product) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => ProductDetailPage(product: product),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final productsAsync = ref.watch(productsProvider);

    final allProducts = productsAsync.when(
      data: (p) => p,
      loading: () => <Product>[],
      error: (_, __) => <Product>[],
    );

    final filtered = _filterProducts(allProducts);
    final visible = filtered.take(_visibleCount).toList();
    final hasMore = visible.length < filtered.length;
    final showFeatured =
        _searchQuery.isEmpty && _selectedCategory == null;
    // Prodotti in evidenza: quelli con badge o promo, max 6
    final featured = showFeatured
        ? allProducts
            .where((p) => p.badge.isVisible || p.hasPromo)
            .take(6)
            .toList()
        : <Product>[];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          // Title + Search sulla stessa riga
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              switchInCurve: Curves.easeInOut,
              switchOutCurve: Curves.easeInOut,
              child: _searchQuery.isNotEmpty
                  // ── Ricerca attiva: search bar a tutta larghezza
                  ? SizedBox(
                      key: const ValueKey('search-full'),
                      height: 32,
                      child: TextField(
                        controller: _searchCtrl,
                        focusNode: _searchFocus,
                        onChanged: (v) => setState(() {
                          _searchQuery = v;
                          _visibleCount = _pageSize;
                        }),
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'Cerca prodotti...',
                          hintStyle: const TextStyle(fontSize: 12),
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            size: 18,
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 32,
                            minHeight: 32,
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.close_rounded,
                              size: 16,
                            ),
                            onPressed: () {
                              _searchCtrl.clear();
                              _searchFocus.unfocus();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          isDense: true,
                        ),
                      ),
                    )
                  // ── Default: titolo + search compatta
                  : Row(
                      key: const ValueKey('title-row'),
                      children: [
                        // Icona con pulse
                        AnimatedBuilder(
                          animation: _shimmerCtrl,
                          builder: (_, child) {
                            final scale = 1.0 +
                                0.05 *
                                    (_shimmerCtrl.value < 0.5
                                        ? _shimmerCtrl.value * 2
                                        : (1 - _shimmerCtrl.value) * 2);
                            return Transform.scale(
                              scale: scale,
                              child: child,
                            );
                          },
                          child: Icon(
                            Icons.storefront_rounded,
                            size: 22,
                            color: AppTheme.ambra,
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Testo con shimmer gradient
                        AnimatedBuilder(
                          animation: _shimmerCtrl,
                          builder: (_, child) {
                            return ShaderMask(
                              shaderCallback: (bounds) {
                                final offset =
                                    _shimmerCtrl.value * 3 - 1;
                                return LinearGradient(
                                  begin: Alignment(offset - 0.3, 0),
                                  end: Alignment(offset + 0.3, 0),
                                  colors: [
                                    AppTheme.ambra,
                                    Colors.white,
                                    AppTheme.teal,
                                    AppTheme.ambra,
                                  ],
                                  stops: const [0.0, 0.4, 0.6, 1.0],
                                ).createShader(bounds);
                              },
                              child: child!,
                            );
                          },
                          child: const Text(
                            'Spaccio Aziendale',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 0.3,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Search bar compatta
                        Expanded(
                          child: SizedBox(
                            height: 32,
                            child: TextField(
                              controller: _searchCtrl,
                              focusNode: _searchFocus,
                              onChanged: (v) => setState(() {
                                _searchQuery = v;
                                _visibleCount = _pageSize;
                              }),
                              style: const TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                hintText: 'Cerca...',
                                hintStyle: const TextStyle(fontSize: 12),
                                prefixIcon: const Icon(
                                  Icons.search_rounded,
                                  size: 18,
                                ),
                                prefixIconConstraints:
                                    const BoxConstraints(
                                  minWidth: 32,
                                  minHeight: 32,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 0,
                                ),
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),

          // Category filter
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: CategoryFilterBar(
              selected: _selectedCategory,
              onSelected: (cat) => setState(() {
                _selectedCategory = cat;
                _visibleCount = _pageSize;
              }),
            ),
          ),
          const SizedBox(height: 6),

          // Product count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              hasMore
                  ? '${visible.length} di ${filtered.length} prodotti'
                  : '${filtered.length} prodotti',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Product grid — infinite scroll
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: isDark
                              ? Colors.white24
                              : Colors.black12,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Nessun prodotto trovato',
                          style: TextStyle(
                            color: isDark
                                ? Colors.white54
                                : Colors.black45,
                          ),
                        ),
                      ],
                    ),
                  )
                : CustomScrollView(
                    controller: _scrollCtrl,
                    slivers: [
                      // Sezione In Evidenza
                      if (featured.isNotEmpty) ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.local_fire_department_rounded,
                                  size: 18,
                                  color: isDark
                                      ? const Color(0xFFFF6D00)
                                      : const Color(0xFFE65100),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'In evidenza',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 220,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              itemCount: featured.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(width: 12),
                              itemBuilder: (_, index) {
                                final product = featured[index];
                                return SizedBox(
                                  width: 155,
                                  child: ProductCard(
                                    product: product,
                                    onTap: () => _openProduct(product),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.grid_view_rounded,
                                  size: 16,
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.black45,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  'Tutti i prodotti',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    color: isDark
                                        ? Colors.white
                                        : Colors.black87,
                                    letterSpacing: -0.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (_, index) {
                              final product = visible[index];
                              return ProductCard(
                                product: product,
                                onTap: () => _openProduct(product),
                              );
                            },
                            childCount: visible.length,
                          ),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                        ),
                      ),
                      // Loader in fondo
                      if (hasMore)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: Color(0xFFFFB800),
                                ),
                              ),
                            ),
                          ),
                        ),
                      // Bottom padding
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 120),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
