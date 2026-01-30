-- Migration: 005_training_quiz
-- Tabelle e RPC per formazione, quiz e certificati.
-- Applicata via Supabase MCP in 2 migrazioni:
--   - create_training_quiz_tables
--   - create_training_quiz_rpc_functions

-- ============================================================
-- TABELLE
-- ============================================================

-- training_contents: contenuti formativi (video, pdf, quiz, lesson)
--   title, description, type, category, duration_minutes, points,
--   is_mandatory, content_url, thumbnail_url

-- user_training_progress: progresso utente su contenuti
--   user_id, content_id (UNIQUE), status, progress, is_favorite,
--   started_at, completed_at

-- quizzes: quiz disponibili
--   title, description, points, category, estimated_minutes,
--   max_attempts, passing_score, is_active

-- quiz_questions: domande quiz
--   quiz_id, text, options (JSONB), correct_index, explanation, sort_order

-- quiz_results: risultati quiz utente
--   user_id, quiz_id, total_questions, correct_answers, answers (INT[]),
--   earned_points, completed_at

-- certificates: certificati ottenuti
--   user_id, title, description, image_url, earned_at, expires_at

-- ============================================================
-- RPC FUNCTIONS
-- ============================================================

-- get_training_contents(p_category?)
--   → lista contenuti con progresso utente (JOIN user_training_progress)
--   → ordinati: obbligatori prima, poi per data creazione
--
-- update_training_progress(p_content_id, p_status, p_progress, p_is_favorite?)
--   → upsert progresso (INSERT ON CONFLICT UPDATE)
--   → se status='completed', assegna punti via award_points()
--
-- get_quizzes(p_category?)
--   → lista quiz attivi con domande (subquery quiz_questions)
--   → include attempts_used per utente
--
-- submit_quiz_result(p_quiz_id, p_answers)
--   → verifica max tentativi, conta risposte corrette
--   → se superato (score >= passing_score), assegna punti via award_points()
--   → salva risultato in quiz_results
--
-- get_my_training_progress()
--   → riepilogo: total_modules, completed_modules, in_progress_modules,
--     certificates[]
--
-- get_my_quiz_results(p_limit, p_offset)
--   → storico risultati quiz dell'utente (più recenti prima)
