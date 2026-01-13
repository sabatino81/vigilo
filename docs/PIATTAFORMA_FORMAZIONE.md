# Piattaforma Formazione Vigilo

> Specifica tecnica per la piattaforma e-learning dedicata ai Partner (Formatori, RSPP, Enti di Formazione)

---

## Executive Summary

La **Piattaforma Formazione Vigilo** è un LMS (Learning Management System) **gratuito** per i Partner, progettato per:

- Erogare formazione D.Lgs. 81/2008 in modalità e-learning e videoconferenza
- Rispettare i requisiti dell'**Accordo Stato-Regioni 17 aprile 2025**
- Integrarsi con l'ecosistema Vigilo (gamification, IoT, monitoraggio)
- Offrire ai Partner uno strumento **white-label** per differenziarsi

### Valore per il Partner

| Aspetto | Piattaforme Tradizionali | Vigilo |
|---------|--------------------------|--------|
| Costo LMS | €3.000-15.000/anno | **GRATIS** |
| Attestati | Brand dell'ente terzo | **Brand del Partner** |
| Margine formazione | 30-50% | **100%** |
| Differenziazione | Corsi standard | **IoT + Gamification** |
| Revenue aggiuntivo | Nessuno | **Royalty €72/operaio/anno** |

---

## Requisiti Normativi (Accordo Stato-Regioni 2025)

### Requisiti E-Learning (Allegato A - Parte IV - Punto 3.3.2)

| Requisito | Implementazione Vigilo |
|-----------|------------------------|
| **LMS conforme** | Piattaforma proprietaria con tracciamento SCORM |
| **Tracciamento continuo** | Log accessi, tempi, progressi, completamenti |
| **Tutor di contenuto** | Docente qualificato associato ad ogni corso |
| **Tutor di processo** | Supporto tecnico Vigilo incluso |
| **Test intermedi/finali** | Quiz builder con punteggio minimo configurabile |
| **Documento progettuale** | Template generato automaticamente |
| **Rilevazione gradimento** | Survey fine corso obbligatoria |
| **No smartphone** | Blocco accesso da mobile per corsi certificativi |

### Requisiti Videoconferenza (Allegato A - Parte IV - Punto 3.2.3)

| Requisito | Implementazione Vigilo |
|-----------|------------------------|
| **Max 30 partecipanti** | Limite configurabile per sessione |
| **Tracciamento presenze** | Log accessi, orari, abbandoni |
| **No smartphone** | Solo PC/tablet |
| **Verifica comprensione** | Test in itinere obbligatori |
| **Registrazione sessione** | Opzionale, con consenso |

### Corsi Erogabili in E-Learning (D.Lgs. 81/2008)

| Corso | Modalità | Durata | Note |
|-------|----------|--------|------|
| Formazione Generale Lavoratori | ✅ E-learning | 4 ore | |
| Formazione Specifica Rischio Basso | ✅ E-learning | 4 ore | |
| Formazione Specifica Rischio Medio/Alto | ⚠️ Blended | 8-12 ore | Parte pratica in presenza |
| Aggiornamento Lavoratori | ✅ E-learning | 6 ore (5 anni) | |
| Preposti | ⚠️ Blended | 8 ore | Modulo pratico in presenza |
| Aggiornamento Preposti | ✅ E-learning | 6 ore (2 anni) | |
| Dirigenti | ✅ E-learning | 16 ore | |
| RSPP Modulo A | ✅ E-learning | 28 ore | |
| RSPP Modulo B | ⚠️ Blended | Variabile | Settore specifico |
| RSPP Modulo C | ✅ E-learning | 24 ore | |

---

## Architettura Piattaforma

### Stack Tecnologico

| Componente | Tecnologia | Note |
|------------|------------|------|
| **Frontend Web** | React / Next.js | Dashboard Partner + Area Corsisti |
| **Backend** | Node.js / Supabase | API REST + Realtime |
| **Database** | PostgreSQL (Supabase) | Multi-tenant |
| **Storage** | Supabase Storage / S3 | Video, PDF, documenti |
| **Video Streaming** | Mux / Cloudflare Stream | HLS adaptive |
| **Videoconferenza** | Jitsi / Daily.co | Self-hosted o SaaS |
| **SCORM Engine** | Rustici / custom | Tracciamento standard |
| **Certificati** | PDF con firma digitale | Template personalizzabili |
| **Analytics** | Mixpanel / PostHog | Metriche engagement |

