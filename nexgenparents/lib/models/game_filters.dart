class GameFilters {
  static const Object _unset = Object();

  final String? searchQuery;
  final int? yearFrom;
  final int? yearTo;
  final List<String> selectedGenres;
  final List<int> selectedPlatforms;
  final int? pegiAge;
  final String ordering;

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
    Object? searchQuery = _unset,
    Object? yearFrom = _unset,
    Object? yearTo = _unset,
    List<String>? selectedGenres,
    List<int>? selectedPlatforms,
    Object? pegiAge = _unset,
    String? ordering,
  }) {
    return GameFilters(
      searchQuery: searchQuery == _unset ? this.searchQuery : searchQuery as String?,
      yearFrom: yearFrom == _unset ? this.yearFrom : yearFrom as int?,
      yearTo: yearTo == _unset ? this.yearTo : yearTo as int?,
      selectedGenres: selectedGenres != null ? List<String>.from(selectedGenres) : List<String>.from(this.selectedGenres),
      selectedPlatforms: selectedPlatforms != null ? List<int>.from(selectedPlatforms) : List<int>.from(this.selectedPlatforms),
      pegiAge: pegiAge == _unset ? this.pegiAge : pegiAge as int?,
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
          : <String>[],
      selectedPlatforms: json['selectedPlatforms'] != null
          ? List<int>.from(json['selectedPlatforms'] as List)
          : <int>[],
      pegiAge: json['pegiAge'] as int?,
      ordering: (json['ordering'] as String?) ?? '-rating',
    );
  }
}