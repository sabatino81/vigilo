# Vigilo - Business Proposal

> Piattaforma digitale per la sicurezza sul lavoro nei cantieri edili

---

## Executive Summary

**Vigilo** è una **piattaforma digitale** che consente ai professionisti della sicurezza di erogare i propri servizi in modalità digitale e di offrire nuovi servizi basati su tecnologia IoT. L'obiettivo è **azzerare gli infortuni sul lavoro** nei cantieri edili e negli ambienti industriali.

### Vision: Platform-as-a-Service per la Sicurezza

Vigilo **non è solo un prodotto**, ma una piattaforma che abilita i Partner a:
- 🔄 **Digitalizzare** i servizi che già erogano (formazione, consulenza, audit)
- 🆕 **Offrire nuovi servizi** basati su IoT e AI (monitoraggio real-time, prevenzione)
- 📈 **Scalare il business** senza aumentare i costi fissi

### Modello di Business: INAIL-Funded Safety

Vigilo adotta un modello **autofinanziato dal risparmio INAIL OT23**: le aziende clienti utilizzano il risparmio sul premio assicurativo per pagare il servizio.

| Elemento | Modello |
|----------|---------|
| **Costo per azienda** | €40/operaio/mese (coperto da risparmio INAIL) |
| **Servizio monitoraggio** | €20/mese → royalty 30% ai Partner |
| **Fondo premi gamification** | €20/mese → no royalty, 30% gross margin Vigilo |
| **Sensori IoT** | 🆓 Comodato d'uso (non venduti) |
| **Piattaforma contenuti** | 🆓 Gratuita per i Partner |
| **Formazione** | ❌ Non passa da Vigilo (100% business del Partner) |

### Architettura Aperta

