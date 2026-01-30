-- Migration: 001_user_profiles
-- Crea la tabella user_profiles, trigger auto-creazione su signup,
-- RLS policies e RPC functions per profilo utente.

-- =============================================================
-- TABELLA: user_profiles
-- =============================================================
CREATE TABLE IF NOT EXISTS public.user_profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  name TEXT NOT NULL DEFAULT '',
  email TEXT NOT NULL DEFAULT '',
  category TEXT NOT NULL DEFAULT 'operaio',
  trust_level TEXT NOT NULL DEFAULT 'base',
  safety_score INT NOT NULL DEFAULT 0,
  streak_days INT NOT NULL DEFAULT 0,
  reports_count INT NOT NULL DEFAULT 0,
  punti_elmetto INT NOT NULL DEFAULT 0,
  welfare_active BOOLEAN NOT NULL DEFAULT FALSE,
  company_name TEXT NOT NULL DEFAULT '',
  avatar_url TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- Commento tabella
COMMENT ON TABLE public.user_profiles IS
  'Profilo utente Vigilo. Creato automaticamente su signup.';

-- =============================================================
-- TRIGGER: aggiorna updated_at automaticamente
-- =============================================================
CREATE OR REPLACE FUNCTION public.update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_user_profiles_updated_at
  BEFORE UPDATE ON public.user_profiles
  FOR EACH ROW
  EXECUTE FUNCTION public.update_updated_at();

-- =============================================================
-- TRIGGER: auto-crea profilo su signup auth
-- =============================================================
CREATE OR REPLACE FUNCTION public.on_auth_user_created()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.user_profiles (id, email, name)
  VALUES (
    NEW.id,
    COALESCE(NEW.email, ''),
    COALESCE(NEW.raw_user_meta_data->>'name', '')
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER trg_on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW
  EXECUTE FUNCTION public.on_auth_user_created();

-- =============================================================
-- RLS: utente legge/modifica solo il proprio profilo
-- =============================================================
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can read own profile"
  ON public.user_profiles
  FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Users can update own profile"
  ON public.user_profiles
  FOR UPDATE
  USING (auth.uid() = id)
  WITH CHECK (auth.uid() = id);

-- =============================================================
-- RPC: get_my_profile()
-- Ritorna il profilo dell'utente corrente come JSON.
-- =============================================================
CREATE OR REPLACE FUNCTION public.get_my_profile()
RETURNS JSON AS $$
DECLARE
  result JSON;
BEGIN
  SELECT row_to_json(p) INTO result
  FROM public.user_profiles p
  WHERE p.id = auth.uid();

  IF result IS NULL THEN
    RAISE EXCEPTION 'Profile not found for user %', auth.uid();
  END IF;

  RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- =============================================================
-- RPC: update_my_profile(p_name, p_category, p_avatar_url)
-- Aggiorna i campi modificabili e ritorna il profilo aggiornato.
-- =============================================================
CREATE OR REPLACE FUNCTION public.update_my_profile(
  p_name TEXT DEFAULT NULL,
  p_category TEXT DEFAULT NULL,
  p_avatar_url TEXT DEFAULT NULL
)
RETURNS JSON AS $$
DECLARE
  result JSON;
BEGIN
  UPDATE public.user_profiles
  SET
    name = COALESCE(p_name, name),
    category = COALESCE(p_category, category),
    avatar_url = COALESCE(p_avatar_url, avatar_url)
  WHERE id = auth.uid();

  SELECT row_to_json(p) INTO result
  FROM public.user_profiles p
  WHERE p.id = auth.uid();

  RETURN result;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
