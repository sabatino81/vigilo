# Vigilo - Scoring Model

> Modello completo dei comportamenti misurabili, dati raccolti e punteggi

---

## Quadro Normativo di Riferimento

Il sistema di scoring deve rispettare tre normative fondamentali:

| Normativa                                       | Vincolo                                                                                                    | Impatto su Vigilo                                                                        |
|-------------------------------------------------|------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| **Art. 4 Statuto Lavoratori** (L. 300/1970)     | Monitoraggio ammesso solo per sicurezza, esigenze organizzative, tutela patrimonio. Mai per controllare attività lavorativa | Nessuna azione dell'app può essere usata per verificare se il dipendente sta lavorando   |
| **GDPR** (Reg. UE 2016/679)                     | Liceità, minimizzazione, trasparenza, DPIA per trattamenti ad alto rischio                                 | Informativa chiara, consenso dove necessario, dati minimi, valutazione impatto            |
| **D.Lgs. 81/2008**                              | Obbligo formazione sicurezza, obbligo segnalazione rischi, obbligo DPI                                     | La formazione via app è strumento di lavoro lecito (Art. 4 comma 2 Statuto)              |
| **Garante Privacy 2025**                         | Geolocalizzazione continua vietata. Sanzione €50K per tracking via app. Consenso lavoratore non sufficiente | No GPS continuo. GPS puntuale solo per emergenza/segnalazione                            |

### Principio fondamentale

Ogni azione che genera punti deve essere **volontaria** o **obbligatoria per legge** (formazione D.Lgs. 81). Nessun dato raccolto può essere usato per fini disciplinari o di controllo dell'attività lavorativa.

---

## I due canali di raccolta dati

### Canale 1 — Azioni volontarie del lavoratore

**Rischio privacy: NULLO**

Il lavoratore sceglie liberamente di compiere un'azione nell'app. Non c'è monitoraggio, non c'è controllo a distanza. È equivalente a compilare un modulo, postare su un social o rispondere a un sondaggio.

**Caratteristiche:**
- Nessun accordo sindacale necessario
- Nessuna DPIA specifica (dati non sensibili)
- Informativa privacy standard nell'app
- Il lavoratore può smettere in qualsiasi momento senza conseguenze

### Canale 2 — Formazione obbligatoria D.Lgs. 81

**Rischio privacy: BASSO**

La formazione sulla sicurezza è un obbligo di legge. L'app è uno strumento per erogarla. Tracciare completamento, score e certificazioni è lecito perché l'app è classificabile come **strumento di lavoro** ai sensi dell'Art. 4 comma 2 dello Statuto dei Lavoratori.

**Caratteristiche:**
- Nessun accordo sindacale se classificato come strumento di lavoro
- Informativa ai dipendenti obbligatoria
- Dati utilizzabili per compliance (ma NON per fini disciplinari diretti)
- L'azienda DEVE erogare formazione, il canale digitale è una modalità lecita

---

## Mappa completa dei comportamenti

### CANALE 1 — Azioni volontarie

#### 1.1 Check-in benessere (inizio turno)

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore apre l'app e risponde a "Come stai oggi?" con emoji/scala 1-5                                |
| **Dato raccolto**      | Livello benessere auto-dichiarato (1-5), timestamp, eventuali note testuali                                |
| **Dato per l'azienda** | Trend benessere aggregato per team/reparto/periodo. Pattern stagionali. Correlazione con near-miss         |
| **Frequenza**          | 1 volta al giorno (inizio turno)                                                                           |
| **Punti**              | **5**                                                                                                      |
| **Anti-abuse**         | Max 1 check-in per giorno calendario. Non richiede posizione                                               |
| **Canale privacy**     | Canale 1 — volontario                                                                                      |

#### 1.2 Feedback fine turno (VOW Survey)

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore risponde a 3-5 domande rapide su com'è andato il turno                                      |
| **Dato raccolto**      | Score per domanda (1-5), commento opzionale, timestamp                                                     |
| **Dato per l'azienda** | Sentiment medio per turno/reparto. Segnali precoci di problemi organizzativi. Correlazione turno-benessere |
| **Frequenza**          | 1 volta al giorno (fine turno)                                                                             |
| **Punti**              | **10**                                                                                                     |
| **Anti-abuse**         | Max 1 survey per giorno. Disponibile solo in finestra oraria (ultime 2h turno + 1h dopo)                   |
| **Domande tipo**       | "Ti sei sentito sicuro oggi?", "Hai avuto abbastanza pause?", "C'è stato qualcosa di pericoloso?", "Il team ha collaborato?", "Suggerimenti?" |
| **Canale privacy**     | Canale 1 — volontario                                                                                      |

