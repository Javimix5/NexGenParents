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

  String _t(BuildContext context,
      {required String es, required String gl, required String en}) {
    switch (Localizations.localeOf(context).languageCode) {
      case 'gl':
        return gl;
      case 'en':
        return en;
      default:
        return es;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: Text(_t(context, es: 'Editar Perfil', gl: 'Editar Perfil', en: 'Edit Profile'))),
        body: Center(child: Text(_t(context, es: 'No hay usuario autenticado', gl: 'Non hai usuario autenticado', en: 'No authenticated user'))),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_t(context, es: 'Editar Perfil', gl: 'Editar Perfil', en: 'Edit Profile')),
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
              _buildSectionTitle(_t(context, es: 'Información Personal', gl: 'Información Persoal', en: 'Personal Information')),
              _buildConstrainedField(
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: _t(context, es: 'Nombre de usuario', gl: 'Nome de usuario', en: 'Username'),
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _t(context, es: 'Por favor, introduce tu nombre', gl: 'Por favor, introduce o teu nome', en: 'Please enter your name');
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
                  decoration: InputDecoration(
                    labelText: _t(context, es: 'Correo electrónico', gl: 'Correo electrónico', en: 'Email address'),
                    prefixIcon: const Icon(Icons.email),
                    suffixIcon: const Icon(Icons.lock_outline, size: 16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return _t(context, es: 'Por favor, introduce tu correo', gl: 'Por favor, introduce o teu correo', en: 'Please enter your email');
                    }
                    if (!value.contains('@')) {
                      return _t(context, es: 'Correo no válido', gl: 'Correo non válido', en: 'Invalid email');
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              Row(
                children: [
                  Icon(Icons.info_outline, size: 14, color: AppConfig.textSecondaryColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      _t(context, es: 'Cambiar el email requiere verificación adicional', gl: 'Cambiar o correo require verificación adicional', en: 'Changing email requires additional verification'),
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
                label: Text(_t(context, es: 'Cambiar contraseña', gl: 'Cambiar contrasinal', en: 'Change password')),
              ),
              const SizedBox(height: AppConfig.paddingLarge),

              // Edades de hijos (calculadas desde año de nacimiento)
              _buildSectionTitle(_t(context, es: 'Información de tus Hijos', gl: 'Información dos teus fillos', en: 'Children Information')),
              Text(
                _t(context, es: 'Añade los años de nacimiento para personalizar recomendaciones de juegos', gl: 'Engade os anos de nacemento para personalizar as recomendacións de xogos', en: 'Add birth years to customize game recommendations'),
                style: const TextStyle(
                  fontSize: AppConfig.fontSizeCaption,
                  color: AppConfig.textSecondaryColor,
                ),
              ),
              const SizedBox(height: AppConfig.paddingSmall),
              _buildChildrenBirthYearsSection(),
              const SizedBox(height: AppConfig.paddingLarge),

              // Plataformas
              _buildSectionTitle(_t(context, es: 'Plataformas que Posees', gl: 'Plataformas que posúes', en: 'Platforms you own')),
              Text(
                _t(context, es: 'Selecciona las consolas y dispositivos que tienes en casa', gl: 'Selecciona as consolas e dispositivos que tes na casa', en: 'Select the consoles and devices you have at home'),
                style: const TextStyle(
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
                    label: Text(_t(context, es: 'Guardar Cambios', gl: 'Gardar cambios', en: 'Save Changes')),
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
                    label: Text(_t(context, es: 'Eliminar Cuenta', gl: 'Eliminar conta', en: 'Delete Account')),
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
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 100, maxHeight: 100),
            child: Container(
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
          ),
          const SizedBox(height: AppConfig.paddingSmall),
          TextButton.icon(
            onPressed: _showAvatarSelector,
            icon: const Icon(Icons.edit),
            label: Text(_t(context, es: 'Cambiar Avatar', gl: 'Cambiar avatar', en: 'Change Avatar')),
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
          Text(
            _t(context, es: 'Tu Actividad en NexGen Parents', gl: 'A túa actividade en NexGen Parents', en: 'Your Activity in NexGen Parents'),
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
                _t(context, es: 'Términos\nPropuestos', gl: 'Termos\nPropostos', en: 'Proposed\nTerms'),
              ),
              _buildStatItem(
                Icons.verified,
                '${user.termsApproved}',
                _t(context, es: 'Términos\nAprobados', gl: 'Termos\nAprobados', en: 'Approved\nTerms'),
              ),
              _buildStatItem(
                Icons.emoji_events,
                user.isAdmin ? 'Admin' : user.isModerator ? 'Mod' : _t(context, es: 'Usuario', gl: 'Usuario', en: 'User'),
                _t(context, es: 'Nivel', gl: 'Nivel', en: 'Level'),
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
              label: Text(_t(context, es: '$age años ($birthYear)', gl: '$age anos ($birthYear)', en: '$age years ($birthYear)')),
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
          label: Text(_t(context, es: 'Añadir Año de Nacimiento', gl: 'Engadir ano de nacemento', en: 'Add Birth Year')),
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
        title: Text(_t(context, es: 'Selecciona tu Avatar', gl: 'Selecciona o teu avatar', en: 'Select your Avatar')),
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
                child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 60, maxHeight: 60),
                child: Container(
                  decoration: BoxDecoration(
                    color: _selectedAvatar == avatar
                        ? AppConfig.primaryColor.withOpacity(0.2)
                        : AppConfig.backgroundLight,
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
        title: Text(_t(context, es: 'Añadir Año de Nacimiento', gl: 'Engadir ano de nacemento', en: 'Add Birth Year')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: birthYearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: _t(context, es: 'Año de nacimiento', gl: 'Ano de nacemento', en: 'Birth year'),
                hintText: _t(context, es: 'Ejemplo: 2015', gl: 'Exemplo: 2015', en: 'Example: 2015'),
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            Text(
              _t(context, es: 'Introduce el año de nacimiento de tu hijo para obtener recomendaciones personalizadas.', gl: 'Introduce o ano de nacemento do teu fillo para obter recomendacións personalizadas.', en: 'Enter your child\'s birth year to get personalized recommendations.'),
              style: const TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(_t(context, es: 'Cancelar', gl: 'Cancelar', en: 'Cancel')),
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
                  SnackBar(content: Text(_t(context, es: 'Por favor, introduce un año de nacimiento válido', gl: 'Por favor, introduce un ano de nacemento válido', en: 'Please enter a valid birth year'))),
                );
              }
            },
            child: Text(_t(context, es: 'Añadir', gl: 'Engadir', en: 'Add')),
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
        throw Exception(basicInfoResult['message'] ?? _t(context, es: 'No se pudo actualizar el nombre', gl: 'Non se puido actualizar o nome', en: 'Could not update name'));
      }

      final birthYearsResult = await _firestoreService.updateChildrenBirthYears(
        userId: user.id,
        birthYears: _childrenBirthYears,
      );

      if (!(birthYearsResult['success'] ?? false)) {
        throw Exception(birthYearsResult['message'] ?? _t(context, es: 'No se pudo actualizar la información de hijos', gl: 'Non se puido actualizar a información dos fillos', en: 'Could not update children information'));
      }

      final platformsResult = await _firestoreService.updateOwnedPlatforms(
        userId: user.id,
        platforms: _selectedPlatforms,
      );

      if (!(platformsResult['success'] ?? false)) {
        throw Exception(platformsResult['message'] ?? _t(context, es: 'No se pudieron actualizar las plataformas', gl: 'Non se puideron actualizar as plataformas', en: 'Could not update platforms'));
      }

      final avatarResult = await _firestoreService.updatePhotoUrl(
        userId: user.id,
        photoUrl: _selectedAvatar,
      );

      if (!(avatarResult['success'] ?? false)) {
        throw Exception(avatarResult['message'] ?? _t(context, es: 'No se pudo actualizar el avatar', gl: 'Non se puido actualizar o avatar', en: 'Could not update avatar'));
      }

      if (trimmedEmail != user.email) {
        final password = await _askForCurrentPassword(
          title: _t(context, es: 'Verificación para cambiar email', gl: 'Verificación para cambiar o correo', en: 'Verification to change email'),
          message: _t(context, es: 'Para cambiar tu correo, confirma tu contraseña actual.', gl: 'Para cambiar o teu correo, confirma o teu contrasinal actual.', en: 'To change your email, confirm your current password.'),
        );

        if (password == null || password.isEmpty) {
          throw Exception(_t(context, es: 'Cambio de email cancelado', gl: 'Cambio de correo cancelado', en: 'Email change cancelled'));
        }

        final emailResult = await _authService.changeEmail(
          currentPassword: password,
          newEmail: trimmedEmail,
        );

        if (!(emailResult['success'] ?? false)) {
          throw Exception(emailResult['message'] ?? _t(context, es: 'No se pudo cambiar el email', gl: 'Non se puido cambiar o correo', en: 'Could not change email'));
        }

        await _firestoreService.updateUserBasicInfo(
          userId: user.id,
          email: trimmedEmail,
        );
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t(context, es: 'Perfil actualizado correctamente', gl: 'Perfil actualizado correctamente', en: 'Profile updated successfully'))),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_t(context, es: 'Error al guardar perfil: $e', gl: 'Erro ao gardar perfil: $e', en: 'Error saving profile: $e'))),
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
        title: Text(_t(context, es: 'Cambiar contraseña', gl: 'Cambiar contrasinal', en: 'Change password')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: _t(context, es: 'Contraseña actual', gl: 'Contrasinal actual', en: 'Current password')),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: _t(context, es: 'Nueva contraseña', gl: 'Novo contrasinal', en: 'New password')),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: _t(context, es: 'Confirmar nueva contraseña', gl: 'Confirmar novo contrasinal', en: 'Confirm new password')),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(_t(context, es: 'Cancelar', gl: 'Cancelar', en: 'Cancel')),
          ),
          ElevatedButton(
            onPressed: () async {
              final currentPassword = currentPasswordController.text.trim();
              final newPassword = newPasswordController.text.trim();
              final confirmPassword = confirmPasswordController.text.trim();

              if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_t(context, es: 'Completa todos los campos', gl: 'Completa todos os campos', en: 'Fill all fields'))),
                );
                return;
              }

              if (newPassword.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_t(context, es: 'La nueva contraseña debe tener al menos 6 caracteres', gl: 'O novo contrasinal debe ter polo menos 6 caracteres', en: 'The new password must be at least 6 characters long'))),
                );
                return;
              }

              if (newPassword != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_t(context, es: 'Las contraseñas no coinciden', gl: 'Os contrasinais non coinciden', en: 'Passwords do not match'))),
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
                SnackBar(content: Text(result['message'] ?? _t(context, es: 'Operación completada', gl: 'Operación completada', en: 'Operation completed'))),
              );
            },
            child: Text(_t(context, es: 'Actualizar', gl: 'Actualizar', en: 'Update')),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteAccountDialog() async {
    final confirmDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(_t(context, es: 'Confirmar eliminación', gl: 'Confirmar eliminación', en: 'Confirm deletion')),
        content: Text(
          _t(context, es: '¿Seguro que quieres eliminar tu perfil? Esta acción es irreversible.', gl: 'Seguro que queres eliminar o teu perfil? Esta acción é irreversible.', en: 'Are you sure you want to delete your profile? This action is irreversible.'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(_t(context, es: 'No', gl: 'Non', en: 'No')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppConfig.errorColor),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(_t(context, es: 'Sí, eliminar', gl: 'Si, eliminar', en: 'Yes, delete')),
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
        title: Text(_t(context, es: 'Eliminar cuenta', gl: 'Eliminar conta', en: 'Delete account')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_t(context, es: 'Esta acción es permanente. Introduce tu contraseña para confirmar.', gl: 'Esta acción é permanente. Introduce o teu contrasinal para confirmar.', en: 'This action is permanent. Enter your password to confirm.')),
            const SizedBox(height: 12),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: _t(context, es: 'Contraseña actual', gl: 'Contrasinal actual', en: 'Current password')),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(_t(context, es: 'Cancelar', gl: 'Cancelar', en: 'Cancel')),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppConfig.errorColor),
            onPressed: () async {
              final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
              final password = passwordController.text.trim();

              if (user == null || password.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(_t(context, es: 'Debes introducir tu contraseña', gl: 'Debes introducir o teu contrasinal', en: 'You must enter your password'))),
                );
                return;
              }

              final reauthResult = await _authService.reauthenticateForSensitiveAction(password);
              if (!(reauthResult['success'] ?? false)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(reauthResult['message'] ?? _t(context, es: 'No se pudo validar la contraseña', gl: 'Non se puido validar o contrasinal', en: 'Could not validate the password'))),
                );
                return;
              }

              final deleteFirestoreResult = await _firestoreService.deleteUserAccount(user.id);
              if (!(deleteFirestoreResult['success'] ?? false)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(deleteFirestoreResult['message'] ?? _t(context, es: 'No se pudo eliminar el perfil en la base de datos', gl: 'Non se puido eliminar o perfil na base de datos', en: 'Could not delete the profile in the database'))),
                );
                return;
              }

              final deleteAuthResult = await _authService.deleteCurrentAuthUser();
              if (!(deleteAuthResult['success'] ?? false)) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(deleteAuthResult['message'] ?? _t(context, es: 'Se eliminó el perfil, pero no la cuenta de acceso', gl: 'Eliminouse o perfil, pero non a conta de acceso', en: 'Profile deleted, but not the access account'))),
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
            child: Text(_t(context, es: 'Eliminar', gl: 'Eliminar', en: 'Delete')),
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
              decoration: InputDecoration(labelText: _t(context, es: 'Contraseña actual', gl: 'Contrasinal actual', en: 'Current password')),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, null),
            child: Text(_t(context, es: 'Cancelar', gl: 'Cancelar', en: 'Cancel')),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, passwordController.text.trim()),
            child: Text(_t(context, es: 'Confirmar', gl: 'Confirmar', en: 'Confirm')),
          ),
        ],
      ),
    );
  }
}