# Vigilo - Spaccio Aziendale (Modello Ecommerce)

> Architettura, catalogo, pricing, logistica e flussi operativi dello Spaccio Aziendale integrato

---

## Principi fondamentali

| Principio                    | Descrizione                                                                                    |
|------------------------------|------------------------------------------------------------------------------------------------|
| **Catalogo unico**          | Stesso catalogo per tutti i lavoratori nello Spaccio Aziendale, tutte le aziende, tutti i settori. Nessuna personalizzazione per azienda |
| **100% dropshipping**       | Nessun magazzino proprio. Tutti i prodotti spediti dal fornitore direttamente al lavoratore    |
| **Ricarico fisso 30%**      | Prezzo Vigilo = costo fornitore + 30%. Margine semplice, prevedibile, scalabile               |
| **Sconto max 20%**          | I Punti Elmetto danno sconto fino al 20% sul prezzo Vigilo. Il margine minimo è sempre positivo |
| **Welfare fino a 100%**     | Con welfare attivo (`welfareActive = true`), l'azienda copre fino al 100% del prezzo (la parte eccedente lo sconto Punti Elmetto del 20%) |
| **Spedizione a carico del lavoratore** | Anche con riscatto welfare 100%, il lavoratore paga la spedizione                   |
| **BNPL con interessi al cliente** | Pagamento dilazionato disponibile, interessi a carico del lavoratore                     |

---

## Catalogo prodotti

### Categorie

Catalogo generalista, non verticale sulla sicurezza. Lo Spaccio Aziendale offre prodotti utili per la vita quotidiana, non solo per il lavoro — come un vero spaccio aziendale riservato ai dipendenti:

| Categoria                    | Esempi                                                              | Range prezzo     |
|------------------------------|---------------------------------------------------------------------|------------------|
| **Casa e giardino**          | Utensili, piccoli elettrodomestici, giardinaggio, pulizia, arredo   | €10 - €200       |
| **Abbigliamento**            | Casual, sportivo, workwear, calzature, accessori                    | €15 - €150       |
| **Tecnologia**               | Smartphone, tablet, cuffie, power bank, smart home, accessori PC    | €10 - €500       |
| **Consumabili**              | Integratori, igiene personale, cura corpo, alimentari, bevande      | €5 - €50         |
| **Sport e tempo libero**     | Attrezzatura fitness, outdoor, camping, bici, accessori sport       | €10 - €300       |
| **Voucher e gift card**      | Amazon, Decathlon, carte carburante, cinema, ristoranti, viaggi     | €10 - €100       |

### Principi del catalogo

| Aspetto                      | Regola                                                                                          |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Personalizzazione**        | Zero. Catalogo uguale per tutti. Nessun catalogo per azienda                                   |
| **Ampiezza**                 | Massima. Più prodotti nello Spaccio = più motivi per aprire l'app e spendere punti             |
| **Profondità**               | Media. Non serve avere 50 varianti dello stesso prodotto                                        |
| **Aggiornamento**            | Rotazione mensile dei prodotti in evidenza. Novità e stagionalità                               |
| **Prodotti esclusi**         | Alcolici, tabacco, armi, farmaci, contenuti adulti                                              |
| **Qualità minima**           | Solo fornitori con rating >4 stelle e tasso reso <5%                                            |

---

## Modello economico

### Pricing

```
Prezzo fornitore (costo):     €100.00
Ricarico Vigilo (30%):       + €30.00
─────────────────────────────────────
Prezzo Vigilo (al pubblico):  €130.00
```

Il ricarico del 30% è fisso su tutto il catalogo dello Spaccio Aziendale. Non ci sono prezzi "scontati" o "in offerta" da parte di Vigilo — il prezzo è unico. L'unico sconto possibile arriva dai Punti Elmetto del lavoratore.

### Equilibrio economico punti ↔ spesa

Il sistema è calibrato perché i punti generati mensilmente coprano circa il **20% della spesa media** del lavoratore, così non accumula troppi punti inutilizzati e non ne ha troppo pochi per sentire il beneficio.

```
Spesa media lavoratore:      €100 - €150/mese (media €125)
Target sconto da punti:      20% di €125 = €25/mese
Generazione punti:           ~1.500 pt/mese (lavoratore attivo)
Conversione necessaria:      1.500 pt ÷ €25 = 60 pt per EUR
─────────────────────────────────────────────────────────────
Risultato: 60 Punti Elmetto = 1 EUR
```

| Parametro | Valore |
|-----------|--------|
| **Conversione** | 60 pt = 1 EUR |
| **Generazione** | ~1.500 pt/mese (lavoratore attivo, vedi SCORING_MODEL.md) |
| **Valore mensile** | €25/mese in sconti potenziali |
| **Valore annuo** | ~18.000 pt/anno = ~€300/anno |
| **Spesa media target** | €100-150/mese (€125 medio) |
| **Copertura punti** | ~20% della spesa → equilibrio flusso in/out |

**Perché 20% è il punto di equilibrio**:
- **Troppo alto (>30%)**: il lavoratore accumula punti più velocemente di quanto spende → hoarding, punti percepiti come "infiniti", meno urgenza di acquisto
- **Troppo basso (<10%)**: lo sconto è impercettibile, il lavoratore non sente il beneficio → disengagement
- **20% giusto**: il lavoratore vede uno sconto reale (€5-25 per acquisto), spende i punti regolarmente, il ciclo mensile si chiude naturalmente

**Nota**: i valori delle azioni (5, 10, 15, 30 pt...) restano invariati rispetto a SCORING_MODEL.md. Cambia solo il tasso di conversione pts→EUR.

### Algoritmo checkout (`ElmettoWallet.calculateCheckout`)

