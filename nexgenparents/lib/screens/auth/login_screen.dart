import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../config/app_config.dart';
import '../../utils/auth_validators.dart';
import 'register_screen.dart';
import '../home/home_screen.dart';

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

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      // Login exitoso - navegar a pantalla principal
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomeScreen()),
      );
    } else if (mounted) {
      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage ?? 'Error al iniciar sesión'),
          backgroundColor: AppConfig.errorColor,
        ),
      );
    }
  }

  Future<void> _handleGoogleSignIn() async {
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
            authProvider.errorMessage ?? 'No se pudo iniciar sesión con Google',
          ),
          backgroundColor: AppConfig.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConfig.backgroundColor,
      body: SafeArea(
        child: Center(
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
                        Image.network(
                          '${AppConfig.githubCdnBase}/icons/logo.webp',
                          height: 100,
                          width: 100,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                            Icons.videogame_asset_rounded,
                            size: 100,
                            color: AppConfig.primaryColor,
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
                          'Guía y Diccionario Game para Padres',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: AppConfig.paddingLarge * 2),

                        // Campo Email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'Correo electrónico',
                            hintText: 'ejemplo@correo.com',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            return AuthValidators.validateEmail(value);
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
                            labelText: 'Contraseña',
                            hintText: 'Introduce tu contraseña',
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
                              return 'Por favor, introduce tu contraseña';
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
                            child: const Text('¿Olvidaste tu contraseña?'),
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
                              : const Text(
                                  'Iniciar sesión',
                                  style: TextStyle(
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
                          label: const Text(
                            'Continuar con Google',
                            style: TextStyle(fontSize: AppConfig.fontSizeBody),
                          ),
                        ),
                        const SizedBox(height: AppConfig.paddingLarge),

                        // Divider
                        const Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppConfig.paddingMedium,
                              ),
                              child: Text('o'),
                            ),
                            Expanded(child: Divider()),
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
                          child: const Text(
                            'Crear cuenta nueva',
                            style: TextStyle(fontSize: AppConfig.fontSizeBody),
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
      ),
    );
  }

  void _showForgotPasswordDialog() {
    final emailController = TextEditingController();
    final rootContext = context;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Recuperar contraseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Introduce tu correo electrónico y te enviaremos un enlace para restablecer tu contraseña.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: AppConfig.paddingMedium),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final email = emailController.text.trim();
              final messenger = ScaffoldMessenger.of(rootContext);
              final emailError = AuthValidators.validateEmail(email);
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
                          ? 'Correo de recuperación enviado. Revisa tu bandeja de entrada.'
                          : authProvider.errorMessage ??
                              'Error al enviar correo',
                    ),
                    backgroundColor:
                        success ? AppConfig.accentColor : AppConfig.errorColor,
                  ),
                );
              }
            },
            child: const Text('Enviar'),
          ),
        ],
      ),
    );
  }
}
