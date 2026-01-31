# Collegamento Lavoratore: App Mobile - App Web - Database

## 1. Il problema centrale

Oggi esistono **due identita** separate per ogni lavoratore nel DB:

- **`user_id`** (UUID da `auth.users`) — usato dall'**app mobile** per tutto: check-in, ordini, segnalazioni, punti, streak, quiz, ecc.
- **`lavoratore_id`** (UUID da `lavoratori`) — usato dall'**app web** per tutto: anagrafica, turni, DPI, attestati, visite mediche, infortuni, ecc.

Il collegamento dovrebbe passare per `user_profiles.lavoratore_id`, ma questa colonna e' **sempre NULL**.

```
APP MOBILE (auth.users)                          APP WEB (lavoratori)
──────────────────────                           ──────────────────────
user_id = auth.uid()                             lavoratore_id = UUID
    |                                                |
    v                                                v
user_profiles ──── lavoratore_id = NULL ────X    lavoratori
shift_checkins                                   turni
safety_reports                                   dpi_assegnazioni
orders                                           dpi_consegne
points_transactions                              attestati
streaks                                          visite_mediche
quiz_results                                     giudizi_idoneita
wellness_checkins                                infortuni
vow_surveys                                      fabbisogni_formativi
sos_emergencies                                  mansioni
challenges                                       reparti
```

**Risultato:** i dati del lavoratore sono spaccati in due mondi che non si parlano.

---

## 2. Tabelle identita

### `auth.users` (Supabase Auth)

Utente autenticato. Creato al signup nell'app mobile.

### `profiles` (trigger automatico al signup)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | = auth.uid(), PK                             |
| `email`              | TEXT      |                                              |
| `role`               | TEXT      | default `'user'`                             |
| `display_name`       | TEXT      |                                              |
| `tipo_utente`        | VARCHAR   | default `'utente'`                           |

### `user_profiles` (profilo esteso app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | = auth.uid(), PK                             |
| `email`              | VARCHAR   |                                              |
| `nome`               | VARCHAR   |                                              |
| `cognome`            | VARCHAR   |                                              |
| `ruolo`              | VARCHAR   | default `'lavoratore'`                       |
| `azienda_id`         | UUID      | FK verso `aziende`                           |
| **`lavoratore_id`**  | **UUID**  | **FK verso `lavoratori` — SEMPRE NULL**      |
| `category`           | VARCHAR   | `operaio` / `caposquadra` / `preposto` / `rspp` |
| `trust_level`        | VARCHAR   | `base` / `verified` / `trusted` / `expert`   |
| `safety_score`       | INT       | punteggio sicurezza                          |
| `streak_days`        | INT       | giorni consecutivi check-in                  |
| `punti_elmetto`      | INT       | saldo punti elmetto                          |
| `welfare_active`     | BOOL      | piano welfare aziendale attivo               |
| `company_name`       | TEXT      | nome azienda (denormalizzato)                |
| `avatar_url`         | VARCHAR   |                                              |

### `user_aziende` (ruolo utente nell'azienda)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `azienda_id`         | UUID      | FK verso `aziende`                           |
| `ruolo`              | VARCHAR   | `admin` / `hr` / `rspp` / `preposto` / `lavoratore` |
| `scope`              | VARCHAR   | `tutto` / `reparto` / `personale`            |
| `reparto_id`         | UUID      | valorizzato se scope = `reparto`             |
| `attivo`             | BOOL      |                                              |

### `lavoratori` (anagrafica gestita dall'app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `azienda_id`         | UUID      | FK verso `aziende`                           |
| `matricola`          | VARCHAR   | codice dipendente aziendale                  |
| `nome`               | VARCHAR   |                                              |
| `cognome`            | VARCHAR   |                                              |
| `codice_fiscale`     | VARCHAR   |                                              |
| `data_nascita`       | DATE      |                                              |
| `email`              | VARCHAR   |                                              |
| `telefono`           | VARCHAR   |                                              |
| `cellulare`          | VARCHAR   |                                              |
| `data_assunzione`    | DATE      |                                              |
| `data_fine_rapporto` | DATE      | NULL se ancora attivo                        |
| `tipo_contratto`     | VARCHAR   | indeterminato / determinato / apprendistato  |
| **`turno_id`**       | **UUID**  | **FK verso `turni`**                         |
| `mansione_id`        | UUID      | FK verso `mansioni`                          |
| `reparto_id`         | UUID      | FK verso `reparti`                           |
| `ruolo_sicurezza`    | VARCHAR   | preposto / aspp / rls / ecc.                 |
| `attivo`             | BOOL      |                                              |

---

## 3. Tutte le attivita condivise tra app web e app mobile

### 3.1 TURNI

#### `turni` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `azienda_id`         | UUID      | FK verso `aziende`                           |
| `nome`               | VARCHAR   | es. "Mattina", "Pomeriggio", "Notte"        |
| `codice`             | VARCHAR   | es. "MAT", "POM", "NOT"                     |
| `ora_inizio`         | TIME      | es. `06:00:00`                               |
| `ora_fine`           | TIME      | es. `14:00:00`                               |
| `giorni_settimana`   | VARCHAR   | es. `LUN,MAR,MER,GIO,VEN`                   |
| `descrizione`        | TEXT      |                                              |
| `attivo`             | BOOL      |                                              |
| `is_global`          | BOOL      | turno condiviso tra aziende                  |

