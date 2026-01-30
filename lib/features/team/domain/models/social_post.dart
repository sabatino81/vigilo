/// Modello per un post nella bacheca sociale aziendale
class SocialPost {
  const SocialPost({
    required this.id,
    required this.imagePath,
    required this.caption,
    required this.author,
    required this.likes,
    required this.date,
    this.thumbnailPath,
    this.comments = 0,
    this.aspectRatio = 1.0,
  });

  final String id;
  final String imagePath;
  final String caption;
  final String author;
  final int likes;
  final int comments;
  final DateTime date;
  final String? thumbnailPath;
  final double aspectRatio; // larghezza/altezza (es: 16/9, 4/3, 1/1)

  /// Restituisce il percorso della thumbnail o l'immagine originale se non disponibile
  String get thumbPath => thumbnailPath ?? imagePath;

  /// Lista di post statici di esempio
  static final List<SocialPost> staticPosts = [
    SocialPost(
      id: 'post_1',
      imagePath: 'assets/posts/giovane-artigiano-che-costruisce-una-casa.jpg',
      thumbnailPath:
          'assets/posts/thumbs/giovane-artigiano-che-costruisce-una-casa.jpg',
      caption: 'Nuova costruzione in fase di completamento! 🏗️',
      author: 'Ahmed',
      likes: 24,
      comments: 5,
      aspectRatio: 3 / 2, // foto orizzontale
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    SocialPost(
      id: 'post_2',
      imagePath:
          'assets/posts/quattro-persone-caschi-protettivi-che-ispezionano-l-area-dell-edificio.jpg',
      thumbnailPath:
          'assets/posts/thumbs/quattro-persone-caschi-protettivi-che-ispezionano-l-area-dell-edificio.jpg',
      caption: 'Ispezione di sicurezza completata con successo ✅',
      author: 'Marco',
      likes: 18,
      comments: 3,
      aspectRatio: 4 / 3,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
    SocialPost(
      id: 'post_3',
      imagePath:
          'assets/posts/ingegnere-civile-e-manager-operaio-edile-possesso-di-tablet-digitale-e-progetti-che-parlano-e-planano-sul-cantiere-concetto-di-lavoro-di-squadra-di-cooperazione.jpg',
      thumbnailPath:
          'assets/posts/thumbs/ingegnere-civile-e-manager-operaio-edile-possesso-di-tablet-digitale-e-progetti-che-parlano-e-planano-sul-cantiere-concetto-di-lavoro-di-squadra-di-cooperazione.jpg',
      caption: 'Grande lavoro di squadra oggi! 💪',
      author: 'Sofia',
      likes: 32,
      comments: 8,
      aspectRatio: 16 / 9, // foto panoramica
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    SocialPost(
      id: 'post_4',
      imagePath:
          'assets/posts/ritratto-di-una-persona-che-lavora-nel-settore-delle-costruzioni.jpg',
      thumbnailPath:
          'assets/posts/thumbs/ritratto-di-una-persona-che-lavora-nel-settore-delle-costruzioni.jpg',
      caption: 'Sempre attenti alla sicurezza! 🦺',
      author: 'Luca',
      likes: 15,
      comments: 2,
      aspectRatio: 2 / 3, // foto verticale
      date: DateTime.now().subtract(const Duration(days: 4)),
    ),
    SocialPost(
      id: 'post_5',
      imagePath: 'assets/posts/i-lavoratori-che-esaminano-il-lavoro.jpg',
      thumbnailPath:
          'assets/posts/thumbs/i-lavoratori-che-esaminano-il-lavoro.jpg',
      caption: 'Controllo qualità in corso 🔍',
      author: 'Giovanni',
      likes: 21,
      comments: 6,
      aspectRatio: 4 / 3,
      date: DateTime.now().subtract(const Duration(days: 5)),
    ),
    SocialPost(
      id: 'post_6',
      imagePath: 'assets/posts/scena-di-cantiere-con-attrezzature.jpg',
      thumbnailPath:
          'assets/posts/thumbs/scena-di-cantiere-con-attrezzature.jpg',
      caption: 'Nuove attrezzature in arrivo! 🚜',
      author: 'Francesca',
      likes: 27,
      comments: 4,
      aspectRatio: 3 / 2,
      date: DateTime.now().subtract(const Duration(days: 6)),
    ),
  ];

  /// Restituisce il post con più likes
  static SocialPost get topPost {
    return staticPosts.reduce(
      (a, b) => a.likes > b.likes ? a : b,
    );
  }
}