#### 1.3 Segnalazione rischio / near-miss

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore segnala un pericolo, un quasi-incidente o un'osservazione di sicurezza                       |
| **Dato raccolto**      | Tipo segnalazione (pericolo imminente, near-miss, infortunio lieve, suggerimento miglioramento), descrizione testo (min 10 caratteri), foto opzionali, geotag puntuale (opzionale, solo al momento della segnalazione), area/reparto selezionato |
| **Dato per l'azienda** | Mappa rischi per area. Frequenza near-miss per tipologia. Trend temporali. Rapporto segnalazioni/incidenti (indicatore leading) |
| **Frequenza**          | Illimitata                                                                                                 |
| **Punti**              | **30** (suggerimento), **40** (near-miss), **50** (pericolo imminente)                                     |
| **Anti-abuse**         | Segnalazioni validate da referente aziendale. Punti erogati dopo validazione. Max 5 segnalazioni puntate al giorno per evitare spam. Score qualità crescente se segnalazioni risultano utili |
| **Geotag**             | GPS puntuale SOLO al momento del tap su "segnala". Non continuo. Lecito perché finalità = sicurezza sul lavoro. Il lavoratore può disattivare la localizzazione (segnalazione valida lo stesso senza geotag) |
| **Canale privacy**     | Canale 1 — volontario. Geotag = dato puntuale con finalità sicurezza                                      |

