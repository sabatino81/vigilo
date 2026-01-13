# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Vigilo è un'app Flutter per la sicurezza sul lavoro nei cantieri. Generata da OneWeekApp AI Software Factory, usa Supabase come backend, Riverpod per state management, Go Router per navigazione e SharedPreferences per settings locali.

## Essential Commands

```bash
# Install dependencies
flutter pub get

# Run the app (flavors: dev, preview, staging, prod)
flutter run --flavor dev

# Run tests
flutter test

# Static analysis (uses very_good_analysis rules)
flutter analyze

# Generate localization files (after editing ARB files)
flutter gen-l10n

# Regenerate code after @freezed/@JsonSerializable changes
dart run build_runner build --delete-conflicting-outputs

# Generate native splash screen
dart run flutter_native_splash:create

# Build for release
flutter build apk --flavor prod --release
flutter build ios --flavor prod --release
flutter build web --release
```

## Architecture

```
lib/
├── main.dart                 # App entry, Supabase init
├── core/
│   ├── env/                  # Environment config (Env.requireEnv)
│   ├── router/               # GoRouter (AppRouter)
│   ├── security/             # Biometric auth
│   ├── services/             # Permissions
│   ├── theme/                # AppTheme (light/dark)
│   └── utils/                # SecureStorage, Validator
├── features/
│   ├── shell/                # MainShell - bottom navigation container
│   ├── home/                 # Dashboard principale
│   ├── team/                 # Team, social wall, challenges
│   ├── sos/                  # Emergency contacts, safety reports
│   ├── punti/                # Points, rewards, leaderboard
│   ├── impara/               # Training, quizzes, certificates
│   ├── auth/                 # Login, signup
│   ├── splash/               # Splash screen
│   ├── daily_todo/           # Daily safety tasks
│   ├── dpi_status/           # DPI (PPE) status
│   ├── safety_score/         # Safety score widget
│   ├── smart_break/          # Break reminders
│   ├── personal_kpi/         # Personal KPIs
│   └── team_challenge/       # Team challenges
├── shared/
│   └── widgets/              # AppBackground, AppHeader
├── providers/                # Riverpod (auth, locale, theme)
└── l10n/                     # i18n (en, it)
```

## App Navigation

5 tab principali in `MainShell`:
1. **Home** - Dashboard con cards: site access, DPI status, daily todo, safety score
2. **Team** - Social wall, team members, challenges, leaderboard
3. **SOS** - Emergency button, contacts, safety reports
4. **Punti** - Wallet, rewards catalog, spin wheel, instant win
5. **Impara** - Training content, quizzes, certificates, progress

## Key Patterns

- **Feature structure**: `domain/models/`, `presentation/pages/`, `presentation/widgets/`
- **Providers**: SharedPreferences per locale/theme persistence (no Hive)
- **Dependency injection**: Services accept clients via constructor for testability
- **Widgets**: `ConsumerWidget` per Riverpod, `AppBackground` + `AppHeader` per UI consistency

## Environment Configuration

`assets/env/.env.<flavor>` (dev, preview, staging, prod):
```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_anon_key
```

## Tech Stack

| Component | Technology |
|-----------|------------|
| Framework | Flutter 3.9.2+, Dart 3.9.2+ |
| State | Riverpod 3.0+ |
| Navigation | Go Router |
| Backend | Supabase (Auth, Database, Storage) |
| Local Storage | SharedPreferences |
| Splash | flutter_native_splash |
| Linting | very_good_analysis |
| Testing | flutter_test, mocktail |

## Adding Features

1. Crea folder in `lib/features/<name>/`
2. Aggiungi `domain/models/` per data classes
3. Aggiungi `presentation/pages/` e `presentation/widgets/`
4. Crea providers in `lib/providers/` se necessario
5. Registra routes in `lib/core/router/app_router.dart`
6. Aggiungi translations in `lib/l10n/app_en.arb` e `app_it.arb`

## Documentation

| Document | Description |
|----------|-------------|
| `docs/PROGETTO.md` | Specifiche funzionali complete |
| `docs/BUSINESS_PROPOSAL.md` | Business model e go-to-market |
| `docs/SSCC_TECHNICAL_SPEC.md` | Spec tecnica sistema casco-centrico |
| `docs/PIATTAFORMA_FORMAZIONE.md` | Spec tecnica LMS per Partner |
| `docs/ROADMAP.md` | Roadmap e gap analysis |
