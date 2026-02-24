import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../models/user_model.dart';
import '../../config/app_config.dart';

class UsersManagementScreen extends StatelessWidget {
  const UsersManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreService = FirestoreService();

    // Verificar que sea admin
    if (!authProvider.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: Text('Acceso Denegado')),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(AppConfig.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.block,
                  size: 80,
                  color: AppConfig.errorColor,
                ),
                SizedBox(height: AppConfig.paddingMedium),
                Text(
                  'Solo los administradores pueden acceder',
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Usuarios'),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: 'Información',
          ),
        ],
      ),
      body: StreamBuilder<List<UserModel>>(
        stream: firestoreService.getAllUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: AppConfig.paddingMedium),
                  Text('Cargando usuarios...'),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(AppConfig.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80,
                      color: AppConfig.errorColor,
                    ),
                    SizedBox(height: AppConfig.paddingMedium),
                    Text(
                      'Error al cargar usuarios',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: AppConfig.paddingSmall),
                    Text(
                      snapshot.error.toString(),
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }

          final users = snapshot.data ?? [];

          if (users.isEmpty) {
            return Center(
              child: Text('No hay usuarios registrados'),
            );
          }

          return Column(
            children: [
              // Header con estadísticas
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: AppConfig.primaryColor.withOpacity(0.1),
                  border: Border(
                    bottom: BorderSide(
                      color: AppConfig.primaryColor.withOpacity(0.3),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatChip(
                      'Total',
                      users.length,
                      AppConfig.primaryColor,
                    ),
                    _buildStatChip(
                      'Admins',
                      users.where((u) => u.role == 'admin').length,
                      AppConfig.errorColor,
                    ),
                    _buildStatChip(
                      'Moderadores',
                      users.where((u) => u.role == 'moderator').length,
                      AppConfig.warningColor,
                    ),
                    _buildStatChip(
                      'Usuarios',
                      users.where((u) => u.role == 'user').length,
                      AppConfig.accentColor,
                    ),
                  ],
                ),
              ),

              // Lista de usuarios
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(AppConfig.paddingMedium),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final isCurrentUser = user.id == authProvider.currentUser?.id;

                    return Card(
                      margin: EdgeInsets.only(bottom: AppConfig.paddingMedium),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getRoleColor(user.role),
                          child: Text(
                            user.displayName.substring(0, 1).toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                user.displayName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (isCurrentUser)
                              Chip(
                                label: Text('Tú'),
                                backgroundColor: AppConfig.primaryColor.withOpacity(0.2),
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.email),
                            SizedBox(height: AppConfig.paddingSmall / 2),
                            Row(
                              children: [
                                _buildRoleChip(user.role),
                                SizedBox(width: AppConfig.paddingSmall),
                                Text(
                                  '${user.termsProposed} propuestos | ${user.termsApproved} aprobados',
                                  style: TextStyle(
                                    fontSize: AppConfig.fontSizeCaption,
                                    color: AppConfig.textSecondaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: isCurrentUser
                            ? null
                            : PopupMenuButton<String>(
                                icon: Icon(Icons.more_vert),
                                onSelected: (value) {
                                  _changeUserRole(
                                    context,
                                    firestoreService,
                                    authProvider,
                                    user,
                                    value,
                                  );
                                },
                                itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 'user',
                                    enabled: user.role != 'user',
                                    child: Row(
                                      children: [
                                        Icon(Icons.person, size: 20),
                                        SizedBox(width: AppConfig.paddingSmall),
                                        Text('Cambiar a Usuario'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'moderator',
                                    enabled: user.role != 'moderator',
                                    child: Row(
                                      children: [
                                        Icon(Icons.verified_user, size: 20),
                                        SizedBox(width: AppConfig.paddingSmall),
                                        Text('Cambiar a Moderador'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'admin',
                                    enabled: user.role != 'admin',
                                    child: Row(
                                      children: [
                                        Icon(Icons.admin_panel_settings, size: 20),
                                        SizedBox(width: AppConfig.paddingSmall),
                                        Text('Cambiar a Admin'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: AppConfig.fontSizeCaption,
            color: AppConfig.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleChip(String role) {
    Color color = _getRoleColor(role);
    String label = _getRoleLabel(role);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConfig.paddingSmall,
        vertical: AppConfig.paddingSmall / 2,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: AppConfig.fontSizeCaption,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Color _getRoleColor(String role) {
    switch (role) {
      case 'admin':
        return AppConfig.errorColor;
      case 'moderator':
        return AppConfig.warningColor;
      default:
        return AppConfig.accentColor;
    }
  }

  String _getRoleLabel(String role) {
    switch (role) {
      case 'admin':
        return 'Admin';
      case 'moderator':
        return 'Moderador';
      default:
        return 'Usuario';
    }
  }

  void _changeUserRole(
    BuildContext context,
    FirestoreService firestoreService,
    AuthProvider authProvider,
    UserModel user,
    String newRole,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmar cambio de rol'),
        content: Text(
          '¿Estás seguro de que deseas cambiar el rol de "${user.displayName}" a "${_getRoleLabel(newRole)}"?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('Confirmar'),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    final result = await firestoreService.updateUserRole(
      userId: user.id,
      newRole: newRole,
      adminId: authProvider.currentUser!.id,
        );

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: result['success'] 
              ? AppConfig.accentColor 
              : AppConfig.errorColor,
        ),
      );
    }
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info_outline, color: AppConfig.primaryColor),
            SizedBox(width: AppConfig.paddingSmall),
            Text('Gestión de Roles'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Roles disponibles:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppConfig.fontSizeBody,
              ),
            ),
            SizedBox(height: AppConfig.paddingSmall),
            _buildRoleInfo(
              'Usuario',
              'Puede consultar el diccionario y proponer términos',
              AppConfig.accentColor,
            ),
            SizedBox(height: AppConfig.paddingSmall),
            _buildRoleInfo(
              'Moderador',
              'Puede aprobar o rechazar términos propuestos',
              AppConfig.warningColor,
            ),
            SizedBox(height: AppConfig.paddingSmall),
            _buildRoleInfo(
              'Admin',
              'Tiene acceso completo, incluida la gestión de usuarios',
              AppConfig.errorColor,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Entendido'),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleInfo(String title, String description, Color color) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8,
          height: 8,
          margin: EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: AppConfig.paddingSmall),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: AppConfig.fontSizeCaption,
                  color: AppConfig.textSecondaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}