# Vigilo - Documentazione di Progetto

> Piattaforma digitale per la sicurezza sul lavoro nei cantieri edili

---

## Panoramica

**Vigilo** è una **piattaforma digitale** per la sicurezza sul lavoro, progettata per cantieri edili e ambienti industriali. Consente ai **Partner** (RSPP, Formatori, Consulenti HSE) di erogare i propri servizi in modalità digitale e di offrire nuovi servizi basati su tecnologia IoT.

La piattaforma segue le normative italiane D.Lgs. 81/2008 e GDPR, fornendo:

**Per i lavoratori:**
- Monitorare metriche di sicurezza personali (indici FI/ASI)
- Segnalare incidenti e pericoli
- Accedere a formazione erogata dal Partner
- Guadagnare punti e premi (gamification)
- Collaborare come team

**Per i Partner:**
- Piattaforma per erogare contenuti formativi digitali
- Dashboard per monitorare i propri clienti
- Strumenti per quiz e certificazioni
- Accesso ai dati IoT dei dispositivi integrati

**Vigilo** si integra con la piattaforma **InSite** (VCT) e supporta l'integrazione di **sensoristica di terze parti** per il monitoraggio real-time dei DPI e dello stato di salute dei lavoratori

---

## Navigazione App

L'app utilizza una **bottom navigation** con 5 tab principali:

| Tab | Icona | Funzione |
|-----|-------|----------|
| **Home** | 🏠 | Dashboard con cards prioritizzate |
| **Team** | 👥 | Social wall, sfide, classifica |
| **SOS** | 🆘 | Emergenze e segnalazioni |
| **Punti** | 🎯 | Wallet, premi, ruota fortunata |
| **Impara** | 📚 | Formazione, quiz, certificati |

---

## Funzionalità per Modulo

### Riepilogo Moduli

| Modulo | Features | Stato | Priorità Prossime |
|--------|----------|-------|-------------------|
| **🏠 Home** | 9 cards dashboard | ✅ Completo | Progress bar formazione |
| **👥 Team** | 8 widgets + VOW survey | ✅ Completo | Notifiche menzioni |
| **🆘 SOS** | 4 tipi segnalazione | ✅ Completo | Countdown visivo, storico |
| **🎯 Punti** | 5 livelli + ruota | ✅ Completo | Achievements/badge |
| **📚 Impara** | CMS + Quiz + Certificati | ✅ Completo | Offline download |

---

### 1. Home - Dashboard

Cards visualizzate in ordine di priorità:

| # | Card | Funzione | Dati Mostrati |
|---|------|----------|---------------|
| 1 | **SiteAccessCard** | Verifica conformità cantiere | Stato accesso, DPI richiesti, formazione valida |
| 2 | **SafetyScoreCard** | Punteggio sicurezza /100 | Score, trend 7gg, breakdown fattori |
| 3 | **DpiStatusCard** | Stato DPI personali | Lista DPI, stato ON/OFF, % batteria, ultimo check |
| 4 | **SocialWallCard** | Feed social cantiere | Ultimi 3 post, contatore commenti |
| 5 | **TeamChallengeCard** | Sfida attiva | Nome sfida, progress %, hot streak 🔥 |
| 6 | **SmartBreakCard** | Timer pausa intelligente | Tempo prossima pausa, zone ombra vicine |
| 7 | **DailyTodoCard** | Checklist giornaliera | Todo completati/totali, prossimo item |
| 8 | **PersonalKpiCard** | KPI personali | FI/ASI attuali, ore lavorate, segnalazioni |
| 9 | **WelcomeGuideCard** | Onboarding (solo nuovi utenti) | Step completati, prossimo step |

**Logica Priorità:**
- Cards 1-3: **Sicurezza critica** - sempre visibili in alto
- Cards 4-6: **Engagement** - ordine basato su attività recente
- Cards 7-9: **Informative** - collassabili/nascondibili

---

### 2. Punti - Sistema Gamification

**Modelli Dati:**

| Modello | Descrizione |
|---------|-------------|
| `PointsStats` | Punti totali, 7gg, 30gg, trend giornaliero |
| `Reward` | Premi riscattabili con costo in punti |
| `LeaderboardEntry` | Classifica con rank e trend |
| `PointsLevel` | Livelli: Bronze → Silver → Gold → Platinum → Diamond |
| `PointsTransaction` | Earned, Spent, Bonus, Penalty |
| `WheelPrize` | Premi ruota fortunata |

