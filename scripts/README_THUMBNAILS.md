# 📸 Thumbnail Generator

Script Python per generare thumbnail ottimizzate delle foto dei post.

## 🎯 Caratteristiche

- **Dimensioni ottimizzate**: 300x300px per caricamento veloce
- **Formato quadrato**: Crop automatico centrato
- **Compressione JPEG**: Qualità 85%, ottimizzato per web/mobile
- **Riduzione dimensioni**: ~99% rispetto alle immagini originali

## 📋 Requisiti

```bash
pip install Pillow
```

## 🚀 Utilizzo

Dalla root del progetto:

```bash
python scripts/generate_thumbnails.py
```

Lo script:

1. Cerca tutte le immagini `.jpg` nella cartella `assets/posts/`
2. Crea thumbnail 300x300px nella cartella `assets/posts/thumbs/`
3. Mostra la riduzione di dimensione per ogni immagine

## 📊 Risultati

### Esempio di output

```
✓ giovane-artigiano-che-costruisce-una-casa.jpg
  → giovane-artigiano-che-costruisce-una-casa.jpg
  Riduzione: 99.5% (3531KB → 19KB)
```

### Statistiche complete

- **10 immagini** processate
- **Dimensione originale totale**: ~117 MB
- **Dimensione thumbnail totale**: ~242 KB
- **Risparmio spazio**: 99.8%

## 🔄 Integrazione con Flutter

Le thumbnail sono automaticamente utilizzate dal modello `SocialPost`:

```dart
// Usa automaticamente la thumbnail se disponibile, altrimenti immagine originale
Image.asset(post.thumbPath)
```

### Vantaggi

- ✅ Caricamento griglia 99% più veloce
- ✅ Riduzione memoria occupata
- ✅ Migliore esperienza utente
- ✅ Immagini originali ad alta risoluzione per vista dettaglio

## 📁 Struttura

```
assets/posts/
├── immagine.jpg          (Originale ad alta risoluzione)
└── thumbs/
    └── immagine.jpg      (Thumbnail 300x300px)
```

## 🛠️ Personalizzazione

Per modificare le dimensioni o la qualità, edita le costanti in `generate_thumbnails.py`:

```python
THUMB_SIZE = (300, 300)  # Dimensioni thumbnail
QUALITY = 85             # Qualità JPEG (1-100)
```
