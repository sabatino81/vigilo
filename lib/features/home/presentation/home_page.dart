import 'package:flutter/material.dart';
import 'package:vigilo/features/daily_todo/presentation/widgets/daily_todo_card.dart';
import 'package:vigilo/features/dpi_status/presentation/widgets/dpi_status_card.dart';
import 'package:vigilo/features/home/presentation/widgets/site_access_card.dart';
import 'package:vigilo/features/home/presentation/widgets/welcome_guide_card.dart';
import 'package:vigilo/features/personal_kpi/presentation/widgets/personal_kpi_card.dart';
import 'package:vigilo/features/safety_score/presentation/widgets/safety_score_card.dart';
import 'package:vigilo/features/smart_break/presentation/widgets/smart_break_card.dart';
import 'package:vigilo/features/team/presentation/widgets/social_wall_card.dart';
import 'package:vigilo/features/team/presentation/widgets/team_challenge_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
      children: const [
        // PRIORITÀ 1: Accesso cantiere - verifica conformità D.Lgs. 81/2008
        SiteAccessCard(),
        SizedBox(height: 16),

        // PRIORITÀ 2: Score sicurezza - visione immediata del proprio stato
        SafetyScoreCard(),
        SizedBox(height: 16),

        // PRIORITÀ 3: Visual engagement - bacheca cantiere con foto colleghi
        SocialWallCard(),
        SizedBox(height: 16),

        // PRIORITÀ 4: Safety pratico - status DPI con alert visivi
        DpiStatusCard(),
        SizedBox(height: 16),

        // PRIORITÀ 5: Motivazione team - challenge attiva con hot streak
        TeamChallengeCard(),
        SizedBox(height: 16),

        // PRIORITÀ 6: Info pratica immediata - countdown pausa
        SmartBreakCard(),
        SizedBox(height: 16),

        // Info aggiuntive
        WelcomeGuideCard(),
        SizedBox(height: 16),
        DailyTodoCard(),
        SizedBox(height: 16),
        PersonalKpiCard(),
      ],
    );
  }
}
