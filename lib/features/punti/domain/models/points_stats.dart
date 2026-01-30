/// Statistiche punti
class PointsStats {
  const PointsStats({
    required this.totalPoints,
    required this.pointsLast7Days,
    required this.pointsLast30Days,
    required this.missionsLast7Days,
    required this.missionsLast30Days,
    required this.dailyPoints,
  });

  final int totalPoints;
  final int pointsLast7Days;
  final int pointsLast30Days;
  final int missionsLast7Days;
  final int missionsLast30Days;

  /// Punti giornalieri ultimi 7 giorni (L, M, M, G, V, S, D)
  final List<int> dailyPoints;

  /// Crea da JSON (risposta RPC get_my_points_stats).
  factory PointsStats.fromJson(Map<String, dynamic> json) {
    final daily = json['daily_points'];
    final dailyList = <int>[];
    if (daily is List) {
      for (final v in daily) {
        dailyList.add((v as num?)?.toInt() ?? 0);
      }
    }
    return PointsStats(
      totalPoints: json['total_points'] as int? ?? 0,
      pointsLast7Days: json['points_last_7_days'] as int? ?? 0,
      pointsLast30Days: json['points_last_30_days'] as int? ?? 0,
      missionsLast7Days: json['missions_last_7_days'] as int? ?? 0,
      missionsLast30Days: json['missions_last_30_days'] as int? ?? 0,
      dailyPoints: dailyList,
    );
  }

  /// Max punti giornalieri (per normalizzare il grafico)
  int get maxDailyPoints {
    if (dailyPoints.isEmpty) return 0;
    return dailyPoints.reduce((a, b) => a > b ? a : b);
  }

  /// Mock data
  static PointsStats mockStats() {
    return const PointsStats(
      totalPoints: 1320,
      pointsLast7Days: 130,
      pointsLast30Days: 490,
      missionsLast7Days: 9,
      missionsLast30Days: 32,
      dailyPoints: [25, 18, 12, 30, 20, 15, 10],
    );
  }
}
