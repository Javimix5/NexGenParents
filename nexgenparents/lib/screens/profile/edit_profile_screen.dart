import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/auth_service.dart';
import '../../services/firestore_service.dart';
import '../../config/app_config.dart';
import '../auth/login_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _authService = AuthService();
  final _firestoreService = FirestoreService();
  List<int> _childrenBirthYears = []; // Cambiado de _childrenAges
  List<String> _selectedPlatforms = [];
  String _selectedAvatar = 'assets/avatars/default.png';
  bool _isLoading = false;

  // Avatares disponibles (emojis como avatares simples)
  final List<String> _avatarOptions = [
    '👨', '👩', '🧑', '👴', '👵',
    '🎮', '🎯', '🎪', '🌟', '⭐',
  ];

  // Plataformas disponibles
  final Map<String, String> _platformOptions = {
    'PlayStation 5': 'ps5',
    'PlayStation 4': 'ps4',
    'Xbox Series X/S': 'xbox-series',
    'Xbox One': 'xbox-one',
    'Nintendo Switch': 'switch',
    'PC': 'pc',
    'iOS': 'ios',
    'Android': 'android',
  };

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Método para calcular la edad a partir del año de nacimiento
  int _calculateAge(int birthYear) {
    final currentYear = DateTime.now().year;
    return currentYear - birthYear;
  }

  void _loadUserData() {
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user != null) {
      _nameController.text = user.displayName;
      _emailController.text = user.email;

      _childrenBirthYears = user.childrenBirthYears ?? [];
      
      _selectedPlatforms = user.ownedPlatforms ?? [];
      _selectedAvatar = user.photoUrl ?? '👨';
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Editar Perfil')),
        body: const Center(child: Text('No hay usuario autenticado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        actions: [
          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConfig.paddingMedium),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 980),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              // Avatar
              _buildAvatarSection(),
              const SizedBox(height: AppConfig.paddingLarge),

              // Estadísticas
              _buildStatsSection(user),
              const SizedBox(height: AppConfig.paddingLarge),

              // Nombre
              _buildSectionTitle('Información Personal'),
              _buildConstrainedField(
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre de usuario',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu nombre';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: AppConfig.paddingMedium),

              // Email
              _buildConstrainedField(
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email),
                    suffixIcon: Icon(Icons.lock_outline, size: 16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, introduce tu correo';
                    }
                    if (!value.contains('@')) {
                      return 'Correo no válido';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              const Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: AppConfig.textSecondaryColor),
                  SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      'Cambiar el email requiere verificación adicional',
                      style: TextStyle(
                        fontSize: AppConfig.fontSizeCaption,
                        color: AppConfig.textSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConfig.paddingMedium),

              // Botón cambiar contraseña
              OutlinedButton.icon(
                onPressed: _showChangePasswordDialog,
                icon: const Icon(Icons.lock),
                label: const Text('Cambiar contraseña'),
              ),
              const SizedBox(height: AppConfig.paddingLarge),

              // Edades de hijos (calculadas desde año de nacimiento)
              _buildSectionTitle('Información de tus Hijos'),
              const Text(
                'Añade los años de nacimiento para personalizar recomendaciones de juegos',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeCaption,
                  color: AppConfig.textSecondaryColor,
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              _buildChildrenBirthYearsSection(),
              const SizedBox(height: AppConfig.paddingLarge),

              // Plataformas
              _buildSectionTitle('Plataformas que Posees'),
              const Text(
                'Selecciona las consolas y dispositivos que tienes en casa',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeCaption,
                  color: AppConfig.textSecondaryColor,
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              _buildPlatformsSection(),
              const SizedBox(height: AppConfig.paddingLarge),

              // Botón guardar
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _saveProfile,
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar Cambios'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConfig.paddingMedium,
                        horizontal: AppConfig.paddingLarge,
                      ),
                      minimumSize: const Size(0, 48),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConfig.paddingMedium),

              // Botón eliminar cuenta
              Align(
                alignment: Alignment.center,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 320),
                  child: OutlinedButton.icon(
                    onPressed: _showDeleteAccountDialog,
                    icon: const Icon(Icons.delete_forever, color: AppConfig.errorColor),
                    label: const Text('Eliminar Cuenta'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppConfig.errorColor,
                      side: const BorderSide(color: AppConfig.errorColor),
                      padding: const EdgeInsets.symmetric(
                        vertical: AppConfig.paddingMedium,
                        horizontal: AppConfig.paddingLarge,
                      ),
                      minimumSize: const Size(0, 48),
                    ),
                  ),
                ),
              ),
            ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConstrainedField(Widget field) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 620),
        child: field,
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppConfig.paddingSmall),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: AppConfig.fontSizeHeading,
          fontWeight: FontWeight.bold,
          color: AppConfig.primaryColor,
        ),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: AppConfig.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
              border: Border.all(color: AppConfig.primaryColor, width: 3),
            ),
            child: Center(
              child: Text(
                _selectedAvatar,
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          TextButton.icon(
            onPressed: _showAvatarSelector,
            icon: const Icon(Icons.edit),
            label: const Text('Cambiar Avatar'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(user) {
    return Container(
      padding: const EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(color: AppConfig.primaryColor),
      ),
      child: Column(
        children: [
          const Text(
            'Tu Actividad en NexGen Parents',
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppConfig.paddingMedium),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                Icons.article_outlined,
                '${user.termsProposed}',
                'Términos\nPropuestos',
              ),
              _buildStatItem(
                Icons.verified,
                '${user.termsApproved}',
                'Términos\nAprobados',
              ),
              _buildStatItem(
                Icons.emoji_events,
                user.isAdmin ? 'Admin' : user.isModerator ? 'Mod' : 'Usuario',
                'Nivel',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: AppConfig.primaryColor, size: 30),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConfig.primaryColor,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppConfig.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  // Widget modificado para mostrar año de nacimiento y edad calculada
  Widget _buildChildrenBirthYearsSection() {
    return Column(
      children: [
        Wrap(
          spacing: AppConfig.paddingSmall,
          runSpacing: AppConfig.paddingSmall,
          children: _childrenBirthYears.map((birthYear) {
            final age = _calculateAge(birthYear);
            return Chip(
              label: Text('$age años ($birthYear)'),
              deleteIcon: const Icon(Icons.close, size: 18),
              onDeleted: () {
                setState(() {
                  _childrenBirthYears.remove(birthYear);
                });
              },
            );
          }).toList(),
        ),
        const SizedBox(height: AppConfig.paddingSmall),
        OutlinedButton.icon(
          onPressed: _showAddBirthYearDialog,
          icon: const Icon(Icons.add),
          label: const Text('Añadir Año de Nacimiento'),
        ),
      ],
    );
  }

  Widget _buildPlatformsSection() {
    return Wrap(
      spacing: AppConfig.paddingSmall,
      runSpacing: AppConfig.paddingSmall,
      children: _platformOptions.entries.map((entry) {
        final isSelected = _selectedPlatforms.contains(entry.value);
        return FilterChip(
          label: Text(entry.key),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedPlatforms.add(entry.value);
              } else {
                _selectedPlatforms.remove(entry.value);
              }
            });
          },
        );
      }).toList(),
    );
  }

  void _showAvatarSelector() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selecciona tu Avatar'),
        content: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: _avatarOptions.map((avatar) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedAvatar = avatar;
                });
                Navigator.pop(context);
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _selectedAvatar == avatar
                      ? AppConfig.primaryColor.withOpacity(0.2)
                      : AppConfig.backgroundColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedAvatar == avatar
                        ? AppConfig.primaryColor
                        : AppConfig.textSecondaryColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(avatar, style: const TextStyle(fontSize: 30)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Diálogo modificado para pedir año de nacimiento en lugar de edad
  void _showAddBirthYearDialog() {
    final birthYearController = TextEditingController();
    final currentYear = DateTime.now().year;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Añadir Año de Nacimiento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: birthYearController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Año de nacimiento',
                hintText: 'Ejemplo: 2015',
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            const Text(
              'Introduce el año de nacimiento de tu hijo para obtener recomendaciones personalizadas.',
              style: TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final birthYear = int.tryParse(birthYearController.text);
              if (birthYear != null && birthYear > 1900 && birthYear <= currentYear) {
                setState(() {
                  _childrenBirthYears.add(birthYear);
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Por favor, introduce un año de nacimiento válido')),
                );
              }
            },
            child: const Text('Añadir'),
          ),
        ],
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;
    if (user == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final trimmedName = _nameController.text.trim();
      final trimmedEmail = _emailController.text.trim();

      final basicInfoResult = await _firestoreService.updateUserBasicInfo(
        userId: user.id,
        displayName: trimmedName,
      );

      if (!(basicInfoResult['success'] ?? false)) {
        throw Exception(basicInfoResult['message'] ?? 'No se pudo actualizar el nombre');
      }

      final birthYearsResult = await _firestoreService.updateChildrenBirthYears(
        userId: user.id,
        birthYears: _childrenBirthYears,
      );

      if (!(birthYearsResult['success'] ?? false)) {
        throw Exception(birthYearsResult['message'] ?? 'No se pudo actualizar la información de hijos');
      }

      final platformsResult = await _firestoreService.updateOwnedPlatforms(
        userId: user.id,
        platforms: _selectedPlatforms,
      );

      if (!(platformsResult['success'] ?? false)) {
        throw Exception(platformsResult['message'] ?? 'No se pudieron actualizar las plataformas');
      }

      final avatarResult = await _firestoreService.updatePhotoUrl(
        userId: user.id,
        photoUrl: _selectedAvatar,
      );

      if (!(avatarResult['success'] ?? false)) {
        throw Exception(avatarResult['message'] ?? 'No se pudo actualizar el avatar');
      }

      if (trimmedEmail != user.email) {
        final password = await _askForCurrentPassword(
          title: 'Verificación para cambiar email',
          message: 'Para cambiar tu correo, confirma tu contraseña actual.',
        );

        if (password == null || password.isEmpty) {
          throw Exception('Cambio de email cancelado');
        }

        final emailResult = await _authService.changeEmail(
          currentPassword: password,
          newEmail: trimmedEmail,
        );

        if (!(emailResult['success'] ?? false)) {
          throw Exception(emailResult['message'] ?? 'No se pudo cambiar el email');
        }

        await _firestoreService.updateUserBasicInfo(
          userId: user.id,
          email: trimmedEmail,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado correctamente')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al guardar perfil: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _showChangePasswordDialog() async {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Cambiar contraseña'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña actual'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Nueva contraseña'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Confirmar nueva contraseña'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final currentPassword = currentPasswordController.text.trim();
              final newPassword = newPasswordController.text.trim();
              final confirmPassword = confirmPasswordController.text.trim();

              if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Completa todos los campos')),
                );
                return;
              }

              if (newPassword.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('La nueva contraseña debe tener al menos 6 caracteres')),
                );
                return;
              }

              if (newPassword != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Las contraseñas no coinciden')),
                );
                return;
              }

              final result = await _authService.changePassword(
                currentPassword: currentPassword,
                newPassword: newPassword,
              );

              if (!mounted) return;

              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result['message'] ?? 'Operación completada')),
              );
            },
            child: const Text('Actualizar'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteAccountDialog() async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: const Text(
          '¿Seguro que quieres eliminar tu perfil? Esta acción es irreversible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('No'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppConfig.errorColor),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Sí, eliminar'),
          ),
        ],
      ),
    );

    if (confirmDelete != true || !mounted) {
      return;
    }

    final passwordController = TextEditingController();

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar cuenta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Esta acción es permanente. Introduce tu contraseña para confirmar.'),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña actual'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppConfig.errorColor),
            onPressed: () async {
              final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
              final password = passwordController.text.trim();

              if (user == null || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Debes introducir tu contraseña')),
                );
                return;
              }

              final reauthResult = await _authService.reauthenticateForSensitiveAction(password);
              if (!(reauthResult['success'] ?? false)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(reauthResult['message'] ?? 'No se pudo validar la contraseña')),
                );
                return;
              }

              final deleteFirestoreResult = await _firestoreService.deleteUserAccount(user.id);
              if (!(deleteFirestoreResult['success'] ?? false)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(deleteFirestoreResult['message'] ?? 'No se pudo eliminar el perfil en la base de datos')),
                );
                return;
              }

              final deleteAuthResult = await _authService.deleteCurrentAuthUser();
              if (!(deleteAuthResult['success'] ?? false)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(deleteAuthResult['message'] ?? 'Se eliminó el perfil, pero no la cuenta de acceso')),
                );
                return;
              }

              await Provider.of<AuthProvider>(context, listen: false).signOut();

              if (!mounted) return;
              Navigator.pop(dialogContext);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  Future<String?> _askForCurrentPassword({
    required String title,
    required String message,
  }) async {
    final passwordController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña actual'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, null),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, passwordController.text.trim()),
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }
}