**Turni attuali nel DB:**

| Nome            | Codice | Inizio   | Fine     | Giorni  |
|:----------------|:------:|:--------:|:--------:|:--------|
| Giornaliero     | —      | 08:00    | 17:00    | LUN-VEN |
| Mattina         | MAT    | 06:00    | 14:00    | LUN-VEN |
| Pomeriggio      | POM    | 14:00    | 22:00    | LUN-VEN |
| Notte           | NOT    | 22:00    | 06:00    | LUN-VEN |
| Uffici          | UFF    | 09:00    | 18:00    | LUN-VEN |

**Chi scrive:** App Web (CRUD completo)
**Chi legge:** App Mobile (readonly, per mostrare orario turno e vincolare check-in)
**Chiave di collegamento:** `lavoratori.turno_id` -> `turni.id`
**Stato:** L'app mobile NON ha accesso perche' `lavoratore_id` e' NULL

---

### 3.2 CHECK-IN TURNO (DPI)

#### `shift_checkins` (gestita da app mobile)

| Colonna              | Tipo         | Note                                      |
|:---------------------|:-------------|:------------------------------------------|
| `id`                 | UUID         | PK                                        |
| `user_id`            | UUID         | FK verso `auth.users`                     |
| `checkin_date`       | DATE         | default `CURRENT_DATE`                    |
| `checkin_time`       | TIMESTAMPTZ  | timestamp effettivo del check-in          |
| `worker_category`    | VARCHAR      | categoria al momento del check-in         |
| `checked_dpi_ids`    | TEXT[]       | lista ID dei DPI auto-dichiarati          |
| `all_checked`        | BOOL         | tutti i DPI confermati                    |
| `status`             | VARCHAR      | `'pending'` / `'completed'`               |
| `points_earned`      | INT          | punti guadagnati                          |
| `azienda_id`         | UUID         | FK verso `aziende`                        |

> Vincolo UNIQUE su `(user_id, checkin_date)` — max 1 check-in al giorno.

**Chi scrive:** App Mobile (RPC `process_checkin`)
**Chi legge:** App Web (analytics, dashboard presenze)
**Chiave usata:** `user_id` (auth.uid)
**Stato:** Funziona ma SENZA vincolo orario turno. Il check-in si puo' fare a qualsiasi ora.

**RPC `process_checkin`:** inserisce check-in, aggiorna streak, calcola punti con moltiplicatore streak (x1.0 base, x1.2 da 7gg, x1.5 da 14gg, x2.0 da 30gg, x3.0 da 60gg), assegna punti elmetto.

**RPC `get_today_checkin`:** ritorna il check-in di oggi per `auth.uid()` (o `has_checkin: false`).

---

### 3.3 STREAK E CALENDARIO

#### `streaks` (gestita da app mobile via `process_checkin`)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `current_days`       | INT       | giorni consecutivi attuali                   |
| `best_streak`        | INT       | record personale                             |
| `last_checkin_date`  | DATE      | ultimo giorno di check-in                    |

#### `streak_calendar` (gestita da app mobile)

Calendario giornaliero per visualizzazione.

**Chi scrive:** App Mobile (automatico dentro `process_checkin`)
**Chi legge:** App Web (KPI lavoratore), App Mobile (visualizzazione)
**Chiave usata:** `user_id`

---

### 3.4 PUNTI E WALLET

#### `points_transactions` (gestita da app mobile via RPC)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `amount`             | INT       | punti (positivo = guadagnato, negativo = speso) |
| `type`               | VARCHAR   | `earned` / `spent` / `bonus`                 |
| `source`             | VARCHAR   | `checkin_dpi` / `quiz` / `report` / `order` / ecc. |
| `description`        | TEXT      |                                              |
| `new_balance`        | INT       | saldo dopo la transazione                    |

**Chi scrive:** App Mobile (via RPC `award_points`, `process_checkin`, `place_order`)
**Chi legge:** App Web (report HR, bilancio punti)
**Chiave usata:** `user_id`

**RPC `get_my_wallet`:** ritorna saldo punti elmetto per `auth.uid()`
**RPC `get_my_points_stats`:** ritorna statistiche punti (guadagnati/spesi/saldo)

---

### 3.5 SEGNALAZIONI SICUREZZA

#### `safety_reports` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users` — chi segnala          |
| `report_code`        | VARCHAR   | codice univoco segnalazione                  |
| `type`               | VARCHAR   | tipo segnalazione                            |
| `description`        | TEXT      | descrizione del problema                     |
| `photo_urls`         | TEXT[]    | foto allegate                                |
| `latitude`           | FLOAT     | GPS                                          |
| `longitude`          | FLOAT     | GPS                                          |
| `location_name`      | TEXT      | nome luogo                                   |
| `contact_requested`  | BOOL      | vuole essere ricontattato                    |
| `status`             | VARCHAR   | `submitted` / `in_review` / `resolved`       |
| `rspp_notes`         | TEXT      | note RSPP (scritte da app web)               |
| `resolved_at`        | TIMESTAMPTZ | quando risolta                             |
| `points_earned`      | INT       | punti guadagnati per la segnalazione         |
| `azienda_id`         | UUID      | FK verso `aziende`                           |
| `sede_id`            | UUID      | FK verso `sedi`                              |
| `reparto_id`         | UUID      | FK verso `reparti`                           |

