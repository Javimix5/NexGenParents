import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final String role; // 'user', 'moderator', 'admin'
  final int termsProposed;
  final int termsApproved;
  final DateTime createdAt;
  final DateTime lastLogin;
  final String? photoUrl;
  final List<int>? childrenBirthYears;
  final List<String>? ownedPlatforms;
  final int level; // Nivel del usuario basado en publicaciones
  final int posts; // Número de publicaciones del usuario

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    this.role = 'user',
    this.termsProposed = 0,
    this.termsApproved = 0,
    required this.createdAt,
    required this.lastLogin,
    this.photoUrl,
    this.childrenBirthYears,
    this.ownedPlatforms,
    this.level = 1, // Nivel inicial por defecto
    this.posts = 0, // Número de publicaciones inicial
  });

  static List<int>? _parseChildrenBirthYears(dynamic birthYearsData, dynamic legacyAgesData) {
    if (birthYearsData != null) {
      return List<int>.from(birthYearsData);
    }

    if (legacyAgesData != null) {
      final currentYear = DateTime.now().year;
      final ages = List<int>.from(legacyAgesData);
      return ages.map((age) => currentYear - age).toList();
    }

    return null;
  }

  // Constructor para crear un UserModel desde un documento de Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['displayName'] ?? '',
      role: data['role'] ?? 'user',
      termsProposed: data['termsProposed'] ?? 0,
      termsApproved: data['termsApproved'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLogin: (data['lastLogin'] as Timestamp).toDate(),
      photoUrl: data['photoUrl'],
      childrenBirthYears: _parseChildrenBirthYears(
        data['childrenBirthYears'],
        data['childrenAges'],
      ),
      ownedPlatforms: data['ownedPlatforms'] != null
          ? List<String>.from(data['ownedPlatforms'])
          : null,
      level: data['level'] ?? 1, // Nivel inicial por defecto
      posts: data['posts'] ?? 0, // Número de publicaciones inicial
    );
  }

  // Constructor para crear un UserModel desde un Map
  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      email: map['email'] ?? '',
      displayName: map['displayName'] ?? '',
      role: map['role'] ?? 'user',
      termsProposed: map['termsProposed'] ?? 0,
      termsApproved: map['termsApproved'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastLogin: (map['lastLogin'] as Timestamp).toDate(),
      photoUrl: map['photoUrl'],
      childrenBirthYears: _parseChildrenBirthYears(
        map['childrenBirthYears'],
        map['childrenAges'],
      ),
      ownedPlatforms: map['ownedPlatforms'] != null
          ? List<String>.from(map['ownedPlatforms'])
          : null,
      level: map['level'] ?? 1, // Nivel inicial por defecto
      posts: map['posts'] ?? 0, // Número de publicaciones inicial
    );
  }

  // Método para convertir un UserModel a Map (para guardar en Firestore)
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'displayName': displayName,
      'role': role,
      'termsProposed': termsProposed,
      'termsApproved': termsApproved,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
      'photoUrl': photoUrl,
      'childrenBirthYears': childrenBirthYears,
      'ownedPlatforms': ownedPlatforms,
      'level': level,
      'posts': posts,
    };
  }

  // Método para crear una copia del usuario con campos actualizados
  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? role,
    int? termsProposed,
    int? termsApproved,
    DateTime? createdAt,
    DateTime? lastLogin,
    String? photoUrl,
    List<int>? childrenBirthYears,
    List<String>? ownedPlatforms,
    int? level,
    int? posts,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      termsProposed: termsProposed ?? this.termsProposed,
      termsApproved: termsApproved ?? this.termsApproved,
      createdAt: createdAt ?? this.createdAt,
      lastLogin: lastLogin ?? this.lastLogin,
      photoUrl: photoUrl ?? this.photoUrl,
      childrenBirthYears: childrenBirthYears ?? this.childrenBirthYears,
      ownedPlatforms: ownedPlatforms ?? this.ownedPlatforms,
      level: level ?? this.level,
      posts: posts ?? this.posts,
    );
  }

  // Método para verificar si el usuario es moderador o admin
  bool get isModerator => role.toLowerCase() == 'moderator' || role.toLowerCase() == 'admin';
  
  bool get isAdmin => role.toLowerCase() == 'admin';

  // Método para calcular el nivel basado en el número de publicaciones
  int calculateLevel() {
    if (isModerator || isAdmin) {
      return level; // Moderadores y admins mantienen su nivel
    }
    return (posts ~/ 10) + 1; // Cada 10 publicaciones, sube un nivel
  }

  // Método para actualizar el nivel del usuario
  UserModel updateLevel() {
    return copyWith(level: calculateLevel());
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, role: $role)';
  }
}