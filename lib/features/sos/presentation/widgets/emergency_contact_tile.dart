import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/features/sos/domain/models/emergency_contact.dart';

/// Tile per un singolo contatto di emergenza
class EmergencyContactTile extends StatelessWidget {
  const EmergencyContactTile({
    required this.contact,
    required this.onCall,
    super.key,
  });

  final EmergencyContact contact;
  final VoidCallback onCall;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.05)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: contact.type.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            contact.type.icon,
            color: contact.type.color,
            size: 24,
          ),
        ),
        title: Text(
          contact.type.label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isDark ? Colors.white : Colors.black87,
          ),
        ),
        subtitle: Text(
          contact.name,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? Colors.white54 : Colors.black45,
          ),
        ),
        trailing: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              unawaited(HapticFeedback.mediumImpact());
              onCall();
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.phone_rounded,
                color: Color(0xFF2E7D32),
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
