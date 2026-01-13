import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/punti/domain/models/wheel_prize.dart';

/// Pagina Gira la Ruota
class SpinWheelPage extends StatefulWidget {
  const SpinWheelPage({
    required this.hasSpinAvailable,
    required this.currentPoints,
    super.key,
  });

  final bool hasSpinAvailable;
  final int currentPoints;

  @override
  State<SpinWheelPage> createState() => _SpinWheelPageState();
}

class _SpinWheelPageState extends State<SpinWheelPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;
  final List<WheelPrize> _prizes = WheelPrize.standardPrizes();
  bool _isSpinning = false;
  bool _hasSpun = false;
  WheelPrize? _wonPrize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spin() {
    if (_isSpinning || _hasSpun || !widget.hasSpinAvailable) return;

    setState(() => _isSpinning = true);
    unawaited(HapticFeedback.mediumImpact());

    // Scegli un premio casuale
    final random = math.Random();
    final prizeIndex = random.nextInt(_prizes.length);
    _wonPrize = _prizes[prizeIndex];

    // Calcola l'angolo finale
    // La ruota ha 8 sezioni da 45° ciascuna
    final sectionAngle = 2 * math.pi / _prizes.length;
    final targetAngle = sectionAngle * prizeIndex;
    // Aggiungi giri extra (4-6 giri completi) + offset per centrare sul premio
    final extraRotations = (4 + random.nextInt(3)) * 2 * math.pi;
    final finalAngle = extraRotations + (2 * math.pi - targetAngle);

    _animation = Tween<double>(
      begin: 0,
      end: finalAngle,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward().then((_) {
      setState(() {
        _isSpinning = false;
        _hasSpun = true;
      });
      unawaited(HapticFeedback.heavyImpact());
      _showResultDialog();
    });
  }

  void _showResultDialog() {
    final prize = _wonPrize!;
    final isWin = prize.isWin;
    final wonPoints = prize.pointsValue ?? 0;

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: isWin
                    ? AppTheme.secondary.withValues(alpha: 0.15)
                    : Colors.grey.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isWin ? Icons.celebration_rounded : Icons.sentiment_neutral,
                color: isWin ? AppTheme.secondary : Colors.grey,
                size: 56,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isWin ? '🎉 COMPLIMENTI! 🎉' : 'OGGI NIENTE PREMIO',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isWin ? AppTheme.secondary : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            if (isWin) ...[
              Text(
                'HAI VINTO:',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: prize.color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  prize.type == WheelPrizeType.points
                      ? '+$wonPoints PUNTI'
                      : prize.gadgetName ?? prize.label,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: prize.color,
                  ),
                ),
              ),
              if (prize.type == WheelPrizeType.points) ...[
                const SizedBox(height: 16),
                Text(
                  'Nuovo saldo: ${widget.currentPoints + wonPoints} pt',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ] else ...[
              Text(
                'La ruota si è fermata su: ${prize.label}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Riprova domani con il tuo giro gratuito!',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(wonPoints);
              },
              style: FilledButton.styleFrom(
                backgroundColor: isWin ? AppTheme.secondary : Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: Text(
                isWin ? 'FANTASTICO!' : 'OK, HO CAPITO',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gira la Ruota'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Info
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE91E63).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE91E63).withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline_rounded,
                    color: Color(0xFFE91E63),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.hasSpinAvailable && !_hasSpun
                          ? 'Hai 1 giro gratuito disponibile!'
                          : 'Hai già usato il tuo giro di oggi',
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Ruota
            Expanded(
              child: Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Ruota
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _animation?.value ?? 0,
                          child: child,
                        );
                      },
                      child: _SpinWheel(prizes: _prizes),
                    ),
                    // Puntatore
                    Positioned(
                      top: 20,
                      child: Container(
                        width: 30,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE91E63),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    // Centro ruota
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isDark ? Colors.grey[800] : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.casino_rounded,
                        color: Color(0xFFE91E63),
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottone
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: (widget.hasSpinAvailable && !_hasSpun && !_isSpinning)
                      ? _spin
                      : null,
                  icon: Icon(_isSpinning
                      ? Icons.hourglass_top_rounded
                      : Icons.refresh_rounded),
                  label: Text(
                    _isSpinning
                        ? 'LA RUOTA GIRA...'
                        : _hasSpun
                            ? 'TORNA DOMANI'
                            : 'GIRA LA RUOTA',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFE91E63),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: isDark
                        ? Colors.white.withValues(alpha: 0.1)
                        : Colors.grey.withValues(alpha: 0.3),
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpinWheel extends StatelessWidget {
  const _SpinWheel({required this.prizes});

  final List<WheelPrize> prizes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.8;

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _WheelPainter(prizes: prizes),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter {
  _WheelPainter({required this.prizes});

  final List<WheelPrize> prizes;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final sectionAngle = 2 * math.pi / prizes.length;

    // Disegna le sezioni
    for (var i = 0; i < prizes.length; i++) {
      final paint = Paint()
        ..color = prizes[i].color
        ..style = PaintingStyle.fill;

      final startAngle = i * sectionAngle - math.pi / 2;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngle,
        true,
        paint,
      );

      // Bordo
      final borderPaint = Paint()
        ..color = Colors.white.withValues(alpha: 0.3)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sectionAngle,
        true,
        borderPaint,
      );

      // Testo
      final textPainter = TextPainter(
        text: TextSpan(
          text: prizes[i].label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            shadows: [
              Shadow(
                color: Colors.black38,
                blurRadius: 4,
              ),
            ],
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Posiziona il testo
      canvas.save();
      final textAngle = startAngle + sectionAngle / 2;
      final textRadius = radius * 0.65;
      final textX = center.dx + textRadius * math.cos(textAngle);
      final textY = center.dy + textRadius * math.sin(textAngle);

      canvas.translate(textX, textY);
      canvas.rotate(textAngle + math.pi / 2);
      textPainter.paint(
        canvas,
        Offset(-textPainter.width / 2, -textPainter.height / 2),
      );
      canvas.restore();
    }

    // Bordo esterno
    final outerBorderPaint = Paint()
      ..color = const Color(0xFFE91E63)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8;

    canvas.drawCircle(center, radius - 4, outerBorderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
