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
  final List<int>? childrenAges;
  final List<String>? ownedPlatforms;

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
    this.childrenAges,
    this.ownedPlatforms,
  });

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
      childrenAges: data['childrenAges'] != null 
          ? List<int>.from(data['childrenAges']) 
          : null,
      ownedPlatforms: data['ownedPlatforms'] != null
          ? List<String>.from(data['ownedPlatforms'])
          : null,
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
      childrenAges: map['childrenAges'] != null
          ? List<int>.from(map['childrenAges'])
          : null,
      ownedPlatforms: map['ownedPlatforms'] != null
          ? List<String>.from(map['ownedPlatforms'])
          : null,
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
      'childrenAges': childrenAges,
      'ownedPlatforms': ownedPlatforms,
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
    List<int>? childrenAges,
    List<String>? ownedPlatforms,
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
      childrenAges: childrenAges ?? this.childrenAges,
      ownedPlatforms: ownedPlatforms ?? this.ownedPlatforms,
    );
  }

  // Método para verificar si el usuario es moderador o admin
  bool get isModerator => role == 'moderator' || role == 'admin';
  
  bool get isAdmin => role == 'admin';

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, displayName: $displayName, role: $role)';
  }
}