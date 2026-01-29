import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/checkin/domain/models/shift_checkin.dart';
import 'package:vigilo/shared/widgets/points_earned_snackbar.dart';

/// Card check-in turno con checklist DPI autodichiarata
class ShiftCheckinCard extends StatefulWidget {
  const ShiftCheckinCard({super.key});

  @override
  State<ShiftCheckinCard> createState() => _ShiftCheckinCardState();
}

class _ShiftCheckinCardState extends State<ShiftCheckinCard> {
  late ShiftCheckin _checkin;

  @override
  void initState() {
    super.initState();
    _checkin = ShiftCheckin.mockPending();
  }

  void _toggleDpi(String dpiId) {
    if (_checkin.status == CheckinStatus.completed) return;
    HapticFeedback.selectionClick();
    setState(() {
      _checkin = _checkin.toggleDpi(dpiId);
    });
  }

  void _confirmCheckin() {
    if (!_checkin.allDpiChecked) return;
    HapticFeedback.mediumImpact();
    setState(() {
      _checkin = _checkin.confirm();
    });
    PointsEarnedSnackbar.show(
      context,
      points: 10,
      action: 'Check-in turno',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isCompleted = _checkin.status == CheckinStatus.completed;
    final accentColor = isCompleted ? AppTheme.secondary : AppTheme.primary;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.3),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: isDark ? 0.15 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  isCompleted
                      ? Icons.check_circle_rounded
                      : Icons.assignment_rounded,
                  color: accentColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CHECK-IN TURNO',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Autodichiarazione DPI - D.Lgs. 81/2008',
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white54 : Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              // Status badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppTheme.secondary.withValues(alpha: 0.15)
                      : AppTheme.ambra.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCompleted
                          ? Icons.check_circle_rounded
                          : Icons.schedule_rounded,
                      size: 14,
                      color:
                          isCompleted ? AppTheme.secondary : AppTheme.ambra,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isCompleted ? 'Fatto' : 'Da fare',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: isCompleted
                            ? AppTheme.secondary
                            : AppTheme.ambra,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Completed banner
          if (isCompleted) ...[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.secondary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.secondary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.verified_rounded,
                    color: AppTheme.secondary,
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Check-in completato',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.secondary,
                          ),
                        ),
                        if (_checkin.checkinTime != null)
                          Text(
                            'Oggi alle ${_checkin.checkinTime!.hour.toString().padLeft(2, '0')}:${_checkin.checkinTime!.minute.toString().padLeft(2, '0')}',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    '${_checkin.totalCount}/${_checkin.totalCount} DPI',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            // Progress indicator
            Row(
              children: [
                Text(
                  'DPI richiesti per il tuo ruolo',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
                const Spacer(),
                Text(
                  '${_checkin.checkedCount}/${_checkin.totalCount}',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: _checkin.allDpiChecked
                        ? AppTheme.secondary
                        : AppTheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _checkin.totalCount > 0
                    ? _checkin.checkedCount / _checkin.totalCount
                    : 0,
                backgroundColor: isDark
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.06),
                valueColor: AlwaysStoppedAnimation<Color>(
                  _checkin.allDpiChecked
                      ? AppTheme.secondary
                      : AppTheme.primary,
                ),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 16),

            // DPI checklist
            ...List.generate(_checkin.requiredDpi.length, (i) {
              final dpi = _checkin.requiredDpi[i];
              final isChecked = _checkin.checkedDpiIds.contains(dpi.id);
              return _DpiCheckItem(
                dpi: dpi,
                isChecked: isChecked,
                onTap: () => _toggleDpi(dpi.id),
                isDark: isDark,
              );
            }),

            const SizedBox(height: 16),

            // Confirm button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _checkin.allDpiChecked ? _confirmCheckin : null,
                icon: const Icon(Icons.check_rounded, size: 20),
                label: Text(
                  _checkin.allDpiChecked
                      ? 'CONFERMA CHECK-IN'
                      : 'Seleziona tutti i DPI',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondary,
                  foregroundColor: AppTheme.onSecondary,
                  disabledBackgroundColor: isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  disabledForegroundColor:
                      isDark ? Colors.white38 : Colors.black26,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: _checkin.allDpiChecked ? 2 : 0,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DpiCheckItem extends StatelessWidget {
  const _DpiCheckItem({
    required this.dpi,
    required this.isChecked,
    required this.onTap,
    required this.isDark,
  });

  final DpiItem dpi;
  final bool isChecked;
  final VoidCallback onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: isChecked
                ? AppTheme.secondary.withValues(alpha: 0.1)
                : isDark
                    ? Colors.white.withValues(alpha: 0.05)
                    : Colors.black.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isChecked
                  ? AppTheme.secondary.withValues(alpha: 0.4)
                  : isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.black.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isChecked
                      ? AppTheme.secondary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isChecked
                        ? AppTheme.secondary
                        : isDark
                            ? Colors.white38
                            : Colors.black26,
                    width: 2,
                  ),
                ),
                child: isChecked
                    ? const Icon(
                        Icons.check_rounded,
                        size: 16,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Icon(
                dpi.icon,
                size: 20,
                color: isChecked
                    ? AppTheme.secondary
                    : isDark
                        ? Colors.white54
                        : Colors.black45,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  dpi.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isChecked ? FontWeight.w600 : FontWeight.w500,
                    color: isChecked
                        ? AppTheme.secondary
                        : isDark
                            ? Colors.white70
                            : Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