### Architettura Multi-Tenant

```
┌─────────────────────────────────────────────────────────────────┐
│                     VIGILO CLOUD                                │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│   ┌─────────────┐   ┌─────────────┐   ┌─────────────┐          │
│   │  Partner A  │   │  Partner B  │   │  Partner C  │          │
│   │  (RSPP)     │   │  (Ente)     │   │  (Formatore)│          │
│   ├─────────────┤   ├─────────────┤   ├─────────────┤          │
│   │ • Corsi     │   │ • Corsi     │   │ • Corsi     │          │
│   │ • Corsisti  │   │ • Corsisti  │   │ • Corsisti  │          │
│   │ • Attestati │   │ • Attestati │   │ • Attestati │          │
│   │ • Brand     │   │ • Brand     │   │ • Brand     │          │
│   └─────────────┘   └─────────────┘   └─────────────┘          │
│           │                 │                 │                 │
│           ▼                 ▼                 ▼                 │
│   ┌─────────────────────────────────────────────────────────┐  │
│   │              DATABASE CONDIVISO (Supabase)              │  │
│   │  Row Level Security (RLS) per isolamento dati          │  │
│   └─────────────────────────────────────────────────────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Moduli Funzionali

### 1. CMS Corsi (Content Management System)

#### Funzionalità

| Funzione | Descrizione |
|----------|-------------|
| **Upload contenuti** | Video (MP4, max 2GB), PDF, SCORM, slide |
| **Editor lezioni** | Struttura modulare con capitoli e sezioni |
| **Tipologie contenuto** | Video, PDF, testo HTML, quiz, SCORM |
| **Ordinamento** | Drag & drop per riordinare moduli |
| **Prerequisiti** | Blocco sezioni fino a completamento precedenti |
| **Durata minima** | Tempo minimo di visualizzazione per validità |
| **Preview** | Anteprima corso lato corsista |

#### Modello Dati

```typescript
interface Course {
  id: string;
  partnerId: string;           // Proprietario del corso
  title: string;
  description: string;
  category: CourseCategory;    // D.Lgs. 81/2008 category
  duration: number;            // Durata in minuti
  validityMonths: number;      // Validità attestato (es. 60 mesi)
  passingScore: number;        // Punteggio minimo quiz (es. 70%)
  maxAttempts: number;         // Tentativi quiz
  isMandatory: boolean;
  isPublished: boolean;
  thumbnail: string;
  modules: Module[];
  createdAt: Date;
  updatedAt: Date;
}

interface Module {
  id: string;
  courseId: string;
  title: string;
  order: number;
  sections: Section[];
}

interface Section {
  id: string;
  moduleId: string;
  title: string;
  type: 'video' | 'pdf' | 'text' | 'quiz' | 'scorm';
  content: string;             // URL o contenuto
  duration: number;            // Durata minima (minuti)
  order: number;
  isRequired: boolean;
}
```

---

### 2. Quiz Builder

#### Funzionalità

| Funzione | Descrizione |
|----------|-------------|
| **Tipi domanda** | Scelta singola, multipla, vero/falso, completamento |
| **Randomizzazione** | Ordine domande e risposte casuale |
| **Punteggio** | Peso per domanda, punteggio minimo configurabile |
| **Tentativi** | Numero max tentativi, cooldown tra tentativi |
| **Feedback** | Risposta corretta mostrata dopo tentativo |
| **Timer** | Tempo massimo per completare il quiz |
| **Domande da pool** | Estrazione casuale da banco domande |

#### Modello Dati

```typescript
interface Quiz {
  id: string;
  courseId: string;
  title: string;
  description: string;
  passingScore: number;        // 0-100
  maxAttempts: number;
  timeLimitMinutes: number;
  randomizeQuestions: boolean;
  randomizeAnswers: boolean;
  showCorrectAnswers: boolean;
  questionsFromPool: number;   // 0 = tutte, N = estrai N domande
  questions: Question[];
}

interface Question {
  id: string;
  quizId: string;
  type: 'single' | 'multiple' | 'boolean' | 'fill';
  text: string;
  image?: string;
  points: number;
  order: number;
  answers: Answer[];
}

