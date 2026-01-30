import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v),
              decoration: InputDecoration(
                hintText: 'Cerca prodotti...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded),
                        onPressed: () =>
                            setState(() => _searchQuery = ''),
                      )
                    : null,
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
          const SizedBox(height: 12),

          // Product count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  '${filtered.length} prodotti',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white54 : Colors.black45,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.info_outline_rounded,
                  size: 14,
                  color: isDark ? Colors.white38 : Colors.black26,
                ),
                const SizedBox(width: 4),
                Text(
                  'Markup 30% incluso',
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? Colors.white38 : Colors.black26,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

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
                      childAspectRatio: 0.72,
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
