import 'package:flutter/material.dart';
import '../../models/game_filters.dart';
import '../../config/app_config.dart';

class GamesFiltersScreen extends StatefulWidget {
  final GameFilters initialFilters;

  const GamesFiltersScreen({
    super.key,
    required this.initialFilters,
  });

  @override
  State<GamesFiltersScreen> createState() => _GamesFiltersScreenState();
}

class _GamesFiltersScreenState extends State<GamesFiltersScreen> {
  late GameFilters _filters;
  
  // Opciones de plataformas (IDs de RAWG API)
  final Map<String, int> platforms = {
    'PlayStation 5': 187,
    'PlayStation 4': 18,
    'Xbox Series X/S': 186,
    'Xbox One': 1,
    'Nintendo Switch': 7,
    'PC': 4,
    'iOS': 3,
    'Android': 21,
  };

  // Opciones de géneros principales
  final Map<String, String> genres = {
    'Acción': 'action',
    'Aventura': 'adventure',
    'RPG': 'role-playing-games-rpg',
    'Estrategia': 'strategy',
    'Shooter': 'shooter',
    'Puzzle': 'puzzle',
    'Deportes': 'sports',
    'Carreras': 'racing',
    'Simulación': 'simulation',
    'Plataformas': 'platformer',
    'Lucha': 'fighting',
    'Arcade': 'arcade',
  };

  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filtros de Búsqueda'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _filters = GameFilters();
              });
            },
            child: const Text(
              'Limpiar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppConfig.paddingMedium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner informativo
            Container(
              padding: const EdgeInsets.all(AppConfig.paddingMedium),
              decoration: BoxDecoration(
                color: AppConfig.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppConfig.borderRadiusMedium),
                border: Border.all(color: AppConfig.primaryColor),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline, color: AppConfig.primaryColor),
                  SizedBox(width: AppConfig.paddingSmall),
                  Expanded(
                    child: Text(
                      'Combina múltiples filtros para encontrar el juego perfecto',
                      style: TextStyle(fontSize: AppConfig.fontSizeCaption),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConfig.paddingLarge),

            // Filtro por Año
            _buildSectionTitle('Año de lanzamiento'),
            const Text(
              'Filtra juegos por su año de salida',
              style: TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _filters.yearFrom,
                    decoration: const InputDecoration(labelText: 'Desde'),
                    items: _buildYearItems(),
                    onChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(yearFrom: value);
                      });
                    },
                  ),
                ),
                const SizedBox(width: AppConfig.paddingMedium),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _filters.yearTo,
                    decoration: const InputDecoration(labelText: 'Hasta'),
                    items: _buildYearItems(),
                    onChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(yearTo: value);
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConfig.paddingLarge),

            // Filtro por Edad PEGI
            _buildSectionTitle('Edad recomendada (PEGI)'),
            const Text(
              'Selecciona la edad de tu hijo para ver juegos apropiados',
              style: TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            Wrap(
              spacing: AppConfig.paddingSmall,
              children: AppConfig.pegiRatings.map((age) {
                final isSelected = _filters.pegiAge == age;
                return ChoiceChip(
                  label: Text('PEGI $age+'),
                  selected: isSelected,
                  selectedColor: AppConfig.accentColor.withOpacity(0.3),
                  onSelected: (selected) {
                    setState(() {
                      _filters = _filters.copyWith(
                        pegiAge: selected ? age : null,
                      );
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: AppConfig.paddingLarge),

            // Filtro por Plataforma
            _buildSectionTitle('Plataforma'),
            const Text(
              'Selecciona en qué dispositivos quieres que esté disponible',
              style: TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            ...platforms.entries.map((entry) {
              final isSelected = _filters.selectedPlatforms.contains(entry.value);
              return CheckboxListTile(
                title: Text(entry.key),
                value: isSelected,
                contentPadding: EdgeInsets.zero,
                onChanged: (checked) {
                  setState(() {
                    List<int> newPlatforms = List.from(_filters.selectedPlatforms);
                    if (checked == true) {
                      newPlatforms.add(entry.value);
                    } else {
                      newPlatforms.remove(entry.value);
                    }
                    _filters = _filters.copyWith(selectedPlatforms: newPlatforms);
                  });
                },
              );
            }),
            const SizedBox(height: AppConfig.paddingLarge),

            // Filtro por Género
            _buildSectionTitle('Género de juego'),
            const Text(
              'Elige el tipo de juegos que te interesan',
              style: TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            Wrap(
              spacing: AppConfig.paddingSmall,
              runSpacing: AppConfig.paddingSmall,
              children: genres.entries.map((entry) {
                final isSelected = _filters.selectedGenres.contains(entry.value);
                return FilterChip(
                  label: Text(entry.key),
                  selected: isSelected,
                  selectedColor: AppConfig.secondaryColor.withOpacity(0.3),
                  onSelected: (selected) {
                    setState(() {
                      List<String> newGenres = List.from(_filters.selectedGenres);
                      if (selected) {
                        newGenres.add(entry.value);
                      } else {
                        newGenres.remove(entry.value);
                      }
                      _filters = _filters.copyWith(selectedGenres: newGenres);
                    });
                  },
                );
              }).toList(),
            ),
            
            const SizedBox(height: AppConfig.paddingLarge),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppConfig.paddingMedium),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pop(_filters);
            },
            icon: const Icon(Icons.check),
            label: const Text(
              'Aplicar Filtros',
              style: TextStyle(fontSize: AppConfig.fontSizeBody),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: AppConfig.paddingMedium),
            ),
          ),
        ),
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

  List<DropdownMenuItem<int>> _buildYearItems() {
    final currentYear = DateTime.now().year;
    List<DropdownMenuItem<int>> items = [
      const DropdownMenuItem(
        value: null,
        child: Text('Cualquiera'),
      ),
    ];
    
    for (int year = currentYear; year >= 2000; year--) {
      items.add(DropdownMenuItem(
        value: year,
        child: Text(year.toString()),
      ));
    }
    
    return items;
  }
}