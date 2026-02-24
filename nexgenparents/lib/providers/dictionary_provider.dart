import 'package:flutter/material.dart';
import '../services/firestore_service.dart';
import '../models/dictionary_term_model.dart';
import '../config/app_config.dart';

class DictionaryProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<DictionaryTerm> _approvedTerms = [];
  List<DictionaryTerm> _userProposedTerms = [];
  List<DictionaryTerm> _pendingTerms = [];
  List<DictionaryTerm> _searchResults = [];
  
  DictionaryTerm? _selectedTerm;
  String _selectedCategory = 'all';
  bool _isLoading = false;
  bool _isSearching = false;
  String? _errorMessage;

  // Getters
  List<DictionaryTerm> get approvedTerms => _approvedTerms;
  List<DictionaryTerm> get userProposedTerms => _userProposedTerms;
  List<DictionaryTerm> get pendingTerms => _pendingTerms;
  List<DictionaryTerm> get searchResults => _searchResults;
  DictionaryTerm? get selectedTerm => _selectedTerm;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  String? get errorMessage => _errorMessage;

  // Obtener términos aprobados (con stream en tiempo real)
  void loadApprovedTerms() {
    _firestoreService.getApprovedTerms().listen((terms) {
      _approvedTerms = terms;
      notifyListeners();
    });
  }

  // Filtrar términos por categoría
  void filterByCategory(String category) {
    _selectedCategory = category;
    
    if (category == 'all') {
      loadApprovedTerms();
    } else {
      _firestoreService.getTermsByCategory(category).listen((terms) {
        _approvedTerms = terms;
        notifyListeners();
      });
    }
  }

  // Buscar términos (READ - parte del CRUD) [1]
  Future<void> searchTerms(String query) async {
    if (query.isEmpty) {
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      _searchResults = await _firestoreService.searchTerms(query);
      _isSearching = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al buscar términos';
      _isSearching = false;
      notifyListeners();
    }
  }

  // Limpiar búsqueda
  void clearSearch() {
    _searchResults = [];
    _isSearching = false;
    notifyListeners();
  }

  // Obtener detalle de un término específico
  Future<void> loadTermDetail(String termId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedTerm = await _firestoreService.getTermById(termId);
      
      // Incrementar contador de visualizaciones
      if (_selectedTerm != null) {
        await _firestoreService.incrementViewCount(termId);
      }
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error al cargar el término';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Proponer nuevo término (CREATE - parte del CRUD) [1]
  Future<bool> proposeNewTerm({
    required String term,
    required String definition,
    required String example,
    required String category,
    required String userId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _firestoreService.proposeNewTerm(
        term: term,
        definition: definition,
        example: example,
        category: category,
        userId: userId,
      );

      _isLoading = false;

      if (result['success']) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al proponer término: ${e.toString()}';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Obtener términos propuestos por el usuario
  void loadUserProposedTerms(String userId) {
    _firestoreService.getUserProposedTerms(userId).listen((terms) {
      _userProposedTerms = terms;
      notifyListeners();
    });
  }

  // Obtener términos pendientes de aprobación (para moderadores)
  void loadPendingTerms() {
    _firestoreService.getPendingTerms().listen((terms) {
      _pendingTerms = terms;
      notifyListeners();
    });
  }

  // Aprobar término (solo moderadores)
  Future<bool> approveTerm({
    required String termId,
    required String moderatorId,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _firestoreService.approveTerm(
        termId: termId,
        moderatorId: moderatorId,
      );

      _isLoading = false;

      if (result['success']) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al aprobar término';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Rechazar término (solo moderadores)
  Future<bool> rejectTerm({
    required String termId,
    required String reason,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _firestoreService.rejectTerm(
        termId: termId,
        reason: reason,
      );

      _isLoading = false;

      if (result['success']) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al rechazar término';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Actualizar término (UPDATE - parte del CRUD) [1]
  Future<bool> updateTerm({
    required String termId,
    String? definition,
    String? example,
    String? category,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _firestoreService.updateTerm(
        termId: termId,
        definition: definition,
        example: example,
        category: category,
      );

      _isLoading = false;

      if (result['success']) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al actualizar término';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Eliminar término (DELETE - parte del CRUD) [1]
  Future<bool> deleteTerm(String termId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _firestoreService.deleteTerm(termId);

      _isLoading = false;

      if (result['success']) {
        notifyListeners();
        return true;
      } else {
        _errorMessage = result['message'];
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error al eliminar término';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Votar por un término (gamificación)
  Future<void> voteForTerm(String termId) async {
    try {
      await _firestoreService.voteForTerm(termId);
      // Actualizar el término en la lista local
      final index = _approvedTerms.indexWhere((t) => t.id == termId);
      if (index != -1) {
        _approvedTerms[index] = _approvedTerms[index].copyWith(
          votes: _approvedTerms[index].votes + 1,
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = 'Error al votar';
      notifyListeners();
    }
  }

  // Limpiar mensaje de error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Obtener términos por categoría legible
  List<DictionaryTerm> getTermsByDisplayCategory(String displayName) {
    return _approvedTerms.where((term) {
      return term.categoryDisplayName == displayName;
    }).toList();
  }
}