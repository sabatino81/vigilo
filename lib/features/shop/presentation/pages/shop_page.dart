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

class _ShopPageState extends ConsumerState<ShopPage> {
  ProductCategory? _selectedCategory;
  String _searchQuery = '';

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

    return Scaffold(
      body: Column(
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.storefront_rounded,
                  size: 26,
                  color: AppTheme.ambra,
                ),
                const SizedBox(width: 10),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [AppTheme.ambra, AppTheme.teal],
                  ).createShader(bounds),
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
                onChanged: (v) => setState(() => _searchQuery = v),
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
              onSelected: (cat) =>
                  setState(() => _selectedCategory = cat),
            ),
          ),
          const SizedBox(height: 6),

          // Product count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '${filtered.length} prodotti',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white38 : Colors.black38,
              ),
            ),
          ),
          const SizedBox(height: 4),

          // Product grid
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
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(
                      16,
                      4,
                      16,
                      120,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (_, index) {
                      final product = filtered[index];
                      return ProductCard(
                        product: product,
                        onTap: () => _openProduct(product),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
