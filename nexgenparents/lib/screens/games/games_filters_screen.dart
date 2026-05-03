import 'package:flutter/material.dart';
import '../../models/game_filters.dart';
import '../../config/app_config.dart';
import '../../l10n/app_localizations.dart';

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
  Map<String, String> _getGenres(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return {
      l10n?.genreAction ?? 'Acción': 'action',
      l10n?.genreAdventure ?? 'Aventura': 'adventure',
      l10n?.genreRPG ?? 'RPG': 'role-playing-games-rpg',
      l10n?.genreStrategy ?? 'Estrategia': 'strategy',
      l10n?.genreShooter ?? 'Shooter': 'shooter',
      l10n?.genrePuzzle ?? 'Puzzle': 'puzzle',
      l10n?.genreSports ?? 'Deportes': 'sports',
      l10n?.genreRacing ?? 'Carreras': 'racing',
      l10n?.genreSimulation ?? 'Simulación': 'simulation',
      l10n?.genrePlatformer ?? 'Plataformas': 'platformer',
      l10n?.genreFighting ?? 'Lucha': 'fighting',
      l10n?.genreArcade ?? 'Arcade': 'arcade',
    };
  }


  @override
  void initState() {
    super.initState();
    _filters = widget.initialFilters;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final genresMap = _getGenres(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n?.filtersTitle ?? 'Filtros de Búsqueda'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _filters = GameFilters();
              });
            },
            child: Text(
              l10n?.filtersClear ?? 'Limpiar',
              style: const TextStyle(color: Colors.white),
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
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: AppConfig.primaryColor),
                  const SizedBox(width: AppConfig.paddingSmall),
                  Expanded(
                    child: Text(
                      l10n?.filtersInfoBanner ?? 'Combina múltiples filtros para encontrar el juego perfecto',
                      style: const TextStyle(fontSize: AppConfig.fontSizeCaption),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConfig.paddingLarge),

            // Filtro por Año
            _buildSectionTitle(l10n?.filtersYearTitle ?? 'Año de lanzamiento'),
            Text(
              l10n?.filtersYearSubtitle ?? 'Filtra juegos por su año de salida',
              style: const TextStyle(
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
                    decoration: InputDecoration(labelText: l10n?.filtersYearFrom ?? 'Desde'),
                    items: _buildYearItems(context),
                    onChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(yearFrom: value);
                        // Auto-corregir "Hasta" si queda por debajo de "Desde"
                        if (value != null && _filters.yearTo != null && _filters.yearTo! < value) {
                          _filters = _filters.copyWith(yearTo: value);
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: AppConfig.paddingMedium),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    initialValue: _filters.yearTo,
                    decoration: InputDecoration(labelText: l10n?.filtersYearTo ?? 'Hasta'),
                    items: _buildYearItems(context),
                    onChanged: (value) {
                      setState(() {
                        _filters = _filters.copyWith(yearTo: value);
                        // Auto-corregir "Desde" si queda por encima de "Hasta"
                        if (value != null && _filters.yearFrom != null && _filters.yearFrom! > value) {
                          _filters = _filters.copyWith(yearFrom: value);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppConfig.paddingLarge),

            // Filtro por Edad PEGI
            _buildSectionTitle(l10n?.filtersPegiTitle ?? 'Edad recomendada (PEGI)'),
            Text(
              l10n?.filtersPegiSubtitle ?? 'Selecciona la edad de tu hijo para ver juegos apropiados',
              style: const TextStyle(
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
            _buildSectionTitle(l10n?.filtersPlatformTitle ?? 'Plataforma'),
            Text(
              l10n?.filtersPlatformSubtitle ?? 'Selecciona en qué dispositivos quieres que esté disponible',
              style: const TextStyle(
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
            _buildSectionTitle(l10n?.filtersGenreTitle ?? 'Género de juego'),
            Text(
              l10n?.filtersGenreSubtitle ?? 'Elige el tipo de juegos que te interesan',
              style: const TextStyle(
                fontSize: AppConfig.fontSizeCaption,
                color: AppConfig.textSecondaryColor,
              ),
            ),
            const SizedBox(height: AppConfig.paddingSmall),
            Wrap(
              spacing: AppConfig.paddingSmall,
              runSpacing: AppConfig.paddingSmall,
              children: genresMap.entries.map((entry) {
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
            label: Text(
              l10n?.filtersApplyBtn ?? 'Aplicar Filtros',
              style: const TextStyle(fontSize: AppConfig.fontSizeBody),
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

  List<DropdownMenuItem<int>> _buildYearItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final currentYear = DateTime.now().year;
    List<DropdownMenuItem<int>> items = [
      DropdownMenuItem(
        value: null,
        child: Text(l10n?.filtersYearAny ?? 'Cualquiera'),
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