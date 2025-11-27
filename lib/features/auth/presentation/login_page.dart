import 'package:flutter/material.dart';
import 'package:flutter_app_template/l10n/generated/app_localizations.dart';
import 'package:flutter_app_template/providers/locale_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    if (!mounted) return;
    setState(() => _loading = true);
    final supabase = Supabase.instance.client;
    try {
      final res = await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      final session = res.session;
      if (session != null && mounted) {
        context.go('/home');
      } else {
        _showError('Login failed');
      }
    } on AuthException catch (e) {
      _showError(e.message);
    } on Object catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: Theme.of(context).textTheme.titleLarge),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ToggleButtons(
              isSelected: _buildSelectionList(),
              onPressed: (index) {
                final locale = index == 0
                    ? const Locale('en')
                    : const Locale('it');
                ref.read(localeProvider.notifier).setLocale(locale);
              },
              borderRadius: BorderRadius.circular(6),
              selectedBorderColor: Theme.of(context).colorScheme.primary,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset(
                    'assets/flags/flag_en.svg',
                    width: 24,
                    height: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset(
                    'assets/flags/flag_it.svg',
                    width: 24,
                    height: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.emailLabel,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.passwordLabel,
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : _signIn,
              child: _loading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(
                      AppLocalizations.of(context)!.signInButton,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  List<bool> _buildSelectionList() {
    final locale = ref.watch(localeProvider);
    return [
      locale.languageCode == 'en',
      locale.languageCode == 'it',
    ];
  }
}
