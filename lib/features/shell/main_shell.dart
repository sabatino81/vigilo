import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vigilo/core/theme/app_theme.dart';
import 'package:vigilo/features/home/presentation/home_page.dart';
import 'package:vigilo/features/impara/presentation/impara_page.dart';
import 'package:vigilo/features/punti/presentation/punti_page.dart';
import 'package:vigilo/features/shop/presentation/pages/shop_page.dart';
import 'package:vigilo/features/sos/presentation/sos_page.dart';
import 'package:vigilo/l10n/generated/app_localizations.dart';
import 'package:vigilo/shared/widgets/app_background.dart';
import 'package:vigilo/shared/widgets/app_header.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    PuntiPage(),
    SosPage(),
    ImparaPage(),
    ShopPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AppBackground(
        child: Column(
          children: [
            // Header fisso
            const AppHeader(),
              // Contenuto scrollabile
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: _pages,
                ),
              ),
            ],
          ),
      ),
      extendBody: true,
      bottomNavigationBar: Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
        child: CustomPaint(
          painter: _NavBarShapePainter(
            color: isDark
                ? theme.colorScheme.surfaceContainerHighest
                    .withValues(alpha: 0.95)
                : theme.colorScheme.surface.withValues(alpha: 0.95),
            borderColor: isDark
                ? Colors.white.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.05),
            shadowColor:
                Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
            notchRadius: 40,
            cornerRadius: 16,
            padding: 3,
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(
                8, 3, 8, MediaQuery.of(context).padding.bottom + 3,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  // 4 bottoni normali — Row compatta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildNavItem(
                        0,
                        Icons.home_outlined,
                        Icons.home_rounded,
                        l10n?.navHome ?? 'Home',
                      ),
                      _buildNavItem(
                        1,
                        Icons.star_outline_rounded,
                        Icons.star_rounded,
                        l10n?.navPunti ?? 'Punti',
                      ),
                      // Spazio vuoto per il bottone centrale
                      const SizedBox(width: 72),
                      _buildNavItem(
                        3,
                        Icons.school_outlined,
                        Icons.school_rounded,
                        l10n?.navImpara ?? 'Impara',
                      ),
                      _buildNavItem(
                        4,
                        Icons.storefront_outlined,
                        Icons.storefront_rounded,
                        'Spaccio',
                      ),
                    ],
                  ),
                  // Bottone centrale posizionato in overlay
                  Positioned(
                    bottom: 0,
                    child: _buildSafetyButton(),
                  ),
                ],
              ),
          ),
        ),
      ),
      ),
    );
  }

  Widget _buildNavItem(
    int index,
    IconData icon,
    IconData activeIcon,
    String label,
  ) {
    final isSelected = _currentIndex == index;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        setState(() => _currentIndex = index);
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: EdgeInsets.fromLTRB(
          isSelected ? 16 : 12, 2, isSelected ? 16 : 12, 8,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer.withValues(alpha: 0.8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isSelected ? activeIcon : icon,
                key: ValueKey(isSelected),
                color: isSelected
                    ? theme.colorScheme.onPrimaryContainer
                    : AppTheme.neutral,
                size: isSelected ? 26 : 24,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                fontSize: isSelected ? 11 : 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected
                    ? theme.colorScheme.onPrimaryContainer
                    : AppTheme.neutral,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSafetyButton() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context);
    final isSelected = _currentIndex == 2;

    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        setState(() => _currentIndex = 2);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isSelected ? 72 : 64,
        height: isSelected ? 72 : 64,
        margin: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primary,
              AppTheme.primary.withValues(alpha: 0.85),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primary.withValues(alpha: isDark ? 0.4 : 0.5),
              blurRadius: isSelected ? 20 : 16,
              offset: const Offset(0, 4),
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
          border: Border.all(
            color: Colors.white.withValues(alpha: isSelected ? 0.3 : 0.2),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shield_rounded,
              color: Colors.white,
              size: isSelected ? 30 : 26,
            ),
            const SizedBox(height: 2),
            Text(
              l10n?.navSos ?? 'Sicurezza',
              style: TextStyle(
                color: Colors.white,
                fontSize: isSelected ? 10 : 9,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Custom painter per la nav bar con notch centrale per il bottone Sicurezza.
class _NavBarShapePainter extends CustomPainter {
  _NavBarShapePainter({
    required this.color,
    required this.borderColor,
    required this.shadowColor,
    required this.notchRadius,
    required this.cornerRadius,
    required this.padding,
  });

  final Color color;
  final Color borderColor;
  final Color shadowColor;
  final double notchRadius;
  final double cornerRadius;
  final double padding;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size);

    // Shadow
    canvas.drawShadow(path, shadowColor, 20, true);

    // Fill
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    // Border
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(path, borderPaint);
  }

  Path _buildPath(Size size) {
    final w = size.width;
    final h = size.height;
    final r = cornerRadius;
    final nr = notchRadius + padding;
    final cx = w / 2;
    // Quanto il notch sale SOPRA la barra
    final notchHeight = 8.0;

    final path = Path()
      // Top-left corner
      ..moveTo(0, r)
      ..arcToPoint(Offset(r, 0), radius: Radius.circular(r),
          clockwise: true)

      // Bordo superiore sinistro → ingresso notch
      ..lineTo(cx - nr, 0)

      // Curva ingresso notch (sale sopra)
      ..cubicTo(
        cx - nr * 0.55, 0,
        cx - nr * 0.45, -notchHeight,
        cx, -notchHeight,
      )

      // Curva uscita notch (torna giù)
      ..cubicTo(
        cx + nr * 0.45, -notchHeight,
        cx + nr * 0.55, 0,
        cx + nr, 0,
      )

      // Bordo superiore destro
      ..lineTo(w - r, 0)

      // Top-right corner
      ..arcToPoint(Offset(w, r), radius: Radius.circular(r))

      // Lato destro
      ..lineTo(w, h - r)

      // Bottom-right corner
      ..arcToPoint(Offset(w - r, h), radius: Radius.circular(r))

      // Lato inferiore
      ..lineTo(r, h)

      // Bottom-left corner
      ..arcToPoint(Offset(0, h - r), radius: Radius.circular(r))

      // Lato sinistro
      ..lineTo(0, r)

      ..close();

    return path;
  }

  @override
  bool shouldRepaint(covariant _NavBarShapePainter oldDelegate) {
    return color != oldDelegate.color ||
        borderColor != oldDelegate.borderColor ||
        notchRadius != oldDelegate.notchRadius;
  }
}
