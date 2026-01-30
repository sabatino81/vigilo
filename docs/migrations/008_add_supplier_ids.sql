-- 008: Add supplier IDs to products and product_variants
-- Supporta multi-supplier (BigBuy, Griffati, futuri)

-- ID prodotto nel sistema del supplier (es. BigBuy product ID, Rewix product ID)
ALTER TABLE public.products
  ADD COLUMN supplier_product_id TEXT;

-- ID variante nel sistema del supplier (es. Griffati model.id per piazzare ordini)
ALTER TABLE public.product_variants
  ADD COLUMN supplier_stock_id TEXT;

-- Indici per lookup rapido durante sync catalogo
CREATE INDEX idx_products_supplier_lookup
  ON public.products (supplier_name, supplier_product_id)
  WHERE supplier_product_id IS NOT NULL;

CREATE INDEX idx_variants_supplier_stock
  ON public.product_variants (supplier_stock_id)
  WHERE supplier_stock_id IS NOT NULL;
