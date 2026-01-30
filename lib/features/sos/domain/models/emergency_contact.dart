import 'package:flutter/material.dart';

/// Tipologie di contatto di emergenza
enum ContactType {
  shiftSupervisor,
  operationsCenter,
  companySafety,
  emergency118,
  family;

  String get label {
    switch (this) {
      case ContactType.shiftSupervisor:
        return 'Preposto turno';
      case ContactType.operationsCenter:
        return 'Centrale Operativa';
      case ContactType.companySafety:
        return 'Sicurezza Aziendale';
      case ContactType.emergency118:
        return '118';
      case ContactType.family:
        return 'Contatto famiglia';
    }
  }

  String get labelEn {
    switch (this) {
      case ContactType.shiftSupervisor:
        return 'Shift Supervisor';
      case ContactType.operationsCenter:
        return 'Operations Center';
      case ContactType.companySafety:
        return 'Company Safety';
      case ContactType.emergency118:
        return '118';
      case ContactType.family:
        return 'Family Contact';
    }
  }

  IconData get icon {
    switch (this) {
      case ContactType.shiftSupervisor:
        return Icons.badge_rounded;
      case ContactType.operationsCenter:
        return Icons.headset_mic_rounded;
      case ContactType.companySafety:
        return Icons.security_rounded;
      case ContactType.emergency118:
        return Icons.local_hospital_rounded;
      case ContactType.family:
        return Icons.family_restroom_rounded;
    }
  }

  Color get color {
    switch (this) {
      case ContactType.shiftSupervisor:
        return const Color(0xFF1565C0);
      case ContactType.operationsCenter:
        return const Color(0xFF7B1FA2);
      case ContactType.companySafety:
        return const Color(0xFF00838F);
      case ContactType.emergency118:
        return const Color(0xFFD32F2F);
      case ContactType.family:
        return const Color(0xFF2E7D32);
    }
  }
}

/// Modello per un contatto di emergenza
class EmergencyContact {
  const EmergencyContact({
    required this.id,
    required this.type,
    required this.name,
    required this.phoneNumber,
    this.email,
    this.isActive = true,
  });

  final String id;
  final ContactType type;
  final String name;
  final String phoneNumber;
  final String? email;
  final bool isActive;

  EmergencyContact copyWith({
    String? id,
    ContactType? type,
    String? name,
    String? phoneNumber,
    String? email,
    bool? isActive,
  }) {
    return EmergencyContact(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
    );
  }

  /// Crea da JSON (risposta RPC get_my_emergency_contacts).
  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      id: json['id'] as String,
      type: _parseContactType(json['type'] as String?),
      name: json['name'] as String? ?? '',
      phoneNumber: json['phone_number'] as String? ?? '',
      email: json['email'] as String?,
      isActive: json['is_active'] as bool? ?? true,
    );
  }

  static ContactType _parseContactType(String? value) {
    if (value == null) return ContactType.companySafety;
    return ContactType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ContactType.companySafety,
    );
  }

  /// Dati mock per testing
  static List<EmergencyContact> mockContacts() {
    return [
      const EmergencyContact(
        id: '1',
        type: ContactType.shiftSupervisor,
        name: 'Marco Rossi',
        phoneNumber: '+39 333 1234567',
      ),
      const EmergencyContact(
        id: '2',
        type: ContactType.operationsCenter,
        name: 'Centrale Operativa',
        phoneNumber: '+39 02 12345678',
      ),
      const EmergencyContact(
        id: '3',
        type: ContactType.companySafety,
        name: 'Ufficio Sicurezza',
        phoneNumber: '+39 02 87654321',
      ),
      const EmergencyContact(
        id: '4',
        type: ContactType.emergency118,
        name: 'Emergenza Sanitaria',
        phoneNumber: '118',
      ),
      const EmergencyContact(
        id: '5',
        type: ContactType.family,
        name: 'Casa',
        phoneNumber: '+39 345 9876543',
      ),
    ];
  }
}