```
Input:
  totalEur            = prezzo prodotto (es. €45)
  puntiElmetto        = saldo punti del lavoratore (es. 1800)
  welfareActive       = boolean (welfare aziendale attivo?)

Costanti:
  elmettoPerEur            = 60     (60 pt = 1 EUR)
  maxDiscountNoWelfare     = 20%
  maxDiscountWithWelfare   = 100%

Calcolo:
  1. elmettoValueEur    = puntiElmetto / 60       → valore EUR dei punti
  2. maxDiscountPercent  = welfareActive ? 100% : 20%
  3. maxDiscount         = totalEur × maxDiscountPercent / 100
  4. elmettoDiscountEur  = min(elmettoValueEur, maxDiscount)
  5. elmettoPointsUsed   = round(elmettoDiscountEur × 60)
  6. workerPaysEur       = totalEur − elmettoDiscountEur
  7. baseDiscount        = totalEur × 20 / 100     → la quota che Vigilo assorbe
  8. companyPaysEur      = (welfareActive && elmettoDiscountEur > baseDiscount)
                            ? elmettoDiscountEur − baseDiscount
                            : 0
  9. isFullyFree         = workerPaysEur ≤ 0
 10. isBnplAvailable     = workerPaysEur ≥ 50
```

**Logica chiave**: lo sconto Punti Elmetto si applica in un'unica passata (fino al cap %). La quota che eccede il 20% base viene fatturata all'azienda come welfare. Vigilo assorbe sempre e solo fino al 20% del prezzo dal suo margine.

### Scenari di acquisto

**Conversione: 60 pt = 1 EUR. Generazione: ~1.500 pt/mese = €25. Spesa media: €125/mese.**

Lavoratore con 1.800 pt (€30, ~5 settimane di accumulo), prodotto medio €45 (costo fornitore ~€35, ricarico 30%):

| # | Scenario | welfareActive | Sconto Elmetto | Punti usati | Lavoratore paga | Azienda paga | Margine Vigilo |
|---|----------|:---:|---:|---:|---:|---:|---:|
| 1 | **Nessun punto usato** | no | €0 (0%) | 0 | €45 | €0 | €10.50 (23%) |
| 2 | **Sconto 10%** | no | €4.50 | 270 | €40.50 | €0 | €6 (13%) |
| 3 | **Sconto 20% (max)** | no | €9 | 540 | €36 | €0 | €1.50 (3%) |
| 4 | **Welfare + punti sufficienti** | si | €45 | 2700 | €0 | €36 | €10.50 (23%) |
| 5 | **Welfare + punti parziali (1800 pt)** | si | €30 | 1800 | €15 | €21 | €10.50 (23%) |
| 6 | **Welfare + zero punti** | si | €0 | 0 | €45 | €0 | €10.50 (23%) |

**Dettaglio scenario 3** (sconto massimo senza welfare):
```
totalEur = €45, puntiElmetto = 1800 (€30), welfareActive = false
maxDiscount = 45 × 20% = €9
elmettoDiscountEur = min(30, 9) = €9         ← cap al 20%
elmettoPointsUsed = 9 × 60 = 540 pt
workerPaysEur = 45 − 9 = €36                ← il lavoratore paga il resto
companyPaysEur = €0
```
Lo sconto è capped a €9 (20%) anche se il lavoratore ha €30 in punti. I punti rimanenti restano nel wallet per acquisti futuri.

**Dettaglio scenario 4** (welfare attivo, punti sufficienti):
```
totalEur = €45, puntiElmetto = 2700 (€45), welfareActive = true
maxDiscount = 45 × 100% = €45
elmettoDiscountEur = min(45, 45) = €45       ← copertura totale
elmettoPointsUsed = 45 × 60 = 2700 pt
workerPaysEur = 45 − 45 = €0                ← gratis per il lavoratore!
baseDiscount = 45 × 20% = €9                ← quota assorbita da Vigilo
companyPaysEur = 45 − 9 = €36               ← fatturato all'azienda
```
Vigilo incassa €36 (azienda) + €9 (dal margine) = €45 → margine €10.50 intatto.

**Dettaglio scenario 5** (welfare attivo, punti parziali):
```
totalEur = €45, puntiElmetto = 1800 (€30), welfareActive = true
maxDiscount = 45 × 100% = €45
elmettoDiscountEur = min(30, 45) = €30       ← limitato dai punti
elmettoPointsUsed = 30 × 60 = 1800 pt
workerPaysEur = 45 − 30 = €15               ← paga il resto
baseDiscount = 45 × 20% = €9
companyPaysEur = 30 − 9 = €21               ← fatturato all'azienda
```
Il lavoratore paga €15 + spedizione. L'azienda copre €21 (la quota che eccede il 20%).

### Ciclo mensile tipico (lavoratore medio, senza welfare)

```
Inizio mese: 600 pt in wallet (residuo mese precedente)

Settimana 1:  +375 pt guadagnati  →  saldo 975 pt (€16.25)
              Acquisto €30        →  sconto 20% = €6 (360 pt) → saldo 615 pt
Settimana 2:  +375 pt guadagnati  →  saldo 990 pt (€16.50)
              Acquisto €25        →  sconto 20% = €5 (300 pt) → saldo 690 pt
Settimana 3:  +375 pt guadagnati  →  saldo 1065 pt (€17.75)
              Acquisto €40        →  sconto 20% = €8 (480 pt) → saldo 585 pt
Settimana 4:  +375 pt guadagnati  →  saldo 960 pt (€16.00)
              Acquisto €30        →  sconto 20% = €6 (360 pt) → saldo 600 pt

Fine mese: 600 pt in wallet (equilibrio!)
─────────────────────────────────────────────────
Spesa totale:   €125
Sconti totali:  €25 (20% medio)
Punti generati: 1.500
Punti spesi:    1.500
```

Il ciclo è in equilibrio: il lavoratore genera e spende circa 1.500 pt/mese. Non accumula, non resta a secco.

### Margine per scenario (su costo fornitore €35, prezzo Vigilo €45)

| Scenario | Incasso Vigilo | Di cui da azienda | Costo fornitore | Margine lordo | Margine % |
|----------|---:|---:|---:|---:|---:|
| Prezzo pieno (no punti) | €45 | €0 | €35 | €10.50 | 23.1% |
| Sconto 10% Elmetto, no welfare | €40.50 | €0 | €35 | €5.50 | 12.2% |
| Sconto 20% Elmetto (max), no welfare | €36 | €0 | €35 | €1.50 | 3.3% |
| Welfare attivo, sconto 100% | €45 | €36 | €35 | €10.50 | 23.1% |
| Welfare attivo, sconto parziale | €45 | €21 | €35 | €10.50 | 23.1% |

