import 'package:flutter/material.dart';
import 'package:vigilo/features/team/presentation/widgets/safety_star_card.dart';
import 'package:vigilo/features/team/presentation/widgets/team_leaderboard_card.dart';
import 'package:vigilo/features/team/presentation/widgets/transparency_dashboard_card.dart';
import 'package:vigilo/features/team/presentation/widgets/vow_survey_card.dart';

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

        SafetyStarCard(),
        SizedBox(height: 16),

        // Trasparenza e feedback
        TransparencyDashboardCard(),
        SizedBox(height: 16),
        VowSurveyCard(),

        // NOTA: SocialWallCard e TeamChallengeCard spostate in HomePage
        // per massimizzare engagement immediato all'apertura app
      ],
    );
  }
}
