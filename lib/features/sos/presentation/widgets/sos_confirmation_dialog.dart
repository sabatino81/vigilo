import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/sos/domain/models/emergency_contact.dart';

/// Dialog di conferma prima dell'invio SOS
class SosConfirmationDialog extends StatefulWidget {
  const SosConfirmationDialog({
    required this.contacts,
    required this.onConfirm,
    super.key,
  });

  final List<EmergencyContact> contacts;
  final void Function(List<EmergencyContact> selectedContacts) onConfirm;

  @override
  State<SosConfirmationDialog> createState() => _SosConfirmationDialogState();

  static Future<void> show(
    BuildContext context, {
    required List<EmergencyContact> contacts,
    required void Function(List<EmergencyContact> selectedContacts) onConfirm,
  }) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => SosConfirmationDialog(
        contacts: contacts,
        onConfirm: onConfirm,
      ),
    );
  }
}

class _SosConfirmationDialogState extends State<SosConfirmationDialog> {
  late Set<String> _selectedContactIds;

  @override
  void initState() {
    super.initState();
    // Seleziona tutti i contatti di default
    _selectedContactIds = widget.contacts.map((c) => c.id).toSet();
  }

  void _toggleContact(String contactId) {
    setState(() {
      if (_selectedContactIds.contains(contactId)) {
        _selectedContactIds.remove(contactId);
      } else {
        _selectedContactIds.add(contactId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AlertDialog(
      backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: AppTheme.danger,
          width: 2,
        ),
      ),
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.dangerContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.warning_rounded,
              color: AppTheme.danger,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Vuoi davvero inviare un SOS?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Saranno avvisati subito:',
            style: TextStyle(
              color: isDark ? Colors.white70 : Colors.black87,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 16),
          ...widget.contacts.map((contact) => _ContactCheckbox(
                contact: contact,
                isSelected: _selectedContactIds.contains(contact.id),
                onChanged: () => _toggleContact(contact.id),
              )),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'ANNULLA',
            style: TextStyle(
              color: isDark ? Colors.white60 : Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        FilledButton(
          onPressed: _selectedContactIds.isEmpty
              ? null
              : () {
                  Navigator.of(context).pop();
                  final selectedContacts = widget.contacts
                      .where((c) => _selectedContactIds.contains(c.id))
                      .toList();
                  widget.onConfirm(selectedContacts);
                },
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.danger,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.send_rounded, size: 18),
              SizedBox(width: 8),
              Text(
                'INVIA SOS',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ContactCheckbox extends StatelessWidget {
  const _ContactCheckbox({
    required this.contact,
    required this.isSelected,
    required this.onChanged,
  });

  final EmergencyContact contact;
  final bool isSelected;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onChanged,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Checkbox(
              value: isSelected,
              onChanged: (_) => onChanged(),
              activeColor: AppTheme.danger,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: contact.type.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                contact.type.icon,
                color: contact.type.color,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.type.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    contact.name,
                    style: TextStyle(
                      color: isDark ? Colors.white60 : Colors.black54,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
