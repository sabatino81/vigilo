# Vigilo - Documentazione di Progetto

> App mobile per la sicurezza sul lavoro nei cantieri edili

---

## Panoramica

**Vigilo** è un'applicazione Flutter per la sicurezza sul lavoro, progettata per cantieri edili e ambienti industriali. Segue le normative italiane D.Lgs. 81/2008, fornendo ai lavoratori strumenti per:

- Monitorare metriche di sicurezza personali
- Segnalare incidenti e pericoli
- Completare formazione obbligatoria
- Guadagnare punti e premi
- Collaborare come team

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

### 4. Impara - Formazione

**Tipi Contenuto:**

| Tipo | Icona | Colore |
|------|-------|--------|
| Video | 🎬 | Rosa |
| PDF | 📄 | Arancione |
| Quiz | ❓ | Viola |
| Lezione | 📖 | Blu |

**Categorie:**
- Sicurezza DPI
- Primo Soccorso
- Procedure
- Macchinari
- Rischi Specifici
- Generale

**Funzionalità:**
- Libreria contenuti con ricerca e filtri
- Progress tracking per contenuto
- Quiz con punteggio minimo 60%
- Certificati con data scadenza
- Contenuti obbligatori vs opzionali

**Modelli Dati:**

| Modello | Campi Principali |
|---------|------------------|
| `TrainingContent` | title, type, category, duration, points, progress, isMandatory |
| `Quiz` | questions[], passingScore, maxAttempts, points |
| `Certificate` | title, earnedAt, expiresAt, isExpiringSoon |
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

## Architettura Tecnica

### Stack Tecnologico

| Componente | Tecnologia |
|------------|------------|
| Framework | Flutter 3.9.2+, Dart 3.9.2+ |
| State Management | Riverpod 3.0+ |
| Navigation | Go Router 16.x |
| Backend | Supabase (Auth, Database, Storage) |
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

## Sicurezza

### Autenticazione
- Supabase Auth (email/password)
- Refresh token automatico
- Auto-signout su inattività
- Biometria opzionale (local_auth)

### Storage
- Credenziali in flutter_secure_storage
- Settings in SharedPreferences
- No dati sensibili in locale

### Normative
- Conforme D.Lgs. 81/2008
- Privacy GDPR
- Dati wellness anonimi

---

## Roadmap Futura

- [ ] Integrazione IoT sensori DPI
- [ ] Notifiche push real-time
- [ ] Modalità offline
- [ ] Dashboard supervisor web
- [ ] Integrazione calendario turni
- [ ] Export report PDF
- [ ] Integrazione con sistemi HR

---

## Contatti

**Progetto generato da:** OneWeekApp AI Software Factory

**Repository:** [github.com/sabatino81/vigilo](https://github.com/sabatino81/vigilo)
