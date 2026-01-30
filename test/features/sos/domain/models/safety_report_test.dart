import 'package:test/test.dart';
import 'package:vigilo/features/sos/domain/models/report_status.dart';
import 'package:vigilo/features/sos/domain/models/report_type.dart';
import 'package:vigilo/features/sos/domain/models/safety_report.dart';

void main() {
  group('SafetyReport.fromJson', () {
    test('parses complete report', () {
      final json = {
        'id': 'r1',
        'report_code': 'NM-2025-00123',
        'type': 'nearMiss',
        'description': 'Cavo scoperto',
        'photo_urls': ['https://img.com/1.jpg', 'https://img.com/2.jpg'],
        'latitude': 45.464,
        'longitude': 9.191,
        'location_name': 'Sede A',
        'contact_requested': true,
        'status': 'approved',
        'created_at': '2025-01-15T10:00:00Z',
        'resolved_at': '2025-01-16T10:00:00Z',
        'rspp_notes': 'Area transennata.',
      };

      final r = SafetyReport.fromJson(json);
      expect(r.id, 'r1');
      expect(r.reportCode, 'NM-2025-00123');
      expect(r.type, ReportType.nearMiss);
      expect(r.description, 'Cavo scoperto');
      expect(r.photoUrls, hasLength(2));
      expect(r.latitude, 45.464);
      expect(r.longitude, 9.191);
      expect(r.locationName, 'Sede A');
      expect(r.contactRequested, isTrue);
      expect(r.status, ReportStatus.approved);
      expect(r.rsppNotes, 'Area transennata.');
    });

    test('parses photo_urls filtering non-strings', () {
      final json = {
        'id': 'r2',
        'type': 'nearMiss',
        'description': 'Test',
        'photo_urls': ['url1', 123, null, 'url2'],
        'created_at': '2025-01-15T10:00:00Z',
      };

      final r = SafetyReport.fromJson(json);
      expect(r.photoUrls, ['url1', 'url2']);
    });

    test('handles missing optional fields', () {
      final json = {
        'id': 'r3',
        'created_at': '2025-01-15T10:00:00Z',
      };

      final r = SafetyReport.fromJson(json);
      expect(r.reportCode, isNull);
      expect(r.type, ReportType.nearMiss);
      expect(r.description, '');
      expect(r.photoUrls, isEmpty);
      expect(r.latitude, isNull);
      expect(r.longitude, isNull);
      expect(r.locationName, isNull);
      expect(r.contactRequested, isFalse);
      expect(r.status, ReportStatus.pending);
      expect(r.resolvedAt, isNull);
      expect(r.rsppNotes, isNull);
    });

    test('defaults type to nearMiss for unknown', () {
      final json = {
        'id': 'r4',
        'type': 'unknown_type',
        'created_at': '2025-01-15T10:00:00Z',
      };

      expect(SafetyReport.fromJson(json).type, ReportType.nearMiss);
    });

    test('defaults status to pending for unknown', () {
      final json = {
        'id': 'r5',
        'status': 'unknown_status',
        'created_at': '2025-01-15T10:00:00Z',
      };

      expect(SafetyReport.fromJson(json).status, ReportStatus.pending);
    });
  });

  group('SafetyReport.copyWith', () {
    test('changes status', () {
      final report = SafetyReport(
        id: 'r1',
        type: ReportType.nearMiss,
        description: 'Test',
        createdAt: DateTime(2025, 1, 15),
      );

      final updated = report.copyWith(status: ReportStatus.closed);
      expect(updated.status, ReportStatus.closed);
      expect(updated.id, 'r1');
      expect(updated.type, ReportType.nearMiss);
    });
  });

  group('ReportType enum', () {
    test('all values have label', () {
      for (final t in ReportType.values) {
        expect(t.label, isNotEmpty);
      }
    });
  });

  group('ReportStatus enum', () {
    test('all values have label', () {
      for (final s in ReportStatus.values) {
        expect(s.label, isNotEmpty);
      }
    });
  });
}
