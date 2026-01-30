import 'package:vigilo/core/data/base_repository.dart';
import 'package:vigilo/features/shop/domain/models/product.dart';

/// Repository per catalogo prodotti via Supabase RPC.
class ProductRepository extends BaseRepository {
  const ProductRepository(super.client);

  /// Lista prodotti attivi, opzionalmente filtrata per categoria.
  Future<List<Product>> getProducts({String? category}) async {
    final json = await rpc<List<dynamic>>(
      'get_products',
      params: {
        if (category != null) 'p_category': category,
      },
    );
    return json
        .whereType<Map<String, dynamic>>()
        .map(Product.fromJson)
        .toList();
  }
}
