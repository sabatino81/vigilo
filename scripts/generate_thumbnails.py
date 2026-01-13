#!/usr/bin/env python3
"""
Script per generare thumbnail ottimizzate delle foto dei post.
Le thumbnail sono create a 300x300px per un caricamento veloce nella griglia.
"""

from pathlib import Path

try:
    from PIL import Image
except ImportError:
    print("Pillow non è installato. Installalo con: pip install Pillow")
    exit(1)

# Percorsi
SCRIPT_DIR = Path(__file__).parent
PROJECT_ROOT = SCRIPT_DIR.parent
POSTS_DIR = PROJECT_ROOT / "assets" / "posts"
THUMBS_DIR = POSTS_DIR / "thumbs"

# Dimensioni thumbnail
THUMB_SIZE = (300, 300)
QUALITY = 85


def create_thumbnail(image_path: Path, output_path: Path):
    """Crea una thumbnail quadrata dall'immagine originale."""
    try:
        with Image.open(image_path) as img:
            # Converti in RGB se necessario (per immagini PNG con trasparenza)
            if img.mode in ("RGBA", "LA", "P"):
                background = Image.new("RGB", img.size, (255, 255, 255))
                if img.mode == "P":
                    img = img.convert("RGBA")
                background.paste(
                    img, mask=img.split()[-1] if img.mode == "RGBA" else None
                )
                img = background

            # Calcola il crop per ottenere un quadrato centrato
            width, height = img.size
            if width > height:
                left = (width - height) // 2
                right = left + height
                img = img.crop((left, 0, right, height))
            elif height > width:
                top = (height - width) // 2
                bottom = top + width
                img = img.crop((0, top, width, bottom))

            # Ridimensiona alla dimensione thumbnail
            img = img.resize(THUMB_SIZE, Image.Resampling.LANCZOS)

            # Salva con ottimizzazione
            img.save(output_path, "JPEG", quality=QUALITY, optimize=True)

            # Calcola la riduzione di dimensione
            original_size = image_path.stat().st_size
            thumb_size = output_path.stat().st_size
            reduction = (1 - thumb_size / original_size) * 100

            print(f"✓ {image_path.name}")
            print(f"  → {output_path.name}")
            print(
                f"  Riduzione: {reduction:.1f}% ({original_size // 1024}KB → {thumb_size // 1024}KB)"
            )

    except Exception as e:
        print(f"✗ Errore con {image_path.name}: {e}")


def main():
    """Genera tutte le thumbnail dalle immagini nella cartella posts."""
    # Verifica che esistano le cartelle
    if not POSTS_DIR.exists():
        print(f"Errore: cartella {POSTS_DIR} non trovata")
        return

    # Crea la cartella thumbs se non esiste
    THUMBS_DIR.mkdir(exist_ok=True)

    print("Generazione thumbnail in corso...\n")

    # Processa tutte le immagini JPG nella cartella posts
    image_files = list(POSTS_DIR.glob("*.jpg")) + list(POSTS_DIR.glob("*.jpeg"))

    if not image_files:
        print("Nessuna immagine JPG trovata nella cartella posts")
        return

    print(f"Trovate {len(image_files)} immagini da processare\n")

    for image_path in image_files:
        # Nome del file thumbnail (stesso nome dell'originale)
        thumb_path = THUMBS_DIR / image_path.name

        # Genera la thumbnail
        create_thumbnail(image_path, thumb_path)
        print()

    print(f"\n✓ Completato! {len(image_files)} thumbnail generate in {THUMBS_DIR}")


if __name__ == "__main__":
    main()
