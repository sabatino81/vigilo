# Testing — Vigilo App

## Panoramica

La test suite copre **221 test** su **25 file**, organizzati in 3 livelli:

| Livello | File | Test | Descrizione |
|---------|------|------|-------------|
| Domain Models | 16 | ~160 | fromJson, computed properties, copyWith, enum |
| Providers | 1 | ~10 | CartNotifier state management |
| Widget / Integration | 5 | ~15 | Auth, HomePage, SplashPage, LoginPage |
| Core Utils | 2 | ~10 | Validator, SecureStorage |
| Helpers | 1 | — | Factory functions e mock repositories |

## Comandi

```bash
flutter test                                    # Tutti i test
flutter test --coverage                         # Con report coverage
flutter test test/features/punti/               # Solo un modulo
flutter test test/features/shop/domain/models/  # Solo modelli shop
flutter test <file>.dart                        # Singolo file
```

## Struttura file

```
test/
├── helpers/
│   └── test_helpers.dart                  # Factory, mock repos, createContainer()
├── core/
│   ├── secure_storage_test.dart           # FlutterSecureStorage wrapper
│   └── validator_test.dart                # FormValidator (email, password, range)
├── features/
│   ├── auth/
│   │   ├── auth_provider_test.dart        # AuthNotifier state (override Supabase)
│   │   ├── auth_service_test.dart         # AuthService con MockGoTrueClient
│   │   └── login_page_test.dart           # Widget: form email/password
│   ├── checkin/domain/models/
│   │   └── shift_checkin_test.dart        # DpiRequirement, allDpiChecked, toggleDpi
│   ├── home/
│   │   └── home_page_test.dart            # Widget: ListView render
│   ├── impara/domain/models/
│   │   └── quiz_test.dart                 # QuizQuestion, Quiz, QuizResult
│   ├── notifications/domain/models/
│   │   └── app_notification_test.dart     # fromJson, category enum, copyWith
│   ├── profile/domain/models/
│   │   └── user_profile_test.dart         # fromJson, toJson, copyWith, enums
│   ├── punti/domain/models/
│   │   ├── elmetto_wallet_test.dart       # calculateCheckout, welfare, BNPL
│   │   └── points_transaction_test.dart   # formattedAmount, TransactionType
│   ├── shop/
│   │   ├── domain/models/
│   │   │   ├── cart_item_test.dart        # subtotal, formattedSubtotal, copyWith
│   │   │   ├── order_test.dart            # fromJson, OrderStatus, itemCount
│   │   │   ├── product_test.dart          # displayPrice, hasPromo, fromJson
│   │   │   └── voucher_test.dart          # isExpired, isValid, fromJson
│   │   └── providers/
│   │       └── cart_notifier_test.dart    # add/remove/update/clear, totals
│   ├── sos/domain/models/
│   │   └── safety_report_test.dart        # fromJson, photo_urls, copyWith
│   ├── splash/
│   │   └── splash_page_test.dart          # Widget: progress indicator
│   ├── streak/domain/models/
│   │   └── streak_test.dart               # StreakLevel.fromDays, multiplier
│   ├── team/domain/models/
│   │   ├── social_post_test.dart          # fromJson, thumbPath
│   │   └── vow_survey_test.dart           # answeredCount, isComplete, averageRating
│   └── team_challenge/domain/models/
│       └── challenge_test.dart            # progress, progressPercent, fromJson
└── widgets/
    └── widget_test.dart                   # Smoke test Counter
```

## Test Helpers (`test/helpers/test_helpers.dart`)

### Mock Repositories

```dart
MockProductRepository   // implements ProductRepository
MockOrderRepository     // implements OrderRepository
MockWalletRepository    // implements WalletRepository
MockCheckinRepository   // implements CheckinRepository
```

Tutti basati su `mocktail`. Usare `when(() => mock.method()).thenReturn(...)`.

### Factory Functions

| Factory | Modello | Parametri principali |
|---------|---------|---------------------|
| `makeProduct()` | `Product` | id, name, basePrice, promoDiscountPercent |
| `makeCartItem()` | `CartItem` | product, quantity |
| `makeWallet()` | `ElmettoWallet` | puntiElmetto, welfareActive |
| `makeProfile()` | `UserProfile` | id, name, category, trustLevel |
| `makeStreak()` | `Streak` | currentDays, bestStreak, calendarDays |

### Container Helper

```dart
final container = createContainer(overrides: [
  isAuthenticatedProvider.overrideWith((ref) => false),
]);
```

## Copertura per feature

### Business-critical (copertura alta)

- **ElmettoWallet** — `calculateCheckout` con/senza welfare, cap 20%, BNPL soglia 50 EUR, `fromJson`
- **Product** — `displayPrice` con promo, `hasPromo`, `fromJson` con category/badge sconosciuti
- **Quiz** — `QuizQuestion.isCorrect`, `Quiz.fromJson` con nested questions, `QuizResult` (score, percentage, passed, 5 soglie resultLabel)
- **Streak** — `StreakLevel.fromDays` per tutte le soglie (1/7/14/30/60), `multiplier`, `nextLevel`, `daysToNextLevel`
- **ShiftCheckin** — `DpiRequirement.forCategory` per 4 ruoli, `allDpiChecked`, `toggleDpi`, `confirm`
- **CartNotifier** — add/remove/updateQuantity/clear, totalEur, itemCount

### Standard (copertura media)

- **Order** — `fromJson` con items nested, status parsing, `itemCount`
- **UserProfile** — `fromJson`, `toJson` round-trip, `copyWith`, `WorkerCategory`/`TrustLevel` enum
- **CartItem** — `subtotal` con/senza promo, `copyWith`
- **SafetyReport** — `fromJson`, photo_urls filtering, `copyWith`
- **Voucher** — `isExpired`, `isValid`, `fromJson`
- **Challenge** — `progress`, `progressPercent` clamp, `remainingPoints`

### Leggera (copertura base)

- **PointsTransaction** — `formattedAmount`, `TransactionType.isPositive`
- **AppNotification** — `fromJson`, `copyWith`
- **SocialPost** — `fromJson`, `thumbPath`
- **VowSurvey** — `answeredCount`, `isComplete`, `averageRating`, `ratingLabel`

## Convenzioni

1. **Nomi gruppi**: `group('NomeClasse.metodo', () { ... })` oppure `group('NomeClasse computed properties', ...)`
2. **Nomi test**: descrizione comportamentale in inglese (`'returns 0 for empty answers'`)
3. **Import**: sempre assoluti (`package:vigilo/...`)
4. **fromJson**: testare sempre JSON completo + campi mancanti + valori sconosciuti per enum
5. **copyWith**: verificare cambio singolo + preservazione invariati
6. **Provider test**: usare `ProviderContainer` con override per isolare da Supabase
7. **Widget test**: wrappare in `ProviderScope` + `MaterialApp`

## Dipendenze test

```yaml
# pubspec.yaml — dev_dependencies
flutter_test:
  sdk: flutter
test: ^1.26.2
mocktail: ^1.0.4
```

## Prossimi passi

- [ ] Provider test per `ProductsNotifier`, `OrdersNotifier`, `WalletNotifier`, `CheckinNotifier`
- [ ] Repository test con mock Supabase client
- [ ] Widget test per pagine principali (Punti, Shop, Impara)
- [ ] Integration test E2E (`docs/04_TESTING/e2e/`)
- [ ] Coverage report automatico in CI (`docs/04_TESTING/COVERAGE/`)
