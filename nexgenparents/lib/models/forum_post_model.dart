import 'package:cloud_firestore/cloud_firestore.dart';

import 'forum_section.dart';

class ForumPost {
  final String id;
  final String title;
  final String content;
  final String authorId;
  final String authorName;
  final String sectionId;
  final String? topic;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int replyCount;

  ForumPost({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorName,
    this.sectionId = 'general',
    this.topic,
    required this.createdAt,
    required this.updatedAt,
    required this.replyCount,
  });

  factory ForumPost.fromMap(String id, Map<String, dynamic> map) {
    final legacyTopic = map['topic'] as String?;
    final storedSectionId = map['sectionId'] as String?;
    final resolvedSectionId = storedSectionId == null || storedSectionId.isEmpty
        ? ForumSections.idFromLegacyTopic(legacyTopic)
        : ForumSections.normalizeId(storedSectionId);

    return ForumPost(
      id: id,
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      authorId: map['authorId'] ?? '',
      authorName: map['authorName'] ?? 'Anónimo',
      sectionId: resolvedSectionId,
      topic: legacyTopic,
      createdAt: (map['createdAt'] as Timestamp? ?? Timestamp.now()).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp? ?? Timestamp.now()).toDate(),
      replyCount: map['replyCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'authorId': authorId,
      'authorName': authorName,
      'sectionId': ForumSections.normalizeId(sectionId),
      // Compatibilidad temporal para documentos legacy y pantallas antiguas.
      'topic': topic,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'replyCount': replyCount,
    };
  }

  String get effectiveSectionId {
    if (sectionId.trim().isNotEmpty) {
      return ForumSections.normalizeId(sectionId);
    }

    return ForumSections.idFromLegacyTopic(topic);
  }
}
