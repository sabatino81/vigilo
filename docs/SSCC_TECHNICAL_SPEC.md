# Safety & Sustainability Control Center

> Documento base di progetto — Sistema casco-centrico per cantieri edili

---

## Indice

1. [Executive & Governance](#1-executive--governance)
2. [Attori & Permessi (RBAC)](#2-attori--permessi-rbac)
3. [Architettura & Componenti](#3-architettura--componenti)
4. [Modelli & Logiche di Rischio](#4-modelli--logiche-di-rischio)
5. [Esperienza Utente (Web & Mobile)](#5-esperienza-utente-web--mobile)
6. [Normativa & Compliance](#6-normativa--compliance)
7. [Privacy & Sicurezza dei Dati](#7-privacy--sicurezza-dei-dati)
8. [Procedure Operative (SOP)](#8-procedure-operative-sop)
9. [Documentazione HSE & Legale](#9-documentazione-hse--legale)
10. [KPI, Reporting & ESG](#10-kpi-reporting--esg)
11. [Piano di Rollout & Change](#11-piano-di-rollout--change)
12. [Operazioni & Servizi](#12-operazioni--servizi)
13. [Integrazioni & Interoperabilità](#13-integrazioni--interoperabilità)
14. [Gestione Rischi & Qualità](#14-gestione-rischi--qualità)
15. [Distinte & Specifiche Tecniche](#15-distinte--specifiche-tecniche)
16. [FAQ](#16-faq)

---

## 1. Executive & Governance

### 1.1 Executive Summary

#### Descrizione del progetto

Sistema **"Safety & Sustainability Control Center"** per cantieri edili, **casco-centrico**: la centralina sul casco acquisisce **GSR/parametri cardiovascolari** e legge **tag DPI** (scarpe/guanti/cintura), invia i dati al **gateway di cantiere** e quindi alla piattaforma cloud.

La **console COS** gestisce allarmi e triage in tempo reale con **playbook operativi**, mentre viste dedicate supportano:
- Responsabili di Cantiere
- RSPP
- Preposti
- Direzione
- Operatori (mobile opzionale)

Il sistema è progettato **privacy-by-design** e si integra nei **POS/DVR/PSC/Fascicolo** con pacchetti probatori firmabili.

#### Obiettivi

| Obiettivo | Descrizione |
|-----------|-------------|
| **Prevenzione infortuni** | Rilevazione precoce di affaticamento/stress e gestione eventi critici (uomo a terra, DPI non conformi) |
| **Compliance normativa** | D.Lgs. 81/2008, Statuto art. 4, GDPR con DPIA, tracciabilità e audit readiness |
| **Efficienza HSE** | Riduzione non conformità, miglioramento del triage e dell'efficacia dei piani correttivi |
| **Allineamento ESG** | Integrazione sensori ambientali e reporting direzionale aggregato |

#### Benefici attesi

- Riduzione del tasso di eventi lesivi e miglior presidio del rischio operativo
- Tempi di risposta più rapidi e decisioni basate su evidenze
- Accountability documentale verso committenti/autorità (POS/DVR/PSC) e riduzione del rischio legale
- Maggiore accettabilità per i lavoratori grazie a trasparenza, minimizzazione e pseudonimi

#### Perimetro

**Inclusi:**
- Cantieri dei clienti
- Caschi sensorizzati + tag DPI + gateway
- Piattaforma web/mobile multi-ruolo
- Integrazione documentale (POS/DVR/PSC/Fascicolo)
- API verso sistemi HSE/HR/ERP

**Esclusi:**
- Sorveglianza audio/video
- Geolocalizzazione continua ultra-granulare fuori dal contesto di sicurezza
- Usi disciplinari o di produttività
- Trattamenti non pertinenti alla prevenzione

### 1.2 Roadmap sintetica

| Fase | Descrizione | Deliverable |
|------|-------------|-------------|
| **Fase 1 - MVP pilota** | 1 cantiere, 20-30 caschi | Allarmi base (uomo a terra, Fatica/Stress v0, DPI), dashboard triage e report POS/DVR |
| **Fase 2 - Pilota esteso** | Multi-cantiere/multi-cliente | Policy centralizzate, RTLS UWB (se richiesto), integrazioni HSE/HR, ESG v1 |
| **Fase 3 - Go-live** | Multi-cliente | Hardening sicurezza, HA/DR, ISO 27001/45001, API partner e operatività scalabile |

### 1.3 Vision & Obiettivi

#### Riduzione incidenti e near-miss

| KPI Target | Valore |
|------------|--------|
| Riduzione tasso eventi lesivi/near-miss | ≥ 30% a regime |
| Tempo di risposta medio allarmi critici | < 3 minuti |
| Copertura telemetria (caschi/gateway) | ≥ 90% |
| Precisione classificazione allarmi | ≥ 95% |

**Leve:**
- Rilevazione precoce Fatica/Stress (GSR/parametri cardiovascolari)
- Algoritmo uomo a terra
- Presidio DPI tramite tag
- Playbook operativi
- Riesame periodico con RSPP e aggiornamento POS/DVR

#### Conformità HSE e privacy-by-design

**Obiettivi normativi:**
- D.Lgs. 81/2008 (Titoli I, III, IV)
- Statuto art. 4 (accordo/Aut. INL)
- GDPR (art. 6, art. 9(2)(b)/(h), art. 35 DPIA)
- ISO 45001 (SGSSL)
- ISO/IEC 27001 & 27701 (ISMS/PIMS)

**Principi:**
- Pseudonimizzazione by default
- De-pseudonimizzazione tracciata su evento
- Limitazione delle finalità
- Minimizzazione

**Output documentali:**
- DPIA
- Registro dei trattamenti
- Informative art. 13-14
- Accordo sindacale/Aut. INL
- Policy e SOP
- Pacchetti probatori per POS/PSC
- Aggiornamenti DVR

#### Indicatori ESG correlati

| Ambito | Metriche |
|--------|----------|
| **Salute e sicurezza (S)** | Tasso conformità DPI, near-miss trattati e chiusi |
| **Impatti ambientali (E)** | Superamenti soglie rumore/polveri, CO₂ stimata |
| **Governance (G)** | Qualità dati (uptime sensori), efficacia azioni correttive |

### 1.4 Ambito & Perimetro

#### Inclusioni

| Categoria | Dettaglio |
|-----------|-----------|
| **Ambiti organizzativi** | Cantieri clienti, aree operative e supporto, commesse e subappalti HSE |
| **Attori** | COS, Responsabili/Direttori Cantiere, RSPP, Preposti, Operatori, Consulenti HSE, Consulente Lavoro, Direzione |
| **Dispositivi** | Caschi con centralina (GSR/cardio), tag DPI, gateway; opzionali: RTLS UWB/BLE, sensori ambientali |
| **Dati trattati** | Segnali GSR/cardio (art. 9 GDPR), stato DPI, eventi sicurezza, log audit, output KPI/ESG |
| **Funzionalità** | Triage allarmi, playbook, ticketing, verifica DPI, pacchetti probatori, dashboard RSPP/KPI |
| **Integrazioni** | HSE/HR/ERP, SSO (OIDC/SAML), workflow documentali, API partner |

#### Esclusioni

| Categoria | Dettaglio |
|-----------|-----------|
| **Sorveglianza non pertinente** | Audio/video, registrazione conversazioni, metriche produttività |
| **Tracciamenti eccedenti** | Geolocalizzazione ultra-granulare fuori contesto sicurezza |
| **Finalità vietate** | Usi disciplinari, marketing, profilazioni extra-HSE |
| **Dati esterni** | Flussi sanitari/clinici, trasferimenti extra-SEE senza garanzie |

### 1.5 Stakeholder & Ruoli decisionali

| Ruolo | Responsabilità | Decisionalità |
|-------|----------------|---------------|
| **Direzione** | Governance e budget | Sì |
| **RSPP** | Policy HSE, DVR/DPIA | No |
| **COS** | Operatività real-time | Sì |
| **Resp. Cantiere** | Esecuzione locale | No |
| **Preposti** | Presidio operativo | Sì |
| **DPO/Privacy** | Conformità GDPR/Art. 4 | No |

---

## 2. Attori & Permessi (RBAC)

### 2.1 Elenco attori e viste/azioni

#### COS (Centro Operativo Sicurezza)

**Web:**
- Command Center multi-sito
- Triage allarmi con assegnazione/escalation
- Playback forense (segnali, DPI, posizione)
- Pacchetti probatori firmabili
- Audit log e reportistica

**Mobile:**
- Allarmi critici e presa in carico one-tap
- Checklist emergenze
- Note foto/audio
- Chiusura interventi con firma digitale

**Output:** Estrazioni verso POS/DVR/PSC e API per integrazioni HSE/ERP

#### Responsabile di Cantiere

**Web:**
- Cruscotto rischio per area/lavorazione
- Gestione non conformità e azioni correttive
- Configurazioni locali di soglia
- Allegati e aggiornamenti POS

**Mobile:**
- Verifica tag DPI on-site
- Azioni rapide (messa in sicurezza, allontanamento area)
- Chiusura NC con foto e coordinate

**Focus HSE:** Vigilanza operativa coerente con Titolo III (DPI) e Titolo IV (cantieri) D.Lgs. 81/2008

#### RSPP

**Web:**
- Osservatorio HSE cross-sito
- Governo policy/soglie
- Integrazione e aggiornamento DVR
- Gestione DPIA e registro trattamenti
- Libreria procedure/istruzioni operative (ISO 45001)

**Mobile:**
- Ispezioni (anche offline)
- Verbali firmati
- Assegnazione azioni correttive

**Compliance:** Governance privacy (GDPR art. 35) e strumenti ex art. 4 Statuto

#### Preposto

**Web:**
- Stato DPI per area/persona
- Controllo varchi
- Playbook passo-passo
- Registro consegne/sostituzioni DPI

**Mobile:**
- Gestione SOS
- Scanner DPI (BLE/NFC)
- Cronologia interventi con tempi e firme

**Note:** Visibilità nominativa limitata al perimetro di intervento (art. 19 D.Lgs. 81/2008)

#### Operatore

**Web/Area personale:**
- Indicatori a semaforo (Fatica/Stress)
- Stato DPI personale
- Download dati
- Informative e documenti (attestati, idoneità, manuali DPI)

**Mobile (opzionale):**
- Stato DPI OK/KO
- SOS e segnalazioni pericolo
- Pannello "perché questa allerta?"

**Privacy:** Trattamento minimizzato su base HSE (art. 9 GDPR) con pseudonimi in centrale

#### Consulenti HSE/Coordinatore

**Web:**
- KPI per incarico
- Audit digitale (checklist Titolo IV)
- Piani di miglioramento
- Pacchetti report per PSC/POS

**Mobile:**
- Ispezioni offline-first con evidenze geotaggate e firma

**Ruolo privacy:** Responsabile del trattamento ex art. 28 GDPR ove applicabile

#### Consulente del Lavoro

**Web:**
- Scadenze idoneità/formazione (esiti binari)
- Attestazioni e export per adempimenti
- **Nessun accesso a dati biometrici/di salute**

**Mobile:**
- Reminder conformità
- Download attestazioni

**GDPR:** Principio di limitazione delle finalità; separazione da flussi HSE

#### Direzione

**Web:**
- KPI aggregati di sicurezza
- Benchmark cantieri/fornitori
- ESG (se integrati)
- Stato audit e ROI sicurezza

**Mobile:**
- Snapshot executive
- Approvazioni rapide
- Condivisione report

**Sicurezza informativa:** ISO/IEC 27001/27701; dati soltanto aggregati/anonimizzati

### 2.2 Matrice RBAC (CRUD)

| Risorsa | COS | Resp. Cantiere | RSPP | Preposto | Operaio | Cons. HSE | Cons. Lavoro | Direzione |
|---------|-----|----------------|------|----------|---------|-----------|--------------|-----------|
| **Allarmi** | R/U (triage) | R/U (locale) | R (analisi) | R/U (azione) | R (propri) | R (incarico) | — | R (aggreg.) |
| **Eventi forensi** | R (ricostru.) | R (evento) | R (audit) | R (evento) | — | R (incarico) | — | R (agg.) |
| **DPI/Tag** | R | R/U (asseg.) | R (policy) | R/U (verif.) | R (propri) | R (incarico) | — | R (agg.) |
| **Report HSE** | C/R/U | R | C/R/U | R | R (propri) | C/R | C/R (amm.) | R |
| **KPI direzionali** | R (ops) | R (cantiere) | R (HSE) | R (locale) | — | R (incarico) | R (amm.) | R (agg.) |
| **Dati personali (pseud.)** | R (su evento) | R (su evento) | R (analisi) | R (su evento) | R (propri) | R (minimo) | — | — |
| **Documenti POS/DVR/PSC** | C/R/U | C/R (POS) | C/R/U (DVR) | R/U (verbali) | R (inform.) | C/R/U (PSC) | R (attest.) | R |

**Legenda:** C=Create, R=Read, U=Update, D=Delete

> **Note:** Le viste Direzione/Consulente del Lavoro sono solo aggregate; le viste Operatore sono solo personali. Definire mascheramento di default e regole di de-pseudonimizzazione su evento.

---

## 3. Architettura & Componenti

### 3.1 Architettura logica

```
Campo → Edge → Cloud → App (web/mobile)
```

> 🔌 **Architettura aperta:** La piattaforma è progettata per integrare sensoristica VCT e di terze parti, consentendo ai Partner di erogare nuovi servizi digitali.

### 3.2 Dispositivi di campo

**Sensoristica VCT (sistema di riferimento):**

| Dispositivo | Funzione |
|-------------|----------|
| **Casco con centralina** | GSR, parametri cardiovascolari |
| **Tag DPI** | Scarpe, guanti, cintura/cordino |
| **Gateway VCT** | Aggregazione e edge processing |

**Sensoristica estendibile (terze parti):**

| Categoria | Esempi | Integrazione |
|-----------|--------|--------------|
| **Wearable** | Smartwatch, band | API standard |
| **Ambientali** | Rumore, polveri, CO₂, WBGT | MQTT/REST |
| **Localizzazione** | RTLS UWB/BLE | SDK |
| **Altri** | Sensori custom | API aperte |

### 3.3 Connettività & Edge

```
BLE/LoRa → Gateway (store-and-forward) → LTE/5G/Wi-Fi
```

**Regole on-edge:**
- Uomo a terra
- Criticità parametri
- DPI mancanti

### 3.4 Back-end

| Componente | Tecnologia |
|------------|------------|
| **Ingest** | MQTT/Kafka |
| **Processing** | Stream processing |
| **Storage** | Time-series DB, Feature store, Data lake |
| **Logic** | Rules/ML |
| **API** | REST/GraphQL |
| **Architettura** | Multi-tenant |

### 3.5 Sicurezza & Operabilità

- Observability
- Logging/metrics/tracing
- HA/DR
- Backup/restore
- Hardening

---

## 4. Modelli & Logiche di Rischio

### 4.1 Indice Fatica (FI)

**Feature:**
- HRV (RMSSD/SDNN)
- GSR/EDA
- Temperatura cutanea
- Micro-immobilità
- Contesto (WBGT)

Pesature personalizzate per ogni lavoratore/contesto.

### 4.2 Indice Stress Acuto (ASI)

**Componenti:**
- Burst EDA
- Incremento HR non spiegato
- Trigger ambientali

**Caratteristiche:**
- Finestra breve
- Soglie adattive

### 4.3 Eventi critici

| Evento | Descrizione |
|--------|-------------|
| **Uomo a terra** | Pattern di caduta/immobilità rilevato |
| **Ipossia probabile** | Parametri O₂ sotto soglia |
| **DPI non conformi** | Tag mancante o non associato |
| **Perdita segnale** | Disconnessione dispositivo |

### 4.4 Qualità & Explainability

- Strategia falsi positivi/negativi
- SHAP/feature importance
- Revisione periodica con RSPP

---

## 5. Esperienza Utente (Web & Mobile)

### 5.1 COS — Command Center, triage, playback e pacchetti probatori

#### Cosa si vede (Web)

- **Mappa multi-sito** con layer attivabili:
  - Allarmi (uomo a terra, affaticamento/stress)
  - Stato DPI (tag su casco/scarpe/guanti/cintura)
  - Connettività caschi/gateway
  - Aree vincolate

- **Pannello stato HSPE** (Health, Safety, Productivity, Environmental) e coda allarmi con severità e SLA

- **Information panel contestuale:**
  - Dettagli lavoratore/area
  - Ultimi minuti di segnali GSR/cardio
  - DPI on/off
  - Posizione
  - Note del preposto

- **Pulsantiera di controllo** per filtrare per commessa, impresa, area operativa, tipologia evento

#### Cosa si fa (Web)

- **Triage strutturato:** presa in carico, assegnazione a Preposto/Direttore, escalation automatica se fuori SLA; chiusura con esito e prove (foto/audio)

- **Playback forense:** timeline sincronizzata (GSR/HR, posizione, DPI) con marcatori e commenti

- **Ticketing e azioni correttive:** apertura/assegnazione, scadenze, collegamento a non conformità DPI

- **Export:** pacchetto probatorio firmabile (PDF + JSON/CSV) per POS/DVR/PSC; API verso HSE/ERP

#### Dati & privacy

- **Pseudonimi by default** in dashboard
- **De-pseudonimizzazione** solo su evento e per ruoli abilitati, con log
- **Minimizzazione:** esposizione indicatori essenziali (semaforo rischio)
- **Retention:** segnali grezzi 30-90 gg → aggregazione; eventi/log 12-24 mesi; audit trail immutabile

#### Mobile (sala operativa in mobilità)

- Bacheca critici con presa in carico one-tap
- Checklist d'emergenza
- Note vocali/foto
- Chiusura con firma
- Rubrica rapida (Preposto/Direttore/RSPP)

### 5.2 Area Cantiere — Cruscotto rischio e gestione operativa

#### Web

- **Cruscotto per area/lavorazione:**
  - Heatmap Fatica/Stress
  - Conformità DPI per varco/attività
  - Ingressi in aree vincolate

- **Registro interventi e non conformità** con evidenze

- **Pianificazione misure** (ombreggio, idratazione, rotazioni operative)

- **Configurazioni locali:** soglie operative nel perimetro della policy HSE

#### Mobile

- Scanner DPI (BLE/NFC) per abilitare lavorazioni/ingressi
- Azioni rapide (metti in sicurezza area, allontanamento)
- Chiusura non conformità con foto, coordinate e firma

#### Privacy

- Visibilità nominativa limitata al perimetro d'intervento
- Mascheramento fuori contesto
- Log accessi

### 5.3 RSPP — Policy, DVR/DPIA, audit & report

#### Web

- **Osservatorio HSE:** trend rischio, matrici per lavorazioni, correlazioni evento/DPI, efficacia azioni correttive

- **Governo regole/soglie** centralizzate

- **Libreria procedure/istruzioni** (ISO 45001)

- **Integrazione DVR:** aggiornamenti motivati da evidenze, versioning e tracciabilità decisioni

- **Privacy:** gestione DPIA, registro trattamenti, ruoli privacy e atti art. 4

#### Mobile

- Checklist ispettive (anche offline)
- Verbale e firme
- Assegnazione azioni ai responsabili di cantiere

### 5.4 Preposto — Pannello operativo, DPI e playbook

#### Web

- **Stato DPI** per persona/area
- **Controllo varchi**
- **Coda allarmi** con playbook passo-passo
- **Registro consegne/sostituzioni** DPI con tracciabilità tag

#### Mobile

- Centro allarmi/SOS con conferma arrivo
- Scanner DPI per abilitare lavorazioni
- Note vocali/foto e firma lavoratore
- Visibilità nominale solo sul proprio perimetro

### 5.5 Operatore — Stato personale, SOS e trasparenza

#### Web (area personale)

- Indicatori a semaforo Fatica/Stress
- Stato DPI personale
- Informative chiare
- Download propri dati e documenti
- Modulo **"Perché questa allerta?"** con spiegazione non clinica

#### Mobile (opzionale)

- DPI OK/KO
- SOS
- Segnalazioni pericolo (testo/foto/audio)
- Notifiche di prevenzione e misure consigliate
- Dati minimizzati e pseudonimizzati

### 5.6 Direzione — KPI/ESG, benchmark e azioni prioritarie

#### Web

- **KPI aggregati:** incidenti/near-miss, conformità DPI, tempi risposta, efficacia azioni correttive
- **Benchmark** tra cantieri/fornitori
- **Moduli ESG** (rumore/polveri/CO₂ se disponibili)
- **Report direzionali** firmabili e versionati

#### Mobile

- Snapshot executive con 5-7 KPI
- Stato allarmi rilevanti
- Approvazioni e condivisione istantanea report
- **Dati solo aggregati/anonimizzati**

### 5.7 Wireframe (da sviluppare)

| Vista | Componenti |
|-------|------------|
| COS Web | Mappa con layer, coda allarmi, playback evento, pacchetto probatorio |
| COS Mobile | Bacheca critici, checklist emergenze, chiusura intervento |
| Cantiere Web | Cruscotto rischio, varchi/DPI, registro non conformità |
| Preposto Mobile | Centro allarmi, scanner DPI, firma chiusura |
| RSPP Web | Osservatorio HSE, policy/soglie, DVR/DPIA, audit |
| Operatore Mobile | Stato personale, SOS, motivazione allerta |
| Direzione Web | KPI/ESG, benchmark, stato audit |

---

## 6. Normativa & Compliance

### 6.1 D.Lgs. 81/2008 — Testo Unico Sicurezza

**Cosa prevede:**
- Quadro generale di prevenzione/protezione
- Responsabilità del datore e dell'organizzazione
- Obblighi d'uso e gestione dei DPI (Titolo III)
- Regole per cantieri temporanei e mobili (Titolo IV: PSC/POS, coordinamento)

**Ambiti chiave:**
- Scelta e idoneità DPI
- Addestramento e vigilanza
- Cooperazione e coordinamento tra imprese
- Verifica efficacia misure

**Come lo applichiamo:**
- Registri DPI con tag
- Evidenze oggettive (allarmi, interventi, non conformità)
- Cruscotti per Preposto/Direttore
- Pacchetti allegabili a POS/DVR/PSC

**Output:** Registro consegne/controlli DPI, report incidenti/near-miss, verbali vigilanza, allegati POS/PSC, aggiornamenti DVR

### 6.2 Statuto dei Lavoratori, art. 4 — Strumenti con controllo a distanza

**Cosa prevede:**
- Strumenti ammessi per esigenze organizzative e sicurezza
- Necessità di **accordo sindacale** o **autorizzazione INL** prima dell'attivazione
- Obbligo di informativa

**Ambiti chiave:**
- Limiti di finalità
- Trasparenza
- Tracciabilità degli accessi
- Controlli proporzionati

**Come lo applichiamo:**
- Pseudonimi by default in dashboard
- De-pseudonimizzazione JIT su evento con log
- Mascheramento nominativi fuori contesto
- Iter accordo/INL documentato

**Output:** Bozza accordo ex art. 4/istanza INL, informative specifiche, registro accessi/de-pseudonimizzazioni, policy d'uso

### 6.3 GDPR — Reg. (UE) 2016/679

**Cosa prevede:**
- Basi di liceità (art. 6(1)(c) obbligo HSE)
- Trattamento categorie particolari (art. 9(2)(b)/(h))
- DPIA (art. 35)
- Informative (artt. 13-14)
- Contratti responsabili (art. 28)
- Registro trattamenti (art. 30)
- Sicurezza (art. 32)
- Gestione data breach (artt. 33-34)

**Ambiti chiave:**
- Minimizzazione
- Limitazione finalità
- Accountability
- Diritti interessati

**Come lo applichiamo:**
- DPIA risk-based
- Registro aggiornato
- Informative multilivello chiare
- Retention breve (grezzi 30-90 gg, eventi 12-24 mesi)
- Canale diritti
- Misure tecniche/organizzative proporzionate

**Output:** DPIA firmata, registro trattamenti, informative consegnate, DPA art. 28, policy sicurezza, procedure breach

### 6.4 ISO 45001 — Sistema di Gestione Salute e Sicurezza (SGSSL)

**Cosa prevede:**
- Leadership/partecipazione
- Identificazione pericoli
- Valutazione rischi/opportunità
- Controllo operativo
- Preparedness & response
- Misurazione performance
- Miglioramento continuo

**Come lo applichiamo:**
- SOP operative (allarmi, DPI, audit)
- KPI HSE e riesami periodici
- Collegamento strutturale ai fascicoli di sicurezza

**Output:** Manuale SGSSL, piani audit interni, report riesame, matrici rischio

### 6.5 ISO/IEC 27001 & 27701 — ISMS & PIMS

**Cosa prevedono:**
- **27001:** Gestione sicurezza informativa (risk assessment, SoA, controlli)
- **27701:** Gestione privacy (ruoli, minimizzazione, processi diritti)

**Ambiti chiave:**
- Cifratura in transito/a riposo
- IAM con MFA e RBAC
- Segregazione tenant
- Gestione chiavi
- Vulnerability management
- Incident response e audit

**Come le applichiamo:**
- Policy ISMS/PIMS
- Controlli tecnici in piattaforma e gateway
- Audit periodici

**Output:** SoA, piani hardening, test DR, report vulnerability, registro incident

### 6.6 UNI EN ISO 7243 (WBGT) & EN 397 (elmetti)

**WBGT:** Valutazione stress termico e calibrazione misure (ombra, idratazione, sospensione attività)

**EN 397:** Requisiti caschi (urti, penetrazione, fiamma, marcature)

**Come le applichiamo:**
- Integrazione WBGT nelle soglie/allarmi
- Registri consegna/controllo elmetti con tag

**Output:** Check WBGT in report POS/PSC, registro DPI, piani mitigazione microclima

### 6.7 Compliance by design — Principi applicati

| Principio | Applicazione |
|-----------|--------------|
| **Pseudonimizzazione by default** | Mascheramento generalizzato |
| **Need-to-know** | Finestre visibilità limitate e logate |
| **Minimizzazione** | Solo dati necessari HSE |
| **Separazione finalità** | Sicurezza ≠ amministrazione |
| **Storage limitation** | SOP retention/deletion |
| **Trasparenza** | Cruscotti aggregati per Direzione |
| **Audit** | Test periodici, log immodificabili |

---

## 7. Privacy & Sicurezza dei Dati

### 7.1 Ruoli privacy

| Ruolo | Descrizione |
|-------|-------------|
| **Titolare** | Datore/Impresa |
| **Responsabili art. 28** | Fornitore piattaforma/telemetria |
| **Contitolari** | Joint operations (se applicabile) |
| **Autorizzati** | COS, RSPP, Preposti, Direttori |

**Applicazione:**
- Nomine formali
- Istruzioni vincolanti
- Formazione
- Separazione canali Medico Competente

**Evidenze:** DPA art. 28 firmati, mansionari, registro autorizzazioni

### 7.2 Registro trattamenti

**Contenuto:**
- Finalità
- Basi giuridiche
- Categorie dati (biometrici, DPI, eventi)
- Destinatari
- Tempi di conservazione
- Misure tecniche/organizzative

**Applicazione:** Un record per ciascun processo (monitoraggio, triage, ticketing, reporting); link a SOP e POS/DVR/PSC

### 7.3 DPIA (art. 35)

**Contenuto:**
- Rischi per diritti/libertà (falsi positivi, accessi indebiti, uso improprio)
- Minacce e vulnerabilità
- Misure e residui

**Applicazione:**
- Revisione periodica
- Mini-DPIA per nuove feature
- Coinvolgimento DPO/RSPP

### 7.4 Retention & cancellazione

| Tipo dato | Retention | Poi |
|-----------|-----------|-----|
| Segnali grezzi | 30-90 giorni | Aggregazione |
| Eventi/log | 12-24 mesi | Cancellazione |
| Report | Aggregati | - |

**Applicazione:**
- Job schedulati di pruning/anonimizzazione
- Verifiche trimestrali
- Log di cancellazione

### 7.5 Sicurezza (art. 32)

| Misura | Descrizione |
|--------|-------------|
| **Cifratura** | In transito e a riposo |
| **Gestione chiavi** | Rotazione, segregazione |
| **IAM** | MFA + RBAC |
| **Segregazione tenant** | Isolamento dati cliente |
| **Hardening gateway** | Configurazione sicura |
| **Logging/monitoring** | Centralizzato |
| **Backup/DR** | Testato periodicamente |

### 7.6 Incident & breach (artt. 33-34)

**Procedura:**
1. Triage e contenimento
2. Valutazione rischio
3. Notifica autorità/interessati (se dovuta)
4. Remediation
5. Post-mortem

**Applicazione:** Esercitazioni periodiche, playbook, ruoli e SLA

### 7.7 Trasferimenti extra-SEE

**Garanzie:**
- SCC
- Transfer Impact Assessment
- Misure supplementari (crittografia, tokenizzazione)
- Data-residency preferibilmente UE/SEE

---

## 8. Procedure Operative (SOP)

### Formato standard SOP

| Sezione | Contenuto |
|---------|-----------|
| **Scopo** | Obiettivo della procedura |
| **Campo di applicazione** | Dove si applica |
| **Trigger** | Cosa attiva la procedura |
| **Ruoli e responsabilità** | Chi fa cosa |
| **Prerequisiti** | Cosa deve essere pronto |
| **Strumenti/Dati** | Input necessari |
| **Procedura** | Passi operativi |
| **Uscite/registrazioni** | Output prodotti |
| **SLA e metriche** | Target di performance |
| **Rischi e mitigazioni** | Cosa può andare storto |
| **Riferimenti** | Norme applicabili |

### 8.1 SOP Allarme critico (uomo a terra / parametri fuori soglia)

**Scopo:** Gestire in modo rapido e tracciato gli eventi potenzialmente lesivi

**Campo:** Tutti i cantieri e operatori equipaggiati

**Trigger:** Rilevazione on-edge o in piattaforma di pattern "uomo a terra" o superamento soglie

**Ruoli:** COS (coordinamento), Preposto (intervento), Resp. Cantiere (supporto), RSPP (analisi post-evento)

**Procedura:**
1. **Conferma allarme (COS):** verifica coerenza segnali e contesto, classifica Critico
2. **Presa in carico (COS)** e assegnazione al Preposto; notifica Resp. Cantiere
3. **Intervento sul posto (Preposto):** messa in sicurezza area, verifica DPI, valutazione primaria
4. **Esecuzione playbook:** misure previste (112/118, idratazione, ombreggio, defibrillatore)
5. **Raccolta evidenze:** foto/audio, note, tempi
6. **Chiusura evento:** esito, cause probabili, follow-up
7. **Riesame HSE (RSPP):** analisi causale, azioni correttive/preventive

**SLA:** Presa in carico < 60s; arrivo preposto < target cantiere; completezza scheda ≥ 95%

### 8.2 SOP De-pseudonimizzazione

**Scopo:** Consentire visibilità nominativa solo quando necessario e in modo tracciabile

**Trigger:** Allarme Critico o richiesta motivata

**Procedura:**
1. **Richiesta JIT** in console (motivo + durata finestra)
2. **Doppia autorizzazione** (COS + RSPP)
3. **Finestra temporale** aperta (es. 60 min) con banner di attenzione
4. **Intervento/analisi**; chiusura finestra e auto-re-pseudonimizzazione
5. **Verifica a posteriori:** RSPP/DPO rivedono log

**SLA:** 100% richieste con motivazione; revisione post-evento < 72h

### 8.3 SOP Non conformità DPI

**Scopo:** Prevenire lavorazioni senza DPI idonei

**Trigger:** Tag DPI assente/non conforme; verifica varco; segnalazione preposto

**Procedura:**
1. **Blocco attività/varco** (automatico o manuale)
2. **Consegna/sostituzione DPI** e verifica tag
3. **Ripristino attività** previa conferma Preposto
4. **Registrazione NC** con foto/evidenze
5. **Analisi RSPP** e piano miglioramento

**SLA:** Chiusura NC minore < 24h; verifica efficacia < 14 gg

### 8.4 SOP Retention & deletion

**Scopo:** Applicare limitazione conservazione e minimizzare rischi

**Trigger:** Scadenze retention o richiesta legittima

**Procedura:**
1. **Pianificazione job** di pruning/anonimizzazione
2. **Esecuzione controllata** (dry-run → run) con log
3. **Verifica campionaria** dei dataset post-job
4. **Report** a DPO/RSPP e aggiornamento registro

**Metriche:** % dataset conformi ≥ 99%; 0 errori critici

### 8.5 SOP Diritti degli interessati

**Scopo:** Garantire esercizio diritti in modo efficace e sicuro

**Trigger:** Richiesta accesso/portabilità/rettifica/limitazione

**Procedura:**
1. **Ricezione e verifica identità**
2. **Raccolta dati pertinenti** (solo del richiedente)
3. **Preparazione risposta** (JSON/CSV/PDF)
4. **Consegna sicura** e registrazione

**SLA:** Risposta entro tempi normativi; tracciabilità 100%

### 8.6 SOP Data breach

**Scopo:** Gestire violazioni riducendo impatto

**Trigger:** Rilevazione anomalia di sicurezza

**Procedura:**
1. **Triage e contenimento** (isolare asset, revocare credenziali)
2. **Valutazione rischio** con DPO
3. **Notifica** autorità/interessati se dovuta
4. **Remediation** e post-mortem

**SLA:** Triage < 4h; decisione notifica < 72h

### 8.7 SOP Onboarding/Offboarding dispositivi

**Scopo:** Garantire integrità e tracciabilità asset

**Procedura:**
1. **Onboarding:** inventario, pairing sicuro, test, assegnazione
2. **Esercizio:** firmware patching, verifica periodica, audit inventario
3. **Offboarding:** wipe/sanitize, revoca credenziali, disaccoppiamento tag

**Metriche:** Tasso asset compliant ≥ 98%

### 8.8 SOP Change management

**Scopo:** Introdurre cambi controllati riducendo rischi

**Trigger:** Nuove feature, modifica soglie/regole, nuovi flussi dati

**Procedura:**
1. **Valutazione impatto** (mini-DPIA + risk HSE)
2. **Pilota** in ambiente controllato
3. **Go/No-Go** con verbale congiunto
4. **Rilascio progressivo**, monitoraggio, rollback pronto

**Metriche:** 0 incidenti critici post-rilascio; tempi rollback < target

---

## 9. Documentazione HSE & Legale

### 9.1 Allegato POS — Sistema di monitoraggio

**Contenuto minimo:**
- Scopo e limiti
- Aree/attività coperte
- Ruoli (Preposto, Resp. Cantiere, COS, RSPP)
- Dispositivi e schemi posizionamento
- Flussi dati e playbook emergenze
- Regole de-pseudonimizzazione
- Piano WBGT (se applicabile)
- Formati report e criteri conservazione

**Output:** Allegato firmabile (PDF), tavole impianto, check-list pre-avvio

### 9.2 Aggiornamenti DVR

**Contenuto:**
- Evidenze statistiche aggregate
- Near-miss e incidenti con lesson learned
- Valutazione efficacia misure
- Nuove azioni progettate

**Output:** Sezione "Monitoraggio tecnologico" con indicatori e decisioni

### 9.3 PSC/Fascicolo

**Contenuto:**
- Regole coordinamento tra imprese
- Scambio informativo con committente
- Livelli di servizio
- Gestione visitatori/subappaltatori

**Output:** Capitolo coordinamento HSE-digitale + modelli verbale

### 9.4 Accordo art. 4 / Istanza INL

**Contenuto:**
- Finalità (solo sicurezza)
- Ambito, aree, soglie/allarmi
- Ruoli con visibilità nominativa
- Retention e misure tecniche
- Esclusione usi disciplinari
- Informative e allegati tecnici

**Output:** Bozza accordo sindacale, modulistica INL, piano comunicazione

### 9.5 Informative & Policy

**Contenuto:**
- Informative art. 13-14
- Registro trattamenti
- DPA art. 28
- Policy ISMS/PIMS
- SOP privacy

**Output:** Pacchetto compliance "ready for audit"

---

## 10. KPI, Reporting & ESG

### 10.1 KPI sicurezza (definizioni)

| KPI | Formula |
|-----|---------|
| **Tasso incidenti** | (incidenti con infortunio / ore lavorate) × 10⁶ |
| **Near-miss trattati** | near-miss con ticket chiuso / near-miss totali |
| **Tempo di risposta** | t_presa_in_carico − t_allarme (median/95p) |
| **Tempo di intervento** | t_arrivo_preposto − t_allarme (median/95p) |
| **DPI compliance** | persone con DPI OK / persone presenti |
| **Efficacia azioni** | azioni chiuse entro target / azioni totali |

### 10.2 Qualità dati

| Metrica | Target |
|---------|--------|
| Uptime caschi/gateway | ≥ 99% |
| Drift sensori | Auto-test EDA/HR |
| Falsi positivi/negativi | Per regola/classe |
| Completezza schede evento | ≥ 95% |

### 10.3 ESG (se integrati ambientali)

| Ambito | Metriche |
|--------|----------|
| **Environmental** | WBGT ore esposte, superamenti rumore/polveri, CO₂ stimata |
| **Safety governance** | % cantieri con audit trimestrale, % formazione completata |

### 10.4 Reporting

| Tipo | Frequenza | Contenuto |
|------|-----------|-----------|
| **Operativo** | Giornaliero/settimanale | Allarmi, NC DPI, tempi risposta, ticket |
| **HSE** | Mensile | Indicatori, trend, analisi cause, piani |
| **Direzionale** | Mensile/trimestrale | KPI aggregati, benchmark, ESG |

**Formati:** PDF firmabile + CSV/JSON via API; viste drill-down con filtri

---

## 11. Piano di Rollout & Change

### 11.1 MVP pilota

**Ambito:** 1 cantiere, 20-30 caschi, gateway ridondati

**Criteri successo:**
- Uptime ≥ 90%
- Tempo risposta critici < 3 min (50p)
- DPI compliance ≥ 95%
- Accettazione utenti ≥ 80%

**Deliverable:** POS allegato, DPIA v1, registro trattamenti, SOP 8.1-8.3, report risultati

### 11.2 Pilota esteso

**Ambito:** Multi-cantiere/multi-cliente; policy centralizzate; RTLS UWB opzionale; integrazioni HSE/HR

**Criteri successo:**
- Scalabilità ingest (p95 latenza < 2s)
- Riduzione falsi positivi ≥ 20%
- Audit HSE trimestrale chiuso

**Deliverable:** DPIA v2, accordo/INL formalizzato, manuali utente, API pubbliche v1

### 11.3 Go-live

**Hardening:**
- Pen-test
- SoA 27001
- Backup/DR testato
- Monitoraggio 24/7

**Operatività:**
- NOC/SOC attivi
- SLA definiti
- Runbook incident
- On-call HSE/IT

**Certificazioni:** Roadmap ISO 27001/45001; audit esterno

### 11.4 Formazione

| Target | Contenuti |
|--------|-----------|
| **Preposti/Resp. Cantiere** | Playbook, DPI, allarmi |
| **COS** | Triage, playback, export probatori |
| **RSPP** | Policy/soglie, DVR/DPIA, audit |
| **Operatori** | Uso casco/tag, SOS, diritti privacy |

**Materiali:** Manuali, quick card, video brevi, quiz

### 11.5 Adozione & change

- Raccolta feedback (survey/UAT)
- Priorità su falsi positivi e UX
- Roadmap trimestrale
- Comunicazioni chiare su finalità e tutele (art. 4/GDPR)

---

## 12. Operazioni & Servizi

### 12.1 SLA/SLO

| Servizio | Target |
|----------|--------|
| **Ingest disponibilità** | ≥ 99,5% |
| **Latenza evento→notifica** | p95 < 5s |
| **Console uptime** | ≥ 99,9% (ore lavorative) |
| **RTO** | ≤ 4h |
| **RPO** | ≤ 15min |
| **Supporto P1** | ≤ 15min |
| **Supporto P2** | ≤ 4h |

### 12.2 Supporto & manutenzione

**Livelli:**
- L1: Helpdesk
- L2: App/back-end
- L3: Ingegneria

**Firmware:** Finestre aggiornamento, rollback, inventario versioni

**Preventiva:** Check periodici sensori/tag/gateway, sostituzioni programmate

### 12.3 Monitoraggio & osservabilità

**Metriche:**
- Ingest, coda allarmi, error rate
- Uptime asset, qualità sensori
- Job retention

**Alerting:**
- Soglie e on-call
- Dashboard NOC/SOC
- Log centralizzati e audit trail

### 12.4 Business continuity & DR

**Strategia:**
- Replica multi-zona
- Backup cifrati
- Test restore trimestrale

**Piani:**
- DR runbook per data center/cloud edge
- Esercitazioni congiunte

---

## 13. Integrazioni & Interoperabilità

### 13.1 Sistemi terzi

| Sistema | Integrazione |
|---------|--------------|
| **HSE/Incident management** | Import near-miss, export ticket |
| **HR** | Anagrafiche, ruoli, idoneità (esito binario) |
| **ERP/MES** | Commesse, lavorazioni |
| **SSO** | OIDC/SAML |

### 13.2 API & contratti d'interfaccia

| API | Tipo |
|-----|------|
| **Eventi** | Webhook real-time |
| **Report** | REST/CSV |
| **RBAC** | Provisioning |
| **Audit** | Estrazioni |

**Contratti:**
- Versionati (semver)
- Schema JSON
- Esempi
- Policy rate-limit
- Sicurezza (OAuth2, mTLS se richiesto)

### 13.3 Import/Export fascicoli

**POS/DVR/PSC:**
- Export pacchetti probatori (PDF+JSON/CSV)
- Import check-list

**Fascicolo:**
- Allegati tecnici (schemi, tavole)

**Tracciabilità:**
- Hash/verifica integrità
- Firma
- Versioning

---

## 14. Gestione Rischi & Qualità

### 14.1 Controlli mitigazione

- Piano test periodico soglie
- DR esercitato
- Audit privacy trimestrali
- Revisione SOP

### 14.2 Piano test & validazione

**Tipologie:**
- QA (unit/integration)
- UAT HSE (con Preposti/RSPP)
- Test campo (simulazioni uomo-a-terra, DPI mancanti, perdita segnale)

**Criteri accettazione:**
- Precisione allarmi ≥ 95%
- Latenza p95 < 5s
- % falsi positivi < target

### 14.3 Audit interni/esterni

| Ambito | Standard |
|--------|----------|
| **HSE** | Conformità 81/08 |
| **Privacy** | GDPR/DPIA |
| **ISMS** | 27001 |

**Output:** Rapporti, non conformità, piani di miglioramento

---

## 15. Distinte & Specifiche Tecniche

### 15.1 BoM pilota (esempio)

| Componente | Quantità | Specifiche |
|------------|----------|------------|
| **Caschi smart** | 30 | Centralina GSR/HR, BLE; batteria ≥ 8h; IP ≥ IP54 |
| **Tag DPI** | 120 | Scarpe/guanti/cintura |
| **Gateway** | 3 | BLE/LoRa + LTE/5G; UPS locale |
| **SIM dati** | 3 | - |
| **Accessori** | - | Caricabatterie multipli, kit manutenzione |

### 15.2 Specifiche sensori

| Sensore | Specifica |
|---------|-----------|
| **GSR/EDA** | Sampling ≥ 4 Hz |
| **HR/HRV** | RMSSD/SDNN su finestra 60-120s; auto-test derivazione |
| **Tag DPI** | BLE/NFC, ID univoco, pairing sicuro; log ultimo check |

### 15.3 Requisiti ambientali

| Requisito | Valore |
|-----------|--------|
| **IP rating** | Min. IP54 |
| **Shock** | EN 60068 |
| **Temperatura** | −10/+50°C |
| **EMC** | Norme industriali |
| **Autonomia batteria** | Target ≥ 8h |

### 15.4 Schemi dati

```json
// Event
{
  "id": "uuid",
  "ts": "ISO8601",
  "deviceId": "string",
  "siteId": "string",
  "type": "enum",
  "severity": "enum",
  "features": {},
  "attachments": []
}

// DPI Check
{
  "workerId": "pseudonym",
  "dpiType": "enum",
  "status": "OK|KO",
  "ts": "ISO8601",
  "evidenceId": "uuid"
}

// Audit
{
  "actorId": "string",
  "action": "string",
  "ts": "ISO8601",
  "resource": "string",
  "outcome": "string",
  "hash": "sha256"
}
```

---

## 16. FAQ

### 16.1 Consenso e basi giuridiche

**Serve il consenso?**

No. La base giuridica è l'**obbligo legale** in materia di salute e sicurezza sul lavoro (art. 6(1)(c) GDPR), con trattamento di categorie particolari strettamente necessarie ai fini HSE (art. 9(2)(b)/(h)).

**Perché non si usa il consenso?**

Nel rapporto di lavoro il consenso non è libero: esiste asimmetria tra datore e lavoratore.

**In pratica:**
- Trattiamo solo i dati necessari a prevenzione/protezione
- Spieghiamo prima come funziona (informative art. 13-14)
- Canale DPO per domande e diritti
- Ogni modifica importante passa da DPIA e accordo sindacale/Aut. INL

### 16.2 Accordo sindacale/INL

**È obbligatorio?**

Sì, quando gli strumenti possono comportare controllo a distanza dell'attività. Se non è possibile l'accordo → istanza all'Ispettorato.

**Cosa contiene:**
- Finalità (solo sicurezza)
- Ambito/aree
- Tipologie di allarme
- Chi può vedere i nominativi e quando
- Tempi di conservazione
- Misure tecniche
- Divieto usi disciplinari

### 16.3 Chi vede i dati

**Chi può vedere il mio nome?**

Solo chi deve intervenire per la sicurezza (Preposto, Responsabile cantiere, COS) e solo durante l'evento (finestra temporale limitata e logata).

**Come funziona:**
- Pseudonimi nelle dashboard standard
- De-pseudonimizzazione JIT con doppia autorizzazione
- Audit trail immutabile

### 16.4 Retention e cancellazione

| Tipo dato | Durata |
|-----------|--------|
| Segnali grezzi (GSR/HR) | 30-90 giorni → poi aggregazione |
| Eventi/allarmi/log | 12-24 mesi |
| Report direzionali | Solo aggregati |

### 16.5 Uso disciplinare

**Può essere usato per sanzionarmi?**

**No.** Il sistema è progettato e configurato per finalità HSE.

**Salvaguardie tecniche:**
- Pseudonimi by default
- Accessi profilati
- Dashboard direzionali aggregate

**Salvaguardie organizzative:**
- Clausole in accordo/INL
- Audit periodici con RSPP/DPO/RSU

### 16.6 DPI e conformità

**Posso usare DPI personali?**

Sì, se conformi alle norme (es. EN 397) e registrati nel sistema con tag associato.

**Cosa monitora il sistema:**
- Presenza/attivazione del DPI richiesto
- **Non** registra prestazioni personali

### 16.7 Falsi positivi & explainability

**Come li gestite?**

Con modello ibrido: regole deterministiche + componenti ML.

**Riduzione falsi positivi:**
- Soglie adattive
- Controllo finestra temporale
- Correlazione con contesto (WBGT, attività)
- Verifica umana nel triage COS
- Feedback-loop per rituning

**Per l'utente:**
- Pannello "Perché questa allerta?" con fattori contribuenti

### 16.8 Trasferimenti extra-SEE

**I dati vanno fuori UE?**

Di norma **no**. Preferiamo data residency UE/SEE.

Se necessario: SCC, Transfer Impact Assessment, misure supplementari.

### 16.9 Integrazione POS/DVR/PSC

**Come si integra?**
- **POS:** Allegato "sistema di monitoraggio"
- **DVR:** Solo aggregati per aggiornare valutazione
- **PSC/Fascicolo:** Capitolo coordinamento digitale

### 16.10 Diritti interessati

**Posso scaricare i miei dati?**

Sì. Dalla tua area personale puoi:
- Consultare indicatori
- Scaricare i tuoi dati (CSV/JSON/PDF)
- Per richieste complesse → canale DPO

**Tempi:** Risposta entro termini normativi; tutte le richieste sono tracciate.

---

*Documento generato dalla specifica "Safety & Sustainability Control Center — Documento Base Di Progetto (casco-centrico)"*

*© 2025 Vigilo*
