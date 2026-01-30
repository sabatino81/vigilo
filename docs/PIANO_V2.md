# Piano di Sviluppo Vigilo V2 — Dati Statici

## Stato: ✅ COMPLETATO

Tutte le 6 fasi implementate + refactor wallet unico + ricalibrazione economia punti + redesign check-in turno + pulizia file orfani + review consistenza codebase.

**Risultato finale: ~45 file nuovi/modificati, chiavi ARB aggiornate, zero errori `flutter analyze` (266 info/warning)**

---

## Riepilogo Modifiche Architetturali (post-piano)

### Refactor Wallet Unico
Il piano originale prevedeva DualWallet (Elmetto + Welfare separati). Durante l'implementazione il modello è stato semplificato:
- **DualWallet + WalletType + WelfarePlan** → **ElmettoWallet** (classe unica)
- Welfare non è un secondo wallet ma un **flag booleano** (`welfareActive`)
- File eliminati: `wallet_type.dart`, `welfare_plan.dart`
- Tutti i consumer aggiornati: punti_page, cart_page, checkout_page, product_detail_page, price_breakdown_widget, order_detail_page, profile_page

### Ricalibrazione Economia Punti
Conversione cambiata da **10 pt = 1 EUR** a **60 pt = 1 EUR**:
- Spesa media lavoratore: €100-150/mese (media €125)
- Generazione punti: ~1.500 pt/mese
- Valore mensile: €25/mese = 20% della spesa media → equilibrio flusso in/out
- Aggiornati: `elmetto_wallet.dart`, `ECOMMERCE_MODEL.md`, `SCORING_MODEL.md`, `WIREFRAMES_V2.md`, `BUSINESS_PROPOSAL_V2.md`

### Redesign Check-in Turno (ex Accesso Cantiere)
L'app non è solo per operai da cantiere ma per varie tipologie di lavoratore. Il sistema non rileva i DPI automaticamente — il lavoratore fa autodichiarazione:
- **"Accesso Cantiere"** → **"Check-in Turno"** con checklist DPI autodichiarata
- DPI richiesti variano per ruolo (`WorkerCategory`): operaio (4 DPI), caposquadra/preposto (3), rspp (2)
- Flow: apri app → vedi DPI per il tuo ruolo → spunta checklist → conferma → +10 punti
- `lib/features/checkin/domain/models/shift_checkin.dart` — DpiItem, DpiRequirement, ShiftCheckin
- `lib/features/checkin/presentation/widgets/shift_checkin_card.dart` — checklist interattiva, progress bar, conferma
- `DpiStatusCard` rimossa (incorporata nel check-in)
- `SiteAccessCard` rimossa (sostituita da ShiftCheckinCard)
- Rimosso "Cantiere Milano Nord" → nome azienda generico
- "BACHECA CANTIERE" → "BACHECA"
- Wireframes aggiornati con nuovo flow

### Pulizia File Orfani
- Eliminato `lib/features/home/presentation/widgets/site_access_card.dart`
- Eliminato `lib/features/dpi_status/presentation/widgets/dpi_status_card.dart`
- Eliminata directory `lib/features/dpi_status/`
- Rimossi file temporanei `tmpclaude-*` e `nul`

### Rename dual_wallet → elmetto_wallet
File e classe rinominati per coerenza con il modello wallet unico:
- `dual_wallet.dart` → `elmetto_wallet.dart`
- `dual_wallet_card.dart` → `elmetto_wallet_card.dart`
- `DualWalletCard` → `ElmettoWalletCard`
- Aggiornati 7 import: punti_page, cart_page, checkout_page, product_detail_page, price_breakdown_widget, elmetto_wallet_card, product_detail_page doc

### Sostituzione Terminologia "cantiere" → generica
Review completa della codebase per eliminare riferimenti specifici a cantieri edili, sostituiti con termini generici per lavoratori di qualsiasi settore:
- `app_notification.dart` — "Allerta meteo cantiere" → "Allerta meteo sede operativa"
- `vow_survey.dart` — "nel cantiere" → "sul luogo di lavoro"
- `sos_page.dart`, `report_form_page.dart`, `safety_report.dart` — "Cantiere A" → "Sede A"
- `quiz.dart` — "in cantiere" → "sul lavoro" / "in area di lavoro" (5 occorrenze)
- `training_content.dart` — "in cantiere" → "sul lavoro" / "in sicurezza" (3 occorrenze)
- `reward.dart` — "T-shirt cantiere" → "T-shirt aziendale", "in cantiere" → "sul lavoro" (3 occorrenze)
- `product.dart` — "per il cantiere" → "per il lavoro", "normativa cantieri" → "normativa vigente"
- `social_post.dart` — commenti doc: "del cantiere" → "aziendale"

