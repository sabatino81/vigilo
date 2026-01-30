-- Migration: 006_team_social
-- Tabelle e RPC per social, sfide team, VOW e notifiche.
-- Applicata via Supabase MCP in 2 migrazioni:
--   - create_team_social_tables
--   - create_team_social_rpc_functions_v2
-- Nota: tabella notifications pre-esisteva con colonne vigilo-web
--   (titolo, messaggio, tipo, stato, data_creazione, data_lettura).
--   Le RPC mappano queste colonne ai nomi mobile.

-- ============================================================
-- TABELLE
-- ============================================================

-- social_posts: post bacheca sociale aziendale
--   user_id, image_url, thumbnail_url, caption, author_name,
--   aspect_ratio, likes_count, comments_count

-- social_likes: like su post (PK composita user_id + post_id)

-- challenges: sfide team
--   title, description, target_points, current_points, bonus_points,
--   company_name, deadline, is_completed

-- challenge_contributions: contributi individuali
--   challenge_id, user_id (UNIQUE), points

-- vow_surveys: sondaggi Voice of Worker
--   user_id, answers (JSONB), average_rating

-- notifications: tabella pre-esistente (vigilo-web)
--   titolo, messaggio, tipo, stato, data_creazione, data_lettura

-- ============================================================
-- RPC FUNCTIONS
-- ============================================================

-- get_social_feed(p_limit, p_offset)
--   → post con liked_by_me per utente corrente
--
-- toggle_social_like(p_post_id)
--   → aggiunge/rimuove like + aggiorna likes_count
--
-- get_active_challenge()
--   → sfida attiva (deadline > now, !completed) con contributi ordinati
--
-- get_challenge_history(p_limit)
--   → storico sfide completate
--
-- submit_vow_survey(p_answers)
--   → salva sondaggio + assegna 15 punti via award_points()
--
-- get_my_notifications(p_limit, p_offset)
--   → notifiche utente (mappa titolo→title, messaggio→body, tipo→category)
--
-- mark_notification_read(p_notification_id)
--   → segna notifica come letta (data_lettura + stato='letta')
--
-- mark_all_notifications_read()
--   → segna tutte le notifiche non lette come lette