**Nota**: con welfare attivo Vigilo incassa sempre il prezzo pieno — la quota non pagata dal lavoratore viene fatturata all'azienda. Il margine rimane intatto. Senza welfare il margine minimo è ~3.3% (sconto max 20%).

Su una spesa media di €125/mese con sconto medio 20%:
- Lavoratore risparmia: €25/mese (€300/anno)
- Vigilo incassa: €100/mese per utente (dopo sconti, prima della quota welfare)
- Con welfare attivo: Vigilo incassa il prezzo pieno da lavoratore + azienda

### Promozioni e sconti

Il 30% di ricarico è calcolato sul **costo effettivo di Vigilo**, non sul listino del fornitore. Questo significa che se il fornitore concede uno sconto, il prezzo al pubblico scende ma il margine di Vigilo resta sempre il 30%.

```
Prezzo normale:
  Costo fornitore:        €100.00
  Ricarico 30%:          + €30.00
  Prezzo Vigilo:          €130.00   ← margine €30

Fornitore concede -20%:
  Costo fornitore:         €80.00
  Ricarico 30%:          + €24.00
  Prezzo Vigilo:          €104.00   ← margine €24 (sempre 30%)
```

**Principio chiave**: Vigilo non erode MAI il proprio margine. Il 30% è intoccabile. Qualsiasi sconto arriva a monte (fornitore) o a valle (Punti Elmetto del lavoratore).

#### Tipologie di promozione

| Tipo promozione              | Come funziona                                                                        | Chi paga lo sconto     |
|------------------------------|--------------------------------------------------------------------------------------|------------------------|
| **Sconto fornitore**         | Il fornitore riduce il costo a Vigilo. Il prezzo al pubblico scende, margine 30%     | Fornitore              |
| **Prodotto della settimana** | Vigilo evidenzia prodotti con sconto fornitore attivo. Visibilità in home app        | Fornitore              |
| **Flash sale**               | Offerta a tempo (24-48h) su prodotti con sconto fornitore negoziato                  | Fornitore              |
| **Tema stagionale**          | Selezione prodotti per stagione (estate, Natale, back-to-school) con sconti fornitori | Fornitore              |
| **Punti Elmetto doppi**      | Evento promozionale: azioni di sicurezza danno punti doppi per una settimana         | Vigilo (costo punti)   |
| **Bonus primo acquisto**     | Sconto extra (es. 5%) sul primo ordine ecommerce del lavoratore                     | Vigilo (margine ridotto una tantum) |

#### Regole promozioni

| Regola                       | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Margine minimo**           | Sempre 30% sul costo effettivo Vigilo. Nessuna eccezione                                       |
| **Vigilo non sconta mai**    | Il prezzo Vigilo = costo + 30%. Lo sconto visibile al lavoratore viene dal fornitore            |
| **Punti Elmetto separati**   | Lo sconto Punti Elmetto (max 20%) si applica DOPO il prezzo Vigilo già calcolato               |
| **Cumulo**                   | Sconto fornitore + sconto Elmetto sono cumulabili. Il lavoratore vede il prezzo già ribassato e può applicare i suoi punti sopra |
| **Trasparenza**              | Il lavoratore vede il prezzo barrato solo se c'è uno sconto fornitore attivo                   |
| **Nessun prezzo gonfiato**   | Vietato alzare il prezzo prima di una promozione per mostrare uno sconto falso                 |

#### Esempio promozione con sconto fornitore + Punti Elmetto

```
Cuffie Bluetooth — promozione settimanale
  Costo fornitore (listino):  €50.00
  Sconto fornitore (-30%):    €35.00   ← costo effettivo Vigilo
  Ricarico 30%:              + €10.50
  Prezzo Vigilo promozionale: €45.50   ← (era €65.00 a prezzo pieno)

  Il lavoratore vede:
    Prezzo originale: €65.00 (barrato)
    Prezzo promo:     €45.50

  Applica 273 Punti Elmetto (€4.55 = 10%):
    Sconto Elmetto:   - €4.55
    Prezzo finale:     €40.95
    + Spedizione:     + €5.90
    ─────────────────────────
    Totale:            €46.85

  Margine Vigilo: €10.50 (30% su €35) ✓
```

---

## Spedizione

### Regole

| Regola                       | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Chi paga**                 | Sempre il lavoratore, anche con riscatto welfare 100%                                           |
| **Costo medio**              | €4.90 - €7.90 (standard), €9.90 - €14.90 (express)                                            |
| **Soglia spedizione gratis** | Nessuna. La spedizione a carico del lavoratore responsabilizza e riduce ordini impulsivi        |
| **Consegna**                 | A domicilio del lavoratore (indirizzo personale)                                                |
| **Tempi**                    | 3-7 giorni lavorativi (dropshipping standard)                                                   |
| **Tracking**                 | Codice tracciamento visibile nell'app, notifica push su aggiornamenti stato                     |
| **Corriere**                 | Definito dal fornitore dropshipping. Vigilo negozia tariffe convenzionate dove possibile         |

### Perché spedizione sempre a carico del lavoratore

- **Responsabilizzazione**: il lavoratore ci pensa due volte prima di ordinare "tanto per"
- **Margine protetto**: su prodotti a basso costo (€10-20), la spedizione gratuita mangerebbe tutto il margine
- **Welfare**: anche nel riscatto gratis, il costo spedizione (€5-8) è un contributo minimo che mantiene il senso di valore
- **Resi ridotti**: chi paga la spedizione rende meno

---

## Pagamenti

### Metodi di pagamento

| Metodo                       | Per chi                | Dettaglio                                                      |
|------------------------------|------------------------|-----------------------------------------------------------------|
| **Carta di credito/debito**  | Tutti i lavoratori     | Visa, Mastercard, Maestro. Tramite Stripe                      |
| **PayPal**                   | Tutti i lavoratori     | Conto PayPal o carta tramite PayPal                            |
| **BNPL (rate)**              | Lavoratori, sopra €50  | Pagamento dilazionato con interessi a carico del lavoratore    |
| **Fattura mensile**          | Solo aziende (welfare) | Fattura aggregata mensile per tutti i riscatti welfare          |

### BNPL — Pagamento a rate

Il lavoratore può dilazionare la parte a suo carico (prezzo dopo sconto Elmetto e/o welfare) quando l'importo supera €50.

