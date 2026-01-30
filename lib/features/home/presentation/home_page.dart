import 'package:flutter/material.dart';
import 'package:vigilo/features/checkin/presentation/widgets/shift_checkin_card.dart';
import 'package:vigilo/features/daily_todo/presentation/widgets/daily_todo_card.dart';
import 'package:vigilo/features/home/presentation/widgets/welcome_guide_card.dart';
import 'package:vigilo/features/personal_kpi/presentation/widgets/personal_kpi_card.dart';
import 'package:vigilo/features/safety_score/presentation/widgets/safety_score_card.dart';
import 'package:vigilo/features/smart_break/presentation/widgets/smart_break_card.dart';
import 'package:vigilo/features/team/presentation/widgets/social_wall_card.dart';
import 'package:vigilo/features/team/presentation/widgets/safety_star_card.dart';
import 'package:vigilo/features/team/presentation/widgets/team_challenge_card.dart';
import 'package:vigilo/features/team/presentation/widgets/vow_survey_card.dart';
import 'package:vigilo/features/team/presentation/widgets/wellness_checkin_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
      children: const [
        // PRIORITA 0: Empatia - "come ti senti oggi?"
        WellnessCheckinCard(),
        SizedBox(height: 16),

        // PRIORITA 1: Check-in turno - autodichiarazione DPI per ruolo
        ShiftCheckinCard(),
        SizedBox(height: 16),

        // PRIORITA 2: Score sicurezza - visione immediata del proprio stato
        SafetyScoreCard(),
        SizedBox(height: 16),

        // PRIORITA 3: Visual engagement - bacheca con foto colleghi
        SocialWallCard(),
        SizedBox(height: 16),

        // PRIORITA 4: Motivazione team - challenge attiva con hot streak
        TeamChallengeCard(),
        SizedBox(height: 16),

        // PRIORITA 5: Info pratica immediata - countdown pausa
        SmartBreakCard(),
        SizedBox(height: 16),

        // Stella sicurezza della settimana
        SafetyStarCard(),
        SizedBox(height: 16),

        // Sondaggio VOW
        VowSurveyCard(),
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