interface Answer {
  id: string;
  questionId: string;
  text: string;
  isCorrect: boolean;
  order: number;
}
```

---

### 3. Tracciamento SCORM

#### Requisiti Tracciamento (Accordo 2025)

| Dato | Descrizione | Retention |
|------|-------------|-----------|
| **cmi.core.student_id** | ID corsista (pseudonimizzato) | 5 anni |
| **cmi.core.lesson_status** | Stato: incomplete, completed, passed, failed | 5 anni |
| **cmi.core.session_time** | Tempo sessione corrente | 5 anni |
| **cmi.core.total_time** | Tempo totale cumulativo | 5 anni |
| **cmi.core.score.raw** | Punteggio quiz | 5 anni |
| **cmi.suspend_data** | Stato di avanzamento | 30 giorni |
| **Timestamp accessi** | Login/logout con IP (anonimizzato) | 5 anni |

#### Log di Tracciamento

```typescript
interface LearningLog {
  id: string;
  enrollmentId: string;
  sectionId: string;
  action: 'start' | 'progress' | 'complete' | 'pause' | 'resume';
  timestamp: Date;
  duration: number;            // Secondi
  progress: number;            // 0-100
  metadata: {
    userAgent: string;
    screenSize: string;
    ipHash: string;            // Hash IP per privacy
  };
}
```

---

### 4. Generatore Certificati

#### Funzionalità

| Funzione | Descrizione |
|----------|-------------|
| **Template personalizzabili** | Logo Partner, colori, layout |
| **Dati automatici** | Nome, corso, data, durata, punteggio |
| **Firma digitale** | PAdES o firma grafica |
| **QR code verifica** | Link a pagina verifica autenticità |
| **Numerazione** | Progressivo univoco |
| **Scadenza** | Data scadenza calcolata automaticamente |
| **Multi-lingua** | IT/EN |

#### Template Certificato

```
┌─────────────────────────────────────────────────────────────────┐
│                                                                 │
│   [LOGO PARTNER]                           [LOGO VIGILO]        │
│                                                                 │
│                      ATTESTATO DI FORMAZIONE                    │
│                                                                 │
│   Si certifica che                                              │
│                                                                 │
│                    [NOME COGNOME]                               │
│                    CF: [CODICE FISCALE]                         │
│                                                                 │
│   ha completato con esito positivo il corso:                    │
│                                                                 │
│        "[TITOLO CORSO]"                                         │
│                                                                 │
│   Durata: [X] ore                                               │
│   Data completamento: [DD/MM/YYYY]                              │
│   Punteggio: [XX]%                                              │
│   Validità: [DD/MM/YYYY]                                        │
│                                                                 │
│   Riferimento normativo: D.Lgs. 81/2008, art. 37               │
│   Accordo Stato-Regioni 17/04/2025                              │
│                                                                 │
│   N. Attestato: [PARTNER-ANNO-PROGRESSIVO]                      │
│                                                                 │
│   [FIRMA DIGITALE]                    [QR CODE VERIFICA]        │
│   Il Formatore                                                  │
│   [Nome Formatore]                                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

#### Modello Dati

```typescript
interface Certificate {
  id: string;
  number: string;              // ES: "RSPP001-2025-00123"
  partnerId: string;
  courseId: string;
  learnerId: string;
  learnerName: string;
  learnerFiscalCode: string;
  courseTitle: string;
  courseDuration: number;
  completedAt: Date;
  expiresAt: Date;
  score: number;
  pdfUrl: string;
  verificationUrl: string;
  signature: {
    type: 'digital' | 'graphic';
    signedBy: string;
    signedAt: Date;
  };
  status: 'valid' | 'expired' | 'revoked';
}
```

---

### 5. Dashboard Partner

#### Viste Disponibili

| Vista | Contenuto |
|-------|-----------|
| **Overview** | KPI: corsisti attivi, completamenti, revenue |
| **Corsi** | Lista corsi con stats (iscritti, completati, rating) |
| **Corsisti** | Anagrafica, progress, scadenze |
| **Aziende** | Clienti con operai assegnati |
| **Attestati** | Emessi, in scadenza, scaduti |
| **Calendario** | Sessioni videoconferenza programmate |
| **Report** | Export per audit, statistiche |

#### KPI Dashboard

