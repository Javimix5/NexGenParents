class GameFilters {
  String? searchQuery;
  int? yearFrom;
  int? yearTo;
  List<String> selectedGenres;
  List<int> selectedPlatforms;
  int? pegiAge;
  String ordering;

  GameFilters({
    this.searchQuery,
    this.yearFrom,
    this.yearTo,
    this.selectedGenres = const [],
    this.selectedPlatforms = const [],
    this.pegiAge,
    this.ordering = '-rating',
  });

  bool get hasActiveFilters {
    return searchQuery != null && searchQuery!.isNotEmpty ||
           yearFrom != null ||
           yearTo != null ||
           selectedGenres.isNotEmpty ||
           selectedPlatforms.isNotEmpty ||
           pegiAge != null;
  }

  GameFilters copyWith({
    String? searchQuery,
    int? yearFrom,
    int? yearTo,
    List<String>? selectedGenres,
    List<int>? selectedPlatforms,
    int? pegiAge,
    String? ordering,
  }) {
    return GameFilters(
      searchQuery: searchQuery ?? this.searchQuery,
      yearFrom: yearFrom ?? this.yearFrom,
      yearTo: yearTo ?? this.yearTo,
      selectedGenres: selectedGenres ?? this.selectedGenres,
      selectedPlatforms: selectedPlatforms ?? this.selectedPlatforms,
      pegiAge: pegiAge ?? this.pegiAge,
      ordering: ordering ?? this.ordering,
    );
  }

  GameFilters clear() {
    return GameFilters();
  }
}