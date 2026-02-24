import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dictionary_term_model.dart';
import '../models/user_model.dart';
import '../config/app_config.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ========== MÉTODOS PARA EL DICCIONARIO ==========

  // Obtener términos aprobados (para usuarios normales)
  Stream<List<DictionaryTerm>> getApprovedTerms() {
    return _firestore
        .collection('dictionary_terms')
        .where('status', isEqualTo: AppConfig.statusApproved)
        .orderBy('term', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DictionaryTerm.fromFirestore(doc))
            .toList());
  }

  // Obtener términos por categoría
  Stream<List<DictionaryTerm>> getTermsByCategory(String category) {
    return _firestore
        .collection('dictionary_terms')
        .where('status', isEqualTo: AppConfig.statusApproved)
        .where('category', isEqualTo: category)
        .orderBy('term', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DictionaryTerm.fromFirestore(doc))
            .toList());
  }

  // Buscar términos aprobados por texto
  Future<List<DictionaryTerm>> searchTerms(String query) async {
    try {
      final snapshot = await _firestore
          .collection('dictionary_terms')
          .where('status', isEqualTo: AppConfig.statusApproved)
          .get();

      // Filtrar en cliente (Firestore no tiene búsqueda full-text nativa)
      final terms = snapshot.docs
          .map((doc) => DictionaryTerm.fromFirestore(doc))
          .where((term) =>
              term.term.toLowerCase().contains(query.toLowerCase()) ||
              term.definition.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return terms;
    } catch (e) {
      print('Error al buscar términos: $e');
      return [];
    }
  }

  // Obtener un término específico por ID
  Future<DictionaryTerm?> getTermById(String termId) async {
    try {
      final doc = await _firestore
          .collection('dictionary_terms')
          .doc(termId)
          .get();

      if (!doc.exists) return null;
      return DictionaryTerm.fromFirestore(doc);
    } catch (e) {
      print('Error al obtener término: $e');
      return null;
    }
  }

  // Proponer nuevo término (CREATE - parte del CRUD)
  Future<Map<String, dynamic>> proposeNewTerm({
    required String term,
    required String definition,
    required String example,
    required String category,
    required String userId,
  }) async {
    try {
      // Verificar si el término ya existe
      final existingTerms = await _firestore
          .collection('dictionary_terms')
          .where('term', isEqualTo: term.trim())
          .get();

      if (existingTerms.docs.isNotEmpty) {
        return {
          'success': false,
          'message': 'Este término ya existe en el diccionario',
        };
      }

      // Crear nuevo término pendiente de aprobación
      final newTerm = DictionaryTerm(
        id: '', // Firestore lo asignará automáticamente
        term: term.trim(),
        definition: definition.trim(),
        example: example.trim(),
        category: category,
        status: AppConfig.statusPending,
        proposedBy: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final docRef = await _firestore
          .collection('dictionary_terms')
          .add(newTerm.toMap());

      // Incrementar contador de términos propuestos del usuario
      await _firestore.collection('users').doc(userId).update({
        'termsProposed': FieldValue.increment(1),
      });

      return {
        'success': true,
        'message': 'Término propuesto correctamente. Será revisado por un moderador',
        'termId': docRef.id,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al proponer término: ${e.toString()}',
      };
    }
  }

  // Obtener términos propuestos por un usuario específico (READ - CRUD)
  Stream<List<DictionaryTerm>> getUserProposedTerms(String userId) {
    return _firestore
        .collection('dictionary_terms')
        .where('proposedBy', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DictionaryTerm.fromFirestore(doc))
            .toList());
  }

  // Obtener términos pendientes de aprobación (para moderadores)
  Stream<List<DictionaryTerm>> getPendingTerms() {
    return _firestore
        .collection('dictionary_terms')
        .where('status', isEqualTo: AppConfig.statusPending)
        .orderBy('createdAt', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => DictionaryTerm.fromFirestore(doc))
            .toList());
  }

  // Aprobar término (solo moderadores/admin)
  Future<Map<String, dynamic>> approveTerm({
    required String termId,
    required String moderatorId,
  }) async {
    try {
      final termDoc = await _firestore
          .collection('dictionary_terms')
          .doc(termId)
          .get();

      if (!termDoc.exists) {
        return {
          'success': false,
          'message': 'El término no existe',
        };
      }

      final term = DictionaryTerm.fromFirestore(termDoc);

      // Actualizar estado del término
      await _firestore.collection('dictionary_terms').doc(termId).update({
        'status': AppConfig.statusApproved,
        'approvedBy': moderatorId,
        'updatedAt': Timestamp.now(),
      });

      // Incrementar contador de términos aprobados del usuario que lo propuso
      await _firestore.collection('users').doc(term.proposedBy).update({
        'termsApproved': FieldValue.increment(1),
      });

      return {
        'success': true,
        'message': 'Término aprobado correctamente',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al aprobar término: ${e.toString()}',
      };
    }
  }

  // Rechazar término (solo moderadores/admin)
  Future<Map<String, dynamic>> rejectTerm({
    required String termId,
    required String reason,
  }) async {
    try {
      await _firestore.collection('dictionary_terms').doc(termId).update({
        'status': AppConfig.statusRejected,
        'rejectionReason': reason,
        'updatedAt': Timestamp.now(),
      });

      return {
        'success': true,
        'message': 'Término rechazado',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al rechazar término: ${e.toString()}',
      };
    }
  }

  // Actualizar término existente (UPDATE - CRUD)
  Future<Map<String, dynamic>> updateTerm({
    required String termId,
    String? definition,
    String? example,
    String? category,
  }) async {
    try {
      Map<String, dynamic> updates = {
        'updatedAt': Timestamp.now(),
      };

      if (definition != null) updates['definition'] = definition;
      if (example != null) updates['example'] = example;
      if (category != null) updates['category'] = category;

      await _firestore
          .collection('dictionary_terms')
          .doc(termId)
          .update(updates);

      return {
        'success': true,
        'message': 'Término actualizado correctamente',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al actualizar término: ${e.toString()}',
      };
    }
  }

  // Eliminar término (DELETE - CRUD, solo admin)
  Future<Map<String, dynamic>> deleteTerm(String termId) async {
    try {
      await _firestore.collection('dictionary_terms').doc(termId).delete();

      return {
        'success': true,
        'message': 'Término eliminado correctamente',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error al eliminar término: ${e.toString()}',
      };
    }
  }

  // Votar término (incrementar contador de votos)
  Future<void> voteForTerm(String termId) async {
    try {
      await _firestore.collection('dictionary_terms').doc(termId).update({
        'votes': FieldValue.increment(1),
      });
    } catch (e) {
      print('Error al votar término: $e');
    }
  }

  // Incrementar contador de visualizaciones
  Future<void> incrementViewCount(String termId) async {
    try {
      await _firestore.collection('dictionary_terms').doc(termId).update({
        'viewCount': FieldValue.increment(1),
      });
    } catch (e) {
      print('Error al incrementar contador de vistas: $e');
    }
  }

  // ========== MÉTODOS PARA USUARIOS ==========

  // Obtener datos de un usuario
  Future<UserModel?> getUserById(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    } catch (e) {
      print('Error al obtener usuario: $e');
      return null;
    }
  }


