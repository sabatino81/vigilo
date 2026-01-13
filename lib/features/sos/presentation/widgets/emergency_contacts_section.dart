import 'package:flutter/material.dart';
import 'package:vigilo/features/sos/domain/models/emergency_contact.dart';
import 'package:vigilo/features/sos/presentation/widgets/emergency_contact_tile.dart';

/// Sezione rubrica emergenza
class EmergencyContactsSection extends StatelessWidget {
  const EmergencyContactsSection({
    required this.contacts,
    required this.onCallContact,
    super.key,
  });

  final List<EmergencyContact> contacts;
  final void Function(EmergencyContact contact) onCallContact;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.contact_phone_rounded,
                  color: isDark ? Colors.white70 : Colors.black54,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'CONTATTI DI SICUREZZA',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                  color: isDark ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ...contacts.map((contact) => EmergencyContactTile(
              contact: contact,
              onCall: () => onCallContact(contact),
            )),
      ],
    );
  }
}
