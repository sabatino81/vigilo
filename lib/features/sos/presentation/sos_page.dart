import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/sos/domain/models/emergency_contact.dart';
import 'package:vigilo/features/sos/domain/models/report_type.dart';
import 'package:vigilo/features/sos/domain/models/safety_report.dart';
import 'package:vigilo/features/sos/presentation/pages/report_detail_page.dart';
import 'package:vigilo/features/sos/presentation/pages/report_form_page.dart';
import 'package:vigilo/features/sos/presentation/widgets/emergency_contacts_section.dart';
import 'package:vigilo/features/sos/presentation/widgets/quick_reports_section.dart';
import 'package:vigilo/features/sos/presentation/widgets/report_history_section.dart';
import 'package:vigilo/features/sos/presentation/widgets/sos_confirmation_dialog.dart';
import 'package:vigilo/features/sos/presentation/widgets/sos_emergency_button.dart';
import 'package:vigilo/features/sos/presentation/widgets/sos_success_dialog.dart';

/// Pagina principale SOS
class SosPage extends StatefulWidget {
  const SosPage({super.key});

  @override
  State<SosPage> createState() => _SosPageState();
}

class _SosPageState extends State<SosPage> {
  late List<EmergencyContact> _contacts;
  late List<SafetyReport> _reports;

  @override
  void initState() {
    super.initState();
    _contacts = EmergencyContact.mockContacts();
    _reports = SafetyReport.mockReports();
  }

  void _onSosActivated() {
    unawaited(SosConfirmationDialog.show(
      context,
      contacts: _contacts,
      onConfirm: (selectedContacts) {
        // Simula invio SOS
        unawaited(SosSuccessDialog.show(
          context,
          locationName: 'Sede A - Area 3',
        ));
      },
    ));
  }

  void _onReportSelected(ReportType type) {
    unawaited(ReportFormSheet.show(context, type));
  }

  void _onCallContact(EmergencyContact contact) {
    // In una implementazione reale qui si userebbe url_launcher
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Chiamata a ${contact.name}: ${contact.phoneNumber}'),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
  }

  void _onReportTap(SafetyReport report) {
    unawaited(ReportDetailSheet.show(context, report));
  }

  void _onViewAllReports() {
    // In una implementazione reale qui si navigherebbe a una pagina
    // con tutte le segnalazioni
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funzione in arrivo'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header
            SliverToBoxAdapter(
              child: _SosPageHeader(isDark: isDark),
            ),

            // Content
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Sezione Emergenza
                  _SectionHeader(
                    title: 'CHIEDI AIUTO',
                    isDark: isDark,
                    color: AppTheme.danger,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppTheme.dangerContainer.withValues(alpha: 0.5),
                          AppTheme.dangerContainer.withValues(alpha: 0.2),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.danger.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppTheme.danger.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(
                                Icons.sos_rounded,
                                color: AppTheme.danger,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Tieni premuto il pulsante rosso per 3 '
                                'secondi per chiedere aiuto.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: isDark
                                      ? Colors.white70
                                      : Colors.black54,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SosEmergencyButton(
                          onActivated: _onSosActivated,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Sezione Segnalazioni Rapide
                  QuickReportsSection(
                    onReportSelected: _onReportSelected,
                  ),
                  const SizedBox(height: 32),

                  // Sezione Rubrica Emergenza
                  EmergencyContactsSection(
                    contacts: _contacts,
                    onCallContact: _onCallContact,
                  ),
                  const SizedBox(height: 32),

                  // Sezione Storico Segnalazioni
                  ReportHistorySection(
                    reports: _reports,
                    onReportTap: _onReportTap,
                    onViewAllTap: _onViewAllReports,
                  ),
                  const SizedBox(height: 32),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SosPageHeader extends StatelessWidget {
  const _SosPageHeader({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppTheme.tertiary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.shield_rounded,
              color: AppTheme.tertiary,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SICUREZZA',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.tertiary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Segnala un problema o chiedi aiuto',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? Colors.white60 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.isDark,
    this.color,
  });

  final String title;
  final bool isDark;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: color ?? AppTheme.tertiary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
            color: isDark ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }
}
