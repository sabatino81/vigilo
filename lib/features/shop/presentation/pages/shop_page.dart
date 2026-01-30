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
      error: (_, __) => Product.mockProducts(),
    );

    final filtered = _filterProducts(allProducts);
    final visible = filtered.take(_visibleCount).toList();
    final hasMore = visible.length < filtered.length;

    return Scaffold(
      body: Column(
        children: [
          // Title — shimmer animato
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icona con pulse
                AnimatedBuilder(
                  animation: _shimmerCtrl,
                  builder: (_, child) {
                    final scale = 1.0 + 0.05 * (_shimmerCtrl.value < 0.5
                        ? _shimmerCtrl.value * 2
                        : (1 - _shimmerCtrl.value) * 2);
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.storefront_rounded,
                    size: 26,
                    color: AppTheme.ambra,
                  ),
                ),
                const SizedBox(width: 10),
                // Testo con shimmer gradient
                AnimatedBuilder(
                  animation: _shimmerCtrl,
                  builder: (_, child) {
                    return ShaderMask(
                      shaderCallback: (bounds) {
                        final offset = _shimmerCtrl.value * 3 - 1;
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
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 6),
            child: SizedBox(
              height: 38,
              child: TextField(
                onChanged: (v) => setState(() {
                  _searchQuery = v;
                  _visibleCount = _pageSize;
                }),
                style: const TextStyle(fontSize: 13),
                decoration: InputDecoration(
                  hintText: 'Cerca prodotti...',
                  hintStyle: const TextStyle(fontSize: 13),
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  prefixIconConstraints:
                      const BoxConstraints(minWidth: 38, minHeight: 38),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded, size: 18),
                          onPressed: () =>
                              setState(() => _searchQuery = ''),
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  isDense: true,
                ),
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
