/// Trend posizione in classifica
enum RankTrend {
  up,
  down,
  same;

  String get icon {
    switch (this) {
      case RankTrend.up:
        return '↑';
      case RankTrend.down:
        return '↓';
      case RankTrend.same:
        return '→';
    }
  }
}

/// Voce classifica
class LeaderboardEntry {
  const LeaderboardEntry({
    required this.rank,
    required this.name,
    required this.points,
    required this.trend,
    this.isCurrentUser = false,
    this.avatarUrl,
  });

  final int rank;
  final String name;
  final int points;
  final RankTrend trend;
  final bool isCurrentUser;
  final String? avatarUrl;

  /// Mock data
  static List<LeaderboardEntry> mockLeaderboard() {
    return const [
      LeaderboardEntry(
        rank: 1,
        name: 'Ahmed R.',
        points: 1820,
        trend: RankTrend.up,
      ),
      LeaderboardEntry(
        rank: 2,
        name: 'Maria S.',
        points: 1700,
        trend: RankTrend.same,
      ),
      LeaderboardEntry(
        rank: 3,
        name: 'Ranieri R.',
        points: 1320,
        trend: RankTrend.up,
        isCurrentUser: true,
      ),
      LeaderboardEntry(
        rank: 4,
        name: 'Luca B.',
        points: 1200,
        trend: RankTrend.down,
      ),
      LeaderboardEntry(
        rank: 5,
        name: 'Sofia K.',
        points: 950,
        trend: RankTrend.same,
      ),
    ];
  }
}
