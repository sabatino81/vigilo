# Vigilo - Modello Ecommerce

> Architettura, catalogo, pricing, logistica e flussi operativi del marketplace integrato

---

## Principi fondamentali

| Principio                    | Descrizione                                                                                    |
|------------------------------|------------------------------------------------------------------------------------------------|
| **Catalogo unico**          | Stesso catalogo per tutti i lavoratori, tutte le aziende, tutti i settori. Nessuna personalizzazione per azienda |
| **100% dropshipping**       | Nessun magazzino proprio. Tutti i prodotti spediti dal fornitore direttamente al lavoratore    |
| **Ricarico fisso 30%**      | Prezzo Vigilo = costo fornitore + 30%. Margine semplice, prevedibile, scalabile               |
| **Sconto max 20%**          | I Punti Elmetto danno sconto fino al 20% sul prezzo Vigilo. Il margine minimo è sempre positivo |
| **Welfare fino a 100%**     | I Punti Welfare coprono fino al 100% del prezzo prodotto. L'azienda paga                     |
| **Spedizione a carico del lavoratore** | Anche con riscatto welfare 100%, il lavoratore paga la spedizione                   |
| **BNPL con interessi al cliente** | Pagamento dilazionato disponibile, interessi a carico del lavoratore                     |

---

## Catalogo prodotti

### Categorie

Catalogo generalista, non verticale sulla sicurezza. L'obiettivo è che il lavoratore trovi prodotti utili per la vita quotidiana, non solo per il lavoro:

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
| **Ampiezza**                 | Massima. Più prodotti = più motivi per aprire l'app e spendere punti                           |
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

Il ricarico del 30% è fisso su tutto il catalogo. Non ci sono prezzi "scontati" o "in offerta" da parte di Vigilo — il prezzo è unico. L'unico sconto possibile arriva dai Punti Elmetto del lavoratore.

### Scenari di acquisto

| Scenario                                | Prezzo base | Sconto Elmetto | Welfare | Lavoratore paga | Azienda paga | Margine Vigilo |
|-----------------------------------------|-------------|----------------|---------|-----------------|--------------|----------------|
| **Nessun punto usato**                  | €130        | 0%             | €0      | €130            | €0           | €30 (23%)      |
| **Sconto 5% (200 Punti Elmetto)**      | €130        | -5%            | €0      | €123.50         | €0           | €23.50 (18%)   |
| **Sconto 10% (500 Punti Elmetto)**     | €130        | -10%           | €0      | €117            | €0           | €17 (13%)      |
| **Sconto 20% max (2.000 Punti Elmetto)** | €130     | -20%           | €0      | €104            | €0           | €4 (3%)        |
| **Welfare parziale (€50)**             | €130        | 0%             | -€50    | €80             | €50          | €30 (23%)      |
| **Welfare parziale + sconto 10%**      | €130        | -10%           | -€50    | €72             | €50          | €22 (17%)      |
| **Welfare 100%**                        | €130        | 0%             | -€130   | €0              | €130         | €30 (23%)      |

**Regola di applicazione**: prima si sottrae il welfare (€), poi si calcola lo sconto Elmetto (%) sul restante.

### Margine per scenario (su costo fornitore €100)

| Scenario                     | Incasso totale Vigilo | Costo fornitore | Margine lordo | Margine % |
|------------------------------|----------------------|-----------------|---------------|-----------|
| Prezzo pieno                 | €130                 | €100            | €30           | 23.1%     |
| Sconto 10% Elmetto          | €117                 | €100            | €17           | 14.5%     |
| Sconto 20% Elmetto (max)    | €104                 | €100            | €4            | 3.8%      |
| Welfare 100%                 | €130                 | €100            | €30           | 23.1%     |
| Welfare parziale + sconto   | €122                 | €100            | €22           | 18.0%     |

