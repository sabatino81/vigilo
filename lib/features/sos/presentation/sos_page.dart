import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:vigilo/features/sos/providers/sos_providers.dart';

/// Pagina principale SOS — ConsumerWidget con dati da Supabase.
class SosPage extends ConsumerWidget {
  const SosPage({super.key});

  void _onSosActivated(BuildContext context, List<EmergencyContact> contacts) {
    unawaited(SosConfirmationDialog.show(
      context,
      contacts: contacts,
      onConfirm: (selectedContacts) {
        unawaited(SosSuccessDialog.show(
          context,
          locationName: 'Sede A - Area 3',
        ));
      },
    ));
  }

  void _onReportSelected(BuildContext context, ReportType type) {
    unawaited(ReportFormSheet.show(context, type));
  }

  void _onCallContact(BuildContext context, EmergencyContact contact) {
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

  void _onReportTap(BuildContext context, SafetyReport report) {
    unawaited(ReportDetailSheet.show(context, report));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final contactsAsync = ref.watch(emergencyContactsProvider);
    final reportsAsync = ref.watch(safetyReportsProvider);

    // Estrai dati con fallback
    final contacts = contactsAsync.when(
      data: (c) => c,
      loading: () => <EmergencyContact>[],
      error: (_, __) => <EmergencyContact>[],
    );
    final reports = reportsAsync.when(
      data: (r) => r,
      loading: () => <SafetyReport>[],
      error: (_, __) => <SafetyReport>[],
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(emergencyContactsProvider);
            ref.invalidate(safetyReportsProvider);
          },
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
                            onActivated: () =>
                                _onSosActivated(context, contacts),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Sezione Segnalazioni Rapide
                    QuickReportsSection(
                      onReportSelected: (type) =>
                          _onReportSelected(context, type),
                    ),
                    const SizedBox(height: 32),

                    // Sezione Rubrica Emergenza
                    if (contacts.isNotEmpty)
                      EmergencyContactsSection(
                        contacts: contacts,
                        onCallContact: (c) => _onCallContact(context, c),
                      ),
                    if (contacts.isNotEmpty) const SizedBox(height: 32),

                    // Sezione Storico Segnalazioni
                    if (reports.isNotEmpty)
                      ReportHistorySection(
                        reports: reports,
                        onReportTap: (r) => _onReportTap(context, r),
                        onViewAllTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Funzione in arrivo'),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 32),
                  ]),
                ),
              ),
            ],
          ),
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
