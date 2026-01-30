-- Migration: 004_sos_reports
-- Tabelle e RPC per SOS, segnalazioni sicurezza e contatti emergenza.
-- Applicata via Supabase MCP in 2 migrazioni:
--   - create_sos_tables
--   - create_sos_rpc_functions

-- ============================================================
-- TABELLE
-- ============================================================

-- emergency_contacts: contatti emergenza (personali + aziendali)
--   user_id (NULL = aziendale), azienda_id, type, name, phone_number, email

-- safety_reports: segnalazioni sicurezza con codice univoco
--   user_id, report_code (PER/NM/INF/SUG-YYYY-NNNNN), type, description,
--   photo_urls[], lat/lng, location_name, contact_requested,
--   status (pending→underReview→inProgress→approved→closed),
--   rspp_notes, resolved_at, points_earned

-- report_code_seq: sequence per codici leggibili

-- ============================================================
-- RPC FUNCTIONS
-- ============================================================

-- submit_safety_report(type, description, location_name?, lat?, lng?, contact_requested?)
--   → genera codice (PER-2025-00001), inserisce report
--   → assegna punti variabili: imminentDanger=50, minorInjury=40,
--     nearMiss=30, improvement=20
--   → aggiorna reports_count su user_profiles
--
-- get_my_reports(limit, offset)
--   → storico segnalazioni dell'utente (più recenti prima)
--
-- get_my_emergency_contacts()
--   → contatti propri + contatti aziendali (user_id IS NULL)
