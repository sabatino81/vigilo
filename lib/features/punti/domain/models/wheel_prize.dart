import 'package:flutter/material.dart';

/// Tipo di premio ruota
enum WheelPrizeType {
  points,
  gadget,
  nothing;
}

/// Premio sulla ruota
class WheelPrize {
  const WheelPrize({
    required this.id,
    required this.label,
    required this.type,
    required this.color,
    this.pointsValue,
    this.gadgetName,
  });

  final String id;
  final String label;
  final WheelPrizeType type;
  final Color color;
  final int? pointsValue;
  final String? gadgetName;

  bool get isWin => type != WheelPrizeType.nothing;

  /// Premi standard sulla ruota
  static List<WheelPrize> standardPrizes() {
    return const [
      WheelPrize(
        id: 'p1',
        label: '+10 pt',
        type: WheelPrizeType.points,
        color: Color(0xFF4CAF50),
        pointsValue: 10,
      ),
      WheelPrize(
        id: 'p2',
        label: '+50 pt',
        type: WheelPrizeType.points,
        color: Color(0xFF2196F3),
        pointsValue: 50,
      ),
      WheelPrize(
        id: 'p3',
        label: 'Niente',
        type: WheelPrizeType.nothing,
        color: Color(0xFF9E9E9E),
      ),
      WheelPrize(
        id: 'p4',
        label: '+100 pt',
        type: WheelPrizeType.points,
        color: Color(0xFFFF9800),
        pointsValue: 100,
      ),
      WheelPrize(
        id: 'p5',
        label: '+20 pt',
        type: WheelPrizeType.points,
        color: Color(0xFF8BC34A),
        pointsValue: 20,
      ),
      WheelPrize(
        id: 'p6',
        label: 'Niente',
        type: WheelPrizeType.nothing,
        color: Color(0xFF757575),
      ),
      WheelPrize(
        id: 'p7',
        label: 'Snack',
        type: WheelPrizeType.gadget,
        color: Color(0xFFE91E63),
        gadgetName: 'Buono snack',
      ),
      WheelPrize(
        id: 'p8',
        label: '+30 pt',
        type: WheelPrizeType.points,
        color: Color(0xFF00BCD4),
        pointsValue: 30,
      ),
    ];
  }
}
