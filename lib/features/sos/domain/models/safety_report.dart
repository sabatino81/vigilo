import 'package:vigilo/features/sos/domain/models/report_status.dart';
import 'package:vigilo/features/sos/domain/models/report_type.dart';

/// Modello per una segnalazione di sicurezza
class SafetyReport {
  const SafetyReport({
    required this.id,
    required this.type,
    required this.description,
    required this.createdAt,
    this.reportCode,
    this.photoUrls = const [],
    this.latitude,
    this.longitude,
    this.locationName,
    this.contactRequested = false,
    this.status = ReportStatus.pending,
    this.resolvedAt,
    this.rsppNotes,
  });

  final String id;
  final String? reportCode;
  final ReportType type;
  final String description;
  final List<String> photoUrls;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final bool contactRequested;
  final ReportStatus status;
  final DateTime createdAt;
  final DateTime? resolvedAt;
  final String? rsppNotes;

  SafetyReport copyWith({
    String? id,
    String? reportCode,
    ReportType? type,
    String? description,
    List<String>? photoUrls,
    double? latitude,
    double? longitude,
    String? locationName,
    bool? contactRequested,
    ReportStatus? status,
    DateTime? createdAt,
    DateTime? resolvedAt,
    String? rsppNotes,
  }) {
    return SafetyReport(
      id: id ?? this.id,
      reportCode: reportCode ?? this.reportCode,
      type: type ?? this.type,
      description: description ?? this.description,
      photoUrls: photoUrls ?? this.photoUrls,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      locationName: locationName ?? this.locationName,
      contactRequested: contactRequested ?? this.contactRequested,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      rsppNotes: rsppNotes ?? this.rsppNotes,
    );
  }

  /// Dati mock per testing
  static List<SafetyReport> mockReports() {
    final now = DateTime.now();
    return [
      SafetyReport(
        id: '1',
        reportCode: 'NM-2025-00123',
        type: ReportType.nearMiss,
        description: 'Cavo elettrico scoperto vicino alla scala.',
        locationName: 'Area 2 - Sede A',
        status: ReportStatus.approved,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      SafetyReport(
        id: '2',
        reportCode: 'PER-2025-00124',
        type: ReportType.imminentDanger,
        description: 'Tubazione instabile vicino alla scala.',
        locationName: 'Area 3 - Sede A',
        status: ReportStatus.inProgress,
        createdAt: now.subtract(const Duration(hours: 4)),
        rsppNotes: 'Area transennata, intervento programmato.',
      ),
      SafetyReport(
        id: '3',
        reportCode: 'SUG-2025-00125',
        type: ReportType.improvement,
        description: 'Migliorare illuminazione corridoio B.',
        locationName: 'Corridoio B',
        status: ReportStatus.underReview,
        createdAt: now.subtract(const Duration(hours: 7)),
      ),
      SafetyReport(
        id: '4',
        reportCode: 'INF-2025-00126',
        type: ReportType.minorInjury,
        description: 'Scivolata su pavimento bagnato.',
        locationName: 'Ingresso principale',
        status: ReportStatus.closed,
        createdAt: now.subtract(const Duration(days: 1)),
        resolvedAt: now.subtract(const Duration(hours: 12)),
        rsppNotes: 'Installato cartello pavimento bagnato.',
      ),
    ];
  }
}