**Categorie Premi:**
- 🎫 Voucher (Amazon, ecc.)
- 🦺 DPI (zaini, cuffie antirumore)
- 👕 Gadget (t-shirt, borracce)
- 📦 Altro

**Funzionalità:**
- Wallet con saldo e transazioni recenti
- Catalogo premi con filtri e ordinamento
- Ruota fortunata giornaliera (spin gratuito)
- Classifica live del team

---

### 3. SOS - Emergenze e Segnalazioni

**Tipi di Segnalazione:**

| Tipo | Colore | Esempi |
|------|--------|--------|
| Pericolo Imminente | 🔴 Rosso | Materiale instabile, rischio caduta |
| Near Miss | 🟠 Arancione | Incidente evitato |
| Infortunio Lieve | 🔵 Blu | Scivolate, tagli lievi |
| Suggerimento | 🟢 Verde | Proposte miglioramento |

**Stati Segnalazione:**
`Pending` → `Under Review` → `In Progress` → `Approved` → `Closed`

**Contatti Emergenza:**
- Capocantiere (turno)
- Centrale Operativa
- RSPP Aziendale
- 118 Emergenze
- Contatto Familiare

**Funzione SOS:**
- Pulsante emergenza con **hold-to-activate** (3 secondi)
- **Countdown circolare visivo** durante pressione (feedback UX)
- Vibrazione progressiva durante hold
- Invio automatico: segnale, posizione GPS, stato movimento
- Notifica simultanea a tutti i contatti configurati
- Conferma visiva e sonora post-invio

**UX Flow SOS:**
```
┌─────────────────────────────────────────────────────────┐
│                                                         │
│     Pressione iniziale → Countdown 3s (cerchio)        │
│              │                                          │
│              ▼                                          │
│     ┌─────────────┐                                    │
│     │   ◯ 3...    │  ← Vibrazione leggera              │
│     │   ◯ 2...    │  ← Vibrazione media                │
│     │   ◯ 1...    │  ← Vibrazione forte                │
│     └─────────────┘                                    │
│              │                                          │
│              ▼                                          │
│     ┌─────────────┐                                    │
│     │  ✅ INVIATO │  ← Conferma + suono                │
│     └─────────────┘                                    │
│                                                         │
│     Rilascio anticipato → Annulla (nessun invio)       │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

---

### 4. Impara - Formazione (Piattaforma Partner)

> ⚠️ **Nota:** La formazione è erogata dai **Partner** (RSPP, Formatori abilitati), NON da VCT. La piattaforma fornisce gli strumenti digitali gratuitamente ai Partner per erogare i propri corsi.

**Cosa offre la piattaforma ai Partner:**
- 📤 **CMS** per caricare contenuti (video, PDF, lezioni)
- ❓ **Quiz builder** per creare test certificativi
- 📊 **Dashboard** per monitorare progress dei corsisti
- 📜 **Generatore certificati** con firma digitale

**Tipi Contenuto (caricati dal Partner):**

| Tipo | Icona | Colore |
|------|-------|--------|
| Video | 🎬 | Rosa |
| PDF | 📄 | Arancione |
| Quiz | ❓ | Viola |
| Lezione | 📖 | Blu |

**Categorie D.Lgs. 81/2008:**
- Sicurezza DPI
- Primo Soccorso
- Procedure operative
- Macchinari e attrezzature
- Rischi Specifici
- Formazione generale/specifica

**Funzionalità per il Lavoratore:**
- Libreria contenuti con ricerca e filtri
- Progress tracking per contenuto
- Quiz con punteggio minimo configurabile
- Certificati con data scadenza
- Contenuti obbligatori vs opzionali

**Modelli Dati:**

| Modello | Campi Principali |
|---------|------------------|
| `TrainingContent` | title, type, category, duration, points, progress, isMandatory, **partnerId** |
| `Quiz` | questions[], passingScore, maxAttempts, points, **partnerId** |
| `Certificate` | title, earnedAt, expiresAt, isExpiringSoon, **issuedBy** |
| `TrainingProgress` | completedModules, certificates, progressPercentage |

---

### 5. Team - Collaborazione

**Cards e Funzionalità:**

| Widget | Funzione |
|--------|----------|
| `TeamHeaderCard` | Info team, membri online/offline |
| `TeamLeaderboardCard` | Classifica team live |
| `TeamChallengeCard` | Sfida attiva (es. "Settimana Zero Infortuni") |
| `SafetyStarCard` | Safety Star della settimana + nomination |
| `SocialWallCard` | Feed foto cantiere |
| `VowSurveyCard` | Survey Voice of Worker |
| `WellnessCheckinCard` | Check-in umore (Great/So-so/Stressed) |
| `TransparencyDashboardCard` | "Hai detto → Abbiamo fatto" |

**Survey VOW (Voice of Worker):**

| # | Domanda | Tipo | Obbligatoria |
|---|---------|------|--------------|
| 1 | Ti sei sentito sicuro oggi? | Sì/No | ✅ |
| 2 | Qual è stato il rischio maggiore? | Scelta multipla | ✅ |
| 3 | Hai segnalato un pericolo? | Sì/No | ✅ |
| 4 | Commento libero | Testo (max 500 char) | ❌ |

**Opzioni Domanda 2:**
- 🔧 Attrezzature/Macchinari
- 📋 Procedure non chiare
- 🌡️ Ambiente (caldo/freddo/rumore)
- 👷 Comportamenti colleghi
- 🦺 DPI inadeguati
- 📦 Altro

**Frequenza:** Fine turno (notifica automatica)
**Incentivo:** +10 punti per completamento

---

## Sensoristica IoT e Centrale Operativa

### Architettura Modulare

Vigilo adotta un'**architettura aperta** per la sensoristica IoT:

```
┌─────────────────────────────────────────────────────────────────┐
│                    PIATTAFORMA VIGILO                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   SENSORI INTEGRATI          SENSORI TERZE PARTI               │
│   ─────────────────          ──────────────────                │
│   • VCT InSite (casco)       • Wearable generici               │
│   • Tag DPI (NFC/BLE)        • Sensori ambientali              │
│   • Gateway VCT              • RTLS UWB/BLE                    │
│                              • Altri (futuro)                   │
│                                                                 │
│                         ▼                                       │
│              GATEWAY / EDGE PROCESSING                          │
│              (BLE/LoRa → LTE/5G/Wi-Fi)                         │
│                         ▼                                       │
│              PIATTAFORMA CLOUD                                  │
│              (API aperte per integrazioni)                      │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Piattaforma InSite (VCT)