| KPI | Descrizione | Calcolo |
|-----|-------------|---------|
| **Corsisti attivi** | Iscritti con attività negli ultimi 30gg | COUNT |
| **Completion rate** | Corsi completati / corsi iniziati | % |
| **Tempo medio** | Durata media per completare un corso | AVG |
| **Quiz pass rate** | Quiz superati al primo tentativo | % |
| **Attestati emessi** | Totale mese corrente | COUNT |
| **In scadenza** | Attestati che scadono nei prossimi 60gg | COUNT |
| **NPS** | Net Promoter Score dai survey | -100/+100 |
| **Revenue formazione** | Stimato da corsisti × prezzo medio | € |

---

### 6. Area Corsista (Learner Portal)

#### Funzionalità

| Funzione | Descrizione |
|----------|-------------|
| **I miei corsi** | Corsi assegnati, in corso, completati |
| **Progress** | Barra avanzamento per corso e modulo |
| **Player video** | Streaming HLS, no download, no skip |
| **Quiz** | Interfaccia test con timer |
| **Certificati** | Download PDF attestati |
| **Scadenze** | Alert corsi in scadenza |
| **Gamification** | Punti guadagnati per completamenti |

#### Player Video (Requisiti Anti-Skip)

| Controllo | Implementazione |
|-----------|-----------------|
| **No skip** | Barra progress disabilitata fino a fine video |
| **Pausa max** | Timeout dopo 5 min pausa → riprendi da checkpoint |
| **Focus detection** | Pausa se tab non attiva (opzionale) |
| **Watermark** | Nome corsista + timestamp su video |
| **No download** | DRM / HLS encryption |
| **Presenza** | Domande casuali durante video |

---

### 7. Videoconferenza Sincrona

#### Funzionalità

| Funzione | Descrizione |
|----------|-------------|
| **Scheduling** | Calendario con inviti email |
| **Waiting room** | Sala d'attesa con verifica identità |
| **Presenza** | Log automatico entrata/uscita |
| **Screen sharing** | Condivisione schermo docente |
| **Chat** | Messaggi testuali |
| **Alzata di mano** | Richiesta parola |
| **Poll** | Sondaggi in tempo reale |
| **Breakout rooms** | Sotto-gruppi per esercitazioni |
| **Registrazione** | Con consenso, per assenti giustificati |
| **Report presenze** | Export automatico post-sessione |

#### Modello Dati Sessione

```typescript
interface LiveSession {
  id: string;
  courseId: string;
  partnerId: string;
  title: string;
  scheduledAt: Date;
  duration: number;            // Minuti
  maxParticipants: number;     // Max 30
  instructor: {
    id: string;
    name: string;
    email: string;
  };
  meetingUrl: string;
  recordingEnabled: boolean;
  recordingUrl?: string;
  attendees: Attendee[];
  status: 'scheduled' | 'live' | 'completed' | 'cancelled';
}

interface Attendee {
  id: string;
  sessionId: string;
  learnerId: string;
  learnerName: string;
  joinedAt?: Date;
  leftAt?: Date;
  totalTime: number;           // Minuti
  attentionScore: number;      // 0-100 (da poll/interazioni)
  status: 'invited' | 'attended' | 'absent' | 'partial';
}
```

---

### 8. Integrazione Gamification Vigilo

#### Punti Formazione

| Azione | Punti | Note |
|--------|-------|------|
| **Completamento modulo** | +10 | Per ogni modulo |
| **Quiz superato (1° tentativo)** | +50 | Bonus primo tentativo |
| **Quiz superato (altri tentativi)** | +20 | |
| **Corso completato** | +100-200 | In base a durata |
| **Certificato ottenuto** | +50 | |
| **Streak 7 giorni** | +100 | 7 giorni consecutivi di studio |
| **Survey completato** | +10 | Feedback fine corso |

#### Badge Formazione

| Badge | Condizione |
|-------|------------|
| 🎓 **Studente Modello** | 5 corsi completati |
| 📚 **Divoratore di Corsi** | 10 corsi completati |
| ⚡ **Speed Learner** | Corso completato in <50% tempo medio |
| 🎯 **Perfezionista** | 3 quiz con 100% |
| 🔥 **Streak Master** | 30 giorni consecutivi |
| 🏆 **Top Learner** | #1 classifica formazione del mese |

---

## User Flows

### Flow 1: Partner Crea Corso