La piattaforma supporta:
- 📱 **App mobile** per lavoratori (iOS/Android)
- 🪖 **Sensoristica VCT InSite** (casco-centrico) in **comodato d'uso**
- 🔌 **Integrazione sensori terze parti** (architettura aperta)
- 🖥️ **Dashboard COS** centrale operativa ([insite.vct-me.com](https://insite.vct-me.com))
- 🤖 **Intelligenza artificiale** per prevenzione e alert (FI/ASI)
- 👨‍💼 **Portale Partner** gratuito per contenuti, quiz e certificazioni

---

## Il Problema

### Numeri degli Infortuni in Italia (INAIL 2023)

| Metrica | Valore |
|---------|--------|
| Denunce infortuni | **585.356** |
| Infortuni mortali | **1.041** |
| Settore costruzioni (morti) | **150+** |
| Costo medio infortunio grave | **€ 50.000 - 150.000** |
| Costo sociale annuo | **€ 45 miliardi** |

### Cause Principali Infortuni Cantieri

1. **Cadute dall'alto** (30%) - Ponteggi, scale, coperture
2. **Colpi di calore** (15%) - Lavoro estivo senza monitoraggio
3. **Investimenti/schiacciamenti** (12%) - Mezzi in movimento
4. **Elettrocuzione** (8%) - Impianti provvisori
5. **DPI non indossati** (20%) - Mancato utilizzo dispositivi

### Pain Points Attuali

| Stakeholder | Problema |
|-------------|----------|
| **Lavoratore** | Non percepisce rischi, formazione noiosa, nessun incentivo sicurezza |
| **Capocantiere** | Controllo manuale DPI, impossibile monitorare tutti |
| **RSPP** | Documentazione cartacea, audit retrospettivi |
| **Datore di lavoro** | Responsabilità penale, costi assicurativi, fermi cantiere |
| **ASL/Ispettorato** | Controlli a campione, dati non real-time |

---

## La Soluzione: Vigilo

### Value Proposition

> **"Zero infortuni attraverso prevenzione intelligente, gamification e monitoraggio real-time"**

### Approccio Innovativo

```
┌─────────────────────────────────────────────────────────────────┐
│                         VIGILO                                  │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   PREVENZIONE          PROTEZIONE          ENGAGEMENT          │
│   ────────────         ──────────          ──────────          │
│   • Formazione         • Smart Helmet      • Gamification      │
│   • Quiz interattivi   • InSite Band       • Punti e premi     │
│   • Certificazioni     • Alert AI          • Classifiche       │
│   • Procedure          • SOS automatico    • Team challenge    │
│                                                                 │
│                    ▼                                            │
│         CENTRALE OPERATIVA 24/7                                │
│         Monitoraggio real-time tutti i cantieri                │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Funzionalità Chiave

#### 1. Monitoraggio Fisiologico Real-Time (Sistema Casco-Centrico)

| Sensore | Parametro | Indice AI | Beneficio |
|---------|-----------|-----------|-----------|
| GSR/EDA | Risposta galvanica | **ASI** (Acute Stress Index) | Rileva stress acuto |
| HRV | Variabilità cardiaca | **FI** (Fatigue Index) | Previene errori da stanchezza |
| Temperatura cutanea | Stress termico | Correlazione WBGT | Previene colpo di calore |
| Accelerometro | Pattern movimento | Uomo a terra | Intervento immediato |

> 🔌 **Architettura aperta:** la piattaforma supporta l'integrazione di sensori aggiuntivi (ambientali, RTLS, wearable terze parti)

#### 2. Controllo DPI Automatico (Tag NFC/BLE)

- ✅ Verifica indossamento casco in tempo reale
- 👟 Tag per scarpe antinfortunistiche
- 🧤 Tag per guanti
- 🦺 Tag per cintura/cordino
- ⚠️ Alert se DPI mancante in zona vincolata
- 📊 Report compliance per audit (allegabili a POS/DVR)

#### 3. Piattaforma Formazione per Partner

> ⚠️ La formazione è erogata dai **Partner**, NON da Vigilo. La piattaforma fornisce gli strumenti digitali.

- 📤 **CMS** per caricare contenuti (video, PDF, lezioni)
- ❓ **Quiz builder** per test certificativi D.Lgs. 81
- 📊 **Dashboard** progress corsisti
- 📜 **Certificati digitali** con firma
- 🏆 **Gamification** integrata (punti, classifiche)

#### 4. Sistema SOS e Allarmi Intelligenti

- 🆘 Pulsante emergenza manuale (app + casco)
- 🤖 Attivazione automatica su:
  - Uomo a terra (pattern caduta/immobilità)
  - ASI critico (stress acuto)
  - FI critico (affaticamento severo)
  - DPI non conformi in zona vincolata
- 📍 Geolocalizzazione zona cantiere
- 📞 Notifica simultanea: Preposto, COS, 118

---

## Funzionalità per Attore

### 👷 OPERAIO (Lavoratore)

#### Funzionalità App Mobile

| Modulo | Funzionalità | Descrizione |
|--------|--------------|-------------|
| **Home** | Dashboard personale | Safety score, stato DPI, KPI (FI/ASI), checklist giornaliera |
| **Home** | Smart Break | Timer pause intelligenti, zone ombra vicine |
| **SOS** | Pulsante emergenza | Hold 3s → invia posizione GPS + stato a tutti i contatti |
| **SOS** | Segnalazioni | Near-miss, pericoli, suggerimenti (con foto/audio) |
| **Punti** | Wallet punti | Saldo, transazioni, livello (Bronze→Diamond) |
| **Punti** | Catalogo premi | Voucher, DPI premium, gadget (riscatto con punti) |
| **Punti** | Ruota fortunata | 1 spin gratuito/giorno, premi istantanei |
| **Impara** | Corsi formazione | Video, PDF, lezioni del proprio Formatore |
| **Impara** | Quiz certificativi | Test con punteggio minimo, tentativi multipli |
| **Impara** | Certificati | Download attestati, notifica scadenze |
| **Team** | Social wall | Foto cantiere, commenti, like |
| **Team** | Sfide team | Challenge settimanali (es. "Zero Infortuni") |
| **Team** | Safety Star | Nomina colleghi meritevoli |
| **Team** | VOW Survey | Feedback fine turno (+10 punti) |

#### Vantaggi Operaio

| Vantaggio | Descrizione |
|-----------|-------------|
| 💰 **Premi reali** | €240/anno in premi riscattabili (voucher Amazon, DPI, gadget) |
| 🛡️ **Protezione** | Monitoraggio FI/ASI previene incidenti da fatica/stress |
| 🆘 **SOS immediato** | Un pulsante per chiamare aiuto in 3 secondi |
| 📚 **Formazione facile** | Corsi online dal telefono, punti per ogni completamento |
| 🏆 **Riconoscimento** | Safety Star, classifiche, badge pubblici |
| 👁️ **Trasparenza** | Vede solo i propri dati, privacy garantita |

---

### 👔 PREPOSTO

#### Funzionalità

| Piattaforma | Funzionalità | Descrizione |
|-------------|--------------|-------------|
| **Web** | Stato DPI area | Vista real-time DPI per persona/zona |
| **Web** | Controllo varchi | Chi entra/esce da aree vincolate |
| **Web** | Playbook emergenze | Procedure passo-passo per ogni tipo di alert |
| **Web** | Registro DPI | Consegne, sostituzioni, scadenze |
| **Mobile** | Gestione SOS | Ricezione alert, conferma arrivo, chiusura |
| **Mobile** | Scanner DPI | Verifica tag NFC/BLE su casco/scarpe/guanti |
| **Mobile** | Interventi | Cronologia con tempi, foto, firma digitale |

#### Vantaggi Preposto

| Vantaggio | Descrizione |
|-----------|-------------|
| ⚡ **Reattività** | Alert in tempo reale sul telefono |
| 📋 **Procedure chiare** | Playbook elimina dubbi su cosa fare |
| 📱 **Mobilità** | Tutto dal telefono, anche offline |
| 📊 **Tracciabilità** | Ogni intervento documentato automaticamente |
| ⚖️ **Tutela legale** | Evidenze oggettive della propria vigilanza |

---

### 🏗️ RESPONSABILE CANTIERE

#### Funzionalità

| Piattaforma | Funzionalità | Descrizione |
|-------------|--------------|-------------|
| **Web** | Cruscotto rischio | Heatmap fatica/stress per area/lavorazione |
| **Web** | Non conformità | Gestione NC con workflow e scadenze |
| **Web** | Azioni correttive | Assegnazione, follow-up, chiusura |
| **Web** | Configurazione soglie | Personalizzazione alert per il cantiere |
| **Web** | Allegati POS | Upload documenti, aggiornamenti |
| **Mobile** | Verifica DPI on-site | Scanner + foto + coordinate |
| **Mobile** | Azioni rapide | Messa in sicurezza area, allontanamento |
| **Mobile** | Chiusura NC | Foto, firma, geolocalizzazione |

#### Vantaggi Responsabile Cantiere

| Vantaggio | Descrizione |
|-----------|-------------|
| 🎯 **Visione completa** | Tutto il cantiere in un cruscotto |
| ⏱️ **Risparmio tempo** | NC gestite digitalmente, zero carta |
| 📉 **Riduzione incidenti** | Alert preventivi prima dell'evento |
| 📄 **POS sempre aggiornato** | Allegati digitali, versioning automatico |
| ✅ **Compliance** | Evidenze per audit e ispezioni |

---

### 🛡️ RSPP (Responsabile Servizio Prevenzione e Protezione)

#### Funzionalità

| Piattaforma | Funzionalità | Descrizione |
|-------------|--------------|-------------|
| **Web** | Osservatorio HSE | Dashboard cross-sito, trend, correlazioni |
| **Web** | Policy & soglie | Configurazione centralizzata regole alert |
| **Web** | Integrazione DVR | Aggiornamenti motivati da evidenze |
| **Web** | Gestione DPIA | Registro trattamenti, valutazione impatti |
| **Web** | Libreria procedure | Istruzioni operative ISO 45001 |
| **Web** | Report HSE | KPI, analisi cause, piani miglioramento |
| **Mobile** | Ispezioni | Checklist offline, verbali firmati |
| **Mobile** | Azioni correttive | Assegnazione a responsabili cantiere |

#### Vantaggi RSPP

| Vantaggio | Descrizione |
|-----------|-------------|
| 📊 **Data-driven** | Decisioni basate su dati reali, non sensazioni |
| 🔄 **DVR dinamico** | Aggiornamenti automatici da evidenze |
| ⚖️ **Compliance GDPR** | DPIA e registro trattamenti integrati |
| 🎯 **Prevenzione** | FI/ASI rilevano rischi prima dell'incidente |
| 📱 **Ispezioni smart** | Offline-first, firma digitale, geotag |
| 💼 **Professionalità** | Strumenti digitali moderni per i clienti |

---

### 🖥️ COS (Centro Operativo Sicurezza)

#### Funzionalità

| Piattaforma | Funzionalità | Descrizione |
|-------------|--------------|-------------|
| **Web** | Command Center | Mappa multi-sito, layer attivabili |
| **Web** | Triage allarmi | Presa in carico, assegnazione, escalation |
| **Web** | Playback forense | Timeline sincronizzata (GSR/HR, posizione, DPI) |
| **Web** | Pacchetti probatori | PDF + JSON firmabili per POS/DVR/PSC |
| **Web** | Audit log | Tracciabilità completa di ogni azione |
| **Mobile** | Allarmi critici | Notifica push, presa in carico one-tap |
| **Mobile** | Checklist emergenze | Procedure guidate |
| **Mobile** | Chiusura interventi | Note, foto, audio, firma digitale |

#### Vantaggi COS

| Vantaggio | Descrizione |
|-----------|-------------|
| 🌐 **Vista globale** | Tutti i cantieri in un'unica console |
| ⚡ **SLA garantiti** | Triage < 60s, escalation automatica |
| 🔍 **Forense** | Ricostruzione eventi con timeline completa |
| 📦 **Pacchetti probatori** | Export per autorità e assicurazioni |
| 🔒 **Privacy** | Pseudonimi by default, de-pseud. tracciata |

---

### 👔 DIREZIONE / DATORE DI LAVORO

#### Funzionalità

| Piattaforma | Funzionalità | Descrizione |
|-------------|--------------|-------------|
| **Web** | KPI aggregati | Incidenti, near-miss, compliance DPI, tempi risposta |
| **Web** | Benchmark | Confronto cantieri, fornitori, periodi |
| **Web** | ESG | Metriche ambientali (rumore, polveri, CO₂) |
| **Web** | ROI sicurezza | Costi evitati, risparmio INAIL |
| **Web** | Stato audit | Ispezioni, NC aperte, azioni in corso |
| **Mobile** | Snapshot executive | 5-7 KPI chiave |
| **Mobile** | Approvazioni | Firma digitale documenti |

#### Vantaggi Direzione

| Vantaggio | Descrizione |
|-----------|-------------|
| 💰 **ROI misurabile** | Risparmio INAIL OT23 fino al 28% |
| 📉 **-30% infortuni** | Prevenzione = meno fermi cantiere |
| ⚖️ **Tutela penale** | Evidenze di adempimento D.Lgs. 81/2008 |
| 📊 **ESG ready** | Report per stakeholder e bandi |
| 🏆 **Employer branding** | Azienda che investe in sicurezza |
| 💵 **Costo zero** | Per PMI ≤10: risparmio INAIL copre costo Vigilo |

---

### 📚 PARTNER / FORMATORE

#### Funzionalità

| Piattaforma | Funzionalità | Descrizione |
|-------------|--------------|-------------|
| **Web** | CMS Formazione | Upload video, PDF, lezioni |
| **Web** | Quiz builder | Creazione test certificativi D.Lgs. 81 |
| **Web** | Generatore certificati | Attestati con firma digitale |
| **Web** | Dashboard corsisti | Progress, completamenti, scadenze |
| **Web** | Report compliance | Export per audit clienti |
| **Web** | Accesso dati IoT | Indici FI/ASI, eventi, allarmi |
| **Web** | Catalogo premi custom | Premi brandizzati personalizzati |
| **Web** | Sfide custom | Challenge specifiche per clienti |

#### Vantaggi Partner/Formatore

| Vantaggio | Descrizione |
|-----------|-------------|
| 🆓 **Piattaforma GRATIS** | Zero costi per CMS, quiz, certificati |
| 💰 **Royalty €72/anno** | Per ogni operaio dei propri clienti |
| 💯 **Formazione = 100% sua** | Fattura direttamente al cliente |
| 🎯 **Differenziazione** | IoT + Gamification = offerta unica |
| 📈 **Upsell** | Da formatore a consulente tech |
| 🔄 **Revenue ricorrente** | Monitoraggio = relazione continua |
| 🏷️ **White-label** | Attestati col proprio brand |

---

### 🔍 CONSULENTE HSE / COORDINATORE SICUREZZA

#### Funzionalità

| Piattaforma | Funzionalità | Descrizione |
|-------------|--------------|-------------|
| **Web** | KPI per incarico | Performance dei cantieri seguiti |
| **Web** | Audit digitale | Checklist Titolo IV D.Lgs. 81 |
| **Web** | Piani miglioramento | Azioni correttive con scadenze |
| **Web** | Pacchetti PSC/POS | Report esportabili |
| **Mobile** | Ispezioni offline | Evidenze geotaggate, firma |

#### Vantaggi Consulente HSE

| Vantaggio | Descrizione |
|-----------|-------------|
| 📱 **Mobilità** | Ispezioni da tablet, anche senza rete |
| 📊 **Dati oggettivi** | KPI reali per supportare raccomandazioni |
| 📄 **Documentazione** | Pacchetti probatori pronti per PSC |
| ⏱️ **Efficienza** | Meno tempo su carta, più consulenza |

---

### Riepilogo Vantaggi per Attore

| Attore | Vantaggio Principale | Valore Economico |
|--------|---------------------|------------------|
| **Operaio** | Premi reali + protezione | €240/anno in premi |
| **Preposto** | Alert real-time + playbook | Riduzione responsabilità |
| **Resp. Cantiere** | Cruscotto rischio + NC digitali | -50% tempo admin |
| **RSPP** | DVR dinamico + data-driven | Compliance garantita |
| **COS** | Command center H24 | SLA < 3 min |
| **Direzione** | ROI + tutela penale | Fino a +€180/operaio/anno |
| **Formatore** | Piattaforma gratis + royalty | €72/operaio/anno |
| **Consulente HSE** | Audit digitale | +30% efficienza |

---

## Target Market

### Target Primario: Consulenti Sicurezza e Formazione

Vigilo si rivolge esclusivamente a **professionisti abilitati alla formazione sulla sicurezza** ai sensi del D.Lgs. 81/2008.

#### Requisiti Partner Vigilo

Per diventare Partner è necessario possedere **almeno uno** dei seguenti requisiti:
- ✅ Qualifica di **RSPP** (Responsabile Servizio Prevenzione e Protezione)
- ✅ Qualifica di **ASPP** (Addetto Servizio Prevenzione e Protezione)
- ✅ Abilitazione come **Formatore per la Sicurezza** (D.I. 6 marzo 2013)
- ✅ Accreditamento come **Ente di Formazione** regionale
- ✅ Iscrizione all'**Albo Formatori** di associazioni riconosciute (AIFOS, AIAS, ecc.)

#### Tipologie Partner

| Tipologia Partner | Numero Italia | Clienti Medi | Opportunità | Priorità |
|-------------------|---------------|--------------|-------------|----------|
| **RSPP/ASPP esterni** | ~15.000 | 10-30 aziende | Formazione + consulenza DVR | 🥇 Alta |
| **Formatori sicurezza abilitati** | ~8.000 | 20-50 aziende | Corsi certificati D.Lgs. 81 | 🥇 Alta |
| **Enti di formazione accreditati** | ~2.000 | 50-200 aziende | Volume corsi, credibilità | 🥇 Alta |
| **Studi consulenza HSE** | ~3.000 | 30-100 aziende | Pacchetti completi sicurezza | 🥈 Media |
| **Associazioni di categoria** | ~500 | 100-1.000 associati | Volume, canale B2B2B | 🥈 Media |

#### Perché Solo Professionisti Abilitati?

| Motivo | Beneficio |
|--------|-----------|
| **Compliance normativa** | Formazione erogata è valida per legge |
| **Credibilità** | Partner qualificati aumentano trust del brand |
| **Revenue garantito** | Aziende DEVONO fare formazione (obbligo D.Lgs. 81) |
| **Competenza tecnica** | Sanno spiegare valore DPI sensorizzati |
| **Rete esistente** | Hanno già clienti che necessitano sicurezza |

### Target Secondario: Aziende Finali (tramite Partner)

| Segmento | Dimensione Italia | Raggiunto tramite |
|----------|-------------------|-------------------|
| **PMI costruzioni** | ~80.000 aziende | RSPP esterni, consulenti |
| **Grandi imprese edili** | ~500 aziende | Studi consulenza |
| **Manifatturiero** | ~50.000 aziende | Associazioni categoria |
| **Logistica** | ~15.000 aziende | Enti formazione |

### Buyer Personas (Partner)

#### 1. Alessandro - RSPP Esterno Abilitato
- **Profilo**: 45 anni, laurea ingegneria, RSPP dal 2010, gestisce 25 PMI edili (~500 operai)
- **Qualifica**: RSPP modulo A-B-C, Formatore qualificato area 2 (D.I. 6/3/2013)
- **Goal**: Differenziarsi dalla concorrenza, aumentare ricavi per cliente
- **Pain**: Clienti vedono sicurezza come costo, difficile fidelizzare
- **Trigger**: Un suo cliente ha avuto infortunio grave → cerca soluzioni innovative
- **Opportunità**: Partnership Vigilo **senza costi**, royalty €72/operaio/anno
- **Revenue potenziale**: 500 × €72 = **€36.000/anno** in royalty passive

#### 2. Francesca - Titolare Studio Consulenza HSE
- **Profilo**: 50 anni, studio con 5 consulenti RSPP, 80 aziende clienti (~1.600 operai)
- **Qualifica**: Tutti i consulenti sono RSPP abilitati + 2 formatori qualificati
- **Goal**: Scalare senza assumere, digitalizzare servizi ripetitivi
- **Pain**: Troppo tempo su formazione base, margini bassi su corsi standard
- **Trigger**: Concorrente ha iniziato a offrire formazione online
- **Opportunità**: Vigilo come **differenziatore premium** (IoT + gamification)
- **Revenue potenziale**: 1.600 × €72 = **€115.200/anno** in royalty per lo studio

#### 3. Roberto - Direttore Ente Formazione Accreditato
- **Profilo**: Ente accreditato Regione Lombardia, 200 aziende/anno (~3.000 operai)
- **Qualifica**: Accreditamento regionale, 10 formatori abilitati in organico
- **Goal**: Innovare offerta formativa, ridurre dropout, aumentare engagement
- **Pain**: Corsi in aula poco efficaci, difficile tracciare apprendimento
- **Trigger**: Bando regionale per digitalizzazione formazione sicurezza
- **Opportunità**: Vigilo come piattaforma **blended learning** certificata
- **Revenue potenziale**: 3.000 × €72 = **€216.000/anno** in royalty

#### 4. Giuseppe - Formatore Freelance Specializzato
- **Profilo**: 38 anni, ex-capocantiere, formatore da 8 anni, 40 aziende clienti (~800 operai)
- **Qualifica**: Formatore qualificato area 2 + esperienza cantieri (criterio 3)
- **Goal**: Ampliare offerta, passare da formazione base a consulenza premium
- **Pain**: Concorrenza sui prezzi, difficile giustificare tariffe alte
- **Trigger**: Cliente chiede soluzione IoT vista a fiera SAIE
- **Opportunità**: Vigilo come **upgrade di posizionamento** (da formatore a consulente tech)
- **Revenue potenziale**: 800 × €72 = **€57.600/anno** in royalty

### Buyer Persona (Cliente Finale)

#### Marco - CEO Impresa Edile (raggiunto tramite Partner)
- **Profilo**: 55 anni, impresa 80 dipendenti, 4 cantieri attivi
- **Pain**: Infortunio grave nel 2023, ispezione ASL, premio INAIL aumentato
- **Goal**: Azzerare infortuni, ridurre premi assicurativi, evitare responsabilità penale
- **Budget**: €30-50K/anno per sicurezza (già spende per consulente + formazione)
- **Decisione**: Si affida al proprio RSPP esterno (Partner Vigilo) per soluzione completa
- **NON contattato direttamente da Vigilo** → arriva tramite il suo consulente

---

## Business Model

### Modello INAIL-Funded: Il Servizio Si Ripaga Da Solo

Il modello di business di Vigilo è **autofinanziato**: le aziende clienti utilizzano il **risparmio INAIL OT23** per pagare il servizio, ottenendo sicurezza a costo zero (o addirittura con guadagno).

```
                    FLUSSO ECONOMICO VIGILO
                    =======================

┌─────────────────────────────────────────────────────────────────┐
│                   AZIENDE CLIENTI                               │
│              (Imprese edili, Manifatturiero)                   │
│                                                                 │
│   📉 RISPARMIO INAIL OT23: €55/mese per operaio (PMI ≤10)     │
│   💰 COSTO VIGILO: €40/mese per operaio                        │
│   ✅ SALDO NETTO: +€15/mese = GUADAGNO                         │
└──────────────┬────────────────────────────────┬─────────────────┘
               │                                │
               │ €40/operaio/mese               │ 💰 Formazione
               │ (coperto da risparmio INAIL)   │    (pagata direttamente)
               ▼                                ▼
┌──────────────────────────────┐    ┌─────────────────────────────┐
│         VIGILO               │    │      PARTNER                │
│                              │    │   (Formatore/RSPP)          │
│ Riceve €40/operaio/mese:     │    │                             │
│ ├─ €20 Monitoraggio          │    │ Cosa fornisce:              │
│ │   └─ 30% royalty Partner   │    │ • Formazione D.Lgs. 81      │
│ └─ €20 Fondo Premi           │    │ • Consulenza sicurezza      │
│     └─ 30% gross margin      │    │ • DVR e documentazione      │
│                              │    │                             │
│ Cosa fornisce:               │    │ Cosa riceve GRATIS:         │
│ • App Vigilo                 │    │ • Piattaforma contenuti     │
│ • Sensori in COMODATO        │    │ • Quiz e materiali          │
│ • Dashboard monitoraggio     │    │ • Strumenti digitali        │
│ • Centrale operativa H24     │    │                             │
│ • Premi gamification         │    │ Cosa riceve DA VIGILO:      │
│                              │    │ • Royalty €6/operaio/mese   │
└──────────────────────────────┘    └─────────────────────────────┘
```

### Calcolo Risparmio INAIL OT23

**Base di calcolo (operaio edile medio):**

| Parametro | Valore | Fonte |
|-----------|--------|-------|
| RAL media operaio edile | €26.000/anno | CCNL Edilizia 2024 |
| Tasso INAIL edilizia (rischio alto) | 9% | Classe 7-9 INAIL |
| **Premio INAIL/operaio** | **€2.340/anno** | €26.000 × 9% |

**Riduzione OT23 per dimensione azienda:**

| Dimensione Azienda | Dipendenti | Riduzione OT23 | Risparmio/anno | Risparmio/mese |
|--------------------|------------|----------------|----------------|----------------|
| **Piccola** | ≤10 | **28%** | **€655** | **€55** |
| **Media** | 11-50 | 18% | €421 | €35 |
| **Medio-grande** | 51-200 | 10% | €234 | €20 |
| **Grande** | 201-500 | 7% | €164 | €14 |

> 📊 **Fonte**: [INAIL OT23 2025](https://biblus.acca.it/ot23-riduzione-tasso-medio-prevenzione-inail/) - Riduzione tasso medio per prevenzione

### Il Modello: €40/operaio/mese

| Componente | Importo/mese | Destinazione |
|------------|--------------|--------------|
| **Servizio Monitoraggio** | €20 | Vigilo (royalty 30% al Partner) |
| **Fondo Premi Gamification** | €20 | Lavoratori (gross margin 30% Vigilo) |
| **TOTALE** | **€40** | |

### Bilancio per l'Azienda Cliente

| Dimensione | Risparmio INAIL | Costo Vigilo | **Saldo/mese** | **Saldo/anno** |
|------------|-----------------|--------------|----------------|----------------|
| **Piccola (≤10)** | €55 | €40 | **+€15** ✅ | **+€180** |
| **Media (11-50)** | €35 | €40 | -€5 | -€60 |
| **Grande (51-200)** | €20 | €40 | -€20 | -€240 |

> 💡 **Per le PMI piccole**: Vigilo si ripaga completamente + €180/anno di risparmio netto per operaio
>
> 💡 **Per aziende medie/grandi**: Costo netto €60-240/anno per operaio, ma compensato da:
> - **Riduzione infortuni -30%** = €15.000-50.000 risparmiati per incidente evitato
> - Minori fermi cantiere
> - Protezione legale e compliance D.Lgs. 81/2008
> - Documentazione automatica per audit

### Distribuzione Revenue (per operaio/mese)

| Destinatario | Importo | % | Note |
|--------------|---------|---|------|
| **Partner** (royalty) | €6 | 15% | 30% del monitoraggio (€20) |
| **Lavoratori** (premi effettivi) | €14 | 35% | 70% del fondo premi (€20) |
| **Vigilo** (net revenue) | €20 | 50% | €14 monitoraggio + €6 margin premi |
| **TOTALE** | €40 | 100% | |

### Cosa Riceve il Partner (GRATIS + Royalty)

**Strumenti gratuiti:**

| Strumento | Descrizione | Servizio Digitalizzato |
|-----------|-------------|------------------------|
| **CMS Formazione** | Carica corsi, video, documenti | Formazione D.Lgs. 81 online |
| **Quiz Builder** | Crea test certificativi | Verifiche apprendimento |
| **Generatore Certificati** | Attestati con firma digitale | Certificazioni automatiche |
| **Dashboard Compliance** | Monitora DPI, scadenze, audit | Consulenza HSE continua |
| **Report POS/DVR** | Pacchetti probatori esportabili | Documentazione per audit |
| **Accesso dati IoT** | Indici FI/ASI, eventi, allarmi | Nuovi servizi predittivi |

**Royalty garantita (solo su monitoraggio):**

| Voce | Calcolo | Importo |
|------|---------|---------|
| Per operaio/mese | 30% di €20 | **€6** |
| Per operaio/anno | €6 × 12 | **€72** |

> ⚠️ **La formazione rimane business del Partner**: Vigilo non incassa nulla sulla formazione. Il Partner la eroga, la fattura e la incassa direttamente.
>
> ⚠️ **Nessuna royalty sui premi**: Il fondo premi (€20/mese) non genera royalty per i Partner.

### Esempio Economico Partner

**Partner tipo: RSPP con 20 aziende clienti, 400 lavoratori totali**

| Voce | Fonte | Ricavo/anno |
|------|-------|-------------|
| **Royalty Vigilo** (400 × €6 × 12) | Vigilo paga al Partner | **€28.800** |
| **Formazione base** (400 × €80) | Cliente paga direttamente | €32.000 |
| **Aggiornamenti annuali** (400 × €50) | Cliente paga direttamente | €20.000 |
| **Consulenza DVR** (20 × €500) | Cliente paga direttamente | €10.000 |
| **TOTALE PARTNER** | | **€90.800** |

> ✅ Di cui **€28.800 sono royalty passive** da Vigilo (rendita ricorrente)
> ✅ **€62.000 sono ricavi diretti** dalla formazione (100% business del Partner)

### Esempio Economico Vigilo

**Su 100 Partner attivi, 2.000 aziende clienti, 40.000 operai**

| Voce | Calcolo | Importo/anno |
|------|---------|--------------|
| **Revenue totale** | 40.000 × €40 × 12 | €19.200.000 |
| - Royalty Partner | 40.000 × €6 × 12 | -€2.880.000 |
| - Premi lavoratori | 40.000 × €14 × 12 | -€6.720.000 |
| **Revenue netto Vigilo** | 40.000 × €20 × 12 | **€9.600.000** |
| - COGS (sensori, cloud, COS) | ~40% | -€3.840.000 |
| **Gross Profit** | | **€5.760.000** |

### Vantaggi del Modello INAIL-Funded

| Per Vigilo | Per il Partner | Per l'Azienda Cliente |
|------------|----------------|----------------------|
| Revenue ricorrente €20/operaio | **Royalty €72/anno** per operaio | **Costo zero** (PMI piccole) |
| Gross margin 50% | **Formazione = 100% suo** | Risparmio INAIL garantito |
| Scalabilità via Partner | **Piattaforma GRATIS** | Sensori in comodato |
| CAC basso | Strumenti digitali moderni | Compliance D.Lgs. 81 |
| Modello difendibile | Zero investimento iniziale | Riduzione infortuni -30% |

---

## Analisi del Mercato: Formazione Sicurezza Online

### Quadro Normativo (Accordo Stato-Regioni 2025)

Il nuovo **Accordo Stato-Regioni n. 59/CSR del 17 aprile 2025** disciplina la formazione sicurezza online:

| Modalità | Requisiti |
|----------|-----------|
| **E-learning asincrono** | LMS conforme, tracciamento SCORM, tutor di contenuto + processo |
| **Videoconferenza sincrona** | Max 30 partecipanti, equivalente all'aula, no smartphone |
| **Moduli pratici** | Obbligatoriamente in presenza |

### Come Operano Oggi i Formatori

#### Opzione 1: Piattaforme "Chiavi in Mano" (White-Label)

I formatori freelance/RSPP usano piattaforme di terze parti:

| Piattaforma | Modello | Pro | Contro |
|-------------|---------|-----|--------|
| **Tutor81** | LMS white-label | Attestati col proprio brand | Costi per corso, nessun IoT |
| **Progetto81** | Ente accreditato | UNI EN ISO 9001-2015 | Margini compressi |
| **Vega Formazione** | Catalogo + videoconferenza | Corsi pronti | Zero personalizzazione |

**Modello economico tipico:**
- Il formatore **acquista** i corsi (€20-80/corso)
- Li **rivende** ai clienti (€50-150/corso)
- **Margine**: 30-50%
- **Attestato**: emesso dall'ente accreditato (non dal formatore)

#### Opzione 2: LMS Proprietario

Enti formativi più strutturati acquistano/affittano una piattaforma LMS:

| Requisito Accordo 2025 | Cosa serve |
|------------------------|------------|
| Tracciamento SCORM | LMS certificato |
| Tutor di contenuto | Docente qualificato |
| Tutor di processo | Supporto tecnico |
| Test intermedi/finali | Quiz builder |
| Autorizzazione regionale | Accreditamento o convenzione |

**Costi stimati LMS proprietario:** €3.000-15.000/anno

### Pain Points dei Formatori Oggi

| Problema | Impatto |
|----------|---------|
| **Costi piattaforma elevati** | Margini ridotti, difficile per freelance |
| **Nessuna differenziazione** | Tutti vendono gli stessi corsi standard |
| **Attestati non propri** | Il brand del formatore sparisce |
| **Zero engagement** | Corsi noiosi, dropout alto |
| **Nessun upsell** | Finito il corso, finita la relazione |
| **Compliance complessa** | Accordo 2025 richiede più figure |

### Come Vigilo Risolve i Pain Points

| Pain Point Attuale | Soluzione Vigilo |
|--------------------|------------------|
| Costi piattaforma | **GRATIS** per i Partner |
| Nessuna differenziazione | **IoT + Gamification** = offerta unica |
| Attestati non propri | **White-label** completo |
| Zero engagement | **€240/anno in premi** per operaio |
| Nessun upsell | **Monitoraggio continuo** = revenue ricorrente |
| Compliance complessa | **Tutor di processo incluso** nella piattaforma |

### Confronto Modelli Economici

| Aspetto | Formatore Oggi | Formatore con Vigilo |
|---------|----------------|----------------------|
| Costo piattaforma | €3.000-15.000/anno | **€0** |
| Margine formazione | 30-50% | **100%** (formazione sua) |
| Revenue ricorrente | ❌ No | ✅ Royalty €72/operaio/anno |
| Differenziazione | ❌ Corsi standard | ✅ IoT + AI + Gamification |
| Fidelizzazione cliente | ❌ Bassa | ✅ Alta (monitoraggio continuo) |

---

## Competitive Landscape

### Competitor Diretti

| Competitor | Punti di Forza | Punti di Debolezza |
|------------|----------------|-------------------|
| **Safetysnapper** | App semplice, prezzo basso | No IoT, no monitoraggio vitali |
| **iAuditor** | Checklist digitali, brand noto | Solo audit, no prevenzione |
| **Smartcap** | Monitoraggio fatica | Solo casco, no ecosistema |
| **Spot-r** | Tracking persone | No parametri vitali |

### Vantaggi Competitivi Vigilo

| Vantaggio | Descrizione |
|-----------|-------------|
| **INAIL-Funded** | Il servizio si ripaga con il risparmio INAIL OT23 (costo zero per PMI) |
| **Piattaforma aperta** | Architettura estendibile, integra sensori VCT + terze parti |
| **Partner = Professionisti HSE** | Solo RSPP/Formatori qualificati → formazione valida per legge |
| **Gamification con premi reali** | €20/operaio/mese in premi → engagement altissimo |
| **AI predittiva (FI/ASI)** | Indici calcolati rilevano condizioni critiche prima dell'evento |
| **Privacy-by-design** | Pseudonimizzazione, GDPR, Statuto art. 4 nativi |
| **Made in Italy** | Compliance normativa italiana (D.Lgs. 81/2008) nativa |
| **Zero costi per Partner** | Piattaforma gratuita, royalty €72/operaio/anno |
| **COS H24** | Centrale operativa inclusa nel servizio |

### Posizionamento

```
                    ALTO
                      │
     Smartcap         │         ★ VIGILO
        ●             │
                      │
    ──────────────────┼────────────────────
                      │         INTEGRAZIONE
    MONITORAGGIO      │         ECOSISTEMA
    SINGOLO           │
                      │
        ● iAuditor    │    ● Safetysnapper
                      │
                    BASSO
```

---

## Go-to-Market Strategy

### Strategia: Partner-First (Solo Professionisti Abilitati)

Vigilo **non vende direttamente** alle aziende finali. La crescita avviene attraverso il reclutamento di **Consulenti Sicurezza e Formatori Abilitati** che propongono la soluzione ai propri clienti.

> ⚠️ **Requisito obbligatorio**: Ogni Partner deve dimostrare qualifica RSPP/ASPP o abilitazione come Formatore (D.I. 6/3/2013) o accreditamento ente formativo.

### Fase 1: Founding Partners (Mesi 1-6)

**Target**: 20-30 Partner pilota (RSPP esterni, Formatori abilitati, Enti formazione)

| Azione | Obiettivo |
|--------|-----------|
| Selezione Partner pilota | 30 professionisti abilitati con >10 clienti ciascuno |
| Verifica qualifiche | Controllo certificazioni RSPP/Formatore |
| Onboarding gratuito | Formazione piattaforma Vigilo |
| Co-creazione contenuti | Corsi D.Lgs. 81 validati da esperti |
| Case study congiunti | Success stories per recruiting |

**Canali recruiting Partner (focus formazione sicurezza):**
- 🎯 **AIFOS** (Associazione Italiana Formatori Sicurezza) - 3.000+ iscritti
- 🎯 **AIAS** (Associazione Italiana Ambiente e Sicurezza) - 2.000+ iscritti
- 🎯 **AiFOS Academy** - Rete formatori certificati
- 🎯 **LinkedIn** - Gruppi "RSPP Italia", "Formatori Sicurezza", "HSE Manager"
- 🎯 **Fiere di settore** - SAIE, Ambiente Lavoro, Safety Expo
- 🎯 **Ordini professionali** - Ingegneri (sezione sicurezza), Architetti, Periti
- 🎯 **Enti bilaterali edilizia** - FORMEDIL, Scuole Edili provinciali

**KPI**: 30 Partner abilitati, 1.500 operai, €720K ARR lordo, NPS Partner > 60

### Fase 2: Partner Acceleration (Mesi 7-18)

**Target**: 100 Partner abilitati attivi

| Azione | Obiettivo |
|--------|-----------|
| Partner Portal | Self-service onboarding con verifica qualifiche |
| Accademia Vigilo | Certificazione specifica piattaforma (online) |
| Partner Tiers (Bronze/Silver/Gold) | Incentivi per volume formazione erogata |
| Eventi Partner | 2 convention/anno + webinar mensili |
| Referral Program | Formatore porta Formatore (€500 bonus) |

**Supporto Partner:**
- Partner Success Manager dedicato (1:20 ratio)
- Materiali marketing co-branded per formatori
- Template corsi D.Lgs. 81 preconfigurati
- Supporto tecnico prioritario su piattaforma e IoT

**KPI**: 100 Partner abilitati, 8.000 operai, €3.84M ARR lordo (€1.92M netto), Partner churn < 10%

### Fase 3: Network Expansion (Mesi 19-36)

**Target**: 300 Partner abilitati, espansione verticali e geografica

| Azione | Obiettivo |
|--------|-----------|
| Verticali specializzati | Formatori settore Oil&Gas, Food, Pharma, Chimico |
| Partnership associazioni | AIFOS nazionale, ANCE, Confindustria |
| Accordi enti bilaterali | FORMEDIL, OPRA, Fondi interprofessionali |
| Espansione DACH | Partner formatori in Germania, Austria, Svizzera |
| White-label assicurazioni | Co-branding con compagnie (canale alternativo) |

**KPI**: 300 Partner, 25.000 operai, €12M ARR lordo (€6M netto), 3 paesi

### Partner Journey

```
AWARENESS          CONSIDERATION       ONBOARDING         SUCCESS
─────────          ─────────────       ──────────         ───────

LinkedIn Ads  ───► Webinar demo  ───► Certificazione ───► Revenue

Fiere/Eventi  ───► Free trial   ───► Setup clienti  ───► Upselling
                   (30 giorni)       (1° cliente)

Referral      ───► Business     ───► Formazione     ───► Tier upgrade
                   case              piattaforma         (Gold)
```

### Metriche Partner Program

| Metrica | Target |
|---------|--------|
| Partner Activation Rate | >70% (attivi entro 60gg) |
| Time to First Revenue | <45 giorni |
| Partner NPS | >50 |
| Partner Churn | <10%/anno |
| Operai medi per Partner | 83 |
| **Royalty media per Partner** | **€6.000/anno** (83 × €72) |
| Partner referral rate | 25% nuovi Partner da referral |

---

## Proiezioni Finanziarie

### Revenue Forecast (3 anni) - Modello €40/operaio

| Anno | Partner | Operai | Revenue Lordo | Royalty Partner | Premi Lavoratori | **Revenue Netto Vigilo** | Crescita |
|------|---------|--------|---------------|-----------------|------------------|--------------------------|----------|
| **Anno 1** | 30 | 1.500 | €720K | -€108K | -€252K | **€360K** | - |
| **Anno 2** | 100 | 8.000 | €3.84M | -€576K | -€1.34M | **€1.92M** | +433% |
| **Anno 3** | 300 | 25.000 | €12M | -€1.8M | -€4.2M | **€6M** | +213% |

**Calcolo:**
- Revenue lordo = Operai × €40 × 12 mesi
- Royalty Partner = Operai × €6 × 12 (15% del totale)
- Premi lavoratori = Operai × €14 × 12 (35% del totale)
- Revenue netto Vigilo = Operai × €20 × 12 (50% del totale)

### Breakdown Revenue Anno 3 (25.000 operai)

| Componente | Per operaio/mese | Totale/anno | % Revenue |
|------------|------------------|-------------|-----------|
| **Revenue lordo** | €40 | €12.000.000 | 100% |
| - Royalty Partner | €6 | -€1.800.000 | 15% |
| - Premi lavoratori | €14 | -€4.200.000 | 35% |
| **= Revenue netto Vigilo** | €20 | **€6.000.000** | 50% |
| - COGS (sensori, cloud, COS) | ~€8 | -€2.400.000 | 20% |
| **= Gross Profit** | €12 | **€3.600.000** | 30% |

> ⚠️ **Formazione esclusa**: Non passa da Vigilo. I 300 Partner la erogano direttamente ai clienti (~€18M/anno nel network totale).
> 💡 **Hardware in comodato**: Sensori forniti gratuitamente, costo incluso nel COGS.

### Unit Economics

| Metrica | Valore | Note |
|---------|--------|------|
| **ARPU** (Revenue per operaio) | €40/mese lordo, €20/mese netto | Dopo royalty e premi |
| **CAC Partner** | €1.500 | Basso: piattaforma gratis, zero rischio |
| **LTV per operaio** (3 anni) | €720 | €20 × 36 mesi |
| **Operai medi per Partner** | 83 | 25.000 operai / 300 Partner |
| **Revenue Vigilo per Partner/anno** | €20.000 | 83 operai × €20 × 12 |
| **LTV/CAC Ratio Partner** | 48x | Eccellente per modello B2B2B |
| **Gross Margin** | 60% | Su revenue netto (€20) |
| **Partner Retention** | 95%/anno | Alta: guadagnano senza investire |
| **Avg Royalty per Partner** | €6.000/anno | 83 operai × €72/anno |

### Breakdown Costi (su Revenue Netto Vigilo €6M Anno 3)

| Voce | Importo | % Revenue Netto | Note |
|------|---------|-----------------|------|
| COGS (sensori, cloud, COS) | €2.4M | 40% | Hardware comodato ammortizzato 3 anni |
| Partner Success & Marketing | €720K | 12% | Recruiting e supporto Partner |
| R&D | €900K | 15% | App, piattaforma, AI |
| G&A | €480K | 8% | Amministrazione |
| **EBITDA** | **€1.5M** | **25%** | |

### Margini per Stakeholder

| Stakeholder | Importo/operaio/anno | Su 25.000 operai | % del totale |
|-------------|----------------------|------------------|--------------|
| **Partner** (royalty) | €72 | €1.8M | 15% |
| **Lavoratori** (premi) | €168 | €4.2M | 35% |
| **Vigilo** (netto) | €240 | €6M | 50% |
| **TOTALE** | €480 | €12M | 100% |

---

## Team

### Management

| Ruolo | Responsabilità |
|-------|----------------|
| **CEO** | Strategia, fundraising, partnership strategiche |
| **CTO** | Prodotto, tecnologia, IoT |
| **COO** | Operations, centrale operativa |
| **Head of Partner Success** | Recruiting, onboarding, supporto Partner |

### Advisory Board

- Ex-direttore INAIL
- CEO impresa edile Top 10
- Partner studio legale specializzato D.Lgs. 81
- CTO scale-up IoT (exit >€50M)

---

## Investment Ask

### Round: Seed

| Voce | Importo |
|------|---------|
| **Richiesta** | €1.5M |
| **Valutazione pre-money** | €5M |
| **Equity offerta** | 23% |

### Uso dei Fondi

| Area | Importo | % |
|------|---------|---|
| R&D (prodotto, AI) | €500K | 33% |
| Sales & Marketing | €450K | 30% |
| Operations (centrale) | €300K | 20% |
| Team expansion | €200K | 13% |
| Buffer | €50K | 4% |

### Milestones 18 mesi

- ✅ 5.000 operai monitorati
- ✅ €2.4M ARR lordo (€1.2M netto Vigilo)
- ✅ Break-even operativo
- ✅ 3 partnership strategiche (ANCE, assicurazione, INAIL)
- ✅ 80 Partner attivi

---

## Impatto Sociale

### SDG Alignment

| SDG | Contributo Vigilo |
|-----|-------------------|
| **SDG 3** - Salute e benessere | Riduzione infortuni e malattie professionali |
| **SDG 8** - Lavoro dignitoso | Ambienti di lavoro sicuri |
| **SDG 9** - Innovazione | Tecnologia IoT per sicurezza |
| **SDG 11** - Città sostenibili | Cantieri più sicuri |

### Metriche di Impatto

| Metrica | Target Anno 3 |
|---------|---------------|
| Infortuni prevenuti | 500+ |
| Vite salvate | 10+ |
| Ore formazione erogate | 100.000+ |
| CO2 risparmiata (meno fermi cantiere) | 500 ton |

---

## Conclusione

**Vigilo** trasforma la sicurezza sul lavoro da **obbligo burocratico** a **vantaggio competitivo**.

### Perché Ora

1. **Normativa**: D.Lgs. 81/2008 sempre più stringente
2. **Tecnologia**: IoT e AI accessibili e affidabili
3. **Cultura**: Nuove generazioni chiedono sicurezza
4. **Costi**: Assicurazioni premiano prevenzione

### Call to Action

> **Uniamoci per costruire un futuro dove nessuno muore sul lavoro.**

---

## Contatti

**Website**: [vct-me.com](https://vct-me.com)

**Dashboard**: [insite.vct-me.com](https://insite.vct-me.com)

**Email**: info@vct-me.com

---

*Documento riservato - © 2024 VCT - Virtual Creative Technologies*