**Chi scrive:** App Mobile (RPC `submit_safety_report`)
**Chi legge/aggiorna:** App Web (dashboard RSPP, cambia status, aggiunge `rspp_notes`)
**Chiave usata:** `user_id`

---

### 3.6 SOS EMERGENZE

#### `sos_emergencies` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users` — chi attiva SOS       |
| `azienda_id`         | UUID      |                                              |
| `sede_id`            | UUID      |                                              |
| `latitude`           | FLOAT     | GPS                                          |
| `longitude`          | FLOAT     | GPS                                          |
| `status`             | TEXT      | `active` / `acknowledged` / `resolved`       |
| `acknowledged_at`    | TIMESTAMPTZ | quando presa in carico                     |
| `acknowledged_by`    | UUID      | chi ha preso in carico                       |
| `resolved_at`        | TIMESTAMPTZ | quando risolta                             |
| `resolved_by`        | UUID      | chi ha risolto                               |
| `resolution_notes`   | TEXT      |                                              |
| `response_time_seconds` | INT    | tempo di risposta                            |
| `contacts_notified`  | TEXT[]    | contatti avvisati                            |

**Chi scrive:** App Mobile (attivazione SOS)
**Chi legge/aggiorna:** App Web (presa in carico, risoluzione, analytics)
**Chiave usata:** `user_id`

---

### 3.7 CONTATTI EMERGENZA

#### `emergency_contacts` (gestita da entrambe)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users` (nullable)             |
| `azienda_id`         | UUID      | FK verso `aziende` (nullable)                |
| `type`               | VARCHAR   | tipo contatto                                |
| `name`               | TEXT      | nome contatto                                |
| `phone_number`       | TEXT      | telefono                                     |
| `email`              | TEXT      |                                              |
| `is_active`          | BOOL      |                                              |

**Chi scrive:** App Web (contatti aziendali), App Mobile (contatti personali)
**Chi legge:** App Mobile (lista contatti SOS)
**Chiave usata:** `user_id` per personali, `azienda_id` per aziendali

---

### 3.8 DPI (Dispositivi Protezione Individuale)

#### `dpi_assegnazioni` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `azienda_id`         | UUID      |                                              |
| **`lavoratore_id`**  | **UUID**  | **FK verso `lavoratori`**                    |
| `dpi_id`             | UUID      | FK verso `dpi_catalogo`                      |
| `origine`            | VARCHAR   | `manuale` / `da_mansione` / `da_rischio`     |
| `mansione_id`        | UUID      |                                              |
| `taglia`             | VARCHAR   |                                              |
| `quantita`           | INT       |                                              |
| `obbligatorio`       | BOOL      |                                              |
| `attivo`             | BOOL      |                                              |
| `data_assegnazione`  | DATE      |                                              |
| `data_fine`          | DATE      |                                              |

#### `dpi_consegne` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `assegnazione_id`    | UUID      | FK verso `dpi_assegnazioni`                  |
| **`lavoratore_id`**  | **UUID**  | **FK verso `lavoratori`**                    |
| `dpi_id`             | UUID      |                                              |
| `data_consegna`      | DATE      |                                              |
| `data_scadenza`      | DATE      |                                              |
| `firma_lavoratore`   | TEXT      | firma digitale                               |
| `firma_data`         | TIMESTAMPTZ |                                            |
| `stato`              | VARCHAR   | `consegnato` / `reso` / `scaduto`            |
| `lotto`              | VARCHAR   |                                              |
| `taglia`             | VARCHAR   |                                              |

#### `dpi_verifiche` (gestita da app web)

Verifiche periodiche stato DPI.

**Chi scrive:** App Web (assegnazione, consegna, verifica DPI)
**Chi legge:** App Mobile (lista DPI da dichiarare nel check-in)
**Chiave usata:** `lavoratore_id` (NON `user_id`)
**Stato:** L'app mobile NON puo' leggere i DPI assegnati perche' servirebbero via `lavoratore_id` e il collegamento e' rotto

---

### 3.9 ATTESTATI FORMATIVI

#### `attestati` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| **`lavoratore_id`**  | **UUID**  | **FK verso `lavoratori`**                    |
| `corso_id`           | UUID      | FK verso `corsi`                             |
| `codice_attestato`   | VARCHAR   |                                              |
| `data_conseguimento` | DATE      |                                              |
| `data_scadenza`      | DATE      | scadenza certificazione                      |
| `ore_effettuate`     | INT       |                                              |
| `tipo`               | VARCHAR   | `base` / `aggiornamento` / `specializzazione` |
| `documento_path`     | VARCHAR   | PDF allegato                                 |
| `origine`            | VARCHAR   | `interno` / `esterno`                        |
| `verifica_stato`     | VARCHAR   | `da_verificare` / `verificato` / `rifiutato` |
| `attivo`             | BOOL      |                                              |