// ========== MÉTODOS PARA ADMINISTRACIÓN DE USUARIOS ==========

// Obtener todos los usuarios (solo para admin)
Stream<List<UserModel>> getAllUsers() {
  return _firestore
      .collection('users')
      .orderBy('displayName')
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserModel.fromFirestore(doc))
          .toList());
}

// Actualizar rol de usuario (solo admin)
Future<Map<String, dynamic>> updateUserRole({
  required String userId,
  required String newRole,
  required String adminId,
}) async {
  try {
    // Verificar que el nuevo rol sea válido
    if (!['user', 'moderator', 'admin'].contains(newRole)) {
      return {
        'success': false,
        'message': 'Rol inválido. Debe ser: user, moderator o admin',
      };
    }

    // Verificar que el admin no se esté modificando a sí mismo
    if (userId == adminId) {
      return {
        'success': false,
        'message': 'No puedes modificar tu propio rol',
      };
    }

    // Actualizar el rol en Firestore
    await _firestore.collection('users').doc(userId).update({
      'role': newRole,
    });

    return {
      'success': true,
      'message': 'Rol actualizado correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al actualizar rol: ${e.toString()}',
    };
  }
}

// ========== MÉTODOS PARA EDITAR PERFIL ==========

// Actualizar edades de hijos
Future<Map<String, dynamic>> updateChildrenAges({
  required String userId,
  required List<int> ages,
}) async {
  try {
    await _firestore.collection('users').doc(userId).update({
      'childrenAges': ages,
    });
    
    return {
      'success': true,
      'message': 'Edades actualizadas correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al actualizar edades: ${e.toString()}',
    };
  }
}

// Actualizar plataformas
Future<Map<String, dynamic>> updateOwnedPlatforms({
  required String userId,
  required List<String> platforms,
}) async {
  try {
    await _firestore.collection('users').doc(userId).update({
      'ownedPlatforms': platforms,
    });
    
    return {
      'success': true,
      'message': 'Plataformas actualizadas correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al actualizar plataformas: ${e.toString()}',
    };
  }
}

// Actualizar URL de avatar
Future<Map<String, dynamic>> updatePhotoUrl({
  required String userId,
  required String photoUrl,
}) async {
  try {
    await _firestore.collection('users').doc(userId).update({
      'photoUrl': photoUrl,
    });
    
    return {
      'success': true,
      'message': 'Avatar actualizado correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al actualizar avatar: ${e.toString()}',
    };
  }
}

// Actualizar información básica del usuario (displayName, email)
Future<Map<String, dynamic>> updateUserBasicInfo({
  required String userId,
  String? displayName,
  String? email,
}) async {
  try {
    final Map<String, dynamic> updates = {};
    if (displayName != null) updates['displayName'] = displayName;
    if (email != null) updates['email'] = email;

    if (updates.isNotEmpty) {
      await _firestore.collection('users').doc(userId).update(updates);
    }

    return {
      'success': true,
      'message': 'Información de usuario actualizada correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al actualizar información: ${e.toString()}',
    };
  }
}

// Eliminar cuenta de usuario
Future<Map<String, dynamic>> deleteUserAccount(String userId) async {
  try {
    await _firestore.collection('users').doc(userId).delete();
    
    return {
      'success': true,
      'message': 'Cuenta eliminada correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al eliminar cuenta: ${e.toString()}',
    };
  }
}
}