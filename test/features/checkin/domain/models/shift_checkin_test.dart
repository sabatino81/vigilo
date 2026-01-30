import 'package:flutter_test/flutter_test.dart';
import 'package:vigilo/features/checkin/domain/models/shift_checkin.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';

void main() {
  group('DpiRequirement.forCategory', () {
    test('operaio gets 4 DPI items', () {
      final items = DpiRequirement.forCategory(WorkerCategory.operaio);
      expect(items.length, 4);
      final ids = items.map((e) => e.id).toList();
      expect(ids, ['casco', 'scarpe', 'guanti', 'giubbino']);
    });

    test('caposquadra gets 3 DPI items', () {
      final items = DpiRequirement.forCategory(WorkerCategory.caposquadra);
      expect(items.length, 3);
      final ids = items.map((e) => e.id).toList();
      expect(ids, ['casco', 'scarpe', 'giubbino']);
    });

    test('preposto gets 3 DPI items', () {
      final items = DpiRequirement.forCategory(WorkerCategory.preposto);
      expect(items.length, 3);
      final ids = items.map((e) => e.id).toList();
      expect(ids, ['casco', 'scarpe', 'giubbino']);
    });

    test('rspp gets 2 DPI items', () {
      final items = DpiRequirement.forCategory(WorkerCategory.rspp);
      expect(items.length, 2);
      final ids = items.map((e) => e.id).toList();
      expect(ids, ['casco', 'scarpe']);
    });

    test('all DPI items have non-empty id and name', () {
      for (final category in WorkerCategory.values) {
        final items = DpiRequirement.forCategory(category);
        for (final item in items) {
          expect(item.id, isNotEmpty, reason: '$category item has empty id');
          expect(item.name, isNotEmpty,
              reason: '$category item ${item.id} has empty name');
          expect(item.nameEn, isNotEmpty,
              reason: '$category item ${item.id} has empty nameEn');
        }
      }
    });
  });

  group('CheckinStatus', () {
    test('pending has label', () {
      expect(CheckinStatus.pending.label, 'In attesa');
      expect(CheckinStatus.pending.labelEn, 'Pending');
    });

    test('completed has label', () {
      expect(CheckinStatus.completed.label, 'Completato');
      expect(CheckinStatus.completed.labelEn, 'Completed');
    });
  });

  group('ShiftCheckin.allDpiChecked', () {
    test('false when no DPI checked (empty set vs 4 required)', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.operaio,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.operaio),
        checkedDpiIds: const {},
        status: CheckinStatus.pending,
      );
      expect(checkin.allDpiChecked, isFalse);
      expect(checkin.checkedCount, 0);
      expect(checkin.totalCount, 4);
    });

    test('false when partially checked', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.operaio,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.operaio),
        checkedDpiIds: const {'casco', 'scarpe'},
        status: CheckinStatus.pending,
      );
      expect(checkin.allDpiChecked, isFalse);
      expect(checkin.checkedCount, 2);
    });

    test('true when all required DPI checked', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.operaio,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.operaio),
        checkedDpiIds: const {'casco', 'scarpe', 'guanti', 'giubbino'},
        status: CheckinStatus.pending,
      );
      expect(checkin.allDpiChecked, isTrue);
      expect(checkin.checkedCount, 4);
      expect(checkin.totalCount, 4);
    });

    test('true for rspp with 2 DPI checked', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.rspp,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.rspp),
        checkedDpiIds: const {'casco', 'scarpe'},
        status: CheckinStatus.pending,
      );
      expect(checkin.allDpiChecked, isTrue);
    });
  });

  group('ShiftCheckin.toggleDpi', () {
    test('adds unchecked DPI id', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.operaio,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.operaio),
        checkedDpiIds: const {},
        status: CheckinStatus.pending,
      );
      final toggled = checkin.toggleDpi('casco');
      expect(toggled.checkedDpiIds, contains('casco'));
      expect(toggled.checkedCount, 1);
    });

    test('removes already-checked DPI id', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.operaio,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.operaio),
        checkedDpiIds: const {'casco', 'scarpe'},
        status: CheckinStatus.pending,
      );
      final toggled = checkin.toggleDpi('casco');
      expect(toggled.checkedDpiIds, isNot(contains('casco')));
      expect(toggled.checkedDpiIds, contains('scarpe'));
      expect(toggled.checkedCount, 1);
    });

    test('preserves other fields', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.caposquadra,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.caposquadra),
        checkedDpiIds: const {},
        status: CheckinStatus.pending,
        checkinTime: null,
      );
      final toggled = checkin.toggleDpi('casco');
      expect(toggled.workerCategory, WorkerCategory.caposquadra);
      expect(toggled.status, CheckinStatus.pending);
      expect(toggled.checkinTime, isNull);
    });
  });

  group('ShiftCheckin.confirm', () {
    test('sets status to completed and assigns checkinTime', () {
      final checkin = ShiftCheckin(
        workerCategory: WorkerCategory.operaio,
        requiredDpi: DpiRequirement.forCategory(WorkerCategory.operaio),
        checkedDpiIds: const {'casco', 'scarpe', 'guanti', 'giubbino'},
        status: CheckinStatus.pending,
      );
      final confirmed = checkin.confirm();
      expect(confirmed.status, CheckinStatus.completed);
      expect(confirmed.checkinTime, isNotNull);
      expect(confirmed.checkedDpiIds, checkin.checkedDpiIds);
      expect(confirmed.workerCategory, checkin.workerCategory);
    });
  });

  group('ShiftCheckin.fromJson', () {
    test('parses complete JSON with completed status', () {
      final json = <String, dynamic>{
        'status': 'completed',
        'checked_dpi_ids': ['casco', 'scarpe', 'guanti', 'giubbino'],
        'checkin_time': '2025-06-15T08:30:00.000Z',
      };
      final checkin =
          ShiftCheckin.fromJson(json, WorkerCategory.operaio);
      expect(checkin.status, CheckinStatus.completed);
      expect(checkin.checkedDpiIds, {'casco', 'scarpe', 'guanti', 'giubbino'});
      expect(checkin.checkinTime, isNotNull);
      expect(checkin.checkinTime!.year, 2025);
      expect(checkin.workerCategory, WorkerCategory.operaio);
      expect(checkin.requiredDpi.length, 4);
    });

    test('defaults status to pending for null', () {
      final json = <String, dynamic>{
        'status': null,
        'checked_dpi_ids': null,
        'checkin_time': null,
      };
      final checkin =
          ShiftCheckin.fromJson(json, WorkerCategory.operaio);
      expect(checkin.status, CheckinStatus.pending);
      expect(checkin.checkedDpiIds, isEmpty);
      expect(checkin.checkinTime, isNull);
    });

    test('defaults status to pending for unknown value', () {
      final json = <String, dynamic>{
        'status': 'unknown_status',
      };
      final checkin =
          ShiftCheckin.fromJson(json, WorkerCategory.preposto);
      expect(checkin.status, CheckinStatus.pending);
      expect(checkin.requiredDpi.length, 3);
    });

    test('filters non-string items from checked_dpi_ids', () {
      final json = <String, dynamic>{
        'checked_dpi_ids': ['casco', 123, null, 'scarpe'],
      };
      final checkin =
          ShiftCheckin.fromJson(json, WorkerCategory.rspp);
      expect(checkin.checkedDpiIds, {'casco', 'scarpe'});
    });
  });

  group('ShiftCheckin mock factories', () {
    test('mockPending creates pending checkin for operaio', () {
      final checkin = ShiftCheckin.mockPending();
      expect(checkin.status, CheckinStatus.pending);
      expect(checkin.workerCategory, WorkerCategory.operaio);
      expect(checkin.checkedDpiIds, isEmpty);
      expect(checkin.allDpiChecked, isFalse);
    });

    test('mockCompleted creates completed checkin with all DPI', () {
      final checkin = ShiftCheckin.mockCompleted();
      expect(checkin.status, CheckinStatus.completed);
      expect(checkin.workerCategory, WorkerCategory.operaio);
      expect(checkin.allDpiChecked, isTrue);
      expect(checkin.checkinTime, isNotNull);
    });
  });
}
