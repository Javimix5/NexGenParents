import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/dictionary_term_model.dart';
import '../models/user_model.dart';
import '../models/forum_post_model.dart';
import '../models/forum_reply_model.dart';
import '../models/parental_guide_model.dart';
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
    String? term,
    String? definition,
    String? example,
    String? category,
  }) async {
    try {
      Map<String, dynamic> updates = {
        'updatedAt': Timestamp.now(),
      };

      if (term != null) updates['term'] = term.trim();
      if (definition != null) updates['definition'] = definition.trim();
      if (example != null) updates['example'] = example.trim();
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

// Actualizar años de nacimiento de hijos
Future<Map<String, dynamic>> updateChildrenBirthYears({
  required String userId,
  required List<int> birthYears,
}) async {
  try {
    await _firestore.collection('users').doc(userId).update({
      'childrenBirthYears': birthYears,
    });

    return {
      'success': true,
      'message': 'Años de nacimiento actualizados correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al actualizar años de nacimiento: ${e.toString()}',
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

// ========== MÉTODOS PARA GUÍAS DE CONTROL PARENTAL ==========

// Obtener guías adicionales desde Firestore (para escalabilidad futura)
Future<List<ParentalGuide>> getExtraGuides() async {
  try {
    final snapshot = await _firestore
        .collection('parental_guides_extra')
        .get();

    return snapshot.docs
        .map((doc) {
          final data = doc.data();
          // Asegurar que tiene ID
          if (data['id'] == null || data['id'].isEmpty) {
            data['id'] = doc.id;
          }
          return ParentalGuide.fromMap(data);
        })
        .toList();
  } on FirebaseException catch (e) {
    if (e.code != 'permission-denied') {
      print('Error al obtener guías extras desde Firestore: $e');
    }
    return [];
  } catch (e) {
    print('Error al obtener guías extras desde Firestore: $e');
    return [];
  }
}

// --- Métodos para el Foro ---

// Obtiene el total de mensajes aportados por un usuario (hilos + respuestas).
Future<int> getUserCommunityMessagesCount(String userId) async {
  try {
    final postsCountSnapshot = await _firestore
        .collection('forum_posts')
        .where('authorId', isEqualTo: userId)
        .count()
        .get();

    final repliesCountSnapshot = await _firestore
        .collection('forum_replies')
        .where('authorId', isEqualTo: userId)
        .count()
        .get();

    final postsCount = postsCountSnapshot.count ?? 0;
    final repliesCount = repliesCountSnapshot.count ?? 0;
    return postsCount + repliesCount;
  } catch (e) {
    print('Error al obtener total de mensajes de comunidad: $e');
    return 0;
  }
}

// Obtiene un stream de todas las publicaciones del foro, ordenadas por la actividad más reciente.
Stream<List<ForumPost>> getForumPosts() {
  return _firestore
      .collection('forum_posts')
      .orderBy('updatedAt', descending: true)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => ForumPost.fromMap(doc.id, doc.data()))
        .toList();
  });
}

// Obtiene un stream de las respuestas para una publicación específica.
Stream<List<ForumReply>> getRepliesForPost(String postId) {
  return _firestore
      .collection('forum_replies')
      .where('postId', isEqualTo: postId)
      .orderBy('createdAt', descending: false)
      .snapshots()
      .map((snapshot) {
    return snapshot.docs
        .map((doc) => ForumReply.fromMap(doc.id, doc.data()))
        .toList();
  });
}

// Crea una nueva publicación en el foro.
Future<void> createForumPost(ForumPost post) async {
  await _firestore.collection('forum_posts').add(post.toMap());
}

// Elimina una publicación del foro y sus respuestas asociadas.
Future<Map<String, dynamic>> deleteForumPost(String postId) async {
  try {
    final repliesSnapshot = await _firestore
        .collection('forum_replies')
        .where('postId', isEqualTo: postId)
        .get();

    final batch = _firestore.batch();

    for (final replyDoc in repliesSnapshot.docs) {
      batch.delete(replyDoc.reference);
    }

    batch.delete(_firestore.collection('forum_posts').doc(postId));

    await batch.commit();

    return {
      'success': true,
      'message': 'Publicación eliminada correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al eliminar la publicación: ${e.toString()}',
    };
  }
}

// Elimina una respuesta del foro y actualiza el contador del post.
Future<Map<String, dynamic>> deleteForumReply({
  required String replyId,
  required String postId,
}) async {
  try {
    final postRef = _firestore.collection('forum_posts').doc(postId);
    final replyRef = _firestore.collection('forum_replies').doc(replyId);

    await _firestore.runTransaction((transaction) async {
      final postSnapshot = await transaction.get(postRef);
      if (!postSnapshot.exists) {
        throw FirebaseException(
          plugin: 'cloud_firestore',
          code: 'not-found',
          message: 'La publicación asociada no existe',
        );
      }

      transaction.delete(replyRef);

      final currentReplyCount = (postSnapshot.data()?['replyCount'] ?? 0) as int;
      transaction.update(postRef, {
        'replyCount': currentReplyCount > 0 ? currentReplyCount - 1 : 0,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    });

    return {
      'success': true,
      'message': 'Respuesta eliminada correctamente',
    };
  } catch (e) {
    return {
      'success': false,
      'message': 'Error al eliminar la respuesta: ${e.toString()}',
    };
  }
}

// Añade una respuesta y actualiza el contador y la fecha en la publicación principal.
Future<void> createForumReply(ForumReply reply) async {
  final postRef = _firestore.collection('forum_posts').doc(reply.postId);
  final replyRef = _firestore.collection('forum_replies').doc();

  // Usamos una transacción para asegurar que ambas operaciones se completen correctamente.
  await _firestore.runTransaction((transaction) async {
    transaction.set(replyRef, reply.toMap());
    transaction.update(postRef, {
      'replyCount': FieldValue.increment(1),
      'updatedAt': FieldValue.serverTimestamp(),
      'lastReplyAt': FieldValue.serverTimestamp(),
    });
  });
}
}