| Aspetto                      | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Piattaforma primaria**     | Scalapay — leader BNPL italiano, brand noto al target operai                                   |
| **Piattaforma fallback**     | Klarna — copertura internazionale per espansione futura                                        |
| **Rate disponibili**         | 3 rate (importi €50-500) oppure 6 rate (importi €200+)                                        |
| **Interessi**                | A carico del lavoratore. TAN/TAEG definito dalla piattaforma BNPL                             |
| **Soglia minima**            | €50 (sotto questa cifra la dilazione non ha senso)                                              |
| **Flusso per Vigilo**        | Vigilo incassa subito il 100% dalla piattaforma BNPL                                          |
| **Fee merchant Vigilo**      | 1-3% sull'importo dilazionato (pagato da Vigilo alla piattaforma)                             |
| **Rischio credito**          | Zero per Vigilo. Il rischio è della piattaforma BNPL                                          |

### Esempio BNPL

Il BNPL si applica solo su `workerPaysEur` (la parte a carico del lavoratore dopo lo sconto Elmetto). La soglia minima è €50.

```
Prodotto: Smartphone accessibile (senza welfare attivo)
Prezzo Vigilo (totalEur):   €260.00
calculateCheckout:
  maxDiscount = 260 × 20% = €52
  elmettoDiscountEur = min(€30, €52) = €30  (lavoratore ha 1800 pt = €30)
  elmettoPointsUsed = 30 × 60 = 1800 pt
  workerPaysEur = 260 − 30 = €230
  companyPaysEur = €0 (no welfare)
  isBnplAvailable = €230 ≥ 50 → true ✓
─────────────────────────────────────
Da pagare (lavoratore):     €230.00
Spedizione:                 + €7.90
─────────────────────────────────────
Totale lavoratore:          €237.90

Paga con Scalapay 3 rate:
  Rata 1 (oggi):     €79.30
  Rata 2 (30 giorni): €79.30
  Rata 3 (60 giorni): €79.30
  + interessi BNPL:   ~€5-8

Vigilo incassa: €237.90 subito da Scalapay + €30 assorbiti dal margine
Fee merchant:    €237.90 × 2% = €4.76
```

### Fatturazione welfare

| Aspetto                      | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Frequenza**                | Fattura mensile aggregata per azienda                                                           |
| **Dettaglio**                | Elenco riscatti per dipendente: prodotto, data, quota welfare coperta dall'azienda              |
| **Fee Vigilo**               | Inclusa nel prezzo prodotto (il 30% di ricarico). Nessuna fee aggiuntiva sul welfare           |
| **Deducibilità**             | Fattura conforme per deduzione TUIR Art. 51 comma 2 (fringe benefit/welfare)                   |
| **Pagamento**                | Bonifico 30 giorni data fattura                                                                 |
| **Limiti mensili**           | Nessun piano a tier. Welfare è on/off (`welfareActive`). L'azienda paga la quota eccedente lo sconto Punti Elmetto |

---

## Logistica — 100% Dropshipping

### Modello operativo

```
Lavoratore ordina nell'app
    │
    ▼
Vigilo riceve ordine
    │
    ├─ Checkout verificato (calculateCheckout + pagamento lavoratore)
    │  Se welfareActive: quota azienda registrata per fatturazione
    │
    ▼
Vigilo inoltra ordine al fornitore
    │
    ├─ API automatica (fornitori integrati)
    │  oppure ordine manuale (fornitori non integrati)
    │
    ▼
Fornitore spedisce al lavoratore
    │
    ├─ Tracking aggiornato in tempo reale nell'app
    │
    ▼
Lavoratore riceve il prodotto
    │
    └─ Notifica push: "Il tuo ordine è arrivato!"
        └─ Richiesta feedback: "Come valuti il prodotto?" (1-5 stelle)
```

### Strategia sourcing — nessun middleware, API dirette

Nessuna piattaforma intermediaria (AutoDS, Syncee, Spocket, Oberlo). Vigilo si integra **direttamente via API REST** con i fornitori dropshipping. Le piattaforme tipo AutoDS sono wrapper di queste stesse API pensati per Shopify — non servono se hai un backend custom.

#### Fornitori selezionati

| Fornitore              | Ruolo                        | API              | Costo piattaforma    | Catalogo                                  | Spedizione EU           |
|------------------------|------------------------------|------------------|----------------------|-------------------------------------------|-------------------------|
| **CJDropshipping**     | Fornitore primario           | REST 2.0 pubblica | Gratis               | Enorme: tech, gadget, casa, consumabili   | 2-5 gg (magazzino EU) o 7-15 gg (Cina) |
| **BigBuy**             | Fornitore EU premium         | REST JSON         | ~€69/anno            | 400.000+ prodotti, magazzino EU 30.000 m² | 24/48h (magazzino EU)   |
| **Tillo**              | Voucher digitali             | REST              | Gratis (fee su vendita) | Gift card multi-brand                  | Istantanea (digitale)   |
| **Epipoli**            | Voucher digitali (Italia)    | REST              | Gratis (fee su vendita) | Gift card mercato italiano             | Istantanea (digitale)   |

#### Perché CJDropshipping + BigBuy

| Aspetto                      | CJDropshipping                                    | BigBuy                                            |
|------------------------------|---------------------------------------------------|---------------------------------------------------|
| **Forza**                    | Prezzi bassi, catalogo enorme, zero abbonamento   | Magazzino EU, spedizione 24/48h, qualità alta     |
| **API**                      | REST 2.0, documentazione pubblica, client Python/PHP | REST JSON, guida PDF, supporto tecnico         |
| **Categorie ideali**         | Tecnologia, gadget, accessori, consumabili         | Casa/giardino, abbigliamento, sport, arredo       |
| **Ordine minimo**            | Nessuno                                            | Nessuno                                           |
| **Dropshipping anonimo**     | Si                                                 | Si                                                |
| **Tracking**                 | API + webhook                                      | API + webhook                                     |
| **Doc API**                  | developers.cjdropshipping.com                      | bigbuy.eu/en/api_bigbuy.html                      |

#### Piattaforme escluse e motivazione