**Chi scrive:** App Web (registra attestati, importa batch, verifica)
**Chi legge:** App Mobile (mostra attestati del lavoratore, scadenze)
**Chiave usata:** `lavoratore_id`
**Stato:** L'app mobile NON puo' leggere gli attestati senza `lavoratore_id`

---

### 3.10 VISITE MEDICHE

#### `visite_mediche` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `azienda_id`         | UUID      |                                              |
| **`lavoratore_id`**  | **UUID**  | **FK verso `lavoratori`**                    |
| `protocollo_id`      | UUID      | FK verso protocolli sanitari                 |
| `tipo_visita`        | TEXT      | preventiva / periodica / cambio mansione     |
| `data_pianificata`   | DATE      | quando e' programmata                        |
| `ora_pianificata`    | TIME      |                                              |
| `luogo`              | TEXT      |                                              |
| `data_esecuzione`    | DATE      | quando effettivamente eseguita               |
| `medico_competente_nome` | TEXT  |                                              |
| `stato`              | TEXT      | `pianificata` / `in_corso` / `completata` / `annullata` |

**Chi scrive:** App Web (pianifica, aggiorna, completa)
**Chi legge:** App Mobile (prossima visita, storico, promemoria)
**Chiave usata:** `lavoratore_id`
**Stato:** L'app mobile NON puo' leggere le visite senza `lavoratore_id`

---

### 3.11 GIUDIZI DI IDONEITA

#### `giudizi_idoneita` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `visita_id`          | UUID      | FK verso `visite_mediche`                    |
| **`lavoratore_id`**  | **UUID**  | **FK verso `lavoratori`**                    |
| `mansione_id`        | UUID      |                                              |
| `giudizio`           | TEXT      | idoneo / idoneo_con_prescrizioni / non_idoneo / temporaneamente_non_idoneo |
| `data_giudizio`      | DATE      |                                              |
| `data_scadenza`      | DATE      |                                              |
| `prescrizioni`       | TEXT      | prescrizioni mediche                         |
| `limitazioni`        | TEXT      | limitazioni lavorative                       |

**Chi scrive:** App Web (medico competente)
**Chi legge:** App Mobile (stato idoneita, limitazioni attive)
**Chiave usata:** `lavoratore_id`
**Stato:** L'app mobile NON puo' leggere i giudizi senza `lavoratore_id`

---

### 3.12 INFORTUNI

#### `infortuni` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `codice`             | VARCHAR   | codice univoco infortunio                    |
| `azienda_id`         | UUID      |                                              |
| **`lavoratore_id`**  | **UUID**  | **FK verso `lavoratori`**                    |
| `tipo`               | VARCHAR   | `infortunio` / `malattia_professionale`      |
| `gravita`            | VARCHAR   | `lieve` / `grave` / `mortale`                |
| `data_evento`        | TIMESTAMP |                                              |
| `luogo_evento`       | TEXT      |                                              |
| `descrizione`        | TEXT      |                                              |
| `turno_lavoro`       | VARCHAR   | turno al momento dell'infortunio             |
| `prognosi_iniziale`  | INT       | giorni                                       |
| `prognosi_totale`    | INT       | giorni                                       |
| `data_rientro`       | DATE      |                                              |
| `stato`              | VARCHAR   | `aperto` / `in_gestione` / `chiuso`          |
| `numero_inail`       | VARCHAR   | numero denuncia INAIL                        |
| `stato_denuncia`     | VARCHAR   | `da_inviare` / `inviata` / `accettata`       |

**Chi scrive:** App Web (registra, gestisce, chiude)
**Chi legge:** App Mobile (storico infortuni personali)
**Chiave usata:** `lavoratore_id`
**Stato:** L'app mobile NON puo' leggere gli infortuni senza `lavoratore_id`

---

### 3.13 FABBISOGNI FORMATIVI

#### `fabbisogni_formativi` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `azienda_id`         | UUID      |                                              |
| `mansione_id`        | UUID      | per quale mansione serve                     |
| `corso_id`           | UUID      | quale corso                                  |
| `obbligatorio`       | BOOL      |                                              |
| `priorita`           | VARCHAR   | `alta` / `media` / `bassa`                  |
| `periodicita_rinnovo`| INT       | mesi                                         |
| `data_obiettivo`     | DATE      |                                              |

**Chi scrive:** App Web (RSPP/HR definisce i fabbisogni per mansione)
**Chi legge:** App Mobile (formazione obbligatoria mancante per la propria mansione)
**Chiave usata:** `mansione_id` (indiretto via `lavoratori.mansione_id`)
**Stato:** L'app mobile NON puo' leggere i fabbisogni senza sapere la propria mansione

---

### 3.14 ORDINI ECOMMERCE

