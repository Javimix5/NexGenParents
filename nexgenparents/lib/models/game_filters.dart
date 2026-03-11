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

  Map<String, dynamic> toJson() {
    return {
      'searchQuery': searchQuery,
      'yearFrom': yearFrom,
      'yearTo': yearTo,
      'selectedGenres': selectedGenres,
      'selectedPlatforms': selectedPlatforms,
      'pegiAge': pegiAge,
      'ordering': ordering,
    };
  }

  factory GameFilters.fromJson(Map<String, dynamic> json) {
    return GameFilters(
      searchQuery: json['searchQuery'] as String?,
      yearFrom: json['yearFrom'] as int?,
      yearTo: json['yearTo'] as int?,
      selectedGenres: json['selectedGenres'] != null
          ? List<String>.from(json['selectedGenres'] as List)
          : const [],
      selectedPlatforms: json['selectedPlatforms'] != null
          ? List<int>.from(json['selectedPlatforms'] as List)
          : const [],
      pegiAge: json['pegiAge'] as int?,
      ordering: (json['ordering'] as String?) ?? '-rating',
    );
  }
}