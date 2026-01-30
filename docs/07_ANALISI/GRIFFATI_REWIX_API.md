# Griffati / Rewix — Analisi API Dropshipping

> Analisi completa delle API Rewix (piattaforma B2B di Griffati) per integrazione dropshipping fashion nel modulo Spaccio Aziendale di Vigilo.

---

## Indice

1. [Overview Griffati](#overview-griffati)
2. [Costi e Piani](#costi-e-piani)
3. [Autenticazione API](#autenticazione-api)
4. [Endpoint Completi](#endpoint-completi)
5. [Catalogo Prodotti](#catalogo-prodotti)
6. [Varianti (models)](#varianti-models)
7. [Ordine Dropshipping](#ordine-dropshipping)
8. [Status Ordine e Tracking](#status-ordine-e-tracking)
9. [Corrieri](#corrieri)
10. [Resi](#resi)
11. [Mapping con DB Vigilo](#mapping-con-db-vigilo)
12. [Gap Analysis](#gap-analysis)
13. [Riferimenti](#riferimenti)

---

## Overview Griffati

Griffati e un B2B fashion dropshipping con:

- **10.000+** prodotti disponibili per dropshipping
- **300+** brand (Tommy Hilfiger, Armani Exchange, Calvin Klein, ecc.)
- **500.000+** prodotti nel catalogo wholesale completo
- Categorie: abbigliamento uomo/donna, accessori, calzature, borse, cosmetici
- Disponibile in 24 lingue
- Spedizione anonima (senza branding Griffati) tramite **UPS** e **DHL**
- Nessun ordine minimo

La piattaforma tecnologica sottostante e **Rewix**, che espone API REST documentate.

---

## Costi e Piani

| Piano | Costo | Note |
|-------|-------|------|
| Membership annuale | 90 EUR + IVA | Obbligatoria |
| Fee mensile dropship (API/CSV/JSON) | 90 EUR/mese + IVA | Servizio base |
| Fee mensile dropship (Prestashop/WooCommerce) | 120 EUR/mese + IVA | Plugin dedicati |
| Shopify (Sync2Fashion) | $49/mese o $499/anno | App dedicata |

**Margini esempio:**
- Tommy Hilfiger: costo 54.90 EUR → retail 118.80 EUR (margine ~41 EUR)
- Armani Exchange: costo 67.90 EUR → retail 118.90 EUR (margine ~51 EUR)
- Sconti fino al 65% sul prezzo retail

---

## Autenticazione API

**Metodo:** HTTP Basic Authentication (RFC 2617)

| Parametro | Valore |
|-----------|--------|
| Username | API-Key (fornita dal supplier) |
| Password | Password account supplier |
| Header | `Authorization: Basic <base64(api_key:password)>` |

```
Authorization: Basic QWxhZGRpbjpPcGVuU2VzYW1l
```

### Header richiesti

| Header | Valore | Quando |
|--------|--------|--------|
| `Authorization` | `Basic <encoded>` | Sempre |
| `Accept` | `application/json` | GET (catalogo, status) |
| `Content-Type` | `application/json` | POST (ordini) |

### HTTP Status Codes

| Code | Significato |
|------|-------------|
| 200 | Successo |
| 401 | Non autorizzato (credenziali invalide) |
| 404 | Risorsa non trovata |
| 406 | Accept header non valido |
| 500 | Errore interno server |

---

## Endpoint Completi

| Metodo | Endpoint | Funzione |
|--------|----------|----------|
| `GET` | `/restful/export/api/products.json` | Catalogo prodotti (JSON) |
| `GET` | `/restful/export/api/products.xml` | Catalogo prodotti (XML) |
| `GET` | `/restful/export/carriers` | Lista corrieri disponibili |
| `POST` | `/restful/ghost/orders/0/dropshipping` | Piazza ordine dropshipping |
| `GET` | `/restful/ghost/orders/dropshipping/locked/` | Stato reservation (prodotti riservati) |
| `GET` | `/restful/ghost/clientorders/serverkey/{order_id}` | Stato ordine + tracking |
| `GET` | `/restful/ghost/returnedgoods/serverkey/{order_id}` | Stato reso per ordine |

---

## Catalogo Prodotti

### Endpoint

```
GET /restful/export/api/products.json?v=TEAL&acceptedlocales=it_IT,en_US
```

### Query Parameters

| Parametro | Descrizione | Valori | Obbligatorio |
|-----------|-------------|--------|--------------|
| `v` | Versione API | `LEGACY`, `TEAL` | No (raccomandato: TEAL) |
| `acceptedlocales` | Lingue (comma-separated) | `it_IT`, `en_US`, `fr_FR`, ecc. | Si |
| `since` | Aggiornamenti incrementali | ISO 8601 timestamp | No |
| `tag_1` | Filtro brand | Nome brand | No |
| `tag_4` | Filtro categoria | `clothing`, `accessories`, `bags`, `cosmetics`, `underwear`, `shoes` | No |
| `tag_26` | Filtro genere | `kids`, `women`, `unisex`, `men` | No |
| `tag_11` | Filtro stagione | `fw`, `ss`, `all-year` | No |

**Aggiornamento dati:** ogni 15 minuti. Usare `?since=<timestamp>` per sync incrementale.

### Risposta JSON (v=TEAL)

```json
{
  "pageItems": [
    {
      "id": 82105,
      "name": "T-Shirt Logo Uomo",
      "code": "SKU-12345",
      "streetPrice": 159.00,
      "suggestedPrice": 79.90,
      "taxable": 39.90,
      "bestTaxable": 39.90,
      "currency": "EUR",
      "weight": 2,
      "availability": 74,
      "madein": "Italy",
      "hs": "64035119",
      "online": true,
      "intangible": false,
      "images": [
        {
          "id": 164458,
          "url": "/prod/stock_SKU-12345.jpg"
        }
      ],
      "models": [
        {
          "id": 234225,
          "model": "36",
          "code": "SKU-12345_36",
          "color": "black",
          "size": "36",
          "barcode": "",
          "streetPrice": 159.00,
          "suggestedPrice": 79.90,
          "taxable": 39.90,
          "availability": 5,
          "backorder": false,
          "lastUpdate": "2020-07-23T09:57:46.090087Z"
        }
      ],
      "productLocalizations": {
        "description": {
          "it_IT": { "value": "Descrizione prodotto in italiano" },
          "en_US": { "value": "Product description in English" }
        }
      },
      "tags": [
        { "id": 5, "name": "color", "value": "black" },
        { "id": 1, "name": "brand", "value": "Tommy Hilfiger" }
      ]
    }
  ],
  "totalItems": 209,
  "lastUpdate": "2020-08-03T13:48:50.910Z"
}
```

### Campi Prodotto

| Campo | Tipo | Descrizione |
|-------|------|-------------|
| `id` | int | ID prodotto Rewix |
| `name` | string | Nome prodotto |
| `code` | string | SKU prodotto |
| `streetPrice` | double | Prezzo retail consigliato |
| `suggestedPrice` | double | Prezzo rivendita suggerito |
| `taxable` | double | **Nostro prezzo d'acquisto** |
| `bestTaxable` | double | Miglior prezzo disponibile |
| `currency` | string | Valuta (EUR) |
| `weight` | double | Peso in kg |
| `availability` | int | Stock totale (somma di tutte le varianti) |
| `madein` | string | Paese di produzione |
| `hs` | string | Codice doganale |
| `online` | bool | Prodotto attivo |
| `intangible` | bool | Prodotto digitale (voucher) |
| `images` | array | Immagini (path relativi) |
| `models` | array | **Varianti** (taglia/colore) |
| `productLocalizations` | object | Descrizioni localizzate |
| `tags` | array | Tag (brand, colore, categoria, ecc.) |

---

## Varianti (models)

Ogni prodotto ha un array `models[]` che rappresenta le varianti (taglie, colori).

### Campi Variante

| Campo | Tipo | Descrizione |
|-------|------|-------------|
| `id` | int | **stock_id** — usato per ordini e reservation |
| `model` | string | Label variante (es. "36", "M", "L") |
| `code` | string | SKU variante (es. "SKU-12345_36") |
| `color` | string | Colore |
| `size` | string | Taglia |
| `barcode` | string | EAN/UPC |
| `streetPrice` | double | Prezzo retail variante |
| `suggestedPrice` | double | Prezzo rivendita suggerito |
| `taxable` | double | **Prezzo acquisto variante** |
| `availability` | int | **Stock disponibile per questa variante** |
| `backorder` | bool | Disponibile in backorder |
| `lastUpdate` | string | Ultimo aggiornamento (ISO 8601) |

### Nota su prezzi variante

Ogni `model` puo avere un prezzo diverso dal prodotto padre. Il prezzo effettivo per Vigilo si calcola:

```
prezzo_vigilo = model.taxable * 1.30   (markup 30%)
```

Se il prezzo variante e uguale al prodotto padre, si usa il `base_price` del prodotto.

---

## Ordine Dropshipping

### Endpoint

```
POST /restful/ghost/orders/0/dropshipping
```

### Request Body (JSON)

```json
{
  "key": "VIG-2026-0042",
  "date": "2026/01/30 14:30:00 +0100",
  "carrierId": 1,
  "autoConfirm": true,
  "recipient": "Marco Rossi",
  "street_name": "Via della Sicurezza",
  "address_number": "42",
  "zip": "20100",
  "city": "Milano",
  "province": "MI",
  "countrycode": "IT",
  "notes": "Ordine Vigilo Safety App",
  "items": [
    { "stock_id": 234225, "quantity": 1 },
    { "stock_id": 234230, "quantity": 2 }
  ]
}
```

### Campi Richiesta

| Campo | Tipo | Obbligatorio | Descrizione |
|-------|------|--------------|-------------|
| `key` | string | Si | Nostro ID ordine (es. "VIG-2026-0042") |
| `date` | string | Si | Data ordine (formato: `yyyy/MM/dd HH:mm:ss Z`) |
| `carrierId` | int | No | ID corriere (default se omesso) |
| `autoConfirm` | bool | No | Default: true |
| `recipient` | string | Si | Nome destinatario |
| `street_name` | string | Si | Via |
| `address_number` | string | Si | Numero civico |
| `zip` | string | Si | CAP |
| `city` | string | Si | Citta |
| `province` | string | Si | Provincia |
| `countrycode` | string | Si | ISO 3166-1 alpha-2 (es. "IT") |
| `careof` | string | No | C/O |
| `cfpiva` | string | No | Codice fiscale / P.IVA |
| `notes` | string | No | Note ordine |
| `items` | array | Si | Array di `{stock_id, quantity}` |

### Risposta

```json
{
  "order_id": 12345,
  "models": [
    {
      "stock_id": 234225,
      "locked": 1,
      "available": 4
    }
  ]
}
```

**Nota:** Si raccomanda di inserire un ordine alla volta per migliori performance.

---

## Status Ordine e Tracking

### Endpoint

```
GET /restful/ghost/clientorders/serverkey/{order_id}
```

### Risposta JSON

```json
{
  "orders": [
    {
      "order_id": 114,
      "ext_ref": "VIG-2026-0042",
      "status": 5,
      "last_update": "2026/01/29 17:05:25 +0000",
      "tracking_code": "1Z999AA10123456784",
      "tracking_url": "https://www.ups.com/track?tracknum=1Z999AA10123456784",
      "carrier_name": "UPS",
      "substatus": null,
      "parsedDate": 1611939925000
    }
  ]
}
```

### Codici Status

| Code | Valore | Significato |
|------|--------|-------------|
| 0 | PENDING | Fase gestione carrello |
| 1 | MONEY WAITING | In attesa pagamento |
| 2 | TO DISPATCH | Pronto per spedizione |
| 3 | DISPATCHED | **Spedito** (tracking disponibile) |
| 5 | BOOKED | Creato via API |
| 2000 | CANCELLED | Ordine annullato |
| 2002 | VERIFY FAILED | Pagamento rifiutato |
| 3001 | WORKING ON | In lavorazione logistica |
| 3002 | READY | Disponibile per ritiro |
| 5003 | DROPSHIPPER GROWING | Prodotti virtuali riservati |

### Mapping status Rewix → Vigilo

| Rewix Code | Vigilo `order_status` |
|------------|----------------------|
| 5 (BOOKED) | `confirmed` |
| 3001 (WORKING ON) | `processing` |
| 2 (TO DISPATCH) | `processing` |
| 3 (DISPATCHED) | `shipped` |
| 3002 (READY) | `delivered` |
| 2000 (CANCELLED) | `cancelled` |

---

## Corrieri

### Endpoint

```
GET /restful/export/carriers
```

### Risposta JSON

```json
[
  { "id": 1, "name": "UPS", "cost": 5.90 },
  { "id": 2, "name": "DHL", "cost": 7.50 }
]
```

**Nota:** La lista corrieri e personalizzata per account. Se il corriere specificato non puo servire la destinazione, viene assegnato un alternativo.

---

## Resi

### Endpoint Status Reso

```
GET /restful/ghost/returnedgoods/serverkey/{order_id}
```

### Campi Risposta

| Campo | Tipo | Descrizione |
|-------|------|-------------|
| `refundStatus` | int | 0 = non rimborsato, 1 = rimborsato |
| `pdfLink` | string | PDF manifesto reso |
| `returnCode` | string | Codice autorizzazione reso |
| `stockModelId` | int | ID variante (stock_id) |
| `notes` | string | Note |
| `requestExtRef` | string | Riferimento esterno |
| `quantity` | int | Quantita (sempre 1) |
| `status` | int | Codice stato reso |

### Codici Status Reso

| Code | Valore | Significato |
|------|--------|-------------|
| 0 | PENDING | In attesa approvazione |
| 1 | AUTHORIZED_C | Autorizzato, spedizione a carico cliente |
| 2 | AUTHORIZED | Autorizzato, spedizione a carico supplier |
| 3 | RECEIVED_OK | Ricevuto in buone condizioni |
| 4 | RECEIVED_NOK | Ricevuto in cattive condizioni |
| 5 | NOT_RECEIVED | Non ricevuto |
| 7 | REFUSED | Non autorizzato |
| 9 | COMPLETED | Reso completato |

---

## Mapping con DB Vigilo

### Prodotto → `products` table

| Campo Vigilo | Campo Rewix | Trasformazione |
|-------------|-------------|----------------|
| `id` (UUID) | — | Generato da Supabase |
| `name` | `name` | Diretto |
| `description` | `productLocalizations.description.it_IT.value` | Localizzato |
| `category` | `tags[tag_4]` | Mapping: clothing→abbigliamento, shoes→calzature, ecc. |
| `base_price` | `taxable * 1.30` | Markup 30% |
| `emoji` | — | Assegnato per categoria |
| `badge` | `tags` | Mapping da tag promo |
| `promo_discount_percent` | `(streetPrice - suggestedPrice) / streetPrice * 100` | Se applicabile |
| `supplier_name` | `'Griffati'` (costante) | Identifica il supplier |
| `supplier_product_id` | `id` (int → text) | ID prodotto Rewix (es. "82105") |
| `image_url` | `images[0].url` | Prefissare con base URL Griffati |

### Variante → `product_variants` table

| Campo Vigilo | Campo Rewix | Trasformazione |
|-------------|-------------|----------------|
| `id` (UUID) | — | Generato da Supabase |
| `product_id` (FK) | `id` (prodotto padre) | Lookup |
| `variant_label` | `size` + `color` | Composto (es. "M - Nero") |
| `attributes` (JSONB) | `{size, color, barcode, model}` | Strutturato |
| `price` | `model.taxable * 1.30` | NULL se uguale a base_price |
| `image_url` | — | Se variante ha immagine specifica |
| `supplier_sku` | `model.code` | SKU variante (es. "SKU-12345_36") |
| `supplier_stock_id` | `model.id` (int → text) | ID numerico Rewix per piazzare ordini (es. "234225") |
| `stock_status` | `model.availability` | `> 0` → 'available', `0` → 'out_of_stock' |

### Ordine → Rewix

| Dato Vigilo | Campo Rewix | Note |
|------------|-------------|------|
| `order.id` | `key` | Nostro UUID come riferimento |
| `order_items[].variant_id` → `supplier_stock_id` | `items[].stock_id` | Lookup: variant → supplier_stock_id → Rewix stock_id |
| Indirizzo utente | `recipient`, `street_name`, ecc. | Dal profilo utente |
| `order.status` | Polling `GET /clientorders/serverkey/{id}` | Mapping status codes |
| `order.tracking_code` | `tracking_code` da status response | Quando status = 3 (DISPATCHED) |

---

## Gap Analysis

### Cosa abbiamo gia (compatibile)

- **`product_variants` table** con `variant_label`, `attributes` JSONB, `price` nullable, `supplier_sku`, `stock_status` — matcha perfettamente con `models[]` di Rewix
- **`products.supplier_product_id`** (text) — ID prodotto nel sistema del supplier (migrazione 008)
- **`product_variants.supplier_stock_id`** (text) — ID variante nel sistema del supplier, usato per piazzare ordini Rewix (migrazione 008)
- **`products.supplier_name`** (text) — distingue BigBuy vs Griffati
- **Indici parziali** su `(supplier_name, supplier_product_id)` e `(supplier_stock_id)` per lookup rapido durante sync
- **`order_items.variant_id`** — gia pronto per ordini per variante
- **RPC `place_order`** con `p_variant_ids` — gia predisposto
- **UI variant selector** (ChoiceChip) — gia implementato
- **Carrello per variant_id** — gia funzionante

### Cosa manca (da implementare)

| # | Cosa | Dove | Priorita |
|---|------|------|----------|
| ~~1~~ | ~~Colonna `supplier_product_id` su `products`~~ | ~~DB migration~~ | ✅ Fatto (008) |
| ~~2~~ | ~~Colonna `supplier_stock_id` su `product_variants`~~ | ~~DB migration~~ | ✅ Fatto (008) |
| 3 | Base URL immagini per supplier | Config Edge Function o env var | Media |
| 4 | Edge Function: sync catalogo Griffati | `supabase/functions/sync-griffati/` | Alta |
| 5 | Edge Function: piazza ordine dropshipping | `supabase/functions/place-order-supplier/` | Alta |
| 6 | Edge Function: polling status ordine + tracking | `supabase/functions/poll-order-status/` | Alta |
| 7 | Mapping categorie Rewix → Vigilo `ProductCategory` | Enum/tabella | Media |
| 8 | Gestione resi via API | RPC + Edge Function | Bassa |
| 9 | Cron job sync incrementale (`?since=`) ogni 15 min | pg_cron o scheduled function | Media |
| 10 | Indirizzo spedizione utente (attualmente mock) | Profilo utente + form | Alta |

### Flusso completo da implementare

```
1. SYNC CATALOGO (scheduled, ogni 15 min)
   Edge Function chiama GET /products.json?v=TEAL&since=<last_sync>
   → Upsert products + product_variants nel DB Vigilo
   → Aggiorna stock_status per ogni variante

2. CHECKOUT (utente conferma ordine)
   RPC place_order salva ordine nel DB Vigilo (status: confirmed)
   → Trigger/webhook chiama Edge Function place-order-griffati
   → POST /ghost/orders/0/dropshipping con stock_id + indirizzo
   → Salva order_id Rewix nel DB

3. TRACKING (polling periodico)
   Edge Function poll-order-status (ogni 2h per ordini attivi)
   → GET /ghost/clientorders/serverkey/{rewix_order_id}
   → Aggiorna status + tracking_code + tracking_url nel DB
   → Push notification se status cambia a DISPATCHED

4. RESO (su richiesta utente)
   → Crea return request via Rewix API
   → Polling status reso
```

---

## Riferimenti

- Griffati Dropshipping: https://www.griffati.com/it/dropshipping.html
- Rewix API Docs: https://developer.rewixecommerce.com/
- Products Endpoint: https://developer.rewixecommerce.com/catalog/products/
- Send Order Dropshipping: https://developer.rewixecommerce.com/reservations-and-orders/send-order-dropshipping/
- Order Status: https://developer.rewixecommerce.com/reservations-and-orders/order-status-order-id/
- Carriers: https://developer.rewixecommerce.com/reservations-and-orders/carriers/
- Return Requests: https://developer.rewixecommerce.com/reservations-and-orders/return-requests-order-id/

---

*Documento generato il 30/01/2026 — Analisi API per integrazione Spaccio Aziendale Vigilo*