#### 1.4 Segnalazione SOS / emergenza

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore tiene premuto il pulsante SOS per 3 secondi. Si attiva procedura emergenza                   |
| **Dato raccolto**      | Timestamp, geolocalizzazione puntuale, contatti emergenza notificati, stato (attivo, preso in carico, risolto), note successive |
| **Dato per l'azienda** | Storico emergenze. Tempi di risposta. Distribuzione per area/orario. Analisi cause post-evento             |
| **Frequenza**          | Solo in emergenza reale                                                                                    |
| **Punti**              | **0** (non si incentiva l'emergenza)                                                                       |
| **Anti-abuse**         | Conferma in 2 step (hold + dialogo conferma). Attivazioni false tracciate                                  |
| **Geotag**             | GPS puntuale OBBLIGATORIO per emergenza. Base giuridica: sicurezza vita umana                              |
| **Canale privacy**     | Canale 1 — volontario, ma con base giuridica forte (interesse vitale, Art. 6.1.d GDPR)                    |

#### 1.5 Nomination Safety Star

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore nomina un collega che ha avuto un comportamento sicuro esemplare                              |
| **Dato raccolto**      | Nominato, motivazione (testo breve), timestamp                                                             |
| **Dato per l'azienda** | Chi viene riconosciuto come riferimento sicurezza. Network informale di leadership safety                  |
| **Frequenza**          | Max 1 nomination/settimana                                                                                 |
| **Punti**              | **15** (al nominante), **25** (al nominato)                                                                |
| **Anti-abuse**         | Non puoi nominare te stesso. Non puoi nominare la stessa persona 2 settimane di fila                      |
| **Canale privacy**     | Canale 1 — volontario                                                                                      |

#### 1.6 Social wall: post, commento, like

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore posta foto/testo, commenta o mette like a un post del team                                   |
| **Dato raccolto**      | Contenuto (testo/foto), interazioni, timestamp                                                             |
| **Dato per l'azienda** | Livello di coesione team. Temi ricorrenti. Engagement qualitativo                                          |
| **Frequenza**          | Illimitata                                                                                                 |
| **Punti**              | **5** (post con foto), **3** (commento), **1** (like)                                                      |
| **Anti-abuse**         | Max 30 punti/giorno da social. Moderazione contenuti automatica + manuale                                  |
| **Canale privacy**     | Canale 1 — volontario. Post visibili solo al proprio team/reparto                                          |

#### 1.7 Sfida team completata

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il team raggiunge l'obiettivo della sfida settimanale (es. "Zero incidenti", "100% check-in")              |
| **Dato raccolto**      | Sfida, obiettivo, risultato, partecipanti, durata                                                          |
| **Dato per l'azienda** | Efficacia programmi engagement. Quali sfide funzionano. Team più/meno coinvolti                            |
| **Frequenza**          | 1 sfida attiva per team alla volta                                                                         |
| **Punti**              | **50-100** per membro del team (se obiettivo raggiunto)                                                    |
| **Anti-abuse**         | Obiettivi definiti dall'azienda o da Vigilo, non dal team                                                  |
| **Canale privacy**     | Canale 1 — volontario                                                                                      |

#### 1.8 Streak giornaliero

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore completa almeno 1 azione al giorno per giorni consecutivi                                    |
| **Dato raccolto**      | Contatore giorni consecutivi, azioni completate per giorno                                                 |
| **Dato per l'azienda** | Costanza engagement. Retention nel tempo                                                                   |
| **Frequenza**          | Giornaliero (automatico)                                                                                   |
| **Punti**              | Bonus crescente: **5** (giorno 1-7), **10** (giorno 8-14), **15** (giorno 15-21), **20** (giorno 22-29), **25** (giorno 30+) |
| **Anti-abuse**         | Almeno 1 azione sostanziale (non solo like). Reset a 0 se salta un giorno                                 |
| **Canale privacy**     | Canale 1 — derivato da altre azioni                                                                        |

---

### CANALE 2 — Formazione obbligatoria

#### 2.1 Micro-training giornaliero (5 minuti)

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore guarda un video breve o legge una pillola formativa (max 5 min)                               |
| **Dato raccolto**      | Contenuto visto, tempo effettivo di fruizione, completamento si/no, timestamp                              |
| **Dato per l'azienda** | % completamento formazione giornaliera. Contenuti più/meno fruiti. Tempo medio fruizione                  |
| **Frequenza**          | 1 al giorno (contenuto ruotato)                                                                            |
| **Punti**              | **15**                                                                                                     |
| **Anti-abuse**         | Tempo minimo di visualizzazione (80% durata video). Domanda di verifica a fine contenuto (1 domanda, nessun punteggio extra) |
| **Canale privacy**     | Canale 2 — strumento di lavoro                                                                             |

#### 2.2 Quiz settimanale

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore risponde a un quiz di 10 domande su argomenti sicurezza                                      |
| **Dato raccolto**      | Risposte per domanda, score %, tempo impiegato, tentativi, argomenti sbagliati                             |
| **Dato per l'azienda** | Gap formativi per argomento. Score medio per team/reparto. Argomenti critici (errore > 40%). Compliance formazione |
| **Frequenza**          | 1 alla settimana                                                                                           |
| **Punti**              | **20** (completamento) + **10** bonus se score ≥ 80%                                                      |
| **Anti-abuse**         | Max 3 tentativi per quiz. Ordine domande randomizzato. Timer per domanda (non puoi cercare su Google)      |
| **Canale privacy**     | Canale 2 — strumento di lavoro                                                                             |

#### 2.3 Completamento corso / modulo formativo

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore completa un corso strutturato (video + PDF + quiz finale)                                    |
| **Dato raccolto**      | Corso completato, score quiz finale, tempo totale, certificato generato, data scadenza                     |
| **Dato per l'azienda** | Stato formazione per dipendente. Scadenze certificazioni. Compliance D.Lgs. 81 completa. Report per audit  |
| **Frequenza**          | Per corso (catalogo variabile)                                                                             |
| **Punti**              | **30** (corso breve <30min), **50** (corso standard 30-60min), **80** (corso completo >60min)              |
| **Anti-abuse**         | Completamento verificato (quiz finale ≥ 60%). Non puoi completare lo stesso corso 2 volte (solo aggiornamento) |
| **Canale privacy**     | Canale 2 — strumento di lavoro                                                                             |

#### 2.4 Aggiornamento formativo / scadenza rinnovata

| Campo                  | Valore                                                                                                     |
|------------------------|------------------------------------------------------------------------------------------------------------|
| **Azione**             | Il lavoratore rinnova una certificazione in scadenza prima della deadline                                  |
| **Dato raccolto**      | Certificazione, vecchia scadenza, nuova scadenza, anticipo in giorni                                      |
| **Dato per l'azienda** | Tasso di rinnovo proattivo. Rischio scadenze non coperte. Pianificazione formazione                        |
| **Frequenza**          | Per certificazione                                                                                         |
| **Punti**              | **20** + bonus **10** se rinnovato con >30 giorni di anticipo                                              |
| **Anti-abuse**         | Automatico: il sistema verifica scadenza e completamento                                                   |
| **Canale privacy**     | Canale 2 — strumento di lavoro                                                                             |

---

## Matrice azioni × categorie lavoratori

Tutte le azioni sono disponibili per ogni lavoratore. La matrice indica la **rilevanza** per ciascuna categoria: quanto quell'azione è naturale, frequente e ad alto impatto per quel tipo di lavoratore.

**Legenda:** ●●● = alta rilevanza, ●● = media, ● = bassa ma disponibile

### Settori ad alto rischio fisico

| Azione                       | Edilizia | Manifattura | Logistica | Agroalimentare |
|------------------------------|----------|-------------|-----------|----------------|
| **CANALE 1 — Volontarie**    |          |             |           |                |
| 1.1 Check-in benessere       |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 1.2 Feedback fine turno      |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 1.3 Segnalazione rischio     |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 1.4 SOS emergenza            |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 1.5 Nomination Safety Star   |   ●●●    |    ●●●      |   ●●      |     ●●         |
| 1.6 Social wall              |   ●●     |    ●●       |   ●●      |     ●●         |
| 1.7 Sfida team               |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 1.8 Streak giornaliero       |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| **CANALE 2 — Formazione**    |          |             |           |                |
| 2.1 Micro-training           |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 2.2 Quiz settimanale         |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 2.3 Corso/modulo             |   ●●●    |    ●●●      |   ●●●     |     ●●●        |
| 2.4 Rinnovo certificazione   |   ●●●    |    ●●●      |   ●●      |     ●●●        |

### Settori servizi e rischio misto

| Azione                       | Retail/GDO | Sanità | Trasporti | Ufficio/Servizi |
|------------------------------|------------|--------|-----------|-----------------|
| **CANALE 1 — Volontarie**    |            |        |           |                 |
| 1.1 Check-in benessere       |    ●●      |  ●●●   |   ●●●     |      ●●         |
| 1.2 Feedback fine turno      |    ●●      |  ●●●   |   ●●●     |      ●●         |
| 1.3 Segnalazione rischio     |    ●●      |  ●●●   |   ●●●     |      ●          |
| 1.4 SOS emergenza            |    ●●      |  ●●    |   ●●●     |      ●          |
| 1.5 Nomination Safety Star   |    ●●      |  ●●●   |   ●●      |      ●●         |
| 1.6 Social wall              |    ●●●     |  ●●    |   ●       |      ●●●        |
| 1.7 Sfida team               |    ●●●     |  ●●●   |   ●●      |      ●●         |
| 1.8 Streak giornaliero       |    ●●●     |  ●●●   |   ●●●     |      ●●●        |
| **CANALE 2 — Formazione**    |            |        |           |                 |
| 2.1 Micro-training           |    ●●●     |  ●●●   |   ●●●     |      ●●         |
| 2.2 Quiz settimanale         |    ●●      |  ●●●   |   ●●●     |      ●●         |
| 2.3 Corso/modulo             |    ●●      |  ●●●   |   ●●●     |      ●●         |
| 2.4 Rinnovo certificazione   |    ●       |  ●●●   |   ●●●     |      ●          |

### Note per categoria

| Categoria            | N. lavoratori Italia | Rischi principali                          | Azioni a più alto impatto                       |
|----------------------|----------------------|--------------------------------------------|--------------------------------------------------|
| **Edilizia**         | ~1.5M                | Cadute, schiacciamenti, calore, amianto    | Segnalazione rischio, SOS, formazione DPI        |
| **Manifattura**      | ~4M                  | Macchinari, sostanze chimiche, rumore      | Check-in, segnalazione, quiz specifici           |
| **Logistica**        | ~1.2M                | Movimentazione carichi, investimenti, ritmi | SOS, sfide team, feedback turno                  |
| **Retail/GDO**       | ~1.5M                | Ergonomia, rapine, stress clienti          | Social wall, sfide team, micro-training          |
| **Agroalimentare**   | ~1M                  | Macchinari agricoli, pesticidi, meteo      | Segnalazione, check-in, formazione stagionale    |
| **Sanità**           | ~1.8M                | Rischio biologico, stress, turni pesanti   | Check-in benessere, nomination, feedback turno   |
| **Trasporti**        | ~1M                  | Incidenti stradali, fatica, isolamento     | SOS, check-in, streak (costanza contatto)        |
| **Ufficio/Servizi**  | ~3M                  | Ergonomia, stress, VDT, microclima        | Social wall, sfide, micro-training               |

### Punti potenziali per categoria

Il potenziale di accumulo punti è simile per tutte le categorie (~1.500/mese), ma la **distribuzione tra azioni** cambia:

| Categoria            | Peso Canale 1 | Peso Canale 2 | Azione dominante                             |
|----------------------|---------------|---------------|----------------------------------------------|
| **Edilizia**         | 65%           | 35%           | Segnalazioni rischio (cantiere dinamico)     |
| **Manifattura**      | 55%           | 45%           | Formazione (normative complesse)             |
| **Logistica**        | 60%           | 40%           | Sfide team + feedback turno                  |
| **Retail/GDO**       | 70%           | 30%           | Social wall + sfide (team store)             |
| **Agroalimentare**   | 60%           | 40%           | Segnalazioni + formazione stagionale         |
| **Sanità**           | 55%           | 45%           | Check-in benessere + formazione continua     |
| **Trasporti**        | 65%           | 35%           | SOS + streak (lavoratori spesso isolati)     |
| **Ufficio/Servizi**  | 70%           | 30%           | Social + sfide (rischi fisici minori)        |

---

## Riepilogo punteggi

### Punti per canale

| Canale                       | Azioni                                                            | Punti/mese (lavoratore attivo) | % totale |
|------------------------------|-------------------------------------------------------------------|--------------------------------|----------|
| **Canale 1 — Volontarie**   | Check-in, VOW, segnalazioni, social, sfide, nomination, streak   | ~900                           | 60%      |
| **Canale 2 — Formazione**   | Micro-training, quiz, corsi, rinnovi                              | ~600                           | 40%      |
| **TOTALE**                   |                                                                   | **~1.500/mese**                | 100%     |

### Dettaglio punti/mese per azione (lavoratore attivo, 22 giorni lavorativi)

| Azione                   | Punti/evento | Eventi/mese | Punti/mese |
|--------------------------|--------------|-------------|------------|
| Check-in benessere       | 5            | 22          | 110        |
| Feedback VOW             | 10           | 22          | 220        |
| Micro-training           | 15           | 22          | 330        |
| Quiz settimanale         | 25 (media)   | 4           | 100        |
| Segnalazione rischio     | 35 (media)   | 1           | 35         |
| Post social              | 5            | 4           | 20         |
| Commenti/like            | 2 (media)    | 10          | 20         |
| Nomination Safety Star   | 15           | 2           | 30         |
| Sfida team               | 75 (media)   | 2           | 150        |
| Streak bonus             | 15 (media)   | 22          | 330        |
| Corso/modulo             | 40 (media)   | 0.5         | 20         |
| Rinnovo certificazione   | 25 (media)   | 0.1         | ~3         |
| **TOTALE Canale 1+2**    |              |             | **~1.370** |

Arrotondamento a **~1.500 punti/mese** considerando variabilità e azioni occasionali extra.

---

## Conversione punti → valore economico

### Principio: due wallet separati

Ogni lavoratore ha due wallet distinti nel proprio profilo:

| Wallet                  | Generazione                                              | Utilizzo                              | Visibilità                              |
|-------------------------|----------------------------------------------------------|---------------------------------------|-----------------------------------------|
| **Punti Elmetto**        | Sempre attivo. Ogni azione genera Punti Elmetto           | Sconti % sull'ecommerce. Paga lui     | Tutti i lavoratori                      |
| **Punti Welfare**       | Solo se l'azienda ha un piano welfare attivo             | Riscatto prodotti gratis. Paga l'azienda | Solo lavoratori con welfare attivo     |

Le due tipologie di punti si accumulano **in parallelo**: una singola azione genera punti in entrambi i wallet contemporaneamente. I Punti Elmetto sono sempre uguali per tutti (~1.500/mese). I punti welfare dipendono dal piano scelto dall'azienda.

### Come funziona la generazione parallela

```
Lavoratore fa check-in benessere
    ├─ Wallet Elmetto:  +5 Punti Elmetto (sempre, per tutti)
    └─ Wallet Welfare: +N punti welfare (solo se piano attivo)
                        N varia in base al piano aziendale
```

### Piani welfare aziendali

L'azienda sceglie un piano che determina il **tasso di generazione** dei punti welfare. Il valore di 1 punto welfare è fisso (~€0.017), cambia la **quantità** generata per azione:

| Piano             | Budget/dip/mese | Punti welfare generati/mese | Valore riscattabile/mese | Moltiplicatore welfare |
|-------------------|-----------------|----------------------------|--------------------------|------------------------|
| **Nessun piano**  | €0              | 0 (wallet non visibile)    | €0                       | —                      |
| **Welfare S**     | €5              | ~300                       | ~€5                      | 0.20x                  |
| **Welfare M**     | €10             | ~600                       | ~€10                     | 0.40x                  |
| **Welfare L**     | €20             | ~1.200                     | ~€20                     | 0.80x                  |

Il **moltiplicatore welfare** indica il rapporto rispetto ai Punti Elmetto: con il piano L, ogni azione genera 0.80x punti welfare rispetto ai Punti Elmetto (es. check-in = 5 Punti Elmetto + 4 punti welfare).

### Esempio generazione per azione

| Azione                   | Punti Elmetto (sempre) | Welfare S (+0.20x) | Welfare M (+0.40x) | Welfare L (+0.80x) |
|--------------------------|-----------------------|---------------------|---------------------|---------------------|
| Check-in benessere       | 5                     | 1                   | 2                   | 4                   |
| Feedback fine turno      | 10                    | 2                   | 4                   | 8                   |
| Micro-training           | 15                    | 3                   | 6                   | 12                  |
| Quiz settimanale         | 25                    | 5                   | 10                  | 20                  |
| Segnalazione rischio     | 35                    | 7                   | 14                  | 28                  |
| Sfida team               | 75                    | 15                  | 30                  | 60                  |

### Flusso checkout — ecommerce

Al checkout il lavoratore vede i due saldi e sceglie come pagare:

```
LAVORATORE SENZA WELFARE
─────────────────────────────────────────────────
Wallet:  [Punti Elmetto: 1.200]
Prodotto: Borraccia termica €30

    └─ Usa 1.000 Punti Elmetto → sconto 20%
        └─ Lavoratore paga €24
            └─ Vigilo incassa €24


LAVORATORE CON WELFARE (piano M)
─────────────────────────────────────────────────
Wallet:  [Punti Elmetto: 1.200]  [Punti Welfare: 480]
Prodotto: Borraccia termica €30

    Opzione A — Usa Punti Elmetto
    └─ Usa 1.000 Punti Elmetto → sconto 20%
        └─ Lavoratore paga €24

    Opzione B — Usa punti welfare
    └─ Usa 480 punti welfare → riscatto parziale €8
        └─ Lavoratore paga €22, azienda paga €8

    Opzione C — Mix Elmetto + welfare
    └─ Usa 480 punti welfare (€8) + 500 Punti Elmetto (10%)
        └─ Prezzo: €30 - €8 welfare = €22 - 10% sconto = €19.80
            └─ Lavoratore paga €19.80, azienda paga €8
```

### Tabella sconto — Punti Elmetto

| Punti Elmetto spesi | Sconto applicato | Esempio su prodotto €30 | Chi paga          |
|---------------------|------------------|-------------------------|-------------------|
| 200                 | 5%               | Paga €28.50             | Il lavoratore     |
| 500                 | 10%              | Paga €27.00             | Il lavoratore     |
| 1.000               | 20%              | Paga €24.00             | Il lavoratore     |
| 2.000               | 30%              | Paga €21.00             | Il lavoratore     |
| 5.000               | 40%              | Paga €18.00             | Il lavoratore     |

**Valore implicito di 1 Punto Elmetto**: ~€0.003 (0.3 centesimi)

Con 1.500 Punti Elmetto/mese = 18.000/anno → risparmio annuo: **€36-54 in sconti**

### Tabella riscatto — Punti Welfare

| Punti welfare spesi | Valore riscattabile    | Chi paga              |
|---------------------|------------------------|-----------------------|
| 100                 | ~€1.70                 | L'azienda (welfare)   |
| 300                 | ~€5.00                 | L'azienda (welfare)   |
| 600                 | ~€10.00                | L'azienda (welfare)   |
| 1.200               | ~€20.00                | L'azienda (welfare)   |
| 3.000               | ~€50.00                | L'azienda (welfare)   |

**Valore fisso di 1 punto welfare**: ~€0.017 (1.7 centesimi) — uguale per tutti i piani

### Confronto per piano welfare (anno, lavoratore attivo)

| Piano             | Elmetto/anno | Valore sconti/anno | Punti welfare/anno | Valore welfare/anno | Valore totale/anno |
|-------------------|-------------------|---------------------|--------------------|---------------------|--------------------|
| **Nessun piano**  | 18.000            | €36-54              | 0                  | €0                  | €36-54             |
| **Welfare S**     | 18.000            | €36-54              | ~3.600             | ~€60                | €96-114            |
| **Welfare M**     | 18.000            | €36-54              | ~7.200             | ~€120               | €156-174           |
| **Welfare L**     | 18.000            | €36-54              | ~14.400            | ~€240               | €276-294           |

### Costo per l'azienda

| Piano             | Costo/dip/mese | Costo/dip/anno | Costo 100 dipendenti/anno |
|-------------------|----------------|----------------|---------------------------|
| **Nessun piano**  | €0             | €0             | €0                        |
| **Welfare S**     | €5             | €60            | €6.000                    |
| **Welfare M**     | €10            | €120           | €12.000                   |
| **Welfare L**     | €20            | €240           | €24.000                   |

Il budget welfare è **deducibile** per l'azienda e **detassato** per il lavoratore (entro i limiti del TUIR Art. 51 comma 2).

### Vantaggi del sistema a due wallet

| Aspetto                    | Beneficio                                                                         |
|----------------------------|-----------------------------------------------------------------------------------|
| **Chiarezza per il lavoratore** | Due saldi distinti: "i miei Punti Elmetto" vs "il mio welfare". Zero ambiguità |
| **Controllo per l'azienda**    | Il piano determina esattamente il costo. Budget prevedibile, nessuna sorpresa  |
| **Resilienza**                 | Se l'azienda disattiva il welfare, i Punti Elmetto restano intatti             |
| **UX pulita**                  | Senza welfare il lavoratore vede un solo wallet. Nessun elemento confuso       |
| **Mix al checkout**            | Il lavoratore può combinare Elmetto + welfare per massimizzare il vantaggio    |
| **Scalabilità**                | L'azienda può cambiare piano in qualsiasi momento senza toccare i Punti Elmetto |

---

## UX Card Prodotto — Marketplace

Il lavoratore deve capire **immediatamente** quanto paga davvero. Nessun calcolo manuale. La card risponde a una sola domanda: "quanto mi costa?"

### Anatomia della card prodotto

Elementi comuni a tutte le card:

| Elemento                     | Posizione          | Descrizione                                                         |
|------------------------------|--------------------|---------------------------------------------------------------------|
| Immagine prodotto            | Top                | Foto principale, swipeable per gallery                              |
| Badge stato                  | Overlay su immagine | "GRATIS PER TE" (verde) se welfare copre tutto, "SCONTATO" (blu)   |
| Nome prodotto                | Sotto immagine     | Titolo breve (max 2 righe)                                         |
| Categoria                    | Sotto nome         | Tag: Sicurezza, Benessere, Tech, Abbigliamento, ecc.               |
| Prezzo pieno                 | Evidenziato        | Prezzo originale del prodotto                                       |
| Prezzo finale "Tu paghi"     | Grande, in evidenza | Il prezzo reale dopo welfare + sconto. Aggiornato in tempo reale   |
| Riepilogo vantaggi           | Sotto prezzo       | Breakdown: welfare applicato + sconto applicato                     |
| Controlli punti              | Interattivi        | Toggle welfare ON/OFF + slider Punti Elmetto                         |
| Tasto azione                 | Bottom, fisso      | "Acquista — €XX" oppure "Riscatta gratis"                          |

### Scenario 1 — Lavoratore SENZA welfare

Il lavoratore vede un solo wallet. La card è semplice:

```
┌─────────────────────────────────────┐
│         [IMMAGINE PRODOTTO]         │
│                          SCONTATO   │
├─────────────────────────────────────┤
│  Borraccia Termica Pro              │
│  Categoria: Benessere               │
│                                     │
│  Prezzo: €30.00                     │
│                                     │
│  ── I tuoi Punti Elmetto ─────────  │
│  Saldo: 1.200 punti                │
│  Usa: [●━━━━━━━━━━━] 1.000 punti   │
│  Sconto: -20% (-€6.00)             │
│                                     │
│  ─────────────────────────────────  │
│  Tu paghi:              €24.00      │
│                                     │
│  [       Acquista — €24.00        ] │
└─────────────────────────────────────┘
```

Lo slider permette di scegliere quanti Punti Elmetto usare (da 0 al massimo disponibile). Il prezzo finale si aggiorna in tempo reale.

### Scenario 2 — Lavoratore CON welfare (mix punti)

Il lavoratore vede due wallet e può combinare:

```
┌─────────────────────────────────────┐
│         [IMMAGINE PRODOTTO]         │
│                                     │
├─────────────────────────────────────┤
│  Borraccia Termica Pro              │
│  Categoria: Benessere               │
│                                     │
│  Prezzo: €30.00                     │
│                                     │
│  ── Welfare aziendale ────────────  │
│  Saldo: 480 punti welfare           │
│  Usa welfare: [ON]  → -€8.00       │
│                                     │
│  ── I tuoi Punti Elmetto ─────────  │
│  Saldo: 1.200 punti                │
│  Usa: [●━━━━━━━━━━━] 500 punti     │
│  Sconto: -10% (-€2.20)             │
│                                     │
│  ─────────────────────────────────  │
│  Prezzo:                €30.00      │
│  Welfare:               -€8.00     │
│  Subtotale:             €22.00      │
│  Sconto (10%):          -€2.20     │
│  ─────────────────────────────────  │
│  Tu paghi:              €19.80      │
│                                     │
│  [      Acquista — €19.80         ] │
└─────────────────────────────────────┘
```

**Ordine di applicazione**: prima si sottrae il welfare (€), poi si calcola lo sconto (%) sul restante. Questo è più intuitivo: "tolgo il regalo dell'azienda, poi applico il mio sconto personale".

### Scenario 3 — Prodotto completamente riscattabile gratis

Quando i punti welfare coprono l'intero prezzo, la card cambia aspetto:

```
┌─────────────────────────────────────┐
│         [IMMAGINE PRODOTTO]         │
│                     GRATIS PER TE   │
├─────────────────────────────────────┤
│  Guanti Sicurezza Pro               │
│  Categoria: Sicurezza               │
│                                     │
│  Prezzo: €15.00                     │
│                                     │
│  ── Welfare aziendale ────────────  │
│  Saldo: 480 punti welfare           │
│  Usa welfare: [ON]  → copre tutto!  │
│                                     │
│  ─────────────────────────────────  │
│  Prezzo:                €15.00      │
│  Welfare:              -€15.00     │
│  ─────────────────────────────────  │
│  Tu paghi:          €0.00 GRATIS    │
│                                     │
│  [       Riscatta gratis          ] │
└─────────────────────────────────────┘
```

Il tasto cambia da "Acquista" a **"Riscatta gratis"** (colore verde) — momento di gratificazione forte.

### Scenario 4 — Punti insufficienti per qualsiasi sconto

Il lavoratore ha pochi punti, la card diventa motivazionale:

```
┌─────────────────────────────────────┐
│         [IMMAGINE PRODOTTO]         │
│                                     │
├─────────────────────────────────────┤
│  Zaino Tecnico Waterproof           │
│  Categoria: Abbigliamento           │
│                                     │
│  Prezzo: €85.00                     │
│                                     │
│  ── I tuoi Punti Elmetto ─────────  │
│  Saldo: 120 punti                   │
│  ⚡ Ancora 80 punti per il primo    │
│     sconto! (5% = -€4.25)          │
│                                     │
│  ─────────────────────────────────  │
│  Tu paghi:              €85.00      │
│                                     │
│  [       Acquista — €85.00        ] │
└─────────────────────────────────────┘
```

Il sistema mostra **quanto manca** al primo sconto come incentivo.

### Elementi aggiuntivi nella lista prodotti

Oltre alla card dettaglio, la **lista/griglia prodotti** mostra informazioni rapide:

| Elemento                     | Dove                     | Logica                                                              |
|------------------------------|--------------------------|--------------------------------------------------------------------|
| Badge "GRATIS PER TE"       | Overlay card in griglia  | Il prodotto è interamente riscattabile con i punti welfare attuali |
| Badge "SCONTATO"            | Overlay card in griglia  | Il lavoratore ha abbastanza Punti Elmetto per almeno -5%           |
| Prezzo barrato + prezzo reale | Sotto nome in griglia   | Mostra €30.00 ~~barrato~~ → €24.00                                |
| Filtro "Riscattabili gratis" | Barra filtri top        | Mostra solo prodotti che il welfare copre interamente              |
| Filtro "Con il mio sconto"  | Barra filtri top         | Mostra prodotti dove i punti danno almeno 10% sconto              |
| Ordinamento "Per te"        | Default                  | Ordina per vantaggio massimo ottenibile (gratis prima, poi sconto) |
| Risparmio totale anno        | Header sezione           | "Quest'anno hai risparmiato €XX.XX" — rinforzo positivo           |

### Regola di visibilità wallet

| Stato azienda           | Wallet Elmetto | Wallet Welfare | Toggle welfare nella card |
|-------------------------|---------------|----------------|---------------------------|
| Welfare non attivo      | Visibile      | Nascosto       | Nascosto                  |
| Welfare S/M/L attivo    | Visibile      | Visibile       | Visibile                  |
| Welfare disattivato     | Visibile      | Nascosto (saldo congelato, punti non persi) | Nascosto |

Se l'azienda disattiva il welfare, i punti welfare accumulati vengono **congelati** (non persi). Se il welfare viene riattivato, tornano disponibili.

---

## Dati aggregati per la dashboard aziendale

### Cosa vede l'azienda (e cosa NON vede)

| L'azienda VEDE                                  | L'azienda NON VEDE                                              |
|-------------------------------------------------|------------------------------------------------------------------|
| % check-in completati per reparto               | Risposte individuali al check-in benessere                       |
| Sentiment medio per periodo                     | Chi ha risposto cosa                                             |
| N. segnalazioni per tipo/area/periodo           | Identità del segnalante (anonimizzabile)                         |
| Score medio quiz per argomento                  | Score individuale per quiz (solo aggregato)                      |
| % completamento formazione per reparto          | Tempo esatto di fruizione individuale                            |
| N. sfide completate, engagement rate            | Chi ha partecipato a cosa (solo aggregato)                       |
| Trend safety score aggregato                    | Safety score individuale                                         |
| Tempi risposta SOS                              | Identità di chi ha attivato SOS (solo a referenti sicurezza)     |
| Storico emergenze con analisi cause             | Dati personali individuali non aggregati                         |

### Report esportabili per compliance

| Report                       | Contenuto                                                 | Utilizzo                                  |
|------------------------------|-----------------------------------------------------------|-------------------------------------------|
| **Formazione D.Lgs. 81**    | Corsi completati, score, certificati per dipendente       | Allegato DVR, audit ispettivi             |
| **Segnalazioni**             | Elenco segnalazioni, esito, azioni correttive             | POS, riunione periodica sicurezza         |
| **Near-miss**                | Analisi near-miss per tipologia e area                    | Aggiornamento DVR, piano miglioramento    |
| **Engagement**               | Partecipazione programma, trend, benchmark                | Report HSE direzione                      |
| **SOS**                      | Storico emergenze, tempi risposta, esiti                  | Analisi post-incidente                    |

---

## Regole anti-abuse

### Limiti giornalieri

| Azione                 | Limite giornaliero   | Motivazione                                                                             |
|------------------------|----------------------|-----------------------------------------------------------------------------------------|
| Check-in benessere     | 1                    | Un check-in per turno è sufficiente                                                     |
| Feedback VOW           | 1                    | Un feedback per turno                                                                   |
| Micro-training         | 1                    | Una pillola al giorno per non saturare                                                  |
| Segnalazioni           | 5 (con punti)        | Oltre 5 al giorno probabile abuse; le successive valgono 0 punti ma restano registrate  |
| Post social            | 3 (con punti)        | Oltre 3 solo engagement, no punti                                                       |
| Commenti/like          | Max 30 punti/giorno  | Evita like-bombing                                                                      |
| Nomination             | 1/settimana          | Mantiene valore della nomination                                                        |

### Validazione segnalazioni

| Livello                | Condizione                                                                   | Punti                                    |
|------------------------|------------------------------------------------------------------------------|------------------------------------------|
| **Auto-validata**      | Segnalazione con foto + descrizione >50 caratteri                            | Punti immediati (30-50)                  |
| **In attesa**          | Segnalazione senza foto o descrizione breve                                  | Punti dopo validazione referente         |
| **Rifiutata**          | Segnalazione non pertinente o duplicata                                      | 0 punti, nessuna penalità               |
| **Abuse**              | Pattern ripetitivo: stessa segnalazione, testo copiato, >3 rifiutate in 7gg | Sospensione punti segnalazioni per 7gg  |

### Score qualità segnalante

Ogni lavoratore ha un "trust score" interno (non visibile) che influenza la validazione:

| Trust level            | Condizione                             | Effetto                                          |
|------------------------|----------------------------------------|--------------------------------------------------|
| **Nuovo**              | <10 segnalazioni                       | Tutte in attesa di validazione                   |
| **Affidabile**         | >10 segnalazioni, <10% rifiutate      | Auto-validazione per segnalazioni con foto       |
| **Esperto**            | >50 segnalazioni, <5% rifiutate       | Auto-validazione sempre + punti bonus (+10)      |
| **Sospetto**           | >20% rifiutate negli ultimi 30gg       | Tutte in attesa di validazione manuale           |

---

## Impatto stimato sulla raccolta dati

### Con 1.000 lavoratori attivi (azienda media)

| Dato                         | Volume/mese        | Volume/anno     |
|------------------------------|--------------------|-----------------|
| Check-in benessere           | 22.000             | 264.000         |
| Feedback VOW                 | 22.000             | 264.000         |
| Segnalazioni rischio         | 1.000-2.000        | 12.000-24.000   |
| Quiz completati              | 4.000              | 48.000          |
| Micro-training fruiti        | 22.000             | 264.000         |
| Post social                  | 4.000              | 48.000          |
| Nomination Safety Star       | 2.000              | 24.000          |
| Sfide team completate        | 8 per team (5 team)| ~500            |

Questo volume di dati strutturati non ha precedenti nel settore sicurezza. Oggi la maggior parte delle aziende raccoglie **zero** dati qualitativi dai propri lavoratori in materia di sicurezza.

---

*Documento di riferimento per lo sviluppo del sistema punti Vigilo V2*