### Revisione WIREFRAMES_V2.md
8 fix applicati al documento wireframe:
- "integrata in Accesso Cantiere" → "integrata in Check-in Turno con autodichiarazione"
- "Capocantiere" → "Preposto turno" (2 occorrenze SOS)
- "10 punti = 1 EUR" → "60 punti = 1 EUR"
- "Manuale sicurezza cantiere" → "Manuale sicurezza sul lavoro"
- Duplicato "EdilPro S.r.l." → "Reparto: Produzione"
- Punti profilo 1.200 → 1.800
- Aggiunta riga changelog v2.1

---

## FASE 1: Fondamenta (Tema + Wallet Unico) ✅

### 1.1 Colori Ambra/Teal in AppTheme ✅
- `lib/core/theme/app_theme.dart` — ambra (#FF8F00), teal (#00897B)

### 1.2 Modello ElmettoWallet ✅
- `lib/features/punti/domain/models/elmetto_wallet.dart` — ElmettoWallet + CheckoutBreakdown + calculateCheckout()
- `lib/features/punti/domain/models/points_transaction.dart` — semplificato (rimosso walletType)
- Conversione: 60 pt = 1 EUR, mock 1.800 pt
- ~~wallet_type.dart~~ eliminato
- ~~welfare_plan.dart~~ eliminato

### 1.3 Widget ElmettoWalletCard ✅
- `lib/features/punti/presentation/widgets/elmetto_wallet_card.dart` — wallet unico con badge welfare attivo/non attivo
- `lib/features/punti/presentation/punti_page.dart` — usa ElmettoWallet

### 1.4 Chiavi ARB ✅
- Chiavi welfare-specifiche rimosse, aggiunte walletWelfareActive e walletWelfareCompany

---

## FASE 2: Modulo Ecommerce ✅

### 2.1 Modelli Ecommerce ✅
- `lib/features/shop/domain/models/product_category.dart` — 6 categorie
- `lib/features/shop/domain/models/product_badge.dart` — enum badge
- `lib/features/shop/domain/models/product.dart` — Product con markup 30%, ~12 prodotti mock
- `lib/features/shop/domain/models/cart_item.dart` — CartItem
- `lib/features/shop/domain/models/order.dart` — Order + OrderStatus, companyPaysEur (ex welfareUsedEur)
- `lib/features/shop/domain/models/voucher.dart` — Voucher con codice e scadenza

### 2.2 Pagina Catalogo Prodotti ✅
- `lib/features/shop/presentation/pages/shop_page.dart` — griglia 2 colonne, filtro, search
- `lib/features/shop/presentation/widgets/product_card.dart` — card con emoji, badge overlay
- `lib/features/shop/presentation/widgets/category_filter_bar.dart` — chip orizzontali

### 2.3 Pagina Dettaglio Prodotto ✅
- `lib/features/shop/presentation/pages/product_detail_page.dart` — 5 scenari prezzo, BNPL ≥€50

### 2.4 Carrello e Checkout ✅
- `lib/features/shop/presentation/pages/cart_page.dart` — usa ElmettoWallet
- `lib/features/shop/presentation/pages/checkout_page.dart` — breakdown con workerPaysEur
- `lib/features/shop/presentation/widgets/price_breakdown_widget.dart` — "A carico azienda (welfare)"

### 2.5 Router Ecommerce ✅
- `lib/core/router/app_router.dart` — rotte /shop, /cart, /orders, /profile, /notifications, /streak, /challenge

---

## FASE 3: Profilo + Notifiche ✅

### 3.1 Pagina Profilo ✅
- `lib/features/profile/domain/models/user_profile.dart` — UserProfile con welfareActive (bool), WorkerCategory, TrustLevel
- `lib/features/profile/presentation/pages/profile_page.dart` — avatar, wallet compatto (Punti Elmetto + Welfare ATTIVO/Non attivo), safety stats, trust level, ordini, settings, logout

### 3.2 Centro Notifiche ✅
- `lib/features/notifications/domain/models/app_notification.dart` — AppNotification + NotificationCategory, 10 mock (allineate a wallet unico)
- `lib/features/notifications/presentation/pages/notifications_page.dart` — raggruppate per data, filtro categoria, toggle letto/non letto

### 3.3 Collegamento Header ✅
- `lib/shared/widgets/app_header.dart` — avatar tap → ProfilePage, badge Punti Elmetto (chip blu), campana tap → NotificationsPage (con badge count). Settings rimosso (ora nel Profilo). Modalità immersiva Android (barre di sistema nascoste)

### 3.4 Router + ARB ✅
- Rotte /profile, /notifications in app_router.dart

---

## FASE 4: Ordini e Tracking ✅

### 4.1 Lista Ordini ✅
- `lib/features/shop/presentation/pages/orders_page.dart`
- `lib/features/shop/presentation/widgets/order_tile.dart`
- `lib/features/shop/presentation/widgets/order_status_badge.dart`

### 4.2 Dettaglio Ordine ✅
- `lib/features/shop/presentation/pages/order_detail_page.dart` — "A carico azienda (welfare)" con companyPaysEur
- `lib/features/shop/presentation/widgets/tracking_timeline.dart`
- `lib/features/shop/presentation/widgets/voucher_display.dart`

### 4.3 Router + ARB ✅
- Rotte /orders, pulsante "I miei ordini" nel profilo

---

## FASE 5: Scoring + Dettagli Streak/Sfida ✅

### 5.1 Widget Feedback Punti ✅
- `lib/shared/widgets/points_earned_snackbar.dart` — "+X Punti Elmetto" ambra, auto-dismiss 2s

### 5.2 Collegamento Punti alle Azioni ✅
- Integrato nei widget esistenti (SOS, check-in, survey, quiz)

### 5.3 Pagina Dettaglio Streak ✅
- `lib/features/streak/domain/models/streak.dart` — Streak + StreakLevel (5 livelli: Fiammella→Inferno), moltiplicatori
- `lib/features/streak/presentation/pages/streak_detail_page.dart` — hero, calendario heatmap, progressione livelli, record personale

### 5.4 Pagina Dettaglio Sfida ✅
- `lib/features/team_challenge/domain/models/challenge.dart`
- `lib/features/team_challenge/presentation/pages/challenge_detail_page.dart`

### 5.5 Router + ARB ✅
- Rotte /streak, /challenge

---

## FASE 6: Check-in e Survey Potenziati ✅

### 6.1 Check-in Benessere Migliorato ✅
- Scala 5 emoji, campo note, feedback punti

### 6.2 Survey VOW Completo ✅
- `lib/features/team/domain/models/vow_survey.dart` — VowQuestion + VowSurvey
- `lib/features/team/presentation/pages/vow_survey_page.dart` — flow 5 domande, rating, anonimo, progress

### 6.3 ARB ✅

---

## Documentazione Aggiornata ✅

| Documento | Stato | Note |
|-----------|-------|------|
| `docs/07_ANALISI/ECOMMERCE_MODEL.md` | ✅ | Algoritmo checkout unificato, 60:1, scenari, BNPL, ciclo mensile |
| `docs/07_ANALISI/SCORING_MODEL.md` | ✅ | Algoritmo checkout, scenari A-D, tabella conversione 60:1 |
| `docs/07_ANALISI/BUSINESS_PROPOSAL_V2.md` | ✅ | Conversione 60:1, tabella punti/sconto |
| `docs/02_ARCHITETTURA/WIREFRAMES_V2.md` | ✅ | Wireframe con valori 60:1, check-in turno, nomi azienda generici |

---

## Commit History

| Commit | Descrizione |
|--------|-------------|
| `e028686` | Implement Vigilo V2: dual wallet, Spaccio Aziendale, scoring, profiles |
| `73c67a7` | Unify dual wallet into single Punti Elmetto wallet |
| `af56306` | Update ECOMMERCE_MODEL.md with unified checkout algorithm |
| `0a8fb82` | Update SCORING_MODEL.md with unified checkout algorithm |
| `901de2e` | Recalibrate points economy: 60 pt = 1 EUR (was 10:1) |
| `7b94462` | Update WIREFRAMES_V2 and BUSINESS_PROPOSAL_V2 with 60:1 conversion |
| `b61aaf2` | Align profile and notifications to unified wallet model |
| `ccd29fa` | Replace Accesso Cantiere with Check-in Turno (DPI self-declaration) |
| `bbd8ceb` | Remove orphaned files (site_access_card, dpi_status_card) |
| `ec7253c` | Fix WIREFRAMES_V2: generic terminology, correct values, changelog v2.1 |
| `b9773df` | Rename dual_wallet → elmetto_wallet and replace all cantiere references |

---

## Verifica End-to-End ✅

- `flutter analyze` — 266 info/warning, **zero errori**
- `flutter gen-l10n` — OK
- Wallet unico Punti Elmetto con badge welfare attivo/non attivo
- Spaccio Aziendale: catalogo → dettaglio → carrello → checkout (con calculateCheckout 60:1)
- Header: avatar → profilo, badge Punti Elmetto, campana → notifiche (settings rimosso, ora nel profilo)
- Feedback "+X Punti Elmetto" snackbar
- Streak e sfida con pagine dettaglio navigabili
- Check-in turno con autodichiarazione DPI per ruolo
- Survey VOW con nuova UX
- Ordini e tracking da profilo
- Tutte le stringhe localizzate IT/EN
- File orfani rimossi, codebase pulita
- Nessun riferimento residuo a "cantiere" nel codice Dart (solo in nomi file asset immagini)
- File e classi wallet rinominati per coerenza (elmetto_wallet, ElmettoWalletCard)
- Wireframes V2 allineati: terminologia generica, valori corretti, changelog v2.1