Il margine minimo (3.8%) si verifica solo nel caso peggiore: sconto 20% pieno senza welfare. In pratica la media sarà più alta perché non tutti i lavoratori avranno 2.000 Punti Elmetto da spendere su un singolo acquisto.

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

```
Prodotto: Smartphone accessibile
Prezzo Vigilo:              €260.00
Welfare applicato:          -€80.00  (Punti Welfare)
Sconto Elmetto (10%):       -€18.00
─────────────────────────────────────
Da pagare (lavoratore):     €162.00
Spedizione:                 + €7.90
─────────────────────────────────────
Totale da pagare:           €169.90

Paga con Scalapay 3 rate:
  Rata 1 (oggi):     €58.50
  Rata 2 (30 giorni): €58.50
  Rata 3 (60 giorni): €58.50
  + interessi BNPL:   ~€5-8

Vigilo incassa: €169.90 subito da Scalapay
Fee merchant:    €169.90 × 2% = €3.40
```

### Fatturazione welfare

| Aspetto                      | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Frequenza**                | Fattura mensile aggregata per azienda                                                           |
| **Dettaglio**                | Elenco riscatti per dipendente: prodotto, data, valore welfare applicato                       |
| **Fee Vigilo**               | Inclusa nel prezzo prodotto (il 30% di ricarico). Nessuna fee aggiuntiva sul welfare           |
| **Deducibilità**             | Fattura conforme per deduzione TUIR Art. 51 comma 2 (fringe benefit/welfare)                   |
| **Pagamento**                | Bonifico 30 giorni data fattura                                                                 |
| **Limiti mensili**           | Definiti dal piano welfare scelto (S: €5/dip, M: €10/dip, L: €20/dip)                         |

---

## Logistica — 100% Dropshipping

### Modello operativo

```
Lavoratore ordina nell'app
    │
    ▼
Vigilo riceve ordine
    │
    ├─ Pagamento verificato (carta/PayPal/BNPL)
    │  oppure welfare verificato (budget disponibile)
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

### Gestione fornitori

| Aspetto                      | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Tipo fornitori**           | Piattaforme dropshipping B2B (es. BigBuy, BDroppy, Brandsdistribution, Syncee)                 |
| **Integrazione**             | API dove disponibile, ordine manuale in fase iniziale                                          |
| **Selezione fornitori**      | Rating >4 stelle, tasso reso <5%, spedizione Italia <5 giorni                                  |
| **Contratti**                | Nessun minimo d'ordine, pagamento per ordine, nessun impegno stock                            |
| **Backup fornitore**         | Almeno 2 fornitori per le categorie principali per evitare stock-out                           |
| **Margine negoziazione**     | Start con listino standard, negoziare sconti volume dopo 500+ ordini/mese                     |

### Voucher digitali

| Aspetto                      | Dettaglio                                                                                       |
|------------------------------|-------------------------------------------------------------------------------------------------|
| **Consegna**                 | Istantanea via email/app (codice voucher)                                                      |
| **Logistica**                | Zero — nessuna spedizione fisica                                                                |
| **Margine**                  | Basso (5-10%) ma zero costi operativi                                                          |
| **Fornitori**                | Piattaforme gift card B2B (es. Tillo, Reloadly, Epipoli)                                      |
| **Utilizzo strategico**      | Prodotto di lancio: validare il modello senza logistica fisica                                 |

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
| **Solo Punti Welfare**       | Punti Welfare restituiti al wallet. Budget welfare aziendale riaddebitato                      |
| **Mix Welfare + Elmetto + carta** | Tutti i punti restituiti + rimborso carta per la parte pagata                            |
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
| **% ordini welfare**         | Quota ordini pagati con Punti Welfare                    | >40%                |
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

## Roadmap ecommerce

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
| **Welfare**                  | Riscatto con Punti Welfare attivo, fatturazione mensile aziende     |
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

*Documento di riferimento per lo sviluppo dell'ecommerce Vigilo V2*
