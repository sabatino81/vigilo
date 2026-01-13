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
