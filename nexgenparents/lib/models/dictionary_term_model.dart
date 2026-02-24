import 'package:cloud_firestore/cloud_firestore.dart';

class DictionaryTerm {
  final String id;
  final String term; // El término en sí (ej: "GG", "Nerf")
  final String definition; // Explicación clara del término
  final String example; // Frase de ejemplo de uso
  final String category; // 'jerga_gamer', 'mecánicas_juego', 'plataformas'
  final String status; // 'pending', 'approved', 'rejected'
  final String proposedBy; // userId del que propuso el término
  final String? approvedBy; // userId del moderador (null si pending)
  final int votes; // Likes/útil de la comunidad
  final int viewCount; // Contador de visualizaciones
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? rejectionReason; // Motivo si fue rechazado

  DictionaryTerm({
    required this.id,
    required this.term,
    required this.definition,
    this.example = '',
    required this.category,
    this.status = 'pending',
    required this.proposedBy,
    this.approvedBy,
    this.votes = 0,
    this.viewCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.rejectionReason,
  });

  // Constructor desde documento de Firestore
  factory DictionaryTerm.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return DictionaryTerm(
      id: doc.id,
      term: data['term'] ?? '',
      definition: data['definition'] ?? '',
      example: data['example'] ?? '',
      category: data['category'] ?? 'jerga_gamer',
      status: data['status'] ?? 'pending',
      proposedBy: data['proposedBy'] ?? '',
      approvedBy: data['approvedBy'],
      votes: data['votes'] ?? 0,
      viewCount: data['viewCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      rejectionReason: data['rejectionReason'],
    );
  }

  // Constructor desde Map
  factory DictionaryTerm.fromMap(Map<String, dynamic> map, String id) {
    return DictionaryTerm(
      id: id,
      term: map['term'] ?? '',
      definition: map['definition'] ?? '',
      example: map['example'] ?? '',
      category: map['category'] ?? 'jerga_gamer',
      status: map['status'] ?? 'pending',
      proposedBy: map['proposedBy'] ?? '',
      approvedBy: map['approvedBy'],
      votes: map['votes'] ?? 0,
      viewCount: map['viewCount'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      rejectionReason: map['rejectionReason'],
    );
  }

  // Convertir a Map para Firestore
  Map<String, dynamic> toMap() {
    return {
      'term': term,
      'definition': definition,
      'example': example,
      'category': category,
      'status': status,
      'proposedBy': proposedBy,
      'approvedBy': approvedBy,
      'votes': votes,
      'viewCount': viewCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'rejectionReason': rejectionReason,
    };
  }

  // Crear copia con cambios
  DictionaryTerm copyWith({
    String? id,
    String? term,
    String? definition,
    String? example,
    String? category,
    String? status,
    String? proposedBy,
    String? approvedBy,
    int? votes,
    int? viewCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? rejectionReason,
  }) {
    return DictionaryTerm(
      id: id ?? this.id,
      term: term ?? this.term,
      definition: definition ?? this.definition,
      example: example ?? this.example,
      category: category ?? this.category,
      status: status ?? this.status,
      proposedBy: proposedBy ?? this.proposedBy,
      approvedBy: approvedBy ?? this.approvedBy,
      votes: votes ?? this.votes,
      viewCount: viewCount ?? this.viewCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
    );
  }

  // Getters útiles
  bool get isApproved => status == 'approved';
  bool get isPending => status == 'pending';
  bool get isRejected => status == 'rejected';

  // Método para obtener el nombre legible de la categoría
  String get categoryDisplayName {
    switch (category) {
      case 'jerga_gamer':
        return 'Jerga Gamer';
      case 'mecánicas_juego':
        return 'Mecánicas de Juego';
      case 'plataformas':
        return 'Plataformas';
      default:
        return category;
    }
  }

  @override
  String toString() {
    return 'DictionaryTerm(id: $id, term: $term, status: $status, category: $category)';
  }
}