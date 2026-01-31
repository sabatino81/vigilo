import 'package:flutter/material.dart';
import 'package:vigilo/shared/widgets/app_background.dart';

/// Scaffold con AppBackground integrato.
///
/// Sostituisce [Scaffold] aggiungendo automaticamente lo sfondo
/// industriale dell'app. Supporta [appBar], [body],
/// [bottomNavigationBar], [floatingActionButton] e [extendBody].
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.extendBody = false,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool extendBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: extendBody,
      appBar: appBar,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      body: AppBackground(child: body),
    );
  }
}