#### `orders` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `order_code`         | TEXT      | codice ordine                                |
| `total_eur`          | FLOAT     | totale lordo                                 |
| `company_pays_eur`   | FLOAT     | quota welfare aziendale                      |
| `elmetto_points_used`| INT       | punti elmetto usati                          |
| `elmetto_discount_eur`| FLOAT    | sconto da punti elmetto                      |
| `final_price_eur`    | FLOAT     | prezzo finale a carico lavoratore            |
| `shipping_eur`       | FLOAT     | spedizione                                   |
| `status`             | VARCHAR   | `pending` / `confirmed` / `shipped` / `delivered` |
| `tracking_code`      | TEXT      | codice tracking spedizione                   |
| `used_bnpl`          | BOOL      | pagamento a rate (Scalapay)                  |

**Chi scrive:** App Mobile (RPC `place_order`, `calculate_checkout`)
**Chi legge:** App Web (report ordini, gestione spedizioni)
**Chiave usata:** `user_id`

---

### 3.15 QUIZ E FORMAZIONE

#### `quiz_results` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `quiz_id`            | UUID      | FK verso `quizzes`                           |
| `score`              | INT       | punteggio                                    |
| `passed`             | BOOL      | superato                                     |
| `points_earned`      | INT       |                                              |

#### `user_training_progress` (gestita da app mobile)

Progresso formativo per ogni contenuto.

#### `certificates` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `title`              | TEXT      |                                              |
| `description`        | TEXT      |                                              |
| `image_url`          | TEXT      |                                              |
| `earned_at`          | TIMESTAMPTZ |                                            |
| `expires_at`         | TIMESTAMPTZ |                                            |

**Chi scrive:** App Mobile (quiz completati, progressi formazione)
**Chi legge:** App Web (KPI formazione, compliance)
**Chiave usata:** `user_id`
**Nota:** `certificates` (app mobile, per `user_id`) e' separata da `attestati` (app web, per `lavoratore_id`). Sono due cose diverse che andrebbero unificate.

---

### 3.16 WELLNESS E SURVEY

#### `wellness_checkins` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `azienda_id`         | UUID      |                                              |
| `rating`             | SMALLINT  | valutazione benessere (1-5)                  |
| `notes`              | TEXT      |                                              |
| `points_earned`      | INT       |                                              |
| `checkin_date`       | DATE      |                                              |

#### `vow_surveys` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `azienda_id`         | UUID      |                                              |
| `reparto_id`         | UUID      |                                              |
| `answers`            | JSONB     | risposte al questionario                     |
| `average_rating`     | FLOAT     | media risposte                               |

**Chi scrive:** App Mobile
**Chi legge:** App Web (analytics benessere, KPI aziendale)
**Chiave usata:** `user_id`

---

### 3.17 SFIDE E SOCIAL

#### `challenges` (gestita da app web)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `title`              | TEXT      |                                              |
| `description`        | TEXT      |                                              |
| `target_points`      | INT       | obiettivo punti                              |
| `current_points`     | INT       | punti attuali                                |
| `bonus_points`       | INT       | bonus al completamento                       |
| `company_name`       | TEXT      |                                              |
| `deadline`           | TIMESTAMPTZ |                                            |
| `is_completed`       | BOOL      |                                              |
| `azienda_id`         | UUID      |                                              |

#### `challenge_contributions` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `challenge_id`       | UUID      | FK verso `challenges`                        |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `points`             | INT       | punti contribuiti                            |

#### `safety_nominations` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `nominator_id`       | UUID      | FK verso `auth.users` — chi nomina           |
| `nominee_id`         | UUID      | FK verso `auth.users` — chi viene nominato   |
| `azienda_id`         | UUID      |                                              |
| `motivation`         | TEXT      |                                              |
| `nominator_points`   | INT       | punti a chi nomina                           |
| `nominee_points`     | INT       | punti a chi riceve                           |

**Chi scrive sfide:** App Web (crea sfide)
**Chi contribuisce:** App Mobile (contributi individuali, nomine)
**Chiave usata:** `user_id`

---

### 3.18 TEAM / SOCIAL FEED

#### `social_posts` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users` — autore               |
| `image_url`          | TEXT      | immagine allegata                            |
| `thumbnail_url`      | TEXT      | miniatura                                    |
| `caption`            | TEXT      | testo del post                               |
| `author_name`        | TEXT      | nome autore (denormalizzato)                 |
| `aspect_ratio`       | FLOAT     | ratio immagine                               |
| `likes_count`        | INT       | contatore like                               |
| `comments_count`     | INT       | contatore commenti                           |
| `azienda_id`         | UUID      | FK verso `aziende`                           |

#### `social_likes` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `user_id`            | UUID      | FK verso `auth.users` — chi mette like       |
| `post_id`            | UUID      | FK verso `social_posts`                      |

> PK composita su `(user_id, post_id)` — un like per utente per post.

#### `social_comments` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `post_id`            | UUID      | FK verso `social_posts`                      |
| `user_id`            | UUID      | FK verso `auth.users` — autore commento      |
| `content`            | TEXT      | testo commento                               |
| `points_earned`      | INT       | punti guadagnati per il commento             |