| Piattaforma        | Motivo esclusione                                                              |
|--------------------|--------------------------------------------------------------------------------|
| **AutoDS**         | API gated (su approvazione), orientato Shopify/eBay, abbonamento $27-97/mese   |
| **Spocket**        | Nessuna API pubblica, solo plugin Shopify/WooCommerce/BigCommerce              |
| **Syncee**         | API limitata, pensato per Shopify                                              |
| **Oberlo**         | Ora parte di Shopify, zero API esterna                                         |
| **Flxpoint**       | Enterprise: $399-1.299/mese + onboarding $2.400. Fuori budget per Vigilo       |
| **Wholesale2B**    | API disponibile ($50-100/mese) ma focus US/Canada, debole su EU                |

#### Integrazione API per fornitore

```
CJDropshipping API 2.0
    Endpoint: POST https://developers.cjdropshipping.com/api2.0/
    Auth: CJ-Access-Token (header)
    Operazioni:
        ├─ GET /product/list          → catalogo prodotti
        ├─ GET /product/stock         → verifica stock
        ├─ POST /order/create         → crea ordine dropshipping
        ├─ GET /order/tracking        → stato spedizione
        └─ Webhook: tracking update   → push su stato ordine

BigBuy API REST
    Endpoint: https://api.bigbuy.eu/rest/
    Auth: Bearer token
    Operazioni:
        ├─ GET /catalog/products      → catalogo prodotti
        ├─ GET /catalog/stock         → verifica stock
        ├─ POST /order                → crea ordine dropshipping
        ├─ GET /tracking/{orderId}    → stato spedizione
        └─ Webhook: order status      → aggiornamenti ordine

Tillo / Epipoli API (voucher)
    Auth: API key
    Operazioni:
        ├─ GET /brands                → lista voucher disponibili
        ├─ POST /order                → acquista codice voucher
        └─ Response: codice istantaneo → mostrato in app
```

#### Regole di selezione fornitori

| Regola                       | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Rating minimo**            | >4 stelle su piattaforme di review                                                              |
| **Tasso reso**               | <5% sugli ordini                                                                                |
| **Spedizione Italia**        | <5 giorni lavorativi (magazzino EU obbligatorio per categorie premium)                          |
| **Ordine minimo**            | Zero — nessun impegno stock                                                                     |
| **Backup fornitore**         | Almeno 2 fornitori per le categorie principali per evitare stock-out                           |
| **Negoziazione**             | Start con listino standard, negoziare sconti volume dopo 500+ ordini/mese                      |
| **Dropshipping anonimo**     | Obbligatorio — il lavoratore non deve vedere il nome del fornitore                             |

### Voucher digitali

| Aspetto                      | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Consegna**                 | Istantanea via email/app (codice voucher)                                                      |
| **Logistica**                | Zero — nessuna spedizione fisica                                                                |
| **Margine**                  | Basso (5-10%) ma zero costi operativi                                                          |
| **Fornitori**                | Tillo (multi-brand internazionale), Epipoli (leader mercato italiano)                          |
| **Utilizzo strategico**      | Prodotto di lancio (fase 1): validare il modello senza logistica fisica                        |

---

## Gestione ordini

### Stati dell'ordine

| Stato                        | Descrizione                                         | Visibile al lavoratore |
|------------------------------|-----------------------------------------------------|------------------------|
| **In elaborazione**          | Ordine ricevuto, pagamento verificato               | Si                     |
| **Inoltrato al fornitore**   | Ordine trasmesso al fornitore dropshipping          | Si ("In preparazione") |
| **Spedito**                  | Fornitore ha spedito, tracking disponibile          | Si + tracking          |
| **In consegna**              | Corriere in fase di consegna                        | Si + tracking          |
| **Consegnato**               | Prodotto consegnato                                 | Si                     |
| **Reso richiesto**           | Lavoratore ha aperto un reso                        | Si                     |
| **Reso completato**          | Prodotto reso, rimborso/punti restituiti            | Si                     |
| **Annullato**                | Ordine annullato (prima della spedizione)           | Si                     |

### Notifiche push

| Evento                       | Notifica                                                          |
|------------------------------|-------------------------------------------------------------------|
| Ordine confermato            | "Ordine confermato! Il tuo [prodotto] è in preparazione"          |
| Spedito                      | "Il tuo ordine è stato spedito! Traccia qui"                      |
| In consegna                  | "Il tuo ordine è in consegna oggi!"                               |
| Consegnato                   | "Consegnato! Come valuti il prodotto?"                            |
| Reso approvato               | "Reso approvato. Punti/rimborso restituiti"                      |

---

## Resi e rimborsi

### Policy

| Regola                       | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Diritto di recesso**       | 14 giorni dalla consegna (obbligo D.Lgs. 206/2005, vendita a distanza)                         |
| **Condizioni**               | Prodotto integro, nella confezione originale, non usato                                         |
| **Voucher digitali**         | Non rimborsabili se già riscattati                                                              |
| **Spedizione reso**          | A carico del lavoratore                                                                         |
| **Tempi rimborso**           | Entro 14 giorni dalla ricezione del reso                                                        |

### Rimborso per tipo di pagamento

| Pagamento originale          | Cosa viene rimborsato                                                                          |
|------------------------------|------------------------------------------------------------------------------------------------|
| **Solo Punti Elmetto**       | Punti Elmetto restituiti al wallet                                                             |
| **Solo pagamento (carta)**   | Rimborso su carta/PayPal                                                                       |
| **Mix Elmetto + carta**      | Punti Elmetto restituiti + rimborso differenza su carta                                        |
| **Welfare (azienda ha pagato)** | Nota di credito all'azienda per la quota welfare. Punti Elmetto restituiti              |
| **Mix Elmetto + welfare + carta** | Punti Elmetto restituiti + nota credito welfare azienda + rimborso carta               |
| **BNPL (rate)**              | Rimborso gestito dalla piattaforma BNPL (rate residue annullate)                               |

---

## Customer service

| Canale                       | Dettaglio                                                         |
|------------------------------|-------------------------------------------------------------------|
| **Chat in-app**              | Primo livello di supporto, risposte automatiche + operatore       |
| **Email**                    | supporto@vigilo.app — risposta entro 24h                          |
| **FAQ in-app**               | Sezione domande frequenti su ordini, spedizioni, resi, punti      |
| **Nessun telefono**          | Il target (lavoratori giovani/digitali) preferisce chat/email     |

