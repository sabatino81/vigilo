import 'package:vigilo/features/profile/domain/models/worker_shift.dart';

/// Dati anagrafici del lavoratore collegato (provenienti dalla tabella `lavoratori`).
class WorkerInfo {
  const WorkerInfo({
    required this.lavoratoreId,
    this.matricola,
    this.codiceFiscale,
    this.turno,
    this.mansione,
    this.reparto,
    this.dataAssunzione,
    this.tipoContratto,
    this.ruoloSicurezza,
  });

  factory WorkerInfo.fromJson(Map<String, dynamic> json) {
    return WorkerInfo(
      lavoratoreId: json['lavoratore_id'] as String,
      matricola: json['matricola'] as String?,
      codiceFiscale: json['codice_fiscale'] as String?,
      turno: json['turno'] != null
          ? WorkerShift.fromJson(json['turno'] as Map<String, dynamic>)
          : null,
      mansione: json['mansione'] != null
          ? (json['mansione'] as Map<String, dynamic>)['nome'] as String?
          : null,
      reparto: json['reparto'] != null
          ? (json['reparto'] as Map<String, dynamic>)['nome'] as String?
          : null,
      dataAssunzione: json['data_assunzione'] as String?,
      tipoContratto: json['tipo_contratto'] as String?,
      ruoloSicurezza: json['ruolo_sicurezza'] as String?,
    );
  }

  final String lavoratoreId;
  final String? matricola;
  final String? codiceFiscale;
  final WorkerShift? turno;
  final String? mansione;
  final String? reparto;
  final String? dataAssunzione;
  final String? tipoContratto;
  final String? ruoloSicurezza;

  /// Label contratto leggibile.
  String get tipoContrattoLabel {
    switch (tipoContratto) {
      case 'indeterminato':
        return 'Tempo indeterminato';
      case 'determinato':
        return 'Tempo determinato';
      case 'apprendistato':
        return 'Apprendistato';
      default:
        return tipoContratto ?? '';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'lavoratore_id': lavoratoreId,
      'matricola': matricola,
      'codice_fiscale': codiceFiscale,
      'turno': turno?.toJson(),
      'mansione': mansione != null ? {'nome': mansione} : null,
      'reparto': reparto != null ? {'nome': reparto} : null,
      'data_assunzione': dataAssunzione,
      'tipo_contratto': tipoContratto,
      'ruolo_sicurezza': ruoloSicurezza,
    };
  }

  static WorkerInfo mock() {
    return WorkerInfo(
      lavoratoreId: 'mock-lavoratore-id',
      matricola: 'MAT-001',
      codiceFiscale: 'RSSMRC85M01H501Z',
      turno: WorkerShift.mock(),
      mansione: 'Muratore specializzato',
      reparto: 'Cantiere Nord',
      dataAssunzione: '2020-03-15',
      tipoContratto: 'indeterminato',
      ruoloSicurezza: 'preposto',
    );
  }
}
