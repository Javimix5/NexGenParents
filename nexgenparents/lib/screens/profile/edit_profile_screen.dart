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
  
  List<int> _childrenAges = [];
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

  void _loadUserData() {
    final user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    if (user != null) {
      _nameController.text = user.displayName;
      _emailController.text = user.email;
      _childrenAges = user.childrenAges ?? [];
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
        appBar: AppBar(title: Text('Editar Perfil')),
        body: Center(child: Text('No hay usuario autenticado')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        actions: [
          if (_isLoading)
            Center(
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
        padding: EdgeInsets.all(AppConfig.paddingMedium),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              _buildAvatarSection(),
              SizedBox(height: AppConfig.paddingLarge),

              // Estadísticas
              _buildStatsSection(user),
              SizedBox(height: AppConfig.paddingLarge),

              // Nombre
              _buildSectionTitle('Información Personal'),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
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
              SizedBox(height: AppConfig.paddingMedium),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
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
              SizedBox(height: AppConfig.paddingSmall),
              Row(
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
              SizedBox(height: AppConfig.paddingMedium),

              // Botón cambiar contraseña
              OutlinedButton.icon(
                onPressed: _showChangePasswordDialog,
                icon: Icon(Icons.lock),
                label: Text('Cambiar contraseña'),
              ),
              SizedBox(height: AppConfig.paddingLarge),

              // Edades de hijos
              _buildSectionTitle('Información de tus Hijos'),
              Text(
                'Añade las edades para personalizar recomendaciones de juegos',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeCaption,
                  color: AppConfig.textSecondaryColor,
                ),
              ),
              SizedBox(height: AppConfig.paddingSmall),
              _buildChildrenAgesSection(),
              SizedBox(height: AppConfig.paddingLarge),

              // Plataformas
              _buildSectionTitle('Plataformas que Posees'),
              Text(
                'Selecciona las consolas y dispositivos que tienes en casa',
                style: TextStyle(
                  fontSize: AppConfig.fontSizeCaption,
                  color: AppConfig.textSecondaryColor,
                ),
              ),
              SizedBox(height: AppConfig.paddingSmall),
              _buildPlatformsSection(),
              SizedBox(height: AppConfig.paddingLarge),

              // Botón guardar
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _saveProfile,
                icon: Icon(Icons.save),
                label: Text('Guardar Cambios'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
              SizedBox(height: AppConfig.paddingMedium),

              // Botón eliminar cuenta
              OutlinedButton.icon(
                onPressed: _showDeleteAccountDialog,
                icon: Icon(Icons.delete_forever, color: AppConfig.errorColor),
                label: Text('Eliminar Cuenta'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppConfig.errorColor,
                  side: BorderSide(color: AppConfig.errorColor),
                  minimumSize: Size(double.infinity, 0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppConfig.paddingSmall),
      child: Text(
        title,
        style: TextStyle(
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
                style: TextStyle(fontSize: 50),
              ),
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          TextButton.icon(
            onPressed: _showAvatarSelector,
            icon: Icon(Icons.edit),
            label: Text('Cambiar Avatar'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(user) {
    return Container(
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(color: AppConfig.primaryColor),
      ),
      child: Column(
        children: [
          Text(
            'Tu Actividad en NexGen Parents',
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConfig.paddingMedium),
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
                user.role == 'admin' ? 'Admin' : user.role == 'moderator' ? 'Mod' : 'Usuario',
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
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppConfig.primaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppConfig.textSecondaryColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildChildrenAgesSection() {
    return Column(
      children: [
        Wrap(
          spacing: AppConfig.paddingSmall,
          children: _childrenAges.map((age) {
            return Chip(
              label: Text('$age años'),
              deleteIcon: Icon(Icons.close, size: 18),
              onDeleted: () {
                setState(() {
                  _childrenAges.remove(age);
                });
              },
            );
          }).toList(),
        ),
        SizedBox(height: AppConfig.paddingSmall),
        OutlinedButton.icon(
          onPressed: _showAddAgeDialog,
          icon: Icon(Icons.add),
          label: Text('Añadir Edad de Hijo/a'),
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
        title: Text('Selecciona tu Avatar'),
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
                  child: Text(avatar, style: TextStyle(fontSize: 30)),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showAddAgeDialog() {
    final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Añadir Edad'),
        content: TextField(
          controller: ageController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Edad del niño/a',
            hintText: 'Ejemplo: 10',
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final age = int.tryParse(ageController.text);
              if (age != null && age > 0 && age < 100) {
                setState(() {
                  if (!_childrenAges.contains(age)) {
                    _childrenAges.add(age);
                    _childrenAges.sort();
                  }
                });
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Introduce una edad válida')),
                );
              }
            },
            child: Text('Añadir'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Cambiar Contraseña'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Contraseña Actual'),
              ),
              SizedBox(height: AppConfig.paddingMedium),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Nueva Contraseña'),
              ),
              SizedBox(height: AppConfig.paddingMedium),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: 'Confirmar Nueva Contraseña'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              final currentPassword = currentPasswordController.text;
              final newPassword = newPasswordController.text;
              final confirmPassword = confirmPasswordController.text;

              if (newPassword != confirmPassword) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Las nuevas contraseñas no coinciden')),
                );
                return;
              }

              if (newPassword.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('La nueva contraseña debe tener al menos 6 caracteres')),
                );
                return;
              }

              setState(() => _isLoading = true);

              try {
                final result = await _authService.changePassword(
                  currentPassword: currentPassword,
                  newPassword: newPassword,
                );
                if (!(result['success'] == true)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result['message'] ?? 'Error al cambiar la contraseña')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Contraseña cambiada exitosamente')),
                );
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al cambiar la contraseña: ${e.toString()}')),
                );
              } finally {
                setState(() => _isLoading = false);
              }
            },
            child: Text('Cambiar'),
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

    final newName = _nameController.text.trim();
    final newEmail = _emailController.text.trim();

    setState(() => _isLoading = true);

    try {
      // 1) Actualizar displayName en Firebase Auth si cambia
      final firebaseUser = _authService.currentUser;
      if (firebaseUser != null && newName.isNotEmpty && newName != user.displayName) {
        await firebaseUser.updateDisplayName(newName);
      }

      // 2) Si cambia el email, pedir reautenticación (pedir contraseña)
      if (newEmail.isNotEmpty && newEmail != user.email) {
        final passwordController = TextEditingController();
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirmar cambio de email'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Introduce tu contraseña actual para cambiar el correo'),
                SizedBox(height: AppConfig.paddingSmall),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Contraseña actual'),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context, false), child: Text('Cancelar')),
              ElevatedButton(onPressed: () => Navigator.pop(context, true), child: Text('Confirmar')),
            ],
          ),
        );

        if (confirmed == true) {
          final currentPassword = passwordController.text;
          final result = await _authService.changeEmail(currentPassword: currentPassword, newEmail: newEmail);
          if (!(result['success'] == true)) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Error al cambiar email')));
            setState(() => _isLoading = false);
            return;
          }
        } else {
          setState(() => _isLoading = false);
          return;
        }
      }

      // 3) Actualizar Firestore: displayName, email, childrenAges, ownedPlatforms, photoUrl
      final updates = <String, dynamic>{};
      if (newName != user.displayName) updates['displayName'] = newName;
      if (newEmail != user.email) updates['email'] = newEmail;

      if (updates.isNotEmpty) {
        await _firestoreService.updateUserBasicInfo(userId: user.id, displayName: updates['displayName'], email: updates['email']);
      }

      await _firestoreService.updateChildrenAges(userId: user.id, ages: _childrenAges);
      await _firestoreService.updateOwnedPlatforms(userId: user.id, platforms: _selectedPlatforms);
      await _firestoreService.updatePhotoUrl(userId: user.id, photoUrl: _selectedAvatar);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Perfil actualizado correctamente')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al guardar perfil: ${e.toString()}')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDeleteAccountDialog() {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Eliminar Cuenta'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Esta acción eliminará tu cuenta permanentemente. Introduce tu contraseña para confirmar.'),
            SizedBox(height: AppConfig.paddingSmall),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancelar')),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() => _isLoading = true);
              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              final user = authProvider.currentUser;
              if (user == null) {
                setState(() => _isLoading = false);
                return;
              }

              try {
                final result = await _authService.deleteAccount(passwordController.text);
                if (result['success'] == true) {
                  // Eliminar documento en Firestore
                  await _firestoreService.deleteUserAccount(user.id);
                  // Cerrar sesión local
                  await _authService.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Error al eliminar cuenta')));
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
              } finally {
                setState(() => _isLoading = false);
              }
            },
            child: Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}