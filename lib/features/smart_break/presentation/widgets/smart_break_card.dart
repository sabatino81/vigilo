import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';

class SmartBreakCard extends StatefulWidget {
  const SmartBreakCard({super.key});

  @override
  State<SmartBreakCard> createState() => _SmartBreakCardState();
}

class _SmartBreakCardState extends State<SmartBreakCard> {
  // Initial time: 6 minutes and 12 seconds
  static const int _initialSeconds = 6 * 60 + 12;
  late int _remainingSeconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingSeconds = _initialSeconds;
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        setState(() {
          _remainingSeconds--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  String get _formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  double get _progress {
    return _remainingSeconds / _initialSeconds;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2A2A2A) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.black.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.secondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.timer_rounded,
                  color: AppTheme.secondary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                l10n?.smartBreak ?? 'PAUSA SMART',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Timer display
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n?.breakRemaining ?? 'Pausa rimanente',
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.neutral,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        _formattedTime,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n?.breakMinutes ?? 'min',
                        style: const TextStyle(
                          fontSize: 16,
                          color: AppTheme.neutral,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              // Circular progress indicator
              SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: _progress,
                      strokeWidth: 8,
                      backgroundColor: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.black.withValues(alpha: 0.08),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppTheme.secondary,
                      ),
                    ),
                    const Icon(
                      Icons.coffee_rounded,
                      color: AppTheme.secondary,
                      size: 28,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
