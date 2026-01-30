# Vigilo - Roadmap e Gap Analysis

> Pianificazione sviluppo e analisi delle funzionalità mancanti

---

## Roadmap Futura

### Completati ✅

| Feature | Stato | Note |
|---------|-------|------|
| Integrazione IoT sensori DPI | ✅ Completato | Piattaforma InSite |
| Dashboard supervisor web | ✅ Completato | insite.vct-me.com |
| Sistema casco-centrico | ✅ Completato | GSR/EDA, HRV, Tag DPI |
| Gamification completa | ✅ Completato | Punti, livelli, ruota |
| Formazione Partner | ✅ Completato | CMS, Quiz, Certificati |

### Priorità Alta 🔴 (Prossimo Sprint)

| Feature | Descrizione | Impatto |
|---------|-------------|---------|
| **Notifiche push real-time** | Alert critici, SOS, reminder DPI | Essenziale per sicurezza |
| **Modalità offline** | Cache locale, sync quando online | Cantieri senza rete |
| **Countdown SOS visivo** | Feedback durante hold-to-activate | UX critica |

### Priorità Media 🟡 (Q2)

| Feature | Descrizione | Impatto |
|---------|-------------|---------|
| Export report PDF | Report compliance per audit | Richiesto per DVR/POS |
| Calendario turni | Integrazione presenze/turni | Pianificazione |
| Notifiche preventive | Alert pre-scadenza formazione/DPI | Compliance |

### Priorità Bassa 🟢 (Q3-Q4)

| Feature | Descrizione | Impatto |
|---------|-------------|---------|
| Integrazione HR | Sync anagrafica dipendenti | Automazione |
| ML predizione rischi | Modelli predittivi su FI/ASI | Prevenzione avanzata |
| AR istruzioni sicurezza | Overlay procedure su camera | Innovazione |
| Multi-lingua aggiuntive | Francese, Tedesco, Spagnolo | Espansione DACH |

---

## Gap Analysis

### Funzionalità Critiche Mancanti

| Gap | Rischio | Mitigazione Attuale | Soluzione |
|-----|---------|---------------------|-----------|
| **Push notifications** | Alert non ricevuti | Polling manuale | Implementare FCM/APNs |
| **Offline mode** | App inutilizzabile senza rete | Nessuna | Cache locale + sync |
| **Biometric lock** | Accesso non autorizzato | Pin/password | Implementare local_auth |

### Miglioramenti UX Identificati

| Area | Problema | Soluzione Proposta |
|------|----------|-------------------|
| SOS Button | Nessun feedback durante hold | Countdown circolare 3s |
| DPI Status | Solo stato binario | Aggiungere % batteria, ultimo check |
| Training Progress | Progress poco visibile | Barra progress in card Home |
| Alert History | Non accessibile facilmente | Aggiungere tab "Storico" in SOS |

### Debito Tecnico

| Item | Priorità | Effort |
|------|----------|--------|
| ~~Test coverage < 50%~~ | ✅ Risolto | 221 unit test, copertura modelli >80% |
| Mancano test E2E | 🟡 Media | 1 sprint |
| Documentazione API incompleta | 🟡 Media | 1 settimana |
| Accessibilità (a11y) non testata | 🟢 Bassa | 1 sprint |

---

## Changelog

| Data | Versione | Modifiche |
|------|----------|-----------|
| 2025-01 | 1.0 | Roadmap iniziale estratta da PROGETTO.md |

---

**Documento correlato:** [PROGETTO.md](./PROGETTO.md)
