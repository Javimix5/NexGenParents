import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../config/app_config.dart';
import '../../utils/auth_validators.dart';
import '../home/home_screen.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/locale_provider.dart';
import '../../utils/translation_helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final l10n = AppLocalizations.of(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      displayName: _nameController.text.trim(),
    );

    if (success && mounted) {
      // Registro exitoso - navegar a pantalla principal
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else if (mounted) {
      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(TranslationHelper.translateDynamicKey(context, authProvider.errorMessage, fallback: l10n?.registerError ?? 'Error al registrarse')),
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

    if (kIsWeb) {
      return;
    }

    if (success && mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            TranslationHelper.translateDynamicKey(context, authProvider.errorMessage, fallback: l10n?.registerErrorGoogle ?? 'No se pudo registrar con Google'),
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
      appBar: AppBar(
        title: Text(l10n?.registerTitle ?? 'Crear cuenta'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          _buildLanguageSelector(localeProvider, currentLang),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConfig.paddingLarge),
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, child) {
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Icono
                      const Icon(
                        Icons.person_add_rounded,
                        size: 80,
                        color: AppConfig.primaryColor,
                      ),
                      const SizedBox(height: AppConfig.paddingMedium),

                      // Título
                      Text(
                        l10n?.registerHeader ?? 'Registro de Padres',
                        style: Theme.of(context).textTheme.displayLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConfig.paddingSmall),

                      // Subtítulo
                      Text(
                        l10n?.registerSubtitle ?? 'Crea tu cuenta para acceder a todas las funciones',
                        style: Theme.of(context).textTheme.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: AppConfig.paddingLarge * 2),

                      // Campo Nombre
                      TextFormField(
                        controller: _nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: l10n?.registerNameLabel ?? 'Nombre completo',
                          hintText: l10n?.registerNameHint ?? 'Tu nombre',
                          prefixIcon: const Icon(Icons.person_outline),
                        ),
                        validator: (value) {
                          return AuthValidators.validateDisplayName(value, l10n);
                        },
                      ),
                      const SizedBox(height: AppConfig.paddingMedium),

                      // Campo Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: l10n?.contactUsEmailLabel ?? 'Correo electrónico',
                          hintText: l10n?.loginEmailHint ?? 'ejemplo@correo.com',
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          return AuthValidators.validateEmail(value, l10n);
                        },
                      ),
                      const SizedBox(height: AppConfig.paddingMedium),

                      // Campo Contraseña
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          labelText: l10n?.loginPasswordLabel ?? 'Contraseña',
                          hintText: l10n?.registerPasswordHint ?? 'Mínimo 8 caracteres',
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
                          return AuthValidators.validatePassword(value, l10n);
                        },
                      ),
                      const SizedBox(height: AppConfig.paddingMedium),

                      // Campo Confirmar Contraseña
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: l10n?.registerConfirmPasswordLabel ?? 'Confirmar contraseña',
                          hintText: l10n?.registerConfirmPasswordHint ?? 'Repite la contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          return AuthValidators.validatePasswordConfirmation(
                            value,
                            _passwordController.text,
                            l10n,
                          );
                        },
                      ),
                      const SizedBox(height: AppConfig.paddingLarge),

                      // Información adicional
                      Container(
                        padding: const EdgeInsets.all(AppConfig.paddingMedium),
                        decoration: BoxDecoration(
                          color: AppConfig.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(
                            AppConfig.borderRadiusMedium,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: AppConfig.primaryColor,
                            ),
                            const SizedBox(width: AppConfig.paddingSmall),
                            Expanded(
                              child: Text(
                                l10n?.registerInfoDesc ?? 'Tu información será utilizada únicamente para mejorar tu experiencia en la app',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppConfig.paddingLarge),

                      // Botón de Registro
                      ElevatedButton(
                        onPressed:
                            authProvider.isLoading ? null : _handleRegister,
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
                                l10n?.registerTitle ?? 'Crear cuenta',
                                style: const TextStyle(fontSize: AppConfig.fontSizeBody),
                              ),
                      ),
                      const SizedBox(height: AppConfig.paddingMedium),
                      OutlinedButton.icon(
                        onPressed:
                            authProvider.isLoading ? null : _handleGoogleSignIn,
                        icon: const Icon(Icons.g_mobiledata_rounded),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: AppConfig.paddingMedium,
                          ),
                        ),
                        label: Text(
                          l10n?.registerGoogleBtn ?? 'Registrarse con Google',
                          style: const TextStyle(fontSize: AppConfig.fontSizeBody),
                        ),
                      ),
                      const SizedBox(height: AppConfig.paddingMedium),

                      // Enlace a Login
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            l10n?.registerAlreadyHaveAccount ?? '¿Ya tienes cuenta? ',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(
                              l10n?.loginBtn ?? 'Inicia sesión',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageSelector(LocaleProvider provider, String currentLang) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _langBtn(provider, currentLang, 'es', 'ES'),
        const Text('|', style: TextStyle(color: Colors.grey, fontSize: 12)),
        _langBtn(provider, currentLang, 'en', 'EN'),
        const Text('|', style: TextStyle(color: Colors.grey, fontSize: 12)),
        _langBtn(provider, currentLang, 'gl', 'GL'),
      ],
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
}