### Responsabilità

| Problema                     | Chi risolve                    | Come                                        |
|------------------------------|--------------------------------|---------------------------------------------|
| Prodotto difettoso           | Vigilo + fornitore             | Reso gratuito, sostituzione o rimborso      |
| Prodotto non conforme        | Vigilo + fornitore             | Reso gratuito, sostituzione o rimborso      |
| Spedizione in ritardo        | Vigilo monitora fornitore      | Notifica al lavoratore, sollecito fornitore |
| Prodotto mai arrivato        | Vigilo + corriere              | Indagine tracking, rispedizione o rimborso  |
| Punti non accreditati        | Vigilo                         | Verifica e correzione manuale               |
| Errore prezzo/sconto         | Vigilo                         | Correzione e compensazione punti            |

---

## Metriche ecommerce

### KPI operativi

| KPI                          | Descrizione                                              | Target              |
|------------------------------|----------------------------------------------------------|---------------------|
| **GMV**                      | Gross Merchandise Value — valore totale venduto          | Crescita mensile    |
| **AOV**                      | Average Order Value — valore medio ordine                | €30-50              |
| **Conversion rate**          | % utenti app che acquistano almeno 1 volta               | >15% entro 6 mesi  |
| **% ordini welfare**         | Quota ordini con copertura welfare aziendale              | >40%                |
| **% ordini BNPL**            | Quota ordini con pagamento dilazionato                   | 10-20%              |
| **Margine lordo medio**      | Media ponderata margine su tutti gli ordini              | >15%                |
| **Tasso di reso**            | % ordini resi sul totale                                 | <5%                 |
| **Tempo evasione**           | Giorni da ordine a consegna                              | <7 giorni           |
| **NPS post-acquisto**        | Net Promoter Score dopo consegna                         | >40                 |
| **Repeat purchase rate**     | % lavoratori che riordinano entro 90 giorni              | >30%                |

### KPI economici

| KPI                          | Formula                                                  | Target Anno 1       |
|------------------------------|----------------------------------------------------------|---------------------|
| **Revenue ecommerce**        | GMV × margine medio                                      | Da business plan    |
| **Revenue welfare**          | Ordini welfare × prezzo medio                            | Da business plan    |
| **CAC ecommerce**            | Costo engagement / lavoratori che acquistano              | <€10                |
| **LTV lavoratore**           | AOV × ordini/anno × margine × anni retention             | >€50                |
| **Fee BNPL totale**          | Ordini BNPL × fee merchant media                         | <2% del GMV         |

---

## Roadmap Spaccio Aziendale

### Fase 1 — Voucher digitali (lancio)

| Aspetto                      | Dettaglio                                                           |
|------------------------------|---------------------------------------------------------------------|
| **Catalogo**                 | Solo voucher: Amazon, Decathlon, carte carburante, cinema, food     |
| **Logistica**                | Zero — consegna digitale istantanea                                 |
| **Margine**                  | Basso (5-10%) ma zero costi operativi                               |
| **Obiettivo**                | Validare il flusso: accumulo punti → spesa → soddisfazione          |
| **Pagamento**                | Solo carta/PayPal (no BNPL, importi bassi)                          |

### Fase 2 — Catalogo fisico dropshipping

| Aspetto                      | Dettaglio                                                           |
|------------------------------|---------------------------------------------------------------------|
| **Catalogo**                 | Casa/giardino, abbigliamento, tech, consumabili, sport              |
| **Logistica**                | 100% dropshipping tramite piattaforme B2B                           |
| **Margine**                  | 30% ricarico standard                                               |
| **Obiettivo**                | Scalare GMV, testare categorie, ottimizzare margini                 |
| **Pagamento**                | Carta/PayPal + Scalapay (BNPL)                                      |

### Fase 3 — Welfare + fatturazione

| Aspetto                      | Dettaglio                                                           |
|------------------------------|---------------------------------------------------------------------|
| **Catalogo**                 | Stesso catalogo, nessuna restrizione per welfare                    |
| **Welfare**                  | Flag `welfareActive` per azienda, copertura fino al 100%, fatturazione mensile |
| **Obiettivo**                | Attivare il revenue stream welfare, scalare budget aziendali        |
| **Pagamento**                | Tutti i metodi + fattura mensile B2B per welfare                    |

### Fase 4 — Ottimizzazione e scala

| Aspetto                      | Dettaglio                                                           |
|------------------------------|---------------------------------------------------------------------|
| **Catalogo**                 | Espansione categorie, prodotti stagionali, limited edition          |
| **Fornitori**                | Negoziazione sconti volume, contratti diretti con brand             |
| **Logistica**                | Valutare magazzino 3PL per top seller (>50 ordini/mese)            |
| **Obiettivo**                | Margine medio >20%, repeat purchase >40%, espansione EU             |

---

## Architettura tecnica — Spaccio Aziendale su Supabase custom (no Shopify)

### Decisione architetturale

Nessuna piattaforma ecommerce esterna (Shopify, WooCommerce, Medusa). Lo Spaccio Aziendale è costruito interamente su Supabase per le seguenti ragioni:

| Criterio                     | Piattaforma esterna                            | Supabase custom                                |
|------------------------------|------------------------------------------------|------------------------------------------------|
| **Wallet Punti Elmetto**     | Plugin custom da sviluppare                    | Logica nativa nel checkout RPC                 |
| **Welfare + fatturazione**   | Non supportato, integrazione esterna           | Tabelle e RPC native                           |
| **30% markup dinamico**      | Configurazione per-prodotto manuale            | Calcolato automatico su costo fornitore        |
| **Database**                 | Doppio DB (piattaforma + Supabase)             | DB unico, zero sincronizzazione                |
| **Costi**                    | €29-299/mese + 2% fee transazione              | Zero costi aggiuntivi (già su Supabase)        |
| **Controllo**                | Limitato dal framework della piattaforma       | Totale                                         |
| **Frontend**                 | Adattatore API headless per Flutter            | Supabase SDK diretto da Flutter                |

### Perché non serve Shopify per il dropshipping

