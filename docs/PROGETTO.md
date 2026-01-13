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

### 1. Home - Dashboard

Cards visualizzate in ordine di priorità:

1. **SiteAccessCard** - Verifica conformità cantiere (D.Lgs. 81/2008)
2. **SafetyScoreCard** - Punteggio sicurezza personale /100
3. **SocialWallCard** - Post social del cantiere
4. **DpiStatusCard** - Stato DPI con alert batteria
5. **TeamChallengeCard** - Sfida attiva con hot streak
6. **SmartBreakCard** - Timer pausa e zone ombra
7. **WelcomeGuideCard** - Guida onboarding
8. **DailyTodoCard** - Checklist giornaliera
9. **PersonalKpiCard** - KPI personali

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
- Pulsante emergenza con hold-to-activate
- Invio automatico: segnale, posizione GPS, movimento
- Notifica a tutti i contatti configurati

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

**Survey VOW:**
1. Ti sei sentito sicuro oggi? (Sì/No)
2. Qual è stato il rischio maggiore? (Attrezzature/Procedure/Ambiente/Altro)
3. Hai segnalato un pericolo? (Sì/No)
4. Commento libero

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
- Avatar utente con bordo gradient
- Saluto personalizzato
- Badge notifiche
- Menu settings (Lingua, Tema, Logout)

**AppBackground:**
- Sfondo gradient industriale
- Pattern strisce pericolo (top)
- Decorazioni angolari
- Elementi esagonali/bulloni
- Pattern griglia

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

## Roadmap Futura

- [x] ~~Integrazione IoT sensori DPI~~ ✅ Completato (InSite)
- [x] ~~Dashboard supervisor web~~ ✅ Completato (InSite)
- [ ] Notifiche push real-time
- [ ] Modalità offline completa
- [ ] Integrazione calendario turni
- [ ] Export report PDF
- [ ] Integrazione con sistemi HR
- [ ] Machine learning per predizione rischi
- [ ] Realtà aumentata per istruzioni sicurezza

---

## Contatti

**Progetto generato da:** OneWeekApp AI Software Factory

**Repository:** [github.com/sabatino81/vigilo](https://github.com/sabatino81/vigilo)
