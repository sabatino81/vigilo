-- Migration: 007_shop_orders
-- Tabelle e RPC per ecommerce, ordini e voucher.
-- Applicata via Supabase MCP in 2 migrazioni:
--   - create_shop_order_tables
--   - create_shop_order_rpc_functions

-- ============================================================
-- TABELLE
-- ============================================================

-- products: catalogo prodotti ecommerce
--   name, description, category, base_price (con markup 30%),
--   emoji, badge, promo_discount_percent, supplier_name, is_active

-- orders: ordini ecommerce con codice VIG-YYYY-NNNNN
--   user_id, order_code, total_eur, company_pays_eur,
--   elmetto_points_used, elmetto_discount_eur, final_price_eur,
--   shipping_eur, status, tracking_code, estimated_delivery, used_bnpl

-- order_items: righe ordine
--   order_id, product_id, quantity, unit_price

-- vouchers: buoni digitali
--   user_id, code, product_name, value_eur, barcode, is_used,
--   issued_at, expires_at

-- order_code_seq: sequence per codici leggibili VIG-2025-00001

-- ============================================================
-- RPC FUNCTIONS
-- ============================================================

-- get_products(p_category?)
--   → catalogo prodotti attivi, opzionalmente filtrati per categoria
--
-- calculate_checkout(p_product_ids, p_quantities)
--   → preview breakdown: total, welfare, elmetto discount, final price
--   → NO side effects (solo lettura)
--
-- place_order(p_product_ids, p_quantities, p_use_bnpl?)
--   → transazionale: genera codice, inserisce ordine + items,
--     deduce punti via award_points()
--   → checkout order: welfare first, then elmetto (max 20%)
--
-- get_my_orders(p_limit, p_offset)
--   → storico ordini con items (join products per nome/emoji)
--
-- get_my_vouchers()
--   → buoni digitali utente