I fornitori dropshipping selezionati (CJDropshipping, BigBuy) offrono **API REST dirette** indipendenti da Shopify. Piattaforme tipo AutoDS/Spocket sono solo wrapper — Vigilo chiama le API direttamente dalle Edge Functions.

| Fornitore              | Tipo integrazione | Catalogo          | Ordini              | Tracking            |
|------------------------|-------------------|-------------------|---------------------|---------------------|
| **CJDropshipping**     | API REST 2.0      | GET product/list  | POST order/create   | GET + webhook       |
| **BigBuy**             | API REST JSON      | GET catalog       | POST order          | GET + webhook       |
| **Tillo** (voucher)    | API REST           | GET brands        | POST order          | Istantaneo (codice) |
| **Epipoli** (voucher)  | API REST           | GET lista         | POST order          | Istantaneo (codice) |

### Flusso catalogo — import prodotti

```
Fornitore (API REST)
    │
    ▼
Edge Function (cron giornaliero)
    │
    ├─ Scarica feed prodotti (JSON/CSV)
    ├─ Mappa campi: nome, descrizione, immagini, prezzo fornitore, stock
    ├─ Calcola prezzo Vigilo = costo × 1.30
    ├─ Upsert su tabella products
    │
    ▼
Tabella products (Supabase)
    │
    ├─ Prodotti nuovi → visibili nel catalogo app
    ├─ Prodotti aggiornati → prezzo/stock sincronizzati
    └─ Prodotti out-of-stock → nascosti dal catalogo (non cancellati)
```

**Frequenza sync**: giornaliera per stock/prezzi, settimanale per nuovi prodotti. Real-time via webhook dove supportato dal fornitore.

### Flusso checkout — ordine con wallet unico Punti Elmetto

```
Lavoratore preme "Acquista"
    │
    ▼
RPC checkout_order (transazione atomica PostgreSQL)
    │
    ├─ 1. Verifica stock prodotto (query fornitore o cache locale)
    │
    ├─ 2. Esegui algoritmo calculateCheckout:
    │     a. maxDiscountPercent = welfareActive ? 100% : 20%
    │     b. maxDiscount = totalEur × maxDiscountPercent / 100
    │     c. elmettoDiscountEur = min(elmettoValueEur, maxDiscount)
    │     d. elmettoPointsUsed = round(elmettoDiscountEur × 60)
    │     e. workerPaysEur = totalEur − elmettoDiscountEur
    │     f. baseDiscount = totalEur × 20 / 100
    │     g. companyPaysEur = (welfareActive && elmettoDiscountEur > baseDiscount)
    │                          ? elmettoDiscountEur − baseDiscount : 0
    │
    ├─ 3. Verifica saldo: puntiElmetto >= elmettoPointsUsed
    ├─ 4. Scala elmettoPointsUsed dal wallet del lavoratore
    │
    ├─ 5. Se workerPaysEur > 0:
    │     └─ Processa pagamento (Stripe/PayPal/BNPL)
    │        + spedizione (sempre a carico lavoratore)
    │
    ├─ 6. Se companyPaysEur > 0:
    │     └─ Registra quota welfare per fatturazione mensile azienda
    │
    ├─ 7. Crea record ordine con:
    │     ├─ total_amount = totalEur
    │     ├─ elmetto_discount = elmettoDiscountEur
    │     ├─ elmetto_points_used = elmettoPointsUsed
    │     ├─ welfare_amount = companyPaysEur
    │     ├─ worker_paid = workerPaysEur + shipping
    │     └─ status = "in_elaborazione"
    │
    ├─ 8. Crea record pagamento con dettaglio
    │
    ▼
Se pagamento OK:
    ├─ Edge Function → POST ordine al fornitore (API)
    ├─ Riceve conferma + tracking ID
    ├─ Aggiorna ordine → stato "inoltrato_fornitore"
    └─ Push notification al lavoratore

Se pagamento KO:
    ├─ Rollback: punti restituiti al wallet
    ├─ Ordine → stato "annullato"
    └─ Push notification errore
```

**Punto chiave**: tutto il checkout è una singola transazione PostgreSQL. Se qualsiasi passo fallisce, i punti non vengono scalati e il pagamento non viene processato. L'algoritmo è lo stesso implementato in `ElmettoWallet.calculateCheckout()` (`lib/features/punti/domain/models/dual_wallet.dart`).

### Flusso fulfillment — inoltro al fornitore

```
Ordine confermato
    │
    ▼
Edge Function: forward_to_supplier
    │
    ├─ Legge supplier_id dal prodotto
    ├─ Chiama API fornitore con:
    │   - Prodotto (SKU fornitore)
    │   - Quantità
    │   - Indirizzo spedizione (lavoratore)
    │   - Metodo spedizione scelto
    │
    ▼
Risposta fornitore
    │
    ├─ OK → salva order_id fornitore + tracking_url
    │       aggiorna stato → "inoltrato_fornitore"
    │
    └─ ERRORE → retry automatico (max 3 tentativi)
                se fallisce → alert operatore + stato "errore_inoltro"
```

### Flusso tracking — aggiornamenti spedizione

```
Opzione A: Webhook (fornitori che lo supportano)
    Fornitore → POST webhook → Edge Function → aggiorna ordine + push

Opzione B: Polling (fornitori senza webhook)
    Cron ogni 4 ore → Edge Function → GET tracking API → aggiorna ordine + push
```

### Flusso voucher digitali (fase 1)

```
Lavoratore acquista voucher
    │
    ▼
RPC checkout_order (stessa logica)
    │
    ▼
Edge Function: acquire_voucher
    │
    ├─ POST API fornitore voucher (Tillo/Epipoli)
    ├─ Riceve codice voucher istantaneamente
    ├─ Salva codice in tabella vouchers (crittografato)
    ├─ Aggiorna ordine → stato "consegnato" (istantaneo)
    └─ Push notification: "Il tuo voucher è pronto!"
        └─ Lavoratore vede codice nell'app
```

**Nessuna logistica**, nessun tracking, nessuna attesa. Per questo i voucher sono il prodotto di lancio ideale.

### Schema database (tabelle core)

