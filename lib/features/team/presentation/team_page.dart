import 'package:flutter/material.dart';
import 'package:vigilo/features/team/presentation/widgets/team_leaderboard_card.dart';
import 'package:vigilo/features/team/presentation/widgets/transparency_dashboard_card.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
      children: const [
        // Squadra + Membri + Classifica (card unificata)
        TeamLeaderboardCard(),
        SizedBox(height: 16),

        // Trasparenza e feedback
        TransparencyDashboardCard(),
      ],
    );
  }
}