```
┌─────────────────────────────────────────────────────────────────┐
│  1. LOGIN PARTNER                                               │
│     └─► Dashboard Partner                                       │
│                                                                 │
│  2. CREA CORSO                                                  │
│     └─► Titolo, Categoria D.Lgs. 81, Durata, Validità          │
│     └─► Upload thumbnail                                        │
│                                                                 │
│  3. AGGIUNGI MODULI                                             │
│     └─► Modulo 1: "Introduzione"                               │
│         └─► Sezione 1: Video (upload MP4)                      │
│         └─► Sezione 2: PDF (upload documento)                  │
│         └─► Sezione 3: Quiz intermedio                         │
│     └─► Modulo 2: "Approfondimento"                            │
│         └─► ...                                                 │
│     └─► Modulo 3: "Verifica finale"                            │
│         └─► Quiz finale (punteggio minimo 70%)                 │
│                                                                 │
│  4. CONFIGURA ATTESTATO                                         │
│     └─► Template con logo Partner                              │
│     └─► Firma digitale o grafica                               │
│                                                                 │
│  5. PREVIEW & PUBBLICA                                          │
│     └─► Anteprima lato corsista                                │
│     └─► Pubblica corso                                         │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Flow 2: Corsista Completa Corso

```
┌─────────────────────────────────────────────────────────────────┐
│  1. ACCESSO                                                     │
│     └─► Login (credenziali o SSO aziendale)                    │
│     └─► Verifica dispositivo (no smartphone)                   │
│                                                                 │
│  2. I MIEI CORSI                                                │
│     └─► Vede corsi assegnati dall'azienda                      │
│     └─► Seleziona corso da completare                          │
│                                                                 │
│  3. FRUIZIONE CONTENUTI                                         │
│     └─► Video: guarda fino alla fine (no skip)                 │
│     └─► PDF: visualizza (tempo minimo)                         │
│     └─► Quiz intermedi: supera per proseguire                  │
│     └─► Domande presenza: risponde per confermare attenzione   │
│                                                                 │
│  4. QUIZ FINALE                                                 │
│     └─► Timer attivo                                           │
│     └─► Domande randomizzate                                   │
│     └─► Punteggio ≥ 70% → SUPERATO                            │
│     └─► Punteggio < 70% → Riprova (max tentativi)             │
│                                                                 │
│  5. CERTIFICATO                                                 │
│     └─► Generazione automatica PDF                             │
│     └─► Download + invio email                                 │
│     └─► +150 punti gamification                                │
│                                                                 │
│  6. FEEDBACK                                                    │
│     └─► Survey gradimento (obbligatorio)                       │
│     └─► +10 punti                                              │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### Flow 3: Azienda Assegna Formazione

