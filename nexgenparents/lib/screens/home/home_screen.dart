import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/dictionary_provider.dart';
import '../../providers/games_provider.dart';
import '../../config/app_config.dart';
import '../dictionary/dictionary_list_screen.dart';
import '../dictionary/propose_term_screen.dart';
import '../games/games_search_screen.dart';
import '../auth/login_screen.dart';
import '../parental_guides/parental_guides_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Cargar datos iniciales
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dictionaryProvider = Provider.of<DictionaryProvider>(context, listen: false);
      final gamesProvider = Provider.of<GamesProvider>(context, listen: false);
      
      dictionaryProvider.loadApprovedTerms();
      gamesProvider.loadPopularGames();
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
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              _showProfileMenu(context);
            },
            tooltip: 'Mi perfil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner de bienvenida
            _buildWelcomeBanner(user?.displayName ?? 'Usuario'),
            
            SizedBox(height: AppConfig.paddingLarge),
            
            // Sección de acciones principales
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppConfig.paddingMedium),
              child: Text(
                '¿Qué deseas hacer?',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            SizedBox(height: AppConfig.paddingMedium),
            
            // Cards de acciones principales
            _buildMainActions(context),
            
            SizedBox(height: AppConfig.paddingLarge),
            
            // Sección de información rápida
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
          // Card: Diccionario
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
          
          // Card: Buscador de juegos
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
          
          // Card: Proponer término
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
          _buildInfoCard(
            context: context,
            title: '¿Qué es PEGI?',
            description: 'Sistema europeo de clasificación por edades para videojuegos',
            icon: Icons.info_outline,
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

  void _showProfileMenu(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppConfig.borderRadiusLarge),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(AppConfig.paddingLarge),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: AppConfig.primaryColor,
                child: Text(
                  user?.displayName.substring(0, 1).toUpperCase() ?? 'U',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              title: Text(user?.displayName ?? 'Usuario'),
              subtitle: Text(user?.email ?? ''),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.article_outlined),
              title: Text('Mis términos propuestos'),
              subtitle: Text('${user?.termsProposed ?? 0} términos'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Navegar a pantalla de términos del usuario
              },
            ),
            ListTile(
              leading: Icon(Icons.verified_outlined, color: AppConfig.accentColor),
              title: Text('Términos aprobados'),
              subtitle: Text('${user?.termsApproved ?? 0} aprobados'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout, color: AppConfig.errorColor),
              title: Text('Cerrar sesión'),
              onTap: () async {
                Navigator.pop(context);
                await authProvider.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}