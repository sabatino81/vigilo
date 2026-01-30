-- 009: Add cost_price and elmetto_discount_percent to products
-- cost_price: prezzo di acquisto dal supplier (taxable Rewix, costo BigBuy)
-- elmetto_discount_percent: sconto max Punti Elmetto per prodotto (default 20%)

ALTER TABLE public.products
  ADD COLUMN cost_price DOUBLE PRECISION;

ALTER TABLE public.products
  ADD COLUMN elmetto_discount_percent INTEGER NOT NULL DEFAULT 20;