```
┌─────────────────────────────────────────────────────────────────┐
│  1. RSPP/HR ACCEDE                                              │
│     └─► Dashboard Azienda (via Partner)                        │
│                                                                 │
│  2. SELEZIONA DIPENDENTI                                        │
│     └─► Lista operai dell'azienda                              │
│     └─► Filtra per reparto, mansione, scadenze                 │
│                                                                 │
│  3. ASSEGNA CORSI                                               │
│     └─► Seleziona corso/i obbligatori                          │
│     └─► Imposta deadline                                       │
│     └─► Invia notifica (email + push app Vigilo)               │
│                                                                 │
│  4. MONITORA PROGRESS                                           │
│     └─► Dashboard avanzamento per dipendente                   │
│     └─► Alert per ritardi                                      │
│     └─► Reminder automatici                                    │
│                                                                 │
│  5. REPORT COMPLIANCE                                           │
│     └─► Export attestati per audit                             │
│     └─► Allegati per DVR/POS                                   │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

---

## Integrazioni

### Integrazione App Vigilo (Mobile)

| Funzione | Descrizione |
|----------|-------------|
| **Tab Impara** | Accesso diretto ai corsi assegnati |
| **Notifiche** | Push per nuovi corsi, scadenze, reminder |
| **Punti** | Sincronizzazione punti gamification |
| **Certificati** | Visualizzazione in-app |
| **Deep link** | Apertura corso da notifica |

### Integrazione Dashboard COS/RSPP

| Funzione | Descrizione |
|----------|-------------|
| **Compliance view** | % formazione completata per cantiere |
| **Scadenze** | Alert operai con formazione scaduta |
| **Blocco accesso** | Integrazione con SiteAccessCard |
| **Report** | Export per DVR/POS |

### API Esterne

| API | Uso |
|-----|-----|
| **Webhook completamenti** | Notifica sistemi HR/ERP |
| **SSO SAML/OIDC** | Login aziendale |
| **Export SCORM** | Compatibilità altri LMS |
| **API attestati** | Verifica autenticità |

---

## Sicurezza e Privacy

### Autenticazione

| Metodo | Utente |
|--------|--------|
| Email + password | Partner, corsisti individuali |
| SSO SAML/OIDC | Aziende enterprise |
| Magic link | Corsisti senza password |
| MFA | Obbligatorio per Partner |

### Autorizzazioni (RBAC)

| Ruolo | Permessi |
|-------|----------|
| **Partner Admin** | CRUD corsi, corsisti, attestati, settings |
| **Partner Editor** | CRUD corsi, R corsisti |
| **Azienda Admin** | R corsi, CRUD assegnazioni, R report |
| **Corsista** | R propri corsi, R propri attestati |

### Privacy (GDPR)

| Requisito | Implementazione |
|-----------|-----------------|
| **Minimizzazione** | Solo dati necessari per formazione |
| **Consenso** | Informativa + accettazione T&C |
| **Retention** | Attestati 5 anni, log 2 anni |
| **Portabilità** | Export dati personali |
| **Cancellazione** | Right to be forgotten (con limiti legali) |
| **Pseudonimizzazione** | ID hashati nei log |

---

## Roadmap Implementazione

### Fase 1: MVP (3 mesi)

| Feature | Priorità | Effort |
|---------|----------|--------|
| CMS corsi base (video, PDF) | 🔴 Alta | 4 sett |
| Quiz builder | 🔴 Alta | 3 sett |
| Tracciamento base | 🔴 Alta | 2 sett |
| Generatore certificati | 🔴 Alta | 2 sett |
| Dashboard Partner | 🔴 Alta | 3 sett |
| Area corsista | 🔴 Alta | 3 sett |
| Integrazione punti Vigilo | 🟡 Media | 1 sett |

**Deliverable MVP:** Partner può creare corso, corsista può completarlo, attestato generato automaticamente.

### Fase 2: Compliance (2 mesi)

| Feature | Priorità | Effort |
|---------|----------|--------|
| SCORM engine completo | 🔴 Alta | 3 sett |
| Videoconferenza | 🔴 Alta | 4 sett |
| Report compliance | 🔴 Alta | 2 sett |
| Anti-skip video avanzato | 🟡 Media | 1 sett |
| Survey gradimento | 🟡 Media | 1 sett |

**Deliverable Fase 2:** Piattaforma conforme Accordo Stato-Regioni 2025.

### Fase 3: Scale (2 mesi)

| Feature | Priorità | Effort |
|---------|----------|--------|
| SSO enterprise | 🟡 Media | 2 sett |
| API pubbliche | 🟡 Media | 2 sett |
| White-label avanzato | 🟡 Media | 2 sett |
| Analytics avanzate | 🟢 Bassa | 2 sett |
| Mobile optimization | 🟢 Bassa | 2 sett |

**Deliverable Fase 3:** Piattaforma scalabile per 100+ Partner.

---

## Metriche di Successo

| KPI | Target MVP | Target 12 mesi |
|-----|------------|----------------|
| Partner attivi | 10 | 100 |
| Corsi creati | 50 | 500 |
| Corsisti attivi | 500 | 10.000 |
| Completamenti/mese | 200 | 5.000 |
| Attestati emessi | 200 | 5.000 |
| Uptime piattaforma | 99% | 99.9% |
| NPS Partner | >40 | >60 |
| Tempo medio completamento | <120% durata nominale | <110% |

---

## Appendice: Glossario

| Termine | Definizione |
|---------|-------------|
| **LMS** | Learning Management System - piattaforma e-learning |
| **SCORM** | Sharable Content Object Reference Model - standard tracciamento |
| **LCMS** | Learning Content Management System - LMS + authoring |
| **Blended** | Formazione mista online + presenza |
| **Asincrono** | E-learning fruibile in qualsiasi momento |
| **Sincrono** | Videoconferenza in tempo reale |
| **Partner** | Formatore/RSPP/Ente che usa la piattaforma |
| **Corsista** | Lavoratore che fruisce la formazione |

---

*Documento creato per Vigilo - Piattaforma Sicurezza sul Lavoro*

*© 2025 Vigilo*
