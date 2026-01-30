import 'package:flutter/material.dart';
import 'package:vigilo/features/profile/domain/models/user_profile.dart';

/// Singolo DPI richiesto per il ruolo
class DpiItem {
  const DpiItem({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.icon,
  });

  final String id;
  final String name;
  final String nameEn;
  final IconData icon;
}

/// DPI richiesti per categoria lavoratore
class DpiRequirement {
  const DpiRequirement._();

  /// Restituisce la lista DPI per la categoria lavoratore
  static List<DpiItem> forCategory(WorkerCategory category) {
    switch (category) {
      case WorkerCategory.operaio:
        return const [
          DpiItem(
            id: 'casco',
            name: 'Casco protettivo',
            nameEn: 'Safety helmet',
            icon: Icons.construction_rounded,
          ),
          DpiItem(
            id: 'scarpe',
            name: 'Scarpe antinfortunistiche',
            nameEn: 'Safety shoes',
            icon: Icons.do_not_step_rounded,
          ),
          DpiItem(
            id: 'guanti',
            name: 'Guanti protettivi',
            nameEn: 'Safety gloves',
            icon: Icons.back_hand_rounded,
          ),
          DpiItem(
            id: 'giubbino',
            name: 'Giubbino alta visibilita',
            nameEn: 'High-vis vest',
            icon: Icons.visibility_rounded,
          ),
        ];
      case WorkerCategory.caposquadra:
        return const [
          DpiItem(
            id: 'casco',
            name: 'Casco protettivo',
            nameEn: 'Safety helmet',
            icon: Icons.construction_rounded,
          ),
          DpiItem(
            id: 'scarpe',
            name: 'Scarpe antinfortunistiche',
            nameEn: 'Safety shoes',
            icon: Icons.do_not_step_rounded,
          ),
          DpiItem(
            id: 'giubbino',
            name: 'Giubbino alta visibilita',
            nameEn: 'High-vis vest',
            icon: Icons.visibility_rounded,
          ),
        ];
      case WorkerCategory.preposto:
        return const [
          DpiItem(
            id: 'casco',
            name: 'Casco protettivo',
            nameEn: 'Safety helmet',
            icon: Icons.construction_rounded,
          ),
          DpiItem(
            id: 'scarpe',
            name: 'Scarpe antinfortunistiche',
            nameEn: 'Safety shoes',
            icon: Icons.do_not_step_rounded,
          ),
          DpiItem(
            id: 'giubbino',
            name: 'Giubbino alta visibilita',
            nameEn: 'High-vis vest',
            icon: Icons.visibility_rounded,
          ),
        ];
      case WorkerCategory.rspp:
        return const [
          DpiItem(
            id: 'casco',
            name: 'Casco protettivo',
            nameEn: 'Safety helmet',
            icon: Icons.construction_rounded,
          ),
          DpiItem(
            id: 'scarpe',
            name: 'Scarpe antinfortunistiche',
            nameEn: 'Safety shoes',
            icon: Icons.do_not_step_rounded,
          ),
        ];
    }
  }
}

/// Stato del check-in turno
enum CheckinStatus {
  pending,
  completed;

  String get label {
    switch (this) {
      case CheckinStatus.pending:
        return 'In attesa';
      case CheckinStatus.completed:
        return 'Completato';
    }
  }

  String get labelEn {
    switch (this) {
      case CheckinStatus.pending:
        return 'Pending';
      case CheckinStatus.completed:
        return 'Completed';
    }
  }
}

/// Check-in turno giornaliero
class ShiftCheckin {
  const ShiftCheckin({
    required this.workerCategory,
    required this.requiredDpi,
    required this.checkedDpiIds,
    required this.status,
    this.checkinTime,
  });

  final WorkerCategory workerCategory;
  final List<DpiItem> requiredDpi;
  final Set<String> checkedDpiIds;
  final CheckinStatus status;
  final DateTime? checkinTime;

  bool get allDpiChecked =>
      requiredDpi.every((dpi) => checkedDpiIds.contains(dpi.id));

  int get checkedCount => checkedDpiIds.length;
  int get totalCount => requiredDpi.length;

  ShiftCheckin toggleDpi(String dpiId) {
    final updated = Set<String>.from(checkedDpiIds);
    if (updated.contains(dpiId)) {
      updated.remove(dpiId);
    } else {
      updated.add(dpiId);
    }
    return ShiftCheckin(
      workerCategory: workerCategory,
      requiredDpi: requiredDpi,
      checkedDpiIds: updated,
      status: status,
      checkinTime: checkinTime,
    );
  }

  ShiftCheckin confirm() {
    return ShiftCheckin(
      workerCategory: workerCategory,
      requiredDpi: requiredDpi,
      checkedDpiIds: checkedDpiIds,
      status: CheckinStatus.completed,
      checkinTime: DateTime.now(),
    );
  }

  /// Crea da JSON (risposta RPC get_today_checkin).
  factory ShiftCheckin.fromJson(
    Map<String, dynamic> json,
    WorkerCategory category,
  ) {
    final status = json['status'] as String?;
    final dpiIds = json['checked_dpi_ids'];
    final checkedIds = <String>{};
    if (dpiIds is List) {
      for (final id in dpiIds) {
        if (id is String) checkedIds.add(id);
      }
    }
    final checkinTimeStr = json['checkin_time'] as String?;

    return ShiftCheckin(
      workerCategory: category,
      requiredDpi: DpiRequirement.forCategory(category),
      checkedDpiIds: checkedIds,
      status: status == 'completed'
          ? CheckinStatus.completed
          : CheckinStatus.pending,
      checkinTime: checkinTimeStr != null
          ? DateTime.tryParse(checkinTimeStr)
          : null,
    );
  }

  /// Mock: check-in pendente per operaio
  static ShiftCheckin mockPending() {
    final category = WorkerCategory.operaio;
    return ShiftCheckin(
      workerCategory: category,
      requiredDpi: DpiRequirement.forCategory(category),
      checkedDpiIds: const {},
      status: CheckinStatus.pending,
    );
  }

  /// Mock: check-in completato
  static ShiftCheckin mockCompleted() {
    final category = WorkerCategory.operaio;
    final dpiList = DpiRequirement.forCategory(category);
    return ShiftCheckin(
      workerCategory: category,
      requiredDpi: dpiList,
      checkedDpiIds: dpiList.map((d) => d.id).toSet(),
      status: CheckinStatus.completed,
      checkinTime: DateTime.now().subtract(const Duration(hours: 1)),
    );
  }
}
