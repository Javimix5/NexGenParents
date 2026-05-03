import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/firestore_service.dart';
import '../../models/user_model.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';

class UsersManagementScreen extends StatelessWidget {
  const UsersManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final firestoreService = FirestoreService();
    final l10n = AppLocalizations.of(context)!;

    // Verificar que sea admin
    if (!authProvider.isAdmin) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.adminAccessDeniedTitle)),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppConfig.paddingLarge),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.block,
                  size: 80,
                  color: AppConfig.errorColor,
                ),
                const SizedBox(height: AppConfig.paddingMedium),
                Text(
                  l10n.adminAccessDeniedMessage,
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
        title: Text(l10n.adminUsersTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => _showInfoDialog(context),
            tooltip: l10n.adminUsersInfoTooltip,
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
                  const CircularProgressIndicator(),
                  const SizedBox(height: AppConfig.paddingMedium),
                  Text(l10n.adminUsersLoading),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppConfig.paddingLarge),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 80,
                      color: AppConfig.errorColor,
                    ),
                    const SizedBox(height: AppConfig.paddingMedium),
                    Text(
                      l10n.adminUsersError,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    const SizedBox(height: AppConfig.paddingSmall),
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
              child: Text(l10n.adminUsersEmpty),
            );
          }

          return Column(
            children: [
              // Header con estadísticas
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConfig.paddingMedium),
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
                      l10n.adminUsersStatTotal,
                      users.length,
                      AppConfig.primaryColor,
                    ),
                    _buildStatChip(
                      l10n.adminUsersStatAdmins,
                      users.where((u) => u.isAdmin).length,
                      AppConfig.errorColor,
                    ),
                    _buildStatChip(
                      l10n.adminUsersStatMods,
                      users.where((u) => u.isModerator).length,
                      AppConfig.warningColor,
                    ),
                    _buildStatChip(
                      l10n.adminUsersStatUsers,
                      users.where((u) => u.role == 'user').length,
                      AppConfig.accentColor,
                    ),
                  ],
                ),
              ),

              // Lista de usuarios
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(AppConfig.paddingMedium),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    final isCurrentUser = user.id == authProvider.currentUser?.id;

                    return Card(
                      margin: const EdgeInsets.only(bottom: AppConfig.paddingMedium),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: _getRoleColor(user.role),
                          child: Text(
                            user.displayName.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
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
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            if (isCurrentUser)
                              Chip(
                                label: Text(l10n.adminUsersBadgeYou),
                                backgroundColor: AppConfig.primaryColor.withOpacity(0.2),
                                labelStyle: const TextStyle(fontSize: 12),
                              ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(user.email),
                            const SizedBox(height: AppConfig.paddingSmall / 2),
                            Row(
                              children: [
                                _buildRoleChip(user.role, l10n),
                                const SizedBox(width: AppConfig.paddingSmall),
                                Text(
                                  l10n.adminUsersProposedApproved(user.termsProposed, user.termsApproved),
                                  style: const TextStyle(
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
                                icon: const Icon(Icons.more_vert),
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
                                        const Icon(Icons.person, size: 20),
                                        const SizedBox(width: AppConfig.paddingSmall),
                                        Text(l10n.adminUsersActionMakeUser),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'moderator',
                                    enabled: user.role != 'moderator',
                                    child: Row(
                                      children: [
                                        const Icon(Icons.verified_user, size: 20),
                                        const SizedBox(width: AppConfig.paddingSmall),
                                        Text(l10n.adminUsersActionMakeMod),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 'admin',
                                    enabled: user.role != 'admin',
                                    child: Row(
                                      children: [
                                        const Icon(Icons.admin_panel_settings, size: 20),
                                        const SizedBox(width: AppConfig.paddingSmall),
                                        Text(l10n.adminUsersActionMakeAdmin),
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
          style: const TextStyle(
            fontSize: AppConfig.fontSizeCaption,
            color: AppConfig.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleChip(String role, AppLocalizations l10n) {
    Color color = _getRoleColor(role);
    String label = _getRoleLabel(role, l10n);

    return Container(
      padding: const EdgeInsets.symmetric(
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

  String _getRoleLabel(String role, AppLocalizations l10n) {
    switch (role) {
      case 'admin':
        return l10n.adminRoleAdmin;
      case 'moderator':
        return l10n.adminRoleModerator;
      default:
        return l10n.adminRoleUser;
    }
  }

  void _changeUserRole(
    BuildContext context,
    FirestoreService firestoreService,
    AuthProvider authProvider,
    UserModel user,
    String newRole,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.adminChangeRoleTitle),
        content: Text(
          l10n.adminChangeRoleConfirm(user.displayName, _getRoleLabel(newRole, l10n)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.adminCancelBtn),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(l10n.adminConfirmBtn),
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
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.info_outline, color: AppConfig.primaryColor),
            const SizedBox(width: AppConfig.paddingSmall),
            Text(l10n.adminInfoDialogTitle),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.adminInfoDialogSubtitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: AppConfig.fontSizeBody,
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            _buildRoleInfo(
              l10n.adminRoleUser,
              l10n.adminInfoUserDesc,
              AppConfig.accentColor,
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            _buildRoleInfo(
              l10n.adminRoleModerator,
              l10n.adminInfoModDesc,
              AppConfig.warningColor,
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            _buildRoleInfo(
              l10n.adminRoleAdmin,
              l10n.adminInfoAdminDesc,
              AppConfig.errorColor,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.adminInfoUnderstoodBtn),
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
          margin: const EdgeInsets.only(top: 6),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppConfig.paddingSmall),
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
                style: const TextStyle(
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