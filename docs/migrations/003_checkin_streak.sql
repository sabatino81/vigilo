-- Migration: 003_checkin_streak
-- Tabelle e RPC per check-in DPI giornaliero e streak continua.
-- Applicata via Supabase MCP in 2 migrazioni:
--   - create_checkin_streak_tables
--   - create_checkin_streak_rpc_functions

-- ============================================================
-- TABELLE
-- ============================================================

-- shift_checkins: check-in DPI giornaliero (1 per utente per giorno)
--   user_id, worker_category, checked_dpi_ids[], all_checked,
--   status (pending/completed), checkin_time, points_earned

-- streaks: tracking streak continua (1 riga per utente)
--   user_id (PK), current_days, best_streak, last_checkin_date

-- ============================================================
-- RPC FUNCTIONS
-- ============================================================

-- process_checkin(checked_dpi_ids[])
--   → upsert check-in + aggiorna streak + calcola moltiplicatore
--   → assegna punti (base 10 * multiplier) via award_points()
--   → aggiorna streak_days su user_profiles
--
-- get_today_checkin()
--   → stato check-in odierno (pending/completed, DPI selezionati)
--
-- get_my_streak()
--   → current_days, best_streak, calendar_days[] (mese corrente)

-- ============================================================
-- MOLTIPLICATORI STREAK
-- ============================================================
-- Fiammella (1-6 gg):   x1.0
-- Fuocherello (7-13):   x1.2
-- Falo (14-29):         x1.5
-- Incendio (30-59):     x2.0
-- Inferno (60+):        x3.0