**Chi scrive:** App Mobile (post, like, commenti)
**Chi legge:** App Mobile (feed sociale), App Web (moderazione, analytics)
**Chiave usata:** `user_id`
**Nota:** Il feed e' filtrato per `azienda_id` — i lavoratori vedono solo i post della propria azienda. Il concetto di "team" nell'app corrisponde ai colleghi della stessa azienda (non esiste una tabella `teams` separata).

**RPC `get_social_feed`:** ritorna post ordinati per data con `liked_by_me` booleano.
**RPC `toggle_social_like`:** aggiunge/rimuove like su un post.

---

### 3.19 LEADERBOARD / CLASSIFICA

Non esiste una tabella dedicata. La classifica e' calcolata al volo dalla RPC.

**RPC `get_leaderboard(p_limit)`:** classifica per `punti_elmetto` DESC tra tutti gli `user_profiles` della stessa `azienda_id` dell'utente corrente. Ritorna: rank, name, points, is_current_user, avatar_url.

**Chi scrive:** nessuno (calcolata al volo da `user_profiles.punti_elmetto`)
**Chi legge:** App Mobile (tab Team / classifica)
**Chiave usata:** `user_id` (filtra per `azienda_id` del chiamante)
**Nota:** La classifica e' per azienda. Non c'e' classifica per reparto o mansione (servirebbe `lavoratore_id` per avere il `reparto_id`).

---

### 3.20 RUOTA PREMI

#### `wheel_prizes` (catalogo premi ruota)

Catalogo premi disponibili nella ruota. Non legata a un utente specifico.

#### `user_spins` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `spin_date`          | DATE      | giorno dello spin                            |
| `prize_id`           | UUID      | FK verso `wheel_prizes` (nullable)           |
| `points_won`         | INT       | punti vinti                                  |

**Chi scrive:** App Mobile (RPC `spin_wheel`)
**Chi legge:** App Mobile, App Web (analytics gamification)
**Chiave usata:** `user_id`

**RPC `get_today_spin`:** controlla se l'utente ha gia' girato oggi.
**RPC `spin_wheel`:** esegue lo spin e assegna premio/punti.

---

### 3.21 VOUCHER

#### `vouchers` (gestita da app mobile)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `code`               | TEXT      | codice voucher                               |
| `product_name`       | TEXT      | nome prodotto/servizio                       |
| `value_eur`          | FLOAT     | valore in euro                               |
| `barcode`            | TEXT      | codice a barre                               |
| `is_used`            | BOOL      | gia' utilizzato                              |
| `issued_at`          | TIMESTAMPTZ | quando emesso                              |
| `expires_at`         | TIMESTAMPTZ | scadenza                                   |

**Chi scrive:** Sistema (emette voucher dopo acquisto/riscatto)
**Chi legge:** App Mobile (i miei voucher), App Web (report)
**Chiave usata:** `user_id`

**RPC `get_my_vouchers`:** ritorna i voucher dell'utente corrente.

---

### 3.22 REWARDS (catalogo premi)

#### `rewards` (catalogo)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `name`               | TEXT      | nome premio                                  |
| `description`        | TEXT      | descrizione                                  |
| `cost`               | INT       | costo in punti                               |
| `category`           | VARCHAR   | categoria premio                             |
| `availability`       | VARCHAR   | disponibilita                                |
| `icon`               | TEXT      | icona                                        |
| `image_url`          | TEXT      | immagine                                     |
| `delivery_info`      | TEXT      | info consegna                                |
| `is_active`          | BOOL      |                                              |

**Chi scrive:** App Web / Sistema (gestione catalogo premi)
**Chi legge:** App Mobile (catalogo premi riscattabili)
**Chiave usata:** nessuna (catalogo globale)

---

### 3.23 SAFETY SCORE HISTORY

#### `safety_score_history` (gestita dal sistema)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users`                        |
| `azienda_id`         | UUID      |                                              |
| `score`              | INT       | punteggio sicurezza                          |
| `score_date`         | DATE      | data del punteggio                           |

**Chi scrive:** Sistema (calcolo periodico)
**Chi legge:** App Mobile (grafico evoluzione), App Web (KPI)
**Chiave usata:** `user_id`

---

### 3.24 NOTIFICHE

#### `notifications` (gestita da entrambe)

| Colonna              | Tipo      | Note                                         |
|:---------------------|:----------|:---------------------------------------------|
| `id`                 | UUID      | PK                                           |
| `user_id`            | UUID      | FK verso `auth.users` — destinatario         |
| `azienda_id`         | UUID      |                                              |
| `tipo`               | TEXT      | tipo notifica                                |
| `priorita`           | TEXT      | `bassa` / `media` / `alta` / `critica`       |
| `canale`             | TEXT      | `in_app` / `email` / `push`                  |
| `stato`              | TEXT      | `non_letta` / `letta` / `archiviata`         |
| `titolo`             | TEXT      |                                              |
| `messaggio`          | TEXT      |                                              |
| `modulo`             | TEXT      | modulo di origine                            |
| `entita_id`          | UUID      | ID entita collegata                          |
| `entita_tipo`        | TEXT      | tipo entita collegata                        |
| `route`              | TEXT      | route per navigazione                        |
| `data_lettura`       | TIMESTAMPTZ |                                            |
| `data_scadenza`      | TIMESTAMPTZ |                                            |