**Dashboard:** [https://insite.vct-me.com/](https://insite.vct-me.com/)

La piattaforma **InSite** di VCT è il sistema di riferimento per il monitoraggio centralizzato. La dashboard web consente al **COS (Centro Operativo Sicurezza)** di monitorare in tempo reale tutti i lavoratori e intervenire rapidamente in caso di emergenza.

### Sistema Casco-Centrico VCT

Il casco intelligente è il dispositivo principale, equipaggiato con centralina per:

| Sensore | Parametro | Indice Calcolato |
|---------|-----------|------------------|
| **GSR/EDA** | Risposta galvanica cutanea | ASI (Acute Stress Index) |
| **HRV** | Variabilità cardiaca (RMSSD/SDNN) | FI (Fatigue Index) |
| **Temperatura cutanea** | Stress termico | Correlazione WBGT |
| **Accelerometro** | Pattern movimento/immobilità | Uomo a terra |

**Indici calcolati dalla piattaforma:**

| Indice | Descrizione | Uso |
|--------|-------------|-----|
| **FI (Fatigue Index)** | Indice di affaticamento basato su HRV, GSR, temperatura, micro-immobilità | Prevenzione errori da stanchezza |
| **ASI (Acute Stress Index)** | Indice stress acuto da burst EDA e incremento HR | Rilevazione situazioni critiche |

**Condizioni critiche rilevate (AI):**
- 🔴 Uomo a terra (pattern caduta/immobilità)
- 🔴 Colpo di calore (correlazione WBGT)
- 🔴 Tachicardia/Bradicardia
- 🔴 Perdita di coscienza

### Tag DPI

Sistema di verifica conformità DPI tramite tag NFC/BLE:

| DPI | Tag | Verifica |
|-----|-----|----------|
| **Casco** | Integrato | Indossamento corretto |
| **Scarpe antinfortunistiche** | Tag NFC | Presenza/conformità |
| **Guanti** | Tag NFC | Presenza/conformità |
| **Cintura/Cordino** | Tag NFC | Presenza/conformità |

### Sensoristica Futura (Estendibile)

La piattaforma supporta l'integrazione di:
- 📡 **Sensori ambientali** (rumore, polveri, CO₂, WBGT)
- 📍 **RTLS UWB/BLE** per localizzazione precisa
- ⌚ **Wearable generici** compatibili
- 🔌 **API aperte** per sensori di terze parti

### Metriche Monitorate

**Stato Dispositivi:**
- ✅ Indossato correttamente
- ⚠️ Indossato parzialmente
- ❌ Non indossato
- 🔋 Livello batteria dispositivo
- 📍 Posizione (zona cantiere)

**Parametri Fisiologici (Sistema Casco-Centrico):**
- 📊 GSR/EDA (risposta galvanica cutanea)
- ❤️ HRV - Variabilità cardiaca (RMSSD/SDNN)
- 🌡️ Temperatura cutanea
- 🚶 Pattern movimento/immobilità

**Indici Calcolati (AI):**
- 😴 **FI (Fatigue Index)** - Indice affaticamento
- 😰 **ASI (Acute Stress Index)** - Indice stress acuto
- 🌡️ Correlazione **WBGT** (stress termico ambientale)

**Conformità DPI (Tag NFC/BLE):**
- 🪖 Casco: indossamento
- 👟 Scarpe: presenza tag
- 🧤 Guanti: presenza tag
- 🦺 Cintura/Cordino: presenza tag

**Eventi Critici Rilevati (AI):**
- 🔴 Uomo a terra (pattern caduta/immobilità)
- 🔴 Colpo di calore (FI + WBGT)
- 🔴 Stress acuto critico (ASI elevato)
- 🔴 DPI non conformi (tag mancante/area vincolata)
- 🔴 Perdita segnale dispositivo

### Centrale Operativa di Sicurezza

La Centrale Operativa monitora H24 tutti i cantieri attivi tramite la dashboard InSite:

```
┌─────────────────────────────────────────────────────────────┐
│                   CENTRALE OPERATIVA                        │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐      │
│   │  Cantiere A │   │  Cantiere B │   │  Cantiere C │      │
│   │  👷 12/12   │   │  👷 8/10    │   │  👷 15/15   │      │
│   │  ✅ OK      │   │  ⚠️ Alert   │   │  ✅ OK      │      │
│   └─────────────┘   └─────────────┘   └─────────────┘      │
│                                                             │
│   ┌─────────────────────────────────────────────────┐      │
│   │  ALERT ATTIVI                                    │      │
│   │  🔴 Mario R. - Battito cardiaco elevato (142bpm)│      │
│   │  🟠 Luca B. - Casco non indossato               │      │
│   │  🟡 Area C - Temperatura elevata (38°C)         │      │
│   └─────────────────────────────────────────────────┘      │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### Flusso di Intervento

```
Sensore rileva anomalia
        │
        ▼
┌───────────────────┐
│ Alert su InSite   │ ──► Dashboard Centrale Operativa
└───────────────────┘
        │
        ▼
┌───────────────────┐
│ Notifica Vigilo   │ ──► App del lavoratore
└───────────────────┘
        │
        ▼
┌───────────────────┐
│ Valutazione       │
│ Centrale Operativa│
└───────────────────┘
        │
        ├──► Situazione sotto controllo ──► Monitoraggio continuo
        │
        └──► Intervento necessario
                    │
                    ▼
            ┌───────────────────┐
            │ Azioni possibili: │
            │ • Chiamata diretta│
            │ • Alert capocant. │
            │ • Invio soccorsi  │
            │ • Evacuazione     │
            └───────────────────┘
```

### Tipi di Alert

| Livello | Colore | Trigger | Azione |
|---------|--------|---------|--------|
| **Critico** | 🔴 Rosso | Caduta rilevata, battito assente, SOS manuale | Intervento immediato, 118 |
| **Alto** | 🟠 Arancione | Battito anomalo, temperatura corporea alta, immobilità prolungata | Contatto diretto, verifica |
| **Medio** | 🟡 Giallo | DPI non indossato, zona pericolosa, batteria scarica | Notifica + reminder |
| **Basso** | 🔵 Blu | Pausa non effettuata, idratazione bassa | Suggerimento in-app |

### Integrazione App-Dashboard

| Funzione | App Vigilo | Dashboard InSite |
|----------|------------|------------------|
| Visualizzazione stato DPI | ✅ Personale | ✅ Tutti i lavoratori |
| Parametri vitali | ✅ Personali | ✅ Aggregati + singoli |
| Invio SOS | ✅ Manuale | ✅ Ricezione + gestione |
| Alert automatici | ✅ Ricezione | ✅ Generazione + dispatch |
| Storico dati | ✅ Ultimi 7gg | ✅ Completo + analytics |
| Geolocalizzazione | ✅ Propria | ✅ Mappa cantiere live |
| Report incidenti | ✅ Creazione | ✅ Gestione + follow-up |

### KPI Personali (visibili in app)

L'operatore può visualizzare i propri KPI nella `PersonalKpiCard`:

| KPI | Descrizione | Visualizzazione |
|-----|-------------|-----------------|
| **Safety Score** | Punteggio sicurezza 0-100 | Gauge + trend |
| **FI (Fatigue Index)** | Indice affaticamento | Semaforo 🟢🟡🔴 |
| **ASI (Acute Stress)** | Indice stress acuto | Semaforo 🟢🟡🔴 |
| **DPI Compliance** | % tempo con DPI conformi | Percentuale |
| **Ore lavorate** | Ore nel periodo | Numero + confronto |
| **Segnalazioni** | Near-miss/pericoli segnalati | Contatore |
| **Formazione** | Corsi completati/scaduti | Progress bar |
| **Punti sicurezza** | Punti guadagnati | Numero + livello |

**Privacy:** L'operatore vede SOLO i propri dati. I supervisori vedono dati aggregati/pseudonimizzati.

### Dati e Privacy

La piattaforma è progettata **privacy-by-design** in conformità a GDPR e Statuto Lavoratori (art. 4):

| Principio | Applicazione |
|-----------|--------------|
| **Pseudonimizzazione** | Dati mascherati by default nelle dashboard |
| **De-pseudonimizzazione** | Solo su evento critico, con doppia autorizzazione e log |
| **Minimizzazione** | Solo dati necessari per finalità HSE |
| **Limitazione finalità** | Esclusi usi disciplinari o di produttività |

**Base giuridica:** Obbligo legale D.Lgs. 81/2008 (art. 6(1)(c) GDPR), non consenso.

**Retention Policy:**

| Tipo Dato | Conservazione | Poi |
|-----------|---------------|-----|
| Segnali grezzi (GSR/HRV) | 30-90 giorni | Aggregazione/cancellazione |
| Eventi/allarmi/log | 12-24 mesi | Cancellazione |
| Report direzionali | Indefinito | Solo aggregati anonimi |
| Audit trail | Immutabile | Conservazione legale |

**Sicurezza:**
- Crittografia in transito (TLS) e a riposo
- IAM con MFA e RBAC
- Segregazione dati per tenant/cliente
- Backup cifrati con test DR periodici

---

## Architettura Tecnica

### Stack Tecnologico

| Componente | Tecnologia |
|------------|------------|
| Framework | Flutter 3.9.2+, Dart 3.9.2+ |
| State Management | Riverpod 3.0+ |
| Navigation | Go Router 16.x |
| Backend | Supabase (Auth, Database, Storage) |
| IoT Platform | InSite VCT (sensori DPI, monitoraggio) |
| Local Storage | SharedPreferences |
| Sicurezza | flutter_secure_storage, local_auth |
| Splash | flutter_native_splash |
| Linting | very_good_analysis |

### Struttura Progetto

```
lib/
├── main.dart                    # Entry point, Supabase init
├── core/
│   ├── env/                     # Configurazione ambiente
│   ├── router/                  # Go Router (AppRouter)
│   ├── theme/                   # AppTheme (light/dark)
│   ├── security/                # Autenticazione biometrica
│   ├── services/                # Gestione permessi
│   └── utils/                   # Validator, SecureStorage
├── features/
│   ├── shell/                   # MainShell - navigation container
│   ├── home/                    # Dashboard
│   ├── team/                    # Collaborazione team
│   ├── sos/                     # Emergenze
│   ├── punti/                   # Gamification
│   ├── impara/                  # Formazione
│   ├── auth/                    # Login/Signup
│   ├── splash/                  # Splash screen
│   ├── daily_todo/              # Task giornalieri
│   ├── dpi_status/              # Stato DPI
│   ├── safety_score/            # Punteggio sicurezza
│   ├── smart_break/             # Timer pause
│   ├── personal_kpi/            # KPI personali
│   └── team_challenge/          # Sfide team
├── shared/
│   └── widgets/                 # AppHeader, AppBackground
├── providers/                   # Riverpod providers
└── l10n/                        # Localizzazioni (it, en)
```

### Pattern Feature

Ogni feature segue questa struttura:

```
lib/features/<feature>/
├── domain/
│   └── models/                  # Data classes
├── presentation/
│   ├── pages/                   # Pagine/schermate
│   └── widgets/                 # Widget riutilizzabili
└── <feature>_page.dart          # Entry point feature
```

---

## Design System

### Palette Colori (Safety-focused)

| Colore | Hex | Uso |
|--------|-----|-----|
| **Primary** (Giallo) | #FFB800 | Attenzione, azioni principali |
| **Secondary** (Verde) | #2E7D32 | Sicurezza, conferme |
| **Tertiary** (Blu) | #1565C0 | Informazioni, obbligatorio |
| **Warning** (Arancione) | #FF6D00 | Avvertenze |
| **Danger** (Rosso) | #D32F2F | SOS, divieti |
| **Neutral** (Grigio) | #757575 | Disabilitato, secondario |

### Temi

- **Light Mode**: Sfondo chiaro con accenti colorati
- **Dark Mode**: Sfondo scuro (#1A1A1A) con colori attenuati

### Componenti Condivisi

**AppHeader:**
- Avatar utente con bordo gradient → naviga al Profilo
- Saluto personalizzato + nome utente
- Badge Punti Elmetto (chip blu con icona elmetto)
- Pulsante notifiche con badge contatore
- Modalità immersiva (barre di sistema Android nascoste)

**AppBackground:**
- Sfondo gradient industriale
- Pattern strisce pericolo (top)
- Decorazioni angolari
- Elementi esagonali/bulloni
- Pattern griglia

---

## Sistema Incentivi all'Utilizzo

### Filosofia: Sicurezza come Vantaggio, non Obbligo

Il sistema di incentivi è progettato per **trasformare la percezione della sicurezza** da obbligo burocratico a vantaggio personale e di team. L'approccio si basa su tre pilastri:

```
┌─────────────────────────────────────────────────────────────────┐
│                    PIRAMIDE INCENTIVI                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│                        🏆 PREMI                                 │
│                      Ricompense tangibili                       │
│                                                                 │
│                    ────────────────────                         │
│                                                                 │
│                  🎮 GAMIFICATION                                │
│                Punti, livelli, classifiche                      │
│                                                                 │
│              ──────────────────────────────                     │
│                                                                 │
│            👥 RICONOSCIMENTO SOCIALE                           │
│          Safety Star, team challenge, VOW                       │
│                                                                 │
│        ────────────────────────────────────────                 │
│                                                                 │
│      🛡️ SICUREZZA PERSONALE (Base)                            │
│    Protezione sé stessi, famiglia, colleghi                     │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

### Azioni Premiate e Punti

#### Comportamenti Sicuri (Guadagno Punti)

| Azione | Punti | Frequenza | Logica |
|--------|-------|-----------|--------|
| **DPI indossati correttamente** | +5 | Giornaliero | Verifica automatica tag |
| **Completamento formazione** | +50-200 | Per corso | In base a durata/difficoltà |
| **Quiz superato** | +20-50 | Per quiz | Bonus se primo tentativo |
| **Segnalazione pericolo** | +30 | Per segnalazione | Incentiva near-miss reporting |
| **Survey VOW completato** | +10 | Fine turno | Feedback quotidiano |
| **Wellness check-in** | +5 | Giornaliero | Monitora benessere |
| **Pausa effettuata** | +5 | Per pausa | SmartBreak rispettato |
| **Zero incidenti (team)** | +100 | Settimanale | Bonus collettivo |
| **Hot streak DPI** | +10/giorno | Consecutivo | Moltiplicatore streak |
| **Nomination Safety Star** | +15 | Per nomination | Riconoscimento peer |
| **Vincita Safety Star** | +200 | Settimanale | Premio settimanale |

#### Penalità (Perdita Punti)

| Azione | Punti | Note |
|--------|-------|------|
| **DPI non indossato** | -20 | Alert inviato prima |
| **Formazione scaduta** | -50 | Dopo reminder |
| **Ingresso zona senza DPI** | -30 | Area vincolata |

> ⚠️ **Nota privacy:** Le penalità sono applicate automaticamente dal sistema, senza intervento di supervisori. Nessun uso disciplinare.

---

### Sistema Livelli

| Livello | Punti Richiesti | Badge | Benefici |
|---------|-----------------|-------|----------|
| 🥉 **Bronze** | 0 - 499 | Principiante | Accesso base |
| 🥈 **Silver** | 500 - 1.499 | Attento | Spin extra ruota (2/giorno) |
| 🥇 **Gold** | 1.500 - 3.999 | Esperto | Premi esclusivi, priorità catalogo |
| 💎 **Platinum** | 4.000 - 9.999 | Veterano | Sconto 10% premi, badge profilo |
| 👑 **Diamond** | 10.000+ | Campione | Accesso anticipato novità, mentor badge |

**Progressione:**
- I punti **non scadono** (lifetime)
- Il livello **non può scendere**
- Bonus punti al passaggio di livello (+100/+200/+300/+500)

---

### Premi e Catalogo

#### Categorie Premi

| Categoria | Esempi | Range Punti | Sponsor |
|-----------|--------|-------------|---------|
| 🎫 **Voucher** | Amazon, benzina, supermercato | 500 - 5.000 | VCT / Partner |
| 🦺 **DPI Premium** | Cuffie antirumore, occhiali, zaino | 300 - 2.000 | VCT |
| 👕 **Gadget** | T-shirt Vigilo, borraccia, cappellino | 200 - 800 | VCT |
| 🎁 **Esperienze** | Cena per 2, weekend, biglietti eventi | 3.000 - 10.000 | Partner |
| 🏆 **Esclusivi** | Dispositivi tech, attrezzatura sport | 5.000+ | VCT |

#### Premi Speciali

| Premio | Condizione | Valore |
|--------|------------|--------|
| **Premio Trimestrale Top Safety** | #1 classifica trimestre | Voucher €200 |
| **Team Zero Infortuni** | 0 incidenti mese (team) | Pranzo team offerto |
| **Safety Star dell'Anno** | Più nomination annue | Targa + premio €500 |
| **Mentor Award** | Aiuto onboarding colleghi | Badge speciale + 500 punti |

---

### Ruota Fortunata

**Meccanica:**
- 1 spin gratuito al giorno
- Spin extra per livelli Silver+ o azioni speciali
- Premi istantanei (punti, voucher piccoli, gadget)

| Settore | Probabilità | Premio |
|---------|-------------|--------|
| 🎯 **Punti x2** | 25% | Raddoppio punti giornalieri |
| 🎁 **5-50 punti** | 40% | Punti bonus istantanei |
| 🎫 **Mini voucher** | 15% | €5-10 buono |
| 🦺 **Gadget** | 10% | Item casuale catalogo |
| 👑 **Jackpot** | 5% | Premio top (€50+ valore) |
| ❌ **Ritenta** | 5% | Spin extra gratis |

---

### Sfide e Challenge

#### Sfide Individuali

| Sfida | Durata | Obiettivo | Premio |
|-------|--------|-----------|--------|
| **Prima Settimana Perfetta** | 7 giorni | 100% DPI compliance | 200 punti + badge |
| **Studente Modello** | 30 giorni | 5 corsi completati | 500 punti |
| **Segnalatore Attivo** | Continuo | 10 segnalazioni utili | 300 punti + badge |
| **Streak Master** | Continuo | 30 giorni consecutivi DPI | 1.000 punti + badge |

#### Sfide Team

| Sfida | Durata | Obiettivo | Premio |
|-------|--------|-----------|--------|
| **Settimana Zero Infortuni** | 7 giorni | Nessun incidente team | 100 punti/persona |
| **Mese della Formazione** | 30 giorni | 80% team completa corso X | 200 punti/persona |
| **Challenge Cantiere** | Variabile | Competizione tra cantieri | Trofeo + premio team |

---

### Riconoscimento Sociale

#### Safety Star della Settimana

**Meccanica:**
1. Ogni lavoratore può **nominare** un collega (1 nomination/settimana)
2. Le nomination sono **anonime** (privacy)
3. Chi riceve più nomination vince
4. Il vincitore riceve: **+200 punti** + **badge pubblico** + **menzione**

**Categorie nomination:**
- 🦺 "Ha aiutato con i DPI"
- ⚠️ "Ha segnalato un pericolo"
- 🤝 "Ha supportato un collega in difficoltà"
- 📚 "Ha condiviso conoscenze di sicurezza"
- 🏃 "Ha reagito prontamente a un'emergenza"

#### Transparency Dashboard

Widget "**Hai detto → Abbiamo fatto**":
- Mostra segnalazioni del team → azioni intraprese
- Crea **fiducia** nel sistema
- Incentiva **future segnalazioni**

---

### Incentivi per il Partner

I Partner possono **personalizzare** gli incentivi per i propri clienti:

| Funzionalità | Descrizione |
|--------------|-------------|
| **Catalogo personalizzato** | Aggiungere premi brandizzati |
| **Sfide custom** | Creare challenge specifiche |
| **Bonus formazione** | Extra punti per i propri corsi |
| **Report engagement** | Dashboard utilizzo per cliente |
| **Co-branding premi** | Logo Partner su gadget |

---

### Metriche di Successo Incentivi

| KPI | Target | Misura |
|-----|--------|--------|
| **Daily Active Users (DAU)** | >70% | % lavoratori che aprono app/giorno |
| **Completion rate formazione** | >85% | Corsi completati vs assegnati |
| **VOW survey response** | >60% | Survey completati vs inviati |
| **Near-miss reporting** | +50% | Incremento segnalazioni vs baseline |
| **DPI compliance** | >95% | Tempo con DPI conformi |
| **Punti riscattati** | >40% | Punti spesi vs guadagnati |
| **NPS lavoratori** | >50 | Net Promoter Score |

---

### ROI Incentivi per l'Azienda

| Beneficio | Stima Risparmio | Fonte |
|-----------|-----------------|-------|
| **Riduzione infortuni -30%** | €15.000-50.000/anno | Meno fermi, assicurazioni |
| **Riduzione turnover** | €5.000-10.000/anno | Costo sostituzione personale |
| **Audit più rapidi** | €2.000-5.000/anno | Documentazione automatica |
| **Premio INAIL (OT23)** | Fino a 28% sconto | Prevenzione documentata |

> 💡 **Il costo dei premi (€240/lavoratore/anno = €20/mese) è ampiamente ripagato dal risparmio INAIL OT23.**

---

## Localizzazione

**Lingue supportate:**
- 🇮🇹 Italiano (`app_it.arb`)
- 🇬🇧 Inglese (`app_en.arb`)

**432 chiavi di traduzione** organizzate per feature:
- `punti*` - Sistema punti
- `sos*` - Emergenze
- `impara*` - Formazione
- `team*` - Collaborazione
- `nav*` - Navigazione

---

## Configurazione Ambiente

### File .env

Posizione: `assets/env/.env.<flavor>`

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
```

### Flavors

| Flavor | Uso |
|--------|-----|
| `dev` | Sviluppo locale |
| `preview` | Test interni |
| `staging` | Pre-produzione |
| `prod` | Produzione |

---

## Comandi Sviluppo

```bash
# Installazione dipendenze
flutter pub get

# Esecuzione (con flavor)
flutter run --flavor dev

# Test
flutter test

# Analisi statica
flutter analyze

# Generazione localizzazioni
flutter gen-l10n

# Build runner (dopo modifiche @freezed)
dart run build_runner build --delete-conflicting-outputs

# Generazione splash screen
dart run flutter_native_splash:create

# Build release
flutter build apk --flavor prod --release
flutter build ios --flavor prod --release
```

---

## Sicurezza e Compliance

### Autenticazione (IAM)
- Supabase Auth (email/password)
- MFA opzionale per ruoli privilegiati
- Refresh token automatico
- Auto-signout su inattività
- Biometria opzionale (local_auth)
- SSO (OIDC/SAML) per integrazioni enterprise

### Storage Locale
- Credenziali in flutter_secure_storage
- Settings in SharedPreferences
- **No dati sensibili/biometrici in locale**
- Cache solo per UI, mai per dati HSE

### Normative e Certificazioni
| Normativa | Applicazione |
|-----------|--------------|
| **D.Lgs. 81/2008** | Titoli I, III (DPI), IV (cantieri) |
| **Statuto art. 4** | Accordo sindacale/Aut. INL pre-attivazione |
| **GDPR** | DPIA, art. 28, registro trattamenti |
| **ISO 45001** | SGSSL (roadmap) |
| **ISO 27001/27701** | ISMS/PIMS (roadmap) |

### RBAC (Role-Based Access Control)

| Ruolo | Visibilità Dati | Azioni |
|-------|-----------------|--------|
| **COS** | Pseudonimi + de-pseud. su evento | Triage, escalation, pacchetti probatori |
| **RSPP** | Aggregati + audit | Policy, DVR/DPIA, soglie |
| **Resp. Cantiere** | Proprio cantiere | NC, azioni correttive |
| **Preposto** | Propria area | Verifica DPI, interventi |
| **Operatore** | Solo propri dati | SOS, segnalazioni |
| **Direzione** | Solo aggregati anonimi | KPI, ESG, benchmark |

---

## Roadmap e Gap Analysis

📋 **Vedi documento dedicato:** [ROADMAP.md](./ROADMAP.md)

---

## Contatti

**Progetto generato da:** OneWeekApp AI Software Factory

**Repository:** [github.com/sabatino81/vigilo](https://github.com/sabatino81/vigilo)
