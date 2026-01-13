import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final size = MediaQuery.sizeOf(context);

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [
                  const Color(0xFF1A1A1A),
                  const Color(0xFF0D0D0D),
                ]
              : [
                  const Color(0xFFF5F5F5),
                  const Color(0xFFE8E8E8),
                ],
        ),
      ),
      child: Stack(
        children: [
          // Industrial diagonal stripes - top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              size: Size(size.width, 120),
              painter: _HazardStripesPainter(
                color: AppTheme.primary,
                opacity: isDark ? 0.15 : 0.2,
              ),
            ),
          ),

          // Heavy corner bracket - top left
          Positioned(
            top: 0,
            left: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: _CornerBracketPainter(
                color: isDark
                    ? AppTheme.primary.withValues(alpha: 0.4)
                    : AppTheme.primary.withValues(alpha: 0.5),
                strokeWidth: 6,
                isTopLeft: true,
              ),
            ),
          ),

          // Heavy corner bracket - bottom right
          Positioned(
            bottom: 100,
            right: 0,
            child: CustomPaint(
              size: const Size(100, 100),
              painter: _CornerBracketPainter(
                color: isDark
                    ? AppTheme.secondary.withValues(alpha: 0.35)
                    : AppTheme.secondary.withValues(alpha: 0.45),
                strokeWidth: 6,
                isTopLeft: false,
              ),
            ),
          ),

          // Industrial bar - left side
          Positioned(
            top: size.height * 0.2,
            left: 0,
            child: Container(
              width: 8,
              height: size.height * 0.3,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.primary.withValues(alpha: isDark ? 0.5 : 0.6),
                    AppTheme.primary.withValues(alpha: 0),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
            ),
          ),

          // Industrial bar - right side
          Positioned(
            top: size.height * 0.45,
            right: 0,
            child: Container(
              width: 8,
              height: size.height * 0.25,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.secondary.withValues(alpha: 0),
                    AppTheme.secondary.withValues(alpha: isDark ? 0.45 : 0.55),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
            ),
          ),

          // Hex bolt pattern
          Positioned(
            top: size.height * 0.15,
            right: 20,
            child: _HexBolt(
              size: 24,
              color: isDark
                  ? AppTheme.neutral.withValues(alpha: 0.25)
                  : AppTheme.neutral.withValues(alpha: 0.2),
            ),
          ),
          Positioned(
            top: size.height * 0.35,
            left: 20,
            child: _HexBolt(
              size: 20,
              color: isDark
                  ? AppTheme.neutral.withValues(alpha: 0.2)
                  : AppTheme.neutral.withValues(alpha: 0.15),
            ),
          ),
          Positioned(
            bottom: size.height * 0.25,
            left: 30,
            child: _HexBolt(
              size: 18,
              color: isDark
                  ? AppTheme.neutral.withValues(alpha: 0.22)
                  : AppTheme.neutral.withValues(alpha: 0.18),
            ),
          ),

          // Warning badge accent
          Positioned(
            top: size.height * 0.08,
            right: size.width * 0.15,
            child: _WarningBadge(
              size: 50,
              color: AppTheme.primary,
              opacity: isDark ? 0.25 : 0.35,
            ),
          ),

          // Safety circle accent
          Positioned(
            bottom: size.height * 0.15,
            right: size.width * 0.08,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.secondary.withValues(alpha: isDark ? 0.3 : 0.4),
                  width: 4,
                ),
              ),
              child: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppTheme.secondary.withValues(alpha: isDark ? 0.15 : 0.2),
                  ),
                ),
              ),
            ),
          ),

          // Grid dots pattern
          Positioned.fill(
            child: CustomPaint(
              painter: _GridDotsPainter(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.04)
                    : Colors.black.withValues(alpha: 0.04),
              ),
            ),
          ),

          // Content
          child,
        ],
      ),
    );
  }
}

class _HazardStripesPainter extends CustomPainter {
  _HazardStripesPainter({
    required this.color,
    required this.opacity,
  });

  final Color color;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.fill;

    const stripeWidth = 30.0;
    const gap = 30.0;

    for (double x = -size.height; x < size.width + size.height; x += stripeWidth + gap) {
      final path = Path()
        ..moveTo(x, size.height)
        ..lineTo(x + stripeWidth, size.height)
        ..lineTo(x + size.height + stripeWidth, 0)
        ..lineTo(x + size.height, 0)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _CornerBracketPainter extends CustomPainter {
  _CornerBracketPainter({
    required this.color,
    required this.strokeWidth,
    required this.isTopLeft,
  });

  final Color color;
  final double strokeWidth;
  final bool isTopLeft;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.square;

    final path = Path();

    if (isTopLeft) {
      path.moveTo(0, size.height * 0.7);
      path.lineTo(0, 0);
      path.lineTo(size.width * 0.7, 0);
    } else {
      path.moveTo(size.width, size.height * 0.3);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width * 0.3, size.height);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HexBolt extends StatelessWidget {
  const _HexBolt({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _HexBoltPainter(color: color),
    );
  }
}

class _HexBoltPainter extends CustomPainter {
  _HexBoltPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60 - 30) * 3.14159 / 180;
      final x = center.dx + radius * 0.95 * (angle).cos();
      final y = center.dy + radius * 0.95 * (angle).sin();
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);

    // Inner circle
    final innerPaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius * 0.4, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WarningBadge extends StatelessWidget {
  const _WarningBadge({
    required this.size,
    required this.color,
    required this.opacity,
  });

  final double size;
  final Color color;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size * 0.9),
      painter: _WarningBadgePainter(
        color: color.withValues(alpha: opacity),
      ),
    );
  }
}

class _WarningBadgePainter extends CustomPainter {
  _WarningBadgePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);

    // Inner triangle
    final innerPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final innerPath = Path()
      ..moveTo(size.width / 2, size.height * 0.25)
      ..lineTo(size.width * 0.8, size.height * 0.8)
      ..lineTo(size.width * 0.2, size.height * 0.8)
      ..close();

    canvas.drawPath(innerPath, innerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GridDotsPainter extends CustomPainter {
  _GridDotsPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    const spacing = 50.0;
    const dotRadius = 1.5;

    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotRadius, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension on double {
  double cos() => _cos(this);
  double sin() => _sin(this);
}

double _cos(double radians) {
  return 1.0 - (radians * radians) / 2 + (radians * radians * radians * radians) / 24;
}

double _sin(double radians) {
  return radians - (radians * radians * radians) / 6 + (radians * radians * radians * radians * radians) / 120;
}