**Chi scrive:** App Web (notifiche scadenze, visite, DPI), Sistema (automatiche)
**Chi legge/aggiorna:** App Mobile (mostra, segna come letta)
**Chiave usata:** `user_id`

---

## 4. Riepilogo chiavi di collegamento

### Tabelle che usano `user_id` (auth.uid)

| Tabella                    | Accesso App Mobile | Accesso App Web | Stato       |
|:---------------------------|:------------------:|:---------------:|:------------|
| `user_profiles`            | lettura/scrittura  | lettura         | OK          |
| `shift_checkins`           | scrittura          | lettura         | OK          |
| `streaks`                  | scrittura          | lettura         | OK          |
| `streak_calendar`          | scrittura          | lettura         | OK          |
| `points_transactions`      | scrittura          | lettura         | OK          |
| `safety_reports`           | scrittura          | lettura/update  | OK          |
| `sos_emergencies`          | scrittura          | lettura/update  | OK          |
| `orders`                   | scrittura          | lettura         | OK          |
| `quiz_results`             | scrittura          | lettura         | OK          |
| `user_training_progress`   | scrittura          | lettura         | OK          |
| `certificates`             | scrittura          | lettura         | OK          |
| `wellness_checkins`        | scrittura          | lettura         | OK          |
| `vow_surveys`              | scrittura          | lettura         | OK          |
| `challenge_contributions`  | scrittura          | lettura         | OK          |
| `safety_nominations`       | scrittura          | lettura         | OK          |
| `social_posts`             | scrittura          | lettura         | OK          |
| `social_likes`             | scrittura          | —               | OK          |
| `social_comments`          | scrittura          | lettura         | OK          |
| `user_spins`               | scrittura          | lettura         | OK          |
| `vouchers`                 | lettura            | lettura         | OK          |
| `safety_score_history`     | lettura            | lettura         | OK          |
| `notifications`            | lettura/update     | scrittura       | OK          |
| `emergency_contacts`       | lettura/scrittura  | scrittura       | OK          |

### Tabelle catalogo (nessuna chiave utente)

| Tabella                    | Accesso App Mobile | Accesso App Web | Stato       |
|:---------------------------|:------------------:|:---------------:|:------------|
| `challenges`               | lettura            | CRUD completo   | OK          |
| `rewards`                  | lettura            | CRUD completo   | OK          |
| `wheel_prizes`             | lettura            | CRUD completo   | OK          |

### Tabelle che usano `lavoratore_id`

| Tabella                    | Accesso App Web    | Accesso App Mobile  | Stato              |
|:---------------------------|:------------------:|:-------------------:|:-------------------|
| `lavoratori`               | CRUD completo      | readonly            | **BLOCCATO** (lavoratore_id NULL) |
| `turni` (via lavoratori)   | CRUD completo      | readonly            | **BLOCCATO**       |
| `dpi_assegnazioni`         | CRUD completo      | readonly            | **BLOCCATO**       |
| `dpi_consegne`             | CRUD completo      | readonly            | **BLOCCATO**       |
| `dpi_verifiche`            | CRUD completo      | readonly            | **BLOCCATO**       |
| `attestati`                | CRUD completo      | readonly            | **BLOCCATO**       |
| `visite_mediche`           | CRUD completo      | readonly            | **BLOCCATO**       |
| `giudizi_idoneita`         | CRUD completo      | readonly            | **BLOCCATO**       |
| `infortuni`                | CRUD completo      | readonly            | **BLOCCATO**       |
| `fabbisogni_formativi`     | CRUD completo      | readonly (indiretto)| **BLOCCATO**       |
| `mansioni` (via lavoratori)| CRUD completo      | readonly            | **BLOCCATO**       |
| `reparti` (via lavoratori) | CRUD completo      | readonly            | **BLOCCATO**       |

---

## 5. Duplicazioni da risolvere

| Dato                | App Mobile (`user_id`)           | App Web (`lavoratore_id`)        | Problema                         |
|:--------------------|:---------------------------------|:---------------------------------|:---------------------------------|
| Nome / Cognome      | `user_profiles.nome/cognome`     | `lavoratori.nome/cognome`        | Duplicato, rischio disallineamento |
| Email               | `user_profiles.email`            | `lavoratori.email`               | Duplicato                        |
| Azienda             | `user_profiles.azienda_id`       | `lavoratori.azienda_id`          | Duplicato                        |
| Categoria           | `user_profiles.category`         | `lavoratori.ruolo_sicurezza`     | Nomi diversi, semantica simile   |
| Certificati         | `certificates` (per `user_id`)   | `attestati` (per `lavoratore_id`)| Due tabelle separate per lo stesso concetto |
| Reparto             | —                                | `lavoratori.reparto_id`          | Manca lato mobile                |
| Mansione            | —                                | `lavoratori.mansione_id`         | Manca lato mobile                |
| Turno               | —                                | `lavoratori.turno_id`            | Manca lato mobile                |
| Matricola           | —                                | `lavoratori.matricola`           | Manca lato mobile                |

