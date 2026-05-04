import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../config/app_config.dart';
import '../../utils/auth_validators.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../utils/translation_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      // Login exitoso - navegar a pantalla principal
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()), // Navegar directamente a HomeScreen
      );
    } else if (mounted) {
      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(TranslationHelper.translateDynamicKey(context, authProvider.errorMessage, fallback: l10n?.errorLogin ?? 'Error al iniciar sesión')),
          backgroundColor: AppConfig.errorColor,
        ),
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
    final l10n = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.isLoading) return;

    final success = await authProvider.signInWithGoogle();

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()), // Navegar directamente a HomeScreen
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            TranslationHelper.translateDynamicKey(context, authProvider.errorMessage, fallback: l10n?.errorLoginGoogle ?? 'No se pudo iniciar sesión con Google'),
          ),
          backgroundColor: AppConfig.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeProvider = context.watch<LocaleProvider>();
    final currentLang = localeProvider.locale?.languageCode ?? 'es';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConfig.paddingLarge),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Form(
                  key: _formKey,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo de la app
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
                          child: Image.network(
                            '${AppConfig.githubCdnBase}/icons/logo.webp',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.videogame_asset_rounded,
                              size: 100,
                              color: AppConfig.primaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppConfig.paddingMedium),

                        // Título
                        Text(
                          AppConfig.appName,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: AppConfig.primaryColor,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConfig.paddingSmall),

                        // Subtítulo
                        Text(
                          l10n?.loginSubtitle ?? 'Guía y Diccionario Game para Padres',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConfig.paddingLarge * 2),

                        // Campo Email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: l10n?.contactUsEmailLabel ?? 'Correo electrónico',
                            hintText: l10n?.loginEmailHint ?? 'ejemplo@correo.com',
                            prefixIcon: const Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            return AuthValidators.validateEmail(value, l10n);
                          },
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                        ),
                        const SizedBox(height: AppConfig.paddingMedium),

                        // Campo Contraseña
                        TextFormField(
                          controller: _passwordController,
                          focusNode: _passwordFocusNode,
                          obscureText: _obscurePassword,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _handleLogin(),
                          decoration: InputDecoration(
                            labelText: l10n?.loginPasswordLabel ?? 'Contraseña',
                            hintText: l10n?.loginPasswordHint ?? 'Introduce tu contraseña',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return l10n?.profileErrorPasswordRequired ?? 'Por favor, introduce tu contraseña';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: AppConfig.paddingMedium),

                        // Botón de recuperar contraseña
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              _showForgotPasswordDialog();
                            },
                            child: Text(l10n?.loginForgotPassword ?? '¿Olvidaste tu contraseña?'),
                          ),
                        ),
                        const SizedBox(height: AppConfig.paddingMedium),

                        // Botón de Login
                        ElevatedButton(
                          onPressed:
                              authProvider.isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConfig.paddingMedium,
                            ),
                          ),
                          child: authProvider.isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                              : Text(
                                  l10n?.loginBtn ?? 'Iniciar sesión',
                                  style: const TextStyle(
                                      fontSize: AppConfig.fontSizeBody),
                                ),
                        ),
                        const SizedBox(height: AppConfig.paddingMedium),
                        OutlinedButton.icon(
                          onPressed: authProvider.isLoading
                              ? null
                              : _handleGoogleSignIn,
                          icon: const Icon(Icons.g_mobiledata_rounded),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConfig.paddingMedium,
                            ),
                          ),
                          label: Text(
                            l10n?.loginGoogleBtn ?? 'Continuar con Google',
                            style: const TextStyle(fontSize: AppConfig.fontSizeBody),
                          ),
                        ),
                        const SizedBox(height: AppConfig.paddingLarge),

                        // Divider
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConfig.paddingMedium,
                              ),
                              child: Text(l10n?.loginOr ?? 'o'),
                            ),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: AppConfig.paddingLarge),

                        // Botón de registro
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const RegisterScreen(),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConfig.paddingMedium,
                            ),
                          ),
                          child: Text(
                            l10n?.loginCreateAccountBtn ?? 'Crear cuenta nueva',
                            style: const TextStyle(fontSize: AppConfig.fontSizeBody),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ),
            ),
            Positioned(
              top: 16,
              right: 16,
              child: _buildLanguageSelector(localeProvider, currentLang),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(LocaleProvider provider, String currentLang) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _langBtn(provider, currentLang, 'es', 'ES'),
          const Text('|', style: TextStyle(color: Colors.grey, fontSize: 12)),
          _langBtn(provider, currentLang, 'en', 'EN'),
          const Text('|', style: TextStyle(color: Colors.grey, fontSize: 12)),
          _langBtn(provider, currentLang, 'gl', 'GL'),
        ],
      ),
    );
  }

  Widget _langBtn(LocaleProvider provider, String current, String code, String label) {
    final isActive = current == code;
    return TextButton(
      onPressed: () => provider.setLocale(Locale(code)),
      style: TextButton.styleFrom(
        foregroundColor: isActive ? AppConfig.primaryColor : Colors.grey,
        minimumSize: const Size(36, 36),
        padding: EdgeInsets.zero,
      ),
      child: Text(label, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal, fontSize: 13)),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    final rootContext = context;
    final l10n = AppLocalizations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n?.loginRecoveryTitle ?? 'Recuperar contraseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n?.loginRecoveryDesc ?? 'Introduce tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppConfig.paddingMedium),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: l10n?.contactUsEmailLabel ?? 'Correo electrónico',
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n?.adminCancelBtn ?? 'Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = emailController.text.trim();
              final messenger = ScaffoldMessenger.of(rootContext);
              final emailError = AuthValidators.validateEmail(email, l10n);
              if (emailError != null) {
                messenger.showSnackBar(SnackBar(content: Text(emailError)));
                return;
              }

              Navigator.of(rootContext).pop();

              final authProvider = Provider.of<AuthProvider>(
                rootContext,
                listen: false,
              );
              final success = await authProvider.resetPassword(email: email);

              if (mounted) {
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                        ? (l10n?.successPasswordReset ?? 'Correo de recuperación enviado. Revisa tu bandeja de entrada.')
                        : TranslationHelper.translateDynamicKey(context, authProvider.errorMessage, fallback: l10n?.loginRecoveryError ?? 'Error al enviar correo'),
                    ),
                    backgroundColor:
                        success ? AppConfig.accentColor : AppConfig.errorColor,
                  ),
                );
              }
            },
            child: Text(l10n?.loginRecoverySendBtn ?? 'Enviar'),
          ),
        ],
      ),
    );
  }
}
