import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';

/// Bottone SOS con long press per attivare l'emergenza
class SosEmergencyButton extends StatefulWidget {
  const SosEmergencyButton({
    required this.onActivated,
    super.key,
    this.countdownDuration = const Duration(seconds: 3),
    this.size = 180,
  });

  final VoidCallback onActivated;
  final Duration countdownDuration;
  final double size;

  @override
  State<SosEmergencyButton> createState() => _SosEmergencyButtonState();
}

class _SosEmergencyButtonState extends State<SosEmergencyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  bool _isCountingDown = false;
  double _progress = 0;
  Timer? _progressTimer;
  int _countdown = 3;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(
      begin: 1,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    unawaited(HapticFeedback.heavyImpact());
    setState(() {
      _isCountingDown = true;
      _progress = 0;
      _countdown = widget.countdownDuration.inSeconds;
    });

    const tickDuration = Duration(milliseconds: 50);
    final totalTicks = widget.countdownDuration.inMilliseconds ~/ 50;
    var currentTick = 0;

    _progressTimer = Timer.periodic(tickDuration, (timer) {
      currentTick++;
      final newProgress = currentTick / totalTicks;
      final newCountdown = widget.countdownDuration.inSeconds -
          (currentTick * 50 ~/ 1000);

      if (newCountdown != _countdown && newCountdown > 0) {
        unawaited(HapticFeedback.mediumImpact());
      }

      setState(() {
        _progress = newProgress;
        _countdown = newCountdown > 0 ? newCountdown : 1;
      });

      if (currentTick >= totalTicks) {
        timer.cancel();
        _onCountdownComplete();
      }
    });
  }

  void _cancelCountdown() {
    _progressTimer?.cancel();
    setState(() {
      _isCountingDown = false;
      _progress = 0;
      _countdown = widget.countdownDuration.inSeconds;
    });
  }

  void _onCountdownComplete() {
    unawaited(HapticFeedback.vibrate());
    setState(() {
      _isCountingDown = false;
    });
    widget.onActivated();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _isCountingDown ? 1.0 : _pulseAnimation.value,
              child: child,
            );
          },
          child: GestureDetector(
            onLongPressStart: (_) => _startCountdown(),
            onLongPressEnd: (_) {
              if (_isCountingDown) {
                _cancelCountdown();
              }
            },
            onLongPressCancel: _cancelCountdown,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.danger,
                    AppTheme.danger.withValues(alpha: 0.8),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.danger.withValues(
                      alpha: _isCountingDown ? 0.6 : 0.4,
                    ),
                    blurRadius: _isCountingDown ? 30 : 20,
                    spreadRadius: _isCountingDown ? 5 : 0,
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Progress ring
                  if (_isCountingDown)
                    SizedBox(
                      width: widget.size - 10,
                      height: widget.size - 10,
                      child: CircularProgressIndicator(
                        value: _progress,
                        strokeWidth: 6,
                        backgroundColor: Colors.white.withValues(alpha: 0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
                  // Content
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isCountingDown) ...[
                        Text(
                          '$_countdown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ] else ...[
                        const Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Tieni premuto',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.8),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedOpacity(
          opacity: _isCountingDown ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.1)
                  : Colors.black.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Rilascia per annullare',
              style: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
