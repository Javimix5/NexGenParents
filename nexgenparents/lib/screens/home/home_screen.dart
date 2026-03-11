import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../providers/games_provider.dart';
import '../../config/app_config.dart';
import '../dictionary/dictionary_list_screen.dart';
import '../dictionary/propose_term_screen.dart';
import '../dictionary/my_proposed_terms_screen.dart';
import '../dictionary/moderation_screen.dart';
import '../games/games_search_screen.dart';
import '../auth/login_screen.dart';
import '../info/pegi_info_screen.dart';
import '../admin/users_management_screen.dart';
import '../parental_guides/parental_guides_list_screen.dart';
import '../profile/edit_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);
      final gamesProvider = Provider.of<GamesProvider>(context, listen: false);
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      
      dictionaryProvider.loadApprovedTerms();
      gamesProvider.loadPopularGames();
      
      // Cargar términos propuestos del usuario al iniciar la pantalla
      if (authProvider.currentUser != null) {
        dictionaryProvider.loadUserProposedTerms(authProvider.currentUser!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConfig.appName),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.account_circle),
            onSelected: (value) {
              switch (value) {
                case 'profile':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EditProfileScreen()),
                  );
                  break;
                case 'my_terms':
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => MyProposedTermsScreen()),
                  );
                  break;
                case 'moderation':
                  if (authProvider.isModerator) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ModerationScreen()),
                    );
                  }
                  break;
                case 'users_management':
                  if (authProvider.isAdmin) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const UsersManagementScreen()),
                    );
                  }
                  break;
                case 'logout':
                  authProvider.signOut().then((_) {
                    if (context.mounted) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }
                  });
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'profile',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Editar perfil'),
                ),
              ),
              PopupMenuItem(
                value: 'my_terms',
                child: ListTile(
                  leading: Icon(Icons.article_outlined),
                  title: Text('Mis términos propuestos'),
                  subtitle: Text('${Provider.of<DictionaryProvider>(context, listen: false).userProposedTerms.length} términos'),
                ),
              ),
              if (authProvider.isModerator)
                PopupMenuItem(
                  value: 'moderation',
                  child: ListTile(
                    leading: Icon(Icons.admin_panel_settings),
                    title: Text('Moderación'),
                  ),
                ),
              if (authProvider.isAdmin)
                PopupMenuItem(
                  value: 'users_management',
                  child: ListTile(
                    leading: Icon(Icons.people),
                    title: Text('Gestión de Usuarios'),
                  ),
                ),
              PopupMenuDivider(),
              PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, color: AppConfig.errorColor),
                  title: Text('Cerrar sesión'),
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeBanner(user?.displayName ?? 'Usuario'),
            SizedBox(height: AppConfig.paddingLarge),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
              child: Text(
                '¿Qué deseas hacer?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            SizedBox(height: AppConfig.paddingMedium),
            
            _buildMainActions(context),
            
            SizedBox(height: AppConfig.paddingLarge),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
              child: Text(
                'Información útil',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            SizedBox(height: AppConfig.paddingMedium),
            
            _buildInfoSection(context),
            
            SizedBox(height: AppConfig.paddingLarge),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeBanner(String userName) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppConfig.paddingLarge),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppConfig.primaryColor,
            AppConfig.secondaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '¡Hola, $userName!',
            style: TextStyle(
              fontSize: AppConfig.fontSizeTitle,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          Text(
            'Bienvenido a tu guía de videojuegos para padres',
            style: TextStyle(
              fontSize: AppConfig.fontSizeBody,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainActions(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        children: [
          _buildActionCard(
            context: context,
            title: 'Diccionario Gamer',
            description: 'Consulta términos y jerga de videojuegos',
            icon: Icons.book_outlined,
            color: AppConfig.primaryColor,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DictionaryListScreen(),
                ),
              );
            },
          ),
          SizedBox(height: AppConfig.paddingMedium),
          
          _buildActionCard(
            context: context,
            title: 'Buscar Videojuegos',
            description: 'Encuentra juegos apropiados por edad',
            icon: Icons.search,
            color: AppConfig.secondaryColor,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const GamesSearchScreen(),
                ),
              );
            },
          ),
          SizedBox(height: AppConfig.paddingMedium),
          
          _buildActionCard(
            context: context,
            title: 'Proponer Término',
            description: 'Añade nuevas palabras al diccionario',
            icon: Icons.add_circle_outline,
            color: AppConfig.accentColor,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ProposeTermScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        child: Padding(
          padding: EdgeInsets.all(AppConfig.paddingMedium),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppConfig.paddingMedium),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppConfig.borderRadiusSmall),
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              SizedBox(width: AppConfig.paddingMedium),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    SizedBox(height: AppConfig.paddingSmall / 2),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppConfig.textSecondaryColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PegiInfoScreen(),
                ),
              );
            },
            child: _buildInfoCard(
              context: context,
              title: '¿Qué es PEGI?',
              description: 'Sistema europeo de clasificación por edades para videojuegos',
              icon: Icons.info_outline,
            ),
          ),
          SizedBox(height: AppConfig.paddingSmall),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ParentalGuidesListScreen(),
                ),
              );
            },
            child: _buildInfoCard(
              context: context,
              title: 'Control Parental',
              description: 'Aprende a configurar controles en consolas',
              icon: Icons.security,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required BuildContext context,
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(AppConfig.paddingMedium),
      decoration: BoxDecoration(
        color: AppConfig.cardColor,
        borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
        border: Border.all(
          color: AppConfig.textSecondaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppConfig.primaryColor,
            size: 30,
          ),
          SizedBox(width: AppConfig.paddingMedium),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppConfig.paddingSmall / 2),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}