```
products
    ├─ id (uuid, PK)
    ├─ supplier_id (FK → suppliers)
    ├─ supplier_sku (text)
    ├─ name, description, images[] (jsonb)
    ├─ category (enum)
    ├─ supplier_cost (decimal)         ← prezzo fornitore
    ├─ vigilo_price (decimal)          ← supplier_cost × 1.30 (calcolato)
    ├─ original_price (decimal|null)   ← prezzo pre-promo (se in promozione)
    ├─ stock_available (boolean)
    ├─ is_visible (boolean)
    ├─ is_voucher (boolean)
    └─ updated_at (timestamp)

suppliers
    ├─ id (uuid, PK)
    ├─ name (text)
    ├─ api_type (enum: cjdropshipping, bigbuy, tillo, epipoli, manual)
    ├─ api_base_url (text)             ← es. https://developers.cjdropshipping.com/api2.0/
    ├─ api_credentials (jsonb, encrypted)
    ├─ supports_webhook (boolean)
    ├─ shipping_days_eu (integer)      ← giorni medi spedizione EU
    └─ active (boolean)

orders
    ├─ id (uuid, PK)
    ├─ worker_id (FK → auth.users)
    ├─ company_id (FK → companies)
    ├─ status (enum: in_elaborazione, inoltrato, spedito, in_consegna,
    │          consegnato, reso_richiesto, reso_completato, annullato)
    ├─ total_amount (decimal)          ← totale finale pagato
    ├─ elmetto_discount_eur (decimal)  ← sconto Elmetto in EUR (= elmettoPointsUsed / 60)
    ├─ elmetto_points_used (integer)   ← punti Elmetto spesi (60 pts = 1 EUR)
    ├─ welfare_amount (decimal)        ← companyPaysEur: quota fatturata all'azienda (eccedenza oltre 20%)
    ├─ worker_paid_eur (decimal)       ← workerPaysEur: importo pagato dal lavoratore (esclusa spedizione)
    ├─ shipping_cost (decimal)
    ├─ payment_method (enum)
    ├─ supplier_order_id (text|null)
    ├─ tracking_url (text|null)
    └─ created_at, updated_at

order_items
    ├─ id (uuid, PK)
    ├─ order_id (FK → orders)
    ├─ product_id (FK → products)
    ├─ quantity (integer)
    ├─ unit_price (decimal)            ← prezzo Vigilo al momento dell'acquisto
    └─ supplier_cost (decimal)         ← costo fornitore al momento dell'acquisto

payments
    ├─ id (uuid, PK)
    ├─ order_id (FK → orders)
    ├─ method (enum: stripe, paypal, scalapay, klarna, welfare_invoice)
    ├─ amount (decimal)
    ├─ status (enum: pending, completed, failed, refunded)
    ├─ external_id (text)              ← ID Stripe/PayPal/Scalapay
    └─ created_at

vouchers
    ├─ id (uuid, PK)
    ├─ order_id (FK → orders)
    ├─ code (text, encrypted)          ← codice voucher
    ├─ provider (enum: tillo, epipoli, reloadly)
    ├─ redeemed (boolean)
    └─ expires_at (timestamp|null)

shipments
    ├─ id (uuid, PK)
    ├─ order_id (FK → orders)
    ├─ carrier (text)
    ├─ tracking_code (text)
    ├─ tracking_url (text)
    ├─ status (enum: in_preparazione, spedito, in_transito, in_consegna, consegnato)
    └─ updated_at
```

### Edge Functions necessarie

| Edge Function              | Trigger                    | Descrizione                                           |
|----------------------------|----------------------------|-------------------------------------------------------|
| **sync_catalog**           | Cron giornaliero           | Import/aggiorna prodotti da API fornitori             |
| **checkout_order**         | RPC da app Flutter         | Checkout atomico: wallet + pagamento + creazione ordine |
| **forward_to_supplier**    | Dopo checkout OK           | Inoltra ordine al fornitore via API                   |
| **acquire_voucher**        | Dopo checkout OK (voucher) | Acquista codice voucher da API fornitore              |
| **update_tracking**        | Webhook o cron 4h          | Aggiorna stato spedizione da fornitore                |
| **process_refund**         | Richiesta reso approvata   | Rimborso punti + pagamento, notifica fornitore        |
| **generate_welfare_invoice** | Cron mensile (1° del mese) | Genera fattura aggregata per azienda                |

### Integrazioni esterne

```
Flutter App (Supabase SDK)
    │
    ├─ Supabase Auth            → login/registrazione
    ├─ Supabase Database        → catalogo, ordini, wallet
    ├─ Supabase RPC             → checkout atomico
    ├─ Supabase Edge Functions  → fulfillment, sync, tracking
    │
    ├─ Stripe SDK               → pagamenti carta (client-side + server-side)
    ├─ PayPal SDK               → pagamenti PayPal
    ├─ Scalapay SDK             → BNPL 3/6 rate
    │
    ├─ CJDropshipping API 2.0   → catalogo + ordini + tracking (tech, gadget, consumabili)
    ├─ BigBuy API REST          → catalogo + ordini + tracking (casa, abbigliamento, sport)
    ├─ Tillo API                → voucher digitali (multi-brand internazionale)
    ├─ Epipoli API              → voucher digitali (mercato italiano)
    │
    └─ Push Notifications       → Firebase Cloud Messaging (FCM)
```

### Vantaggi dell'approccio Supabase custom

| Vantaggio                    | Dettaglio                                                                    |
|------------------------------|------------------------------------------------------------------------------|
| **Zero fee piattaforma**     | Nessun canone mensile Shopify, nessuna fee transazione 2%                    |
| **DB unico**                 | Wallet, ordini, utenti, scoring — tutto nello stesso PostgreSQL              |
| **Checkout atomico**         | Una transazione: scala Punti Elmetto + calcola welfare + paga + crea ordine. Impossibile con Shopify |
| **RLS nativo**               | Row Level Security: ogni lavoratore vede solo i suoi ordini                  |
| **Edge Functions**           | Logica server-side (fulfillment, sync) nello stesso ecosistema               |
| **Scalabilità**              | PostgreSQL scala verticalmente; per volumi alti, read replicas               |
| **Costo prevedibile**        | Piano Supabase Pro (€25/mese) copre tutto. Con Shopify: €29-299 + 2% GMV    |

---

*Documento di riferimento per lo sviluppo dello Spaccio Aziendale Vigilo V2*