---

## 6. Opzioni di collegamento

### Opzione A — Popolare `lavoratore_id` (CONSIGLIATA)

La colonna `user_profiles.lavoratore_id` esiste gia'. Basta:

1. Nell'app web, aggiungere un campo "Utente app" al form lavoratore (dropdown o email match)
2. Quando il consulente/HR associa un utente, fare `UPDATE user_profiles SET lavoratore_id = <lavoratore.id>`
3. Nell'app mobile, tutte le RPC fanno JOIN con `lavoratori` via `lavoratore_id`

Pro:
- Nessuna modifica allo schema DB
- Single source of truth per anagrafica (app web)
- L'app mobile diventa una "vista" dei dati gestiti dall'app web

Contro:
- Serve intervento nell'app web (nuovo campo nel form)
- Se l'HR non associa l'utente, restano bloccati tutti i dati `lavoratore_id`

### Opzione B — Match automatico per email (ibrida)

Trigger o RPC che al login:
1. Cerca in `lavoratori` un record con stessa `email`
2. Se trovato, popola `user_profiles.lavoratore_id` automaticamente

Pro: zero lavoro manuale per HR, retroattivo
Contro: email potrebbe non coincidere, duplicati possibili

### Opzione C — Duplicare `turno_id` su `user_profiles` (NON consigliata)

Aggiungere colonne replicate su `user_profiles`. Causa disallineamento permanente.

---

## 7. Impatto del collegamento su ogni feature

Una volta che `user_profiles.lavoratore_id` e' popolato, l'app mobile sblocca:

| Feature App Mobile              | Cosa si sblocca                                          |
|:--------------------------------|:---------------------------------------------------------|
| **Check-in turno**              | Vincolo orario basato su `turni.ora_inizio`              |
| **DPI check-in**                | Lista DPI reali da `dpi_assegnazioni` invece che generici |
| **Profilo**                     | Matricola, mansione, reparto, turno dal record anagrafica |
| **Attestati**                   | Lista certificazioni da `attestati` con scadenze reali   |
| **Visite mediche**              | Prossima visita, storico, promemoria                     |
| **Idoneita**                    | Stato idoneita attuale, limitazioni, prescrizioni        |
| **Infortuni**                   | Storico infortuni personali                              |
| **Formazione obbligatoria**     | Gap formativi reali da `fabbisogni_formativi` + `attestati` |
| **Notifiche smart**             | Scadenze DPI, visite, attestati basate su dati reali     |
| **Analytics web**               | Collegamento bidirezionale per report completi           |

---

## 8. Azioni necessarie

| #   | Dove         | Azione                                                                          | Priorita |
|:---:|:-------------|:--------------------------------------------------------------------------------|:--------:|
| 1   | DB           | RPC `link_worker_profile(p_user_id, p_lavoratore_id)` per collegare i record    | ALTA     |
| 2   | App Web      | Campo "Utente App" nel form lavoratore (dropdown / email match)                 | ALTA     |
| 3   | DB           | Aggiornare RPC `get_my_profile` con JOIN `lavoratori` + `turni` + `mansioni` + `reparti` | ALTA     |
| 4   | App Mobile   | Aggiornare modello `UserProfile` con campi da anagrafica                        | ALTA     |
| 5   | DB           | Aggiornare RPC `process_checkin` con vincolo finestra oraria turno              | MEDIA    |
| 6   | DB           | Nuova RPC `get_my_dpi` che legge `dpi_assegnazioni` via `lavoratore_id`         | MEDIA    |
| 7   | DB           | Nuova RPC `get_my_attestati` che legge `attestati` via `lavoratore_id`          | MEDIA    |
| 8   | DB           | Nuova RPC `get_my_visite` che legge `visite_mediche` via `lavoratore_id`        | MEDIA    |
| 9   | App Mobile   | UI check-in turno con vincolo orario                                            | MEDIA    |
| 10  | App Mobile   | Sezione profilo con attestati, DPI, visite, idoneita                            | BASSA    |
| 11  | App Mobile   | Home card "Il tuo turno oggi" + prossima visita + DPI in scadenza               | BASSA    |

---

## 9. Note tecniche

- **Turno notturno** (22:00-06:00): la finestra di check-in attraversa la mezzanotte, serve logica speciale
- **`shift_checkins` UNIQUE** su `(user_id, checkin_date)` = max 1 check-in al giorno
- **`certificates` vs `attestati`**: sono due tabelle separate (una per `user_id`, l'altra per `lavoratore_id`). A lungo termine andrebbero unificate
- **`lavoratori` non ha `user_id`**: il collegamento e' unidirezionale (`user_profiles.lavoratore_id` -> `lavoratori.id`)
- **RLS:** tutte le nuove RPC devono usare `auth.uid()` per recuperare `lavoratore_id` da `user_profiles`, mai passarlo come parametro
- **`user_aziende`** collega gia' utenti auth ad aziende con ruolo — puo' servire come fallback per match automatico
