# Vigilo - Wireframe V2

> Schermate aggiornate con wallet unico Punti Elmetto (+ welfare aziendale on/off), Spaccio Aziendale (ecommerce dropshipping), scoring model e nuove funzionalita

---

## Indice

1. [Navigazione Principale](#navigazione-principale)
2. [Splash e Login](#splash-e-login)
3. [Home](#home)
4. [SOS](#sos)
5. [Punti — Wallet Punti Elmetto](#punti--wallet-punti-elmetto)
6. [Spaccio Aziendale — Catalogo](#spaccio-aziendale--catalogo)
7. [Spaccio Aziendale — Card Prodotto](#spaccio-aziendale--card-prodotto)
8. [Spaccio Aziendale — Checkout](#spaccio-aziendale--checkout)
9. [Spaccio Aziendale — Ordini e Tracking](#spaccio-aziendale--ordini-e-tracking)
10. [Impara](#impara)
11. [Scoring — Check-in e Survey](#scoring--check-in-e-survey)
12. [Scoring — Segnalazione Rischio](#scoring--segnalazione-rischio)
13. [Scoring — Streak e Sfide](#scoring--streak-e-sfide)
14. [Profilo e Settings](#profilo-e-settings)
15. [Notifiche](#notifiche)
16. [Appendice: Componenti UI](#appendice-componenti-ui)

---

## Navigazione Principale

### Bottom Navigation Bar

```
+-------------------------------------------------------------+
|                                                             |
|                    [CONTENUTO PAGINA]                        |
|                                                             |
+-------------------------------------------------------------+
|                                                             |
|   +------+  +------+  +----------+  +------+  +--------+   |
|   | Home |  | Punti|  |Sicurezza |  |Impara|  |Spaccio |   |
|   |      |  |      |  |          |  |      |  |        |   |
|   +------+  +------+  +----------+  +------+  +--------+   |
|                            ^                                |
|                       Pulsante                              |
|                       circolare                             |
|                       giallo sicurezza                      |
+-------------------------------------------------------------+
```

**Note:**
- 5 tab: Home, Punti, Sicurezza (SOS), Impara, Spaccio (shop)
- Tab Sicurezza con pulsante circolare giallo (#FFB800) distintivo
- Tab Spaccio apre direttamente il catalogo prodotti (ShopPage)
- Icone filled quando selezionate, outlined quando non attive
- Border radius 28px sulla barra

---

## Splash e Login

### Splash Screen

```
+-------------------------------------------------------------+
|                                                             |
|                                                             |
|                                                             |
|                                                             |
|                    +-------------------+                    |
|                    |                   |                    |
|                    |   VIGILO          |                    |
|                    |   Sicurezza       |                    |
|                    |   sul lavoro      |                    |
|                    |                   |                    |
|                    +-------------------+                    |
|                                                             |
|                         o o o                               |
|                    Loading indicator                        |
|                                                             |
|                                                             |
+-------------------------------------------------------------+
```

### Login Page

```
+-------------------------------------------------------------+
|                                                             |
|                       +---------+                           |
|                       | VIGILO  |                           |
|                       +---------+                           |
|                                                             |
|                  Sicurezza sul lavoro                       |
|                                                             |
|    +---------------------------------------------------+   |
|    |  Email                                             |   |
|    |  mario.rossi@azienda.it                           |   |
|    +---------------------------------------------------+   |
|                                                             |
|    +---------------------------------------------------+   |
|    |  Password                                    [eye] |   |
|    |  ************                                     |   |
|    +---------------------------------------------------+   |
|                                                             |
|    +---------------------------------------------------+   |
|    |                    ACCEDI                           |   |
|    +---------------------------------------------------+   |
|                                                             |
|                  Password dimenticata?                      |
|                                                             |
+-------------------------------------------------------------+
```

---

## Home

### Home Page (V2)

```
+-------------------------------------------------------------+
|  [avatar] Ciao! / Nome       ⛑ Punti Elmetto    [bell]      |
|                                                             |
|  Buongiorno, Mario!                                        |
|  EdilPro S.r.l.                                            |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |  COME TI SENTI OGGI?                         +5 pts  | |
|  |                                                       | |
|  |  +----------+ +----------+ +-----------+              | |
|  |  |   :)     | |   :|     | |   :(      |              | |
|  |  |  Bene    | |Cosi-cosi | | Stressato |              | |
|  |  +----------+ +----------+ +-----------+              | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  CHECK-IN TURNO                           [Da fare]   | |
|  |  Autodichiarazione DPI - D.Lgs. 81/2008               | |
|  |                                                         | |
|  |  DPI richiesti per il tuo ruolo         2/4            | |
|  |  [==============..............] 50%                    | |
|  |                                                         | |
|  |  [ ] Casco protettivo                                  | |
|  |  [v] Scarpe antinfortunistiche                         | |
|  |  [v] Guanti protettivi                                 | |
|  |  [ ] Giubbino alta visibilita                          | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |          Seleziona tutti i DPI                     | | |
|  |  +---------------------------------------------------+ | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SAFETY SCORE                                     85   | |
|  |                                                         | |
|  |  [==============================........]              | |
|  |                                                         | |
|  |  +5 rispetto a ieri                                    | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  PUNTI ELMETTO                              1.800 pt  | |
|  |                                                         | |
|  |  Valore: E30.00 in sconti                              | |
|  |  Welfare aziendale: [ATTIVO]                           | |
|  |                                                         | |
|  |  Vai al negozio >                                      | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  STREAK GIORNALIERO                           12 gg    | |
|  |                                                         | |
|  |  [============........] Giorno 12/30                    | |
|  |  Bonus attuale: +15 punti/azione                       | |
|  |  Prossimo livello: giorno 15 (+20 punti)               | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SFIDA TEAM                                    5 gg    | |
|  |                                                         | |
|  |  "Settimana Zero Infortuni"                            | |
|  |  Progress: [================....] 78%                   | |
|  |                                                         | |
|  |  Hot Streak: 5 giorni consecutivi!                      | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  TODO GIORNALIERI                              3/5     | |
|  |                                                         | |
|  |  [v] Check-in benessere                   +5 pts       | |
|  |  [v] Micro-training                      +15 pts       | |
|  |  [v] Briefing sicurezza                                | |
|  |  [ ] Compilare VOW survey                +10 pts       | |
|  |  [ ] Check-out fine turno                               | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SMART BREAK                                           | |
|  |                                                         | |
|  |  Prossima pausa tra: 45 min                            | |
|  |  Zone ombra vicine: Area C, Baracca 2                  | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SAFETY STAR DELLA SETTIMANA                          | |
|  |                                                       | |
|  |         +--------+                                    | |
|  |         | Marco  |                                    | |
|  |         +--------+                                    | |
|  |      Marco Bianchi                                    | |
|  |                                                       | |
|  |  "Ha segnalato 3 near-miss questa settimana"          | |
|  |                                                       | |
|  |  +---------------------------------------------------+| |
|  |  |          NOMINA UN COLLEGA (+15 pts)              || |
|  |  +---------------------------------------------------+| |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SURVEY VOW                                +10 pts    | |
|  |                                                       | |
|  |  Hai completato il survey di oggi?                    | |
|  |                                                       | |
|  |  +---------------------------------------------------+| |
|  |  |            COMPILA SURVEY                         || |
|  |  +---------------------------------------------------+| |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  HAI DETTO -> ABBIAMO FATTO                          | |
|  |                                                       | |
|  |  [v] "Illuminazione Area B scarsa"                    | |
|  |      -> Installati 4 fari LED (12/01)                 | |
|  |                                                       | |
|  |  [v] "Percorso pedonale non segnalato"                | |
|  |      -> Aggiunta segnaletica orizzontale (10/01)      | |
|  |                                                       | |
|  |  [~] "Bagni chimici insufficienti"                    | |
|  |      -> In corso: ordine 2 unita aggiuntive           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  I MIEI KPI                                            | |
|  |                                                         | |
|  |  FI (Fatica)     [green] 32    Nella norma             | |
|  |  ASI (Stress)    [green] 28    Nella norma             | |
|  |  Ore lavorate    6.5h          Oggi                    | |
|  |  Segnalazioni    3             Questo mese             | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------|
|   Home    Punti    Sicurezza    Impara    Spaccio                    |
+-------------------------------------------------------------+
```

**Novita V2:**
- **Card wallet unico** Punti Elmetto con badge welfare attivo/non attivo
- **Card streak** con progress giornaliero e bonus crescente
- **TODO giornalieri** mostrano punti guadagnabili per ogni azione
- Rimossa card DPI Status (integrata in Check-in Turno con autodichiarazione)

**Novita V2.3:**
- **Come ti senti oggi?** spostato da Team a Home (primo widget)
- **Safety Star** spostata da Team a Home
- **Survey VOW** spostato da Team a Home
- **Hai detto -> Abbiamo fatto** (trasparenza) spostato da Team a Home
- Tab Team rimosso, sostituito da tab Spaccio (accesso diretto al negozio)

---

## SOS

### SOS Page

```
+-------------------------------------------------------------+
|  [avatar] Ciao! / Nome       ⛑ Punti Elmetto    [bell]      |
|                                                             |
|                      SICUREZZA                              |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |                 AIUTO EMERGENZA                         | |
|  |                                                         | |
|  |              +---------------------+                    | |
|  |              |                     |                    | |
|  |              |        SOS          |                    | |
|  |              |                     |                    | |
|  |              |    TIENI PREMUTO    |                    | |
|  |              |      3 SECONDI      |                    | |
|  |              |                     |                    | |
|  |              +---------------------+                    | |
|  |                   (pulsante rosso)                      | |
|  |                                                         | |
|  |  Verranno avvisati automaticamente:                     | |
|  |  - Preposto turno  - RSPP  - 118  - Familiare            | |
|  |                                                         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SEGNALAZIONI RAPIDE                                   | |
|  |                                                         | |
|  |  +----------+ +----------+ +-----------+               | |
|  |  |  [red]   | | [orange] | |  [blue]   |               | |
|  |  | Pericolo | | Near Miss| | Infortunio|               | |
|  |  | Imminente| |          | |   Lieve   |               | |
|  |  |  +50 pts | |  +40 pts | |  +30 pts  |               | |
|  |  +----------+ +----------+ +-----------+               | |
|  |                                                         | |
|  |  +----------+                                           | |
|  |  |  [green] |                                           | |
|  |  |Suggerim. |                                           | |
|  |  |  +30 pts |                                           | |
|  |  +----------+                                           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  CONTATTI EMERGENZA                                    | |
|  |                                                         | |
|  |  Preposto turno                      [Chiama]    | |
|  |     Marco Rossi - 333 1234567                          | |
|  |                                                         | |
|  |  Centrale Operativa                        [Chiama]    | |
|  |     H24 - 800 123456                                   | |
|  |                                                         | |
|  |  RSPP Aziendale                            [Chiama]    | |
|  |     Ing. Bianchi - 335 9876543                         | |
|  |                                                         | |
|  |  118 Emergenze                             [Chiama]    | |
|  |     Numero di emergenza                                | |
|  |                                                         | |
|  |  Contatto Familiare                        [Chiama]    | |
|  |     Maria (moglie) - 339 5551234                       | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  STORICO SEGNALAZIONI                    Vedi tutte    | |
|  |                                                         | |
|  |  [orange] Near Miss - Area ponteggi  12/01  [v] Chiusa | |
|  |  [green]  Suggerimento - Illuminaz.  10/01  [v] Chiusa | |
|  |  [red]    Pericolo - Cavo scoperto   08/01  [v] Chiusa | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------|
|   Home    Punti    Sicurezza    Impara    Spaccio                    |
+-------------------------------------------------------------+
```

**Novita V2:**
- Punti visibili per ogni tipo di segnalazione (+30/+40/+50)
- SOS emergenza resta a 0 punti (non si incentiva)

### SOS - Countdown Attivazione

```
+-------------------------------------------------------------+
|                                                             |
|                                                             |
|                                                             |
|                    +---------------------+                  |
|                    |                     |                  |
|                    |    +-----------+    |                  |
|                    |    |           |    |                  |
|                    |    |     2     |    |                  |
|                    |    |           |    |                  |
|                    |    +-----------+    |                  |
|                    |                     |                  |
|                    |   [========.....]   |                  |
|                    |   (progress ring)   |                  |
|                    |                     |                  |
|                    |  RILASCIA PER       |                  |
|                    |    ANNULLARE        |                  |
|                    |                     |                  |
|                    +---------------------+                  |
|                                                             |
|                    Vibrazione progressiva                   |
|                                                             |
+-------------------------------------------------------------+
```

### SOS - Form Segnalazione

```
+-------------------------------------------------------------+
|                                                             |
|  +-------------------------------------------------------+ |
|  |                        -----                           | |
|  |                                                         | |
|  |  [red] Segnalazione Pericolo Imminente      +50 pts   | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  | Descrivi il pericolo...                            | | |
|  |  |                                                    | | |
|  |  | Ho notato un cavo elettrico scoperto vicino        | | |
|  |  | all'area di scarico materiali.                     | | |
|  |  |                                                    | | |
|  |  |                                          127/500   | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  Aggiungi foto                                         | |
|  |  +---------+ +---------+ +---------+                  | |
|  |  |    +    | |  foto1  | |         |                  | |
|  |  |  Scatta | |         | |         |                  | |
|  |  +---------+ +---------+ +---------+                  | |
|  |                                                         | |
|  |  Foto + descrizione >50 char = auto-validazione!       | |
|  |                                                         | |
|  |  Posizione                                             | |
|  |  +---------------------------------------------------+ | |
|  |  | Area B - Zona scarico (rilevata automaticamente)   | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  | [ ] Voglio essere ricontattato                     | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |               INVIA SEGNALAZIONE                   | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

**Novita V2:**
- Punti mostrati nel titolo (+50 pts)
- Nota auto-validazione (foto + descrizione >50 char)

---

## Punti — Wallet Punti Elmetto

### Punti Page (V2 — Wallet Unico)

```
+-------------------------------------------------------------+
|  [avatar] Ciao! / Nome       ⛑ Punti Elmetto    [bell]      |
|                                                             |
|  Punti                                                     |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |  IL TUO WALLET                                         | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |  PUNTI ELMETTO                                    | | |
|  |  |                                                    | | |
|  |  |       1.800 punti                                  | | |
|  |  |       Valore: E30.00 in sconti                     | | |
|  |  |                                                    | | |
|  |  |  Welfare aziendale: [ATTIVO]                       | | |
|  |  |  Con welfare: sconto fino al 100%                  | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  Quest'anno hai risparmiato: E42.30                    | |
|  +-------------------------------------------------------+ |
|                                                             |
|  (nella card wallet, sezione espandibile:)                  |
|  +-------------------------------------------------------+ |
|  |  v COME GUADAGNI PUNTI ELMETTO        (espandibile)   | |
|  |                                                        | |
|  |  AZIONI INDIVIDUALI                                    | |
|  |  Check-in benessere         +5/giorno                  | |
|  |  Feedback fine turno        +10/giorno                 | |
|  |  Segnalazione rischio      +30-50                      | |
|  |  Nomina Safety Star        +15 (tu) +25 (collega)     | |
|  |  Streak giornaliero        +5-25/giorno                | |
|  |                                                        | |
|  |  AZIONI DI SQUADRA                                    | |
|  |  Sfida team completata     +50-100/membro             | |
|  |  Post e commenti social    +3-5 (max 30/gg)           | |
|  |                                                        | |
|  |  FORMAZIONE                                           | |
|  |  Micro-training            +15/giorno                  | |
|  |  Quiz settimanale          +20 (+10 se >80%)          | |
|  |  Corso completato          +30-80                      | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SQUADRA: Falchi Nord                      840 pt     | |
|  |  ---------------------------------------------------- | |
|  |  MEMBRI SQUADRA                                       | |
|  |  [o] Ahmed R.   Perfetto     Online                   | |
|  |  [o] Luca B.    Buono        Offline                  | |
|  |  [o] Maria S.   Ottimo       Online                   | |
|  |  [o] Diego P.   Perfetto     Offline                  | |
|  |  [o] Sofia K.   Nuova        Online                   | |
|  |  [Apri chat squadra]                                  | |
|  |  ---------------------------------------------------- | |
|  |  v CLASSIFICA                 LIVE    (espandibile)   | |
|  |  1. Falchi Nord   840 pt  ^                           | |
|  |  2. Tigri Est     790 pt  v                           | |
|  |  3. Squadra Omega 720 pt  =                           | |
|  |  4. Aquile Sud    680 pt  =                           | |
|  |  5. Delta Crew    600 pt  ^                           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  STATISTICHE                                           | |
|  |                                                         | |
|  |  Ultimi 7 giorni:     +180 punti                       | |
|  |  Ultimi 30 giorni:    +720 punti                       | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |  L   M   M   G   V   S   D                        | | |
|  |  |  =   =   =   =   =   .   .                        | | |
|  |  | 45  32  28  40  35  --  --                         | | |
|  |  +---------------------------------------------------+ | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  CLASSIFICA PUNTI ELMETTO               Vedi tutti     | |
|  |                                                         | |
|  |  1. Marco B.      2,450 pts                            | |
|  |  2. Anna R.       2,120 pts                            | |
|  |  3. Luca P.       1,980 pts                            | |
|  |  -> 4. TU         1,850 pts   +2 posizioni             | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  RUOTA FORTUNATA                                       | |
|  |  1 giro gratuito disponibile oggi!                     | |
|  |  [Gira la ruota!]                                      | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------|
|   Home    Punti    Sicurezza    Impara    Spaccio                    |
+-------------------------------------------------------------+
```

**Novita V2:**
- Wallet unico Punti Elmetto con badge welfare attivo/non attivo
- "Come guadagni punti" integrato nella wallet card, espandibile
- Conversione e cap sconto ben visibili (60pt = 1EUR, max 20%, 100% con welfare)
- Classifica su Punti Elmetto
- Badge welfare nascosto se azienda non ha welfareActive

**Novita V2.3:**
- Rimossi Livello e Ultime Transazioni (punti si spendono, livello non significativo)
- Card Squadra unificata (header + membri + classifica espandibile) aggiunta dopo wallet
- Rimosso "Vai al negozio" (ora tab Spaccio nella bottom bar)
- Ruota fortunata a larghezza piena

---

## Spaccio Aziendale — Catalogo

### Catalogo Prodotti (Lista)

```
+-------------------------------------------------------------+
|  [avatar] Ciao! / Nome       ⛑ Punti Elmetto    [bell]      |
|                                                             |
|      [store✨] Spaccio Aziendale (shimmer ambra→teal)        |
|  [search] Cerca prodotti...                     (compact)  |
|  [Tutti][Casa][Abbigl.][Tech][Consum][Sport][Voucher][Gift]|
|  10 di 124 prodotti                             (small)   |
|                                                             |
|  🔥 In evidenza                                             |
|  +----------+ +----------+ +----------+ +----------+  >>>  |
|  | (emoji)  | | -15%     | | (emoji)  | | -20%     |       |
|  |   🛁     | |   💡     | |   🧦     | |   🎧     |       |
|  | ░overlay | | ░overlay | | ░overlay | | ░overlay |       |
|  | Set Asc. | | Lampada  | | Calzini  | | Auricol. |       |
|  | ⛑26.00  | | ⛑19.65  | | ⛑15.12  | | ⛑27.20  |       |
|  | [Compra] | | [Compra] | | [Compra] | | [Compra] |       |
|  +----------+ +----------+ +----------+ +----------+  >>>  |
|                                    (scroll orizzontale, 6)  |
|                                                             |
|  ▦ Tutti i prodotti                                         |
|                                                             |
|  +---------------------------+ +---------------------------+|
|  |                           | | -15%          SCONTATO    ||
|  |  GRATIS        (emoji)   | |               (emoji)     ||
|  |  PER TE         🛁        | |                💡         ||
|  |              (grande)     | |             (grande)      ||
|  |                           | |                           ||
|  |  ░░░ gradient overlay ░░░ | |  ░░░ gradient overlay ░░░ ||
|  |  Set Asciugamani Premium  | |  Lampada LED Smart        ||
|  |  ~~32.50~~                | |  ~~28.90~~ 24.57 EUR      ||
|  |  ⛑ 26.00 EUR             | |  ⛑ 19.65 EUR              ||
|  |  [  Compra  ] [🛒]        | |  [  Compra  ] [🛒]        ||
|  +---------------------------+ +---------------------------+|
|                                                             |
|  +---------------------------+ +---------------------------+|
|  |                           | | -20%          PROMO       ||
|  |              (emoji)      | |               (emoji)     ||
|  |               🧥          | |                🎧         ||
|  |            (grande)       | |             (grande)      ||
|  |                           | |                           ||
|  |  ░░░ gradient overlay ░░░ | |  ░░░ gradient overlay ░░░ ||
|  |  Giacca Softshell         | |  Auricolari Bluetooth     ||
|  |  ~~65.00~~                | |  ~~42.50~~ 34.00 EUR      ||
|  |  ⛑ 52.00 EUR             | |  ⛑ 27.20 EUR              ||
|  |  [  Compra  ] [🛒]        | |  [  Compra  ] [🛒]        ||
|  +---------------------------+ +---------------------------+|
|                                                             |
|  +---------------------------+ +---------------------------+|
|  |                           | |              GRATIS       ||
|  |              (emoji)      | |               (emoji)     ||
|  |               🎁          | |                ⛽         ||
|  |            (grande)       | |             (grande)      ||
|  |                           | |                           ||
|  |  ░░░ gradient overlay ░░░ | |  ░░░ gradient overlay ░░░ ||
|  |  Buono Amazon 25 EUR      | |  Buono Carburante 50 EUR  ||
|  |  ~~25.00~~                | |  ~~50.00~~                ||
|  |  ⛑ 20.00 EUR             | |  ⛑ 40.00 EUR              ||
|  |  [  Compra  ] [🛒]        | |  [  Compra  ] [🛒]        ||
|  +---------------------------+ +---------------------------+|
|                                                             |
|              ○ Caricamento...  (spinner giallo)             |
|                                                             |
+-------------------------------------------------------------+
```

**Note:**
- **Titolo**: shimmer gradient animato (ambra→bianco→teal) con icona pulse
- **Card moderne**: bordo colorato in base a sconto (giallo=nessuno, arancio=10%+, rosso=20%+), ombre glow tinta categoria, sfondo grigio chiaro (#EEEEEE), overlay scuro (#424242)
- **3 livelli prezzo**: listino (barrato), scontato (se promo), prezzo Elmetto (-20%) in evidenza giallo
- **Tasti card**: "Compra" (gradient giallo→arancio) + carrello (gradient verde) con haptic feedback
- Badge pill top-right con glow: "GRATIS PER TE" (verde), "SCONTATO" (blu), "PROMO" (arancione)
- Badge sconto pill top-left: "-15%" (gradient rosso) se promo attiva
- **In evidenza**: carosello orizzontale 6 card (prodotti con badge o promo), scompare con filtri/ricerca
- **"Tutti i prodotti"**: header sezione prima della griglia principale
- **Infinite scroll**: carica 10 prodotti alla volta, spinner giallo in fondo, contatore "X di Y prodotti"
- Reset paginazione su cambio filtro/ricerca
- Filtri per categoria + ricerca compatta
- Saldo wallet visibile in header catalogo

---

## Spaccio Aziendale — Card Prodotto

### Scenario 1 — Senza welfare

```
+-------------------------------------------------------------+
|  <- Indietro                                     [cart] (2) |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |              [IMMAGINE PRODOTTO]                        | |
|  |              < swipe gallery >                          | |
|  |                                         SCONTATO        | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Borraccia Termica Pro                                     |
|  Categoria: Benessere                                      |
|                                                             |
|  Prezzo: E30.00                                            |
|                                                             |
|  -- I tuoi Punti Elmetto ---------------------------       |
|  Saldo: 1.800 punti (E30)                                 |
|  Usa: [o=================] 360 punti                       |
|  Sconto: -20% (-E6.00)                                    |
|                                                             |
|  -------------------------------------------------         |
|  Tu paghi:                             E24.00              |
|                                                             |
|  Spedizione: E5.90 (standard 3-7 gg)                      |
|                                                             |
|  +-------------------------------------------------------+ |
|  |            Acquista — E29.90                           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Descrizione:                                              |
|  Borraccia in acciaio inox 750ml, doppia parete,           |
|  mantiene caldo 12h e freddo 24h. Ideale per cantiere.     |
|                                                             |
|  Spedizione: 3-7 giorni lavorativi                         |
|  Reso: 14 giorni dalla consegna                            |
|                                                             |
+-------------------------------------------------------------+
```

### Scenario 2 — Con welfare attivo

```
+-------------------------------------------------------------+
|  <- Indietro                                     [cart] (2) |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |              [IMMAGINE PRODOTTO]                        | |
|  |              < swipe gallery >                          | |
|  |                                    GRATIS PER TE        | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Borraccia Termica Pro                                     |
|  Categoria: Benessere                                      |
|                                                             |
|  Prezzo: E30.00                                            |
|                                                             |
|  -- I tuoi Punti Elmetto ---------------------------       |
|  Saldo: 1.800 punti (E30)                                 |
|  Usa: [o=================] 1.800 punti                     |
|  Sconto base: -20% (-E6.00)                               |
|                                                             |
|  -- Welfare aziendale [ATTIVO] ----------------------      |
|  Usa welfare: [ON]                                         |
|  L'azienda copre il resto: -E24.00                         |
|                                                             |
|  -------------------------------------------------         |
|  Prezzo:                               E30.00              |
|  Sconto Elmetto (20%):                 -E6.00              |
|  Welfare azienda:                     -E24.00              |
|  -------------------------------------------------         |
|  Tu paghi:                              E0.00              |
|                                                             |
|  Spedizione: E5.90 (standard 3-7 gg)                      |
|                                                             |
|  +-------------------------------------------------------+ |
|  |         Riscatta gratis — spedizione E5.90             | |
|  +-------------------------------------------------------+ |
|  (tasto verde)                                              |
|                                                             |
+-------------------------------------------------------------+
```

### Scenario 3 — Gratis (welfare copre tutto, prodotto piccolo)

```
+-------------------------------------------------------------+
|  <- Indietro                                     [cart] (2) |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |              [IMMAGINE PRODOTTO]                        | |
|  |              < swipe gallery >                          | |
|  |                                    GRATIS PER TE        | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Guanti Sicurezza Pro                                      |
|  Categoria: Sicurezza                                      |
|                                                             |
|  Prezzo: E15.00                                            |
|                                                             |
|  -- I tuoi Punti Elmetto ---------------------------       |
|  Sconto base: -20% (-E3.00)                               |
|                                                             |
|  -- Welfare aziendale [ATTIVO] ----------------------      |
|  L'azienda copre: -E12.00                                  |
|                                                             |
|  -------------------------------------------------         |
|  Prezzo:                               E15.00              |
|  Sconto Elmetto (20%):                 -E3.00              |
|  Welfare azienda:                     -E12.00              |
|  -------------------------------------------------         |
|  Tu paghi:                        E0.00 GRATIS             |
|                                                             |
|  Spedizione: E5.90 (anche se gratis, la spedizione        |
|              resta a carico tuo)                           |
|                                                             |
|  +-------------------------------------------------------+ |
|  |         Riscatta gratis — spedizione E5.90             | |
|  +-------------------------------------------------------+ |
|  (tasto verde)                                              |
|                                                             |
+-------------------------------------------------------------+
```

### Scenario 4 — Punti insufficienti (motivazionale)

```
+-------------------------------------------------------------+
|  <- Indietro                                     [cart] (2) |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |              [IMMAGINE PRODOTTO]                        | |
|  |              < swipe gallery >                          | |
|  |                                                         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Zaino Tecnico Waterproof                                  |
|  Categoria: Abbigliamento                                  |
|                                                             |
|  Prezzo: E85.00                                            |
|                                                             |
|  -- I tuoi Punti Elmetto ---------------------------       |
|  Saldo: 120 punti (E2)                                     |
|  Ancora 135 punti per il primo sconto! (5% = -E4.25)      |
|                                                             |
|  Completa 2 quiz per raggiungerlo!                         |
|                                                             |
|  -------------------------------------------------         |
|  Tu paghi:                             E85.00              |
|                                                             |
|  Spedizione: E7.90 (standard 3-7 gg)                      |
|                                                             |
|  +-------------------------------------------------------+ |
|  |            Acquista — E92.90                           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Oppure paga in 3 rate con Scalapay:                       |
|  +-------------------------------------------------------+ |
|  |     3 rate da E31.30/mese (+ interessi)               | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

### Scenario 5 — Prodotto in promozione (sconto fornitore)

```
+-------------------------------------------------------------+
|  <- Indietro                                     [cart] (2) |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |              [IMMAGINE PRODOTTO]                        | |
|  |              < swipe gallery >                          | |
|  |                                         PROMO           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Cuffie Bluetooth Sport                                    |
|  Categoria: Tecnologia                                     |
|                                                             |
|  Prezzo originale: --E65.00--                              |
|  Prezzo promo:      E45.50    (-30%)                       |
|                                                             |
|  -- I tuoi Punti Elmetto ---------------------------       |
|  Saldo: 1.800 punti (E30)                                 |
|  Usa: [o=========.........] 273 punti                      |
|  Sconto: -10% (-E4.55)                                    |
|                                                             |
|  -------------------------------------------------         |
|  Prezzo promo:                         E45.50              |
|  Sconto Elmetto (10%):                 -E4.55              |
|  -------------------------------------------------         |
|  Tu paghi:                             E40.95              |
|                                                             |
|  Spedizione: E5.90 (standard 3-7 gg)                      |
|                                                             |
|  +-------------------------------------------------------+ |
|  |            Acquista — E46.85                           | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

---

## Spaccio Aziendale — Checkout

### Checkout Page

```
+-------------------------------------------------------------+
|  <- Carrello                                                |
|                                                             |
|  Checkout                                                  |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |  RIEPILOGO ORDINE                                      | |
|  |                                                         | |
|  |  [img] Borraccia Termica Pro    x1      E30.00         | |
|  |  [img] Guanti Sicurezza Pro     x1      E15.00         | |
|  |                                                         | |
|  |  Subtotale:                             E45.00         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  PUNTI ELMETTO                                         | |
|  |                                                         | |
|  |  Saldo disponibile: 1.800 punti (E30)                  | |
|  |                                                         | |
|  |  Usa: [o===========........] 540 punti                  | |
|  |  Sconto applicato (20%):                -E9.00         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  WELFARE AZIENDALE                         [ATTIVO]    | |
|  |                                                         | |
|  |  Usa welfare: [ON]                                     | |
|  |  L'azienda copre:                      -E36.00         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SPEDIZIONE                                            | |
|  |                                                         | |
|  |  ( ) Standard (3-7 gg)                   E5.90         | |
|  |  ( ) Express (1-3 gg)                    E9.90         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  INDIRIZZO DI CONSEGNA                                 | |
|  |                                                         | |
|  |  Mario Rossi                                           | |
|  |  Via Roma 123, 20100 Milano (MI)                       | |
|  |                                          [Modifica]    | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  METODO DI PAGAMENTO                                   | |
|  |                                                         | |
|  |  (o) Carta di credito/debito (Stripe)                  | |
|  |  ( ) PayPal                                            | |
|  |  ( ) Scalapay — 3 rate da E10.77 (+ interessi)        | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  RIEPILOGO FINALE                                      | |
|  |                                                         | |
|  |  Prodotti:                              E45.00         | |
|  |  Sconto Elmetto (20%):                  -E9.00         | |
|  |  Welfare azienda:                      -E36.00         | |
|  |  Spedizione:                            +E5.90         | |
|  |  -----------------------------------------------       | |
|  |  TOTALE:                                 E5.90         | |
|  |                                                         | |
|  |  L'azienda paga E36.00 (welfare)                       | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |       CONFERMA ORDINE — E5.90 (solo spedizione)       | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

**Note:**
- Ordine applicazione: prima sconto Punti Elmetto (%, max 20%), poi welfare copre il resto se attivo
- BNPL (Scalapay) visibile solo se totale a carico lavoratore >E50
- Spedizione sempre presente, anche con riscatto gratis (welfare non copre spedizione)
- L'importo welfare pagato dall'azienda e mostrato in fondo

---

## Spaccio Aziendale — Ordini e Tracking

### I miei ordini

```
+-------------------------------------------------------------+
|  <- Indietro                                                |
|                                                             |
|  I miei ordini                                             |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |  Ordine #VIG-2026-0042             15/01/2026          | |
|  |                                                         | |
|  |  [img] Borraccia Termica Pro                           | |
|  |  [img] Guanti Sicurezza Pro                            | |
|  |                                                         | |
|  |  Totale: E5.90 (+ E36.00 welfare azienda)              | |
|  |                                                         | |
|  |  Stato: [green] SPEDITO                                | |
|  |         Tracking: BRT 12345678                         | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |              TRACCIA SPEDIZIONE                    | | |
|  |  +---------------------------------------------------+ | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  Ordine #VIG-2026-0038             10/01/2026          | |
|  |                                                         | |
|  |  [img] Voucher Amazon E25                              | |
|  |                                                         | |
|  |  Totale: E25.00                                        | |
|  |                                                         | |
|  |  Stato: [green] CONSEGNATO                             | |
|  |         Codice: AXYZ-1234-5678                         | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |              VEDI CODICE VOUCHER                   | | |
|  |  +---------------------------------------------------+ | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  Ordine #VIG-2026-0035             05/01/2026          | |
|  |                                                         | |
|  |  [img] Cuffie Bluetooth Sport                          | |
|  |                                                         | |
|  |  Totale: E46.85                                        | |
|  |                                                         | |
|  |  Stato: [green] CONSEGNATO                             | |
|  |         Come valuti il prodotto?                       | |
|  |         [1] [2] [3] [4] [5] stelle                    | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

### Dettaglio Tracking

```
+-------------------------------------------------------------+
|  <- I miei ordini                                           |
|                                                             |
|  Ordine #VIG-2026-0042                                     |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |  STATO SPEDIZIONE                                      | |
|  |                                                         | |
|  |  [v]--[v]--[v]--(o)--( )                               | |
|  |   |    |    |    |    |                                 | |
|  |  Conf. Prep. Sped. Trans. Cons.                        | |
|  |                                                         | |
|  |  In transito — Arrivo stimato: 18/01                   | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  DETTAGLIO TRACKING                                    | |
|  |                                                         | |
|  |  17/01  14:30  In transito - Hub Milano                | |
|  |  16/01  22:00  Partito da magazzino fornitore          | |
|  |  16/01  10:00  Pacco ritirato dal corriere             | |
|  |  15/01  18:00  Ordine inoltrato al fornitore           | |
|  |  15/01  17:45  Pagamento confermato                    | |
|  |  15/01  17:44  Ordine creato                           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  DETTAGLIO ORDINE                                      | |
|  |                                                         | |
|  |  [img] Borraccia Termica Pro    x1      E30.00         | |
|  |  [img] Guanti Sicurezza Pro     x1      E15.00         | |
|  |                                                         | |
|  |  Prodotti:                              E45.00         | |
|  |  Sconto Elmetto (20%):                  -E9.00         | |
|  |  Welfare azienda:                      -E36.00         | |
|  |  Spedizione:                            +E5.90         | |
|  |  -----------------------------------------------       | |
|  |  Pagato da te:                           E5.90         | |
|  |  Pagato dall'azienda (welfare):         E36.00         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Corriere: BRT                                             |
|  Tracking: 12345678                                        |
|  +-------------------------------------------------------+ |
|  |         APRI TRACKING SUL SITO BRT                    | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Hai un problema con l'ordine?                             |
|  +-------------------------------------------------------+ |
|  |         CONTATTA SUPPORTO                             | |
|  +-------------------------------------------------------+ |
|  +-------------------------------------------------------+ |
|  |         RICHIEDI RESO                                 | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

### Voucher Riscattato

```
+-------------------------------------------------------------+
|  <- I miei ordini                                           |
|                                                             |
|  Voucher Amazon                                            |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |              [LOGO AMAZON]                              | |
|  |                                                         | |
|  |              VOUCHER E25.00                             | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |                                                    | | |
|  |  |           AXYZ-1234-5678-ABCD                      | | |
|  |  |                                                    | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  [Copia codice]        [Condividi]                     | |
|  |                                                         | |
|  |  Valido fino al: 31/12/2026                            | |
|  |  Utilizzabile su: amazon.it                            | |
|  |                                                         | |
|  |  Stato: Non ancora utilizzato                          | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Acquistato il: 10/01/2026                                 |
|  Pagato: E25.00 (carta)                                    |
|  Punti Elmetto usati: 500 (-10% = -E2.50)                 |
|  Totale pagato: E22.50                                     |
|                                                             |
+-------------------------------------------------------------+
```

---

## Impara

### Impara Page (V2)

```
+-------------------------------------------------------------+
|  [avatar] Ciao! / Nome       ⛑ Punti Elmetto    [bell]      |
|                                                             |
|  Impara                                                    |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |  DA COMPLETARE OGGI                                    | |
|  |                                                         | |
|  |  [ ] Quiz: Sicurezza DPI        10 min    +25 pts       | |
|  |  [ ] Video: Procedure emergenza  15 min   +15 pts       | |
|  |                                                         | |
|  |  Completa tutto per bonus giornaliero: +20 pts          | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  MICRO-TRAINING GIORNALIERO              +15 pts       | |
|  |                                                         | |
|  |  "5 regole per sollevare carichi in sicurezza"          | |
|  |  Video 4:30 min                                        | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |              GUARDA ORA                            | | |
|  |  +---------------------------------------------------+ | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  LIBRERIA CONTENUTI                      Vedi tutti    | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  | Uso corretto imbracatura                           | | |
|  |  | Video - 12 min - DPI - Obbligatorio                | | |
|  |  | [============........] 60%          [>] Continua   | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  | Manuale sicurezza sul lavoro                        | | |
|  |  | PDF - 25 pagine - Procedure                        | | |
|  |  | [====================] 100%         [v] Completato | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  | Quiz primo soccorso                    +25 pts Elm.| | |
|  |  | Quiz - 15 domande - Emergenze                      | | |
|  |  | Non iniziato                          [>] Inizia   | | |
|  |  +---------------------------------------------------+ | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  IL MIO PROGRESSO                                      | |
|  |                                                         | |
|  |  Corsi completati:    8/12                             | |
|  |  [========================........] 67%                | |
|  |                                                         | |
|  |  Quiz superati:       5/6                              | |
|  |  Certificati attivi:  3                                | |
|  |  Punti formazione questo mese:  +450 pts               | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  CONSIGLIATI PER TE                                    | |
|  |                                                         | |
|  |  Aggiornamento D.Lgs. 81/2008                         | |
|  |  Scade tra 30 giorni - Obbligatorio        +50 pts    | |
|  |                                                         | |
|  |  Nuove procedure Area B                               | |
|  |  Nuovo contenuto - Consigliato             +15 pts    | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  I MIEI CERTIFICATI                      Vedi tutti    | |
|  |                                                         | |
|  |  [v] Formazione Generale           Scade: 12/2028     | |
|  |  [v] Formazione Specifica          Scade: 06/2026     | |
|  |  [!] Primo Soccorso                Scade: 02/2026     | |
|  |      Rinnova adesso (+30 pts Elm. bonus anticipo!)     | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------|
|   Home    Punti    Sicurezza    Impara    Spaccio                    |
+-------------------------------------------------------------+
```

**Novita V2:**
- Punti Elmetto mostrati per ogni contenuto
- Micro-training giornaliero in evidenza
- Rinnovo anticipato certificazioni mostra bonus punti
- Progresso mostra punti totali accumulati

### Quiz Page

```
+-------------------------------------------------------------+
|  X Esci                                    Domanda 5/15    |
|                                                             |
|  [============================..................] 33%        |
|                                                             |
|-------------------------------------------------------------|
|                                                             |
|  Quiz: Primo Soccorso                          +25 pts     |
|                                                             |
|  Domanda 5:                                                |
|                                                             |
|  In caso di arresto cardiaco, qual e la sequenza           |
|  corretta delle operazioni da eseguire?                    |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  A) Chiamare il 118, iniziare RCP, usare DAE          | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  B) Usare DAE, chiamare 118, iniziare RCP  [selected] | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  C) Iniziare RCP, chiamare 118, usare DAE             | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  D) Chiamare familiari, iniziare RCP, usare DAE       | |
|  +-------------------------------------------------------+ |
|                                                             |
|                                                             |
|  +---------------+                  +-------------------+  |
|  |   <- INDIETRO |                  |     AVANTI ->     |  |
|  +---------------+                  +-------------------+  |
|                                                             |
+-------------------------------------------------------------+
```

### Quiz - Risultato

```
+-------------------------------------------------------------+
|                                                             |
|                                                             |
|                    QUIZ COMPLETATO!                         |
|                                                             |
|              +-------------------------+                    |
|              |                         |                    |
|              |          85%            |                    |
|              |                         |                    |
|              |     13/15 corrette      |                    |
|              |                         |                    |
|              +-------------------------+                    |
|                                                             |
|                    SUPERATO!                                |
|                  (minimo richiesto: 70%)                    |
|                                                             |
|              +-------------------------+                    |
|              |   +25 PUNTI ELMETTO     |                    |
|              |   +10 BONUS (score>80%) |                    |
|              +-------------------------+                    |
|                                                             |
|  Riepilogo:                                                |
|  - Risposte corrette: 13                                   |
|  - Risposte errate: 2                                      |
|  - Tempo impiegato: 8 min 32 sec                           |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                TORNA ALLA LIBRERIA                     | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |              RIVEDI RISPOSTE ERRATE                    | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

**Novita V2:**
- Risultato mostra Punti Elmetto + bonus separati

---

## Scoring — Check-in e Survey

### Check-in Benessere

```
+-------------------------------------------------------------+
|                                                             |
|  +-------------------------------------------------------+ |
|  |                        -----                           | |
|  |                                                         | |
|  |  Come ti senti oggi?                         +5 pts   | |
|  |                                                         | |
|  |  +----------+ +----------+ +----------+               | |
|  |  |          | |          | |          |               | |
|  |  |   :D     | |   :)     | |   :|     |               | |
|  |  |  Ottimo  | |  Bene    | |Cosi-cosi |               | |
|  |  |          | |          | |          |               | |
|  |  +----------+ +----------+ +----------+               | |
|  |                                                         | |
|  |  +----------+ +----------+                             | |
|  |  |          | |          |                             | |
|  |  |   :(     | |   >:(    |                             | |
|  |  | Non bene | |Pessimo   |                             | |
|  |  |          | |          |                             | |
|  |  +----------+ +----------+                             | |
|  |                                                         | |
|  |  Note (opzionale):                                     | |
|  |  +---------------------------------------------------+ | |
|  |  | Oggi fa molto caldo, fatica a concentrarmi...      | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  |              INVIA CHECK-IN                        | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  Max 1 check-in al giorno. Dati anonimi e aggregati.   | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

### Survey VOW (Fine Turno)

```
+-------------------------------------------------------------+
|  X Chiudi                                        3/5       |
|                                                             |
|  Survey Fine Turno                              +10 pts    |
|  [============............] Domanda 3 di 5                 |
|-------------------------------------------------------------|
|                                                             |
|  Ti sei sentito sicuro oggi?                               |
|                                                             |
|  +----+ +----+ +----+ +----+ +----+                       |
|  | 1  | | 2  | | 3  | | 4  | | 5  |                       |
|  |Per | |    | |    | |    | |Molto|                       |
|  |niente|    | |    | |    | |    |                       |
|  +----+ +----+ +----+ +----+ +----+                       |
|                                                             |
|                                                             |
|  Hai avuto abbastanza pause?                               |
|                                                             |
|  +----+ +----+ +----+ +----+ +----+                       |
|  | 1  | | 2  | | 3  | | 4  | | 5  |                       |
|  +----+ +----+ +----+ +----+ +----+                       |
|                                                             |
|                                                             |
|  C'e stato qualcosa di pericoloso?                         |
|                                                             |
|  ( ) No, tutto bene                                        |
|  ( ) Si, ma gestito                                        |
|  ( ) Si, non gestito (segnala!)                            |
|                                                             |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                    AVANTI ->                           | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Disponibile solo nelle ultime 2h turno + 1h dopo.         |
|  Le risposte sono anonime.                                 |
|                                                             |
+-------------------------------------------------------------+
```

---

## Scoring — Segnalazione Rischio

### Conferma Segnalazione Inviata

```
+-------------------------------------------------------------+
|                                                             |
|                                                             |
|                                                             |
|                    SEGNALAZIONE INVIATA!                    |
|                                                             |
|              +-------------------------+                    |
|              |                         |                    |
|              |      +50 PUNTI          |                    |
|              |      ELMETTO            |                    |
|              |                         |                    |
|              +-------------------------+                    |
|                                                             |
|  Stato: Auto-validata                                      |
|  (foto + descrizione >50 caratteri)                        |
|                                                             |
|  Il tuo trust level: AFFIDABILE                            |
|  Segnalazioni validate: 12/13 (92%)                        |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                TORNA ALLA HOME                         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |              NUOVA SEGNALAZIONE                        | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

---

## Scoring — Streak e Sfide

### Streak Dettaglio

```
+-------------------------------------------------------------+
|  <- Indietro                                                |
|                                                             |
|  Il tuo Streak                                             |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |  GIORNO 12 CONSECUTIVO!                                | |
|  |                                                         | |
|  |  Bonus attuale: +15 punti/azione                       | |
|  |                                                         | |
|  |  +---------------------------------------------------+ | |
|  |  | Livello      | Giorni  | Bonus   | Stato           | | |
|  |  |--------------|---------|---------|---------------| | |
|  |  | Starter      | 1-7     | +5/az   | [v] Completato| | |
|  |  | Costante     | 8-14    | +10/az  | [v] Completato| | |
|  |  | Dedicato     | 15-21   | +15/az  | <- QUI (gg 12)| | |
|  |  | Esperto      | 22-29   | +20/az  | [locked]      | | |
|  |  | Campione     | 30+     | +25/az  | [locked]      | | |
|  |  +---------------------------------------------------+ | |
|  |                                                         | |
|  |  Prossimo livello tra 3 giorni!                         | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  CALENDARIO STREAK                                     | |
|  |                                                         | |
|  |  Gen 2026                                              | |
|  |  L   M   M   G   V   S   D                            | |
|  |           1   2   3   4   5                            | |
|  |  [v] [v] [v] [v] [v] [-] [-]                          | |
|  |  [v] [v] [v] [v] [v] [-] [-]                          | |
|  |  [v] [v] [o] .   .   .   .                            | |
|  |                                                         | |
|  |  [v] = azione completata                               | |
|  |  [o] = oggi (in corso)                                 | |
|  |  [-] = weekend (non conta)                             | |
|  +-------------------------------------------------------+ |
|                                                             |
|  Requisito: almeno 1 azione sostanziale al giorno          |
|  (non solo like). Reset a 0 se salti un giorno lavorativo. |
|                                                             |
+-------------------------------------------------------------+
```

### Sfida Team Dettaglio

```
+-------------------------------------------------------------+
|  <- Indietro                                                |
|                                                             |
|  Sfida Team                                                |
|-------------------------------------------------------------|
|                                                             |
|  +-------------------------------------------------------+ |
|  |  "SETTIMANA ZERO INFORTUNI"                            | |
|  |                                                         | |
|  |  Obiettivo: 7 giorni senza infortuni nel team          | |
|  |  Durata: 13/01 - 19/01                                | |
|  |  Premio: +100 Punti Elmetto per membro                 | |
|  |                                                         | |
|  |  [==========================........] Giorno 5/7       | |
|  |                                                         | |
|  |  Team Alfa - 15 membri                                 | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  CLASSIFICA CONTRIBUTI                                 | |
|  |                                                         | |
|  |  1. Marco B.      5 check-in, 2 segnalazioni          | |
|  |  2. Anna R.       5 check-in, 1 segnalazione          | |
|  |  3. TU (Mario)    4 check-in, 1 segnalazione          | |
|  |  4. Luca P.       3 check-in                          | |
|  |  ...                                                   | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SFIDE PASSATE                                         | |
|  |                                                         | |
|  |  [v] "100% Check-in"   06-12/01   VINTA!  +75 pts     | |
|  |  [x] "Quiz perfetto"   30-05/01   Persa   58%         | |
|  |  [v] "Social week"     23-29/12   VINTA!  +50 pts     | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

---

## Profilo e Settings

### Profilo Utente

```
+-------------------------------------------------------------+
|  <- Indietro                                    [edit]      |
|                                                             |
|  +-------------------------------------------------------+ |
|  |                                                         | |
|  |         +--------+                                      | |
|  |         | Avatar |                                      | |
|  |         +--------+                                      | |
|  |                                                         | |
|  |  Mario Rossi                                           | |
|  |  Operaio specializzato                                 | |
|  |  EdilPro S.r.l.                                        | |
|  |  Reparto: Produzione                                   | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  IL MIO WALLET                                         | |
|  |                                                         | |
|  |  Punti Elmetto:   1.800     Livello: SILVER            | |
|  |  Welfare:         [ATTIVO]                             | |
|  |  Risparmiato:    E42.30     quest'anno                 | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  SAFETY STATS                                          | |
|  |                                                         | |
|  |  Safety Score:      85/100                             | |
|  |  Segnalazioni:      13  (92% validate)                | |
|  |  Trust level:       AFFIDABILE                         | |
|  |  Streak attuale:    12 giorni                          | |
|  |  Streak record:     23 giorni                          | |
|  |  Sfide vinte:       8/12                               | |
|  |  Nomination ricevute: 5                                | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  CERTIFICAZIONI                                        | |
|  |                                                         | |
|  |  [v] Formazione Generale            12/2028            | |
|  |  [v] Formazione Specifica           06/2026            | |
|  |  [!] Primo Soccorso                 02/2026            | |
|  +-------------------------------------------------------+ |
|                                                             |
|  +-------------------------------------------------------+ |
|  |  IMPOSTAZIONI                                          | |
|  |                                                         | |
|  |  Notifiche push                            [ON]        | |
|  |  Lingua                                    Italiano    | |
|  |  Tema                                      Auto        | |
|  |  Indirizzo spedizione                      [>]         | |
|  |  Contatti emergenza                        [>]         | |
|  |  Privacy e dati                            [>]         | |
|  |  Esci                                      [>]         | |
|  +-------------------------------------------------------+ |
|                                                             |
+-------------------------------------------------------------+
```

---

## Notifiche

### Centro Notifiche

```
+-------------------------------------------------------------+
|  <- Indietro                              Segna tutte lette |
|                                                             |
|  Notifiche                                                 |
|-------------------------------------------------------------|
|                                                             |
|  OGGI                                                      |
|                                                             |
|  [o] Il tuo ordine e stato spedito!          14:30         |
|      Borraccia Termica - Traccia qui                       |
|                                                             |
|  [o] +15 Punti Elmetto guadagnati!           10:15         |
|      Micro-training completato                             |
|                                                             |
|  [o] Sfida "Zero Infortuni" - Giorno 5!     09:00         |
|      Ancora 2 giorni per vincere +100 pts                  |
|                                                             |
|  IERI                                                      |
|                                                             |
|  [ ] Marco ti ha nominato Safety Star!       16:30         |
|      +25 Punti Elmetto ricevuti                            |
|                                                             |
|  [ ] Segnalazione validata                   11:00         |
|      "Cavo scoperto Area B" - +50 pts Elm.                 |
|                                                             |
|  [ ] Nuovo prodotto nel negozio!             09:00         |
|      Cuffie Bluetooth in promozione -30%                   |
|                                                             |
|  QUESTA SETTIMANA                                          |
|                                                             |
|  [ ] Quiz settimanale disponibile            Lun 09:00     |
|      Argomento: DPI - Guadagna +25 pts                     |
|                                                             |
|  [ ] Certificato in scadenza!                Lun 08:00     |
|      Primo Soccorso scade il 28/02. Rinnova!               |
|                                                             |
|  [ ] Consegnato! Come valuti il prodotto?    Dom 14:00     |
|      Cuffie Bluetooth Sport                                |
|                                                             |
+-------------------------------------------------------------+
```

---

## Appendice: Componenti UI

### Palette Colori

| Colore              | Hex       | Uso                           |
|---------------------|-----------|-------------------------------|
| **Primary** (Giallo)| `#FFB800` | Attenzione, azioni principali |
| **Secondary** (Verde)| `#2E7D32`| Sicurezza, conferme, GRATIS   |
| **Tertiary** (Blu)  | `#1565C0` | Informazioni, SCONTATO        |
| **Warning** (Arancione)| `#FF6D00`| Avvertenze, PROMO          |
| **Danger** (Rosso)  | `#D32F2F` | SOS, errori, pericolo         |
| **Elmetto** (Ambra) | `#FF8F00` | Badge/tag Punti Elmetto       |
| **Welfare** (Teal)  | `#00897B` | Badge "Welfare attivo"        |
| **Neutral** (Grigio)| `#757575` | Disabilitato                  |

### Tipografia

| Elemento       | Font Size | Weight   |
|----------------|-----------|----------|
| Titolo pagina  | 24sp      | Bold     |
| Titolo card    | 18sp      | SemiBold |
| Prezzo grande  | 22sp      | Bold     |
| Prezzo barrato | 16sp      | Regular  |
| Body           | 14sp      | Regular  |
| Caption        | 12sp      | Regular  |
| Button         | 14sp      | Medium   |
| Badge          | 11sp      | SemiBold |

### Spaziature

| Elemento            | Valore |
|---------------------|--------|
| Padding pagina      | 16dp   |
| Gap tra cards       | 16dp   |
| Padding interno card| 16dp   |
| Border radius card  | 16dp   |
| Border radius button| 8dp    |
| Border radius badge | 8dp    |

### Badge prodotto

| Badge           | Colore fondo | Colore testo | Condizione                          |
|-----------------|-------------|-------------|--------------------------------------|
| GRATIS PER TE   | #2E7D32     | white       | Welfare attivo: sconto + azienda = 100% |
| SCONTATO        | #1565C0     | white       | Punti Elmetto sufficienti per >=5%   |
| PROMO           | #FF6D00     | white       | Sconto fornitore attivo              |

### AppHeader (layout aggiornato)

```
+-------------------------------------------------------------+
|  [avatar] Ciao! / Nome       ⛑ Punti Elmetto    [bell]      |
+-------------------------------------------------------------+
```

| Elemento        | Azione                               |
|-----------------|--------------------------------------|
| Avatar          | Naviga al Profilo (con settings)     |
| Nome utente     | Testo informativo                    |
| ⛑ Punti Elmetto| Chip blu con saldo formattato (1.8K) |
| Campana [bell]  | Naviga a Notifiche (con badge count) |

> **Note:** Il pulsante settings/ingranaggio è stato rimosso dall'header.
> Lingua, tema e logout sono ora accessibili dalla pagina Profilo.
> L'app utilizza modalità immersiva Android (barre di sistema nascoste).

### Icone

| Categoria  | Stile               |
|------------|---------------------|
| Navigation | Material Rounded    |
| Status     | Material Symbols    |
| Actions    | Material Outlined   |
| Wallet     | Custom (elmetto)    |

---

## Changelog

| Data    | Versione | Modifiche                                                            |
|---------|----------|----------------------------------------------------------------------|
| 2025-01 | 1.0      | Wireframe iniziali app Vigilo                                        |
| 2026-01 | 2.0      | V2: wallet unico Punti Elmetto + welfare on/off, Spaccio Aziendale completo, |
|         |          | scoring con punti visibili, checkout con Elmetto+welfare, tracking ordini, |
|         |          | voucher, promozioni, streak dettaglio, sfide team, check-in/survey,  |
|         |          | notifiche, profilo                                                   |
| 2026-01 | 2.1      | Check-in Turno con autodichiarazione DPI per ruolo, terminologia     |
|         |          | generica (non cantiere-specifica), conversione 60:1, pulizia orfani  |
| 2026-01 | 2.2      | Header: rimosso settings (ora nel Profilo), aggiunto badge Punti     |
|         |          | Elmetto, rimosso catalogo premi (sostituito da Spaccio Aziendale),   |
|         |          | modalità immersiva Android                                           |
| 2026-01 | 2.3      | Tab Team sostituito con Spaccio (accesso diretto negozio). Bottone   |
|         |          | Sicurezza giallo (#FFB800). Tutti i widget Team spostati in Home     |
|         |          | (WellnessCheckin, SafetyStar, VowSurvey, Trasparenza). Card squadra  |
|         |          | unificata (header+membri+classifica espandibile) aggiunta a Punti.   |
|         |          | Rimossi Livello e Transazioni dal wallet. "Come guadagni punti"      |
|         |          | espandibile nella wallet card                                        |
| 2026-01 | 2.4      | Spaccio: card moderne glassmorphism con 3 livelli prezzo (listino,   |
|         |          | scontato, Elmetto -20%), tasti Compra+Carrello gradient, bordo       |
|         |          | colorato per sconto %, badge pill con glow, sfondo grigio/overlay    |
|         |          | scuro. Titolo shimmer animato. Infinite scroll (10 per pagina)       |

---

*Documento di riferimento per lo sviluppo UI Vigilo V2*
