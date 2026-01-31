/// Turno di lavoro assegnato al lavoratore.
class WorkerShift {
  const WorkerShift({
    required this.id,
    required this.nome,
    this.codice,
    this.oraInizio,
    this.oraFine,
  });

  factory WorkerShift.fromJson(Map<String, dynamic> json) {
    return WorkerShift(
      id: json['id'] as String,
      nome: json['nome'] as String? ?? '',
      codice: json['codice'] as String?,
      oraInizio: json['ora_inizio'] as String?,
      oraFine: json['ora_fine'] as String?,
    );
  }

  final String id;
  final String nome;
  final String? codice;
  final String? oraInizio;
  final String? oraFine;

  /// Formato orario leggibile, es. "06:00 - 14:00"
  String get orarioDisplay {
    if (oraInizio == null || oraFine == null) return '';
    final inizio = oraInizio!.substring(0, 5);
    final fine = oraFine!.substring(0, 5);
    return '$inizio - $fine';
  }

  /// Label completa, es. "Mattina (06:00 - 14:00)"
  String get label {
    final orario = orarioDisplay;
    if (orario.isEmpty) return nome;
    return '$nome ($orario)';
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'codice': codice,
      'ora_inizio': oraInizio,
      'ora_fine': oraFine,
    };
  }

  static WorkerShift mock() {
    return const WorkerShift(
      id: 'mock-turno-id',
      nome: 'Mattina',
      codice: 'MAT',
      oraInizio: '06:00:00',
      oraFine: '14:00:00',
    );
  }
}
