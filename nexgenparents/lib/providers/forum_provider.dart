import 'package:flutter/material.dart';
import '../models/forum_post_model.dart';
import '../models/forum_section.dart';
import '../models/forum_reply_model.dart';
import '../services/firestore_service.dart';

class ForumProvider with ChangeNotifier {
  final FirestoreService _firestoreService;

  ForumProvider({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // --- Lógica para las publicaciones ---

  Stream<List<ForumPost>> get postsStream => _firestoreService.getForumPosts();

  Future<bool> createPost({
    required String title,
    required String content,
    required String authorId,
    required String authorName,
    required String sectionId,
  }) async {
    _setLoading(true);
    try {
      final newPost = ForumPost(
        id: '', // Firestore lo genera
        title: title,
        content: content,
        authorId: authorId,
        authorName: authorName,
        sectionId: ForumSections.normalizeId(sectionId),
        topic: ForumSections.byId(sectionId).nameEs,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        replyCount: 0,
      );
      await _firestoreService.createForumPost(newPost);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = 'Error al crear la publicación: $e';
      _setLoading(false);
      return false;
    }
  }

  Future<int> getUserCommunityMessagesCount(String userId) {
    return _firestoreService.getUserCommunityMessagesCount(userId);
  }

  // --- Lógica para las respuestas ---

  Stream<List<ForumReply>> getRepliesStream(String postId) {
    return _firestoreService.getRepliesForPost(postId);
  }

  Future<void> addReply(ForumReply reply) async {
    await _firestoreService.createForumReply(reply);
  }

  Future<bool> deletePost(String postId) async {
    _setLoading(true);
    try {
      final result = await _firestoreService.deleteForumPost(postId);
      _errorMessage = result['message'];
      _setLoading(false);
      return result['success'] == true;
    } catch (e) {
      _errorMessage = 'Error al eliminar la publicación: $e';
      _setLoading(false);
      return false;
    }
  }

  Future<bool> deleteReply(
      {required String replyId, required String postId}) async {
    _setLoading(true);
    try {
      final result = await _firestoreService.deleteForumReply(
        replyId: replyId,
        postId: postId,
      );
      _errorMessage = result['message'];
      _setLoading(false);
      return result['success'] == true;
    } catch (e) {
      _errorMessage = 'Error al eliminar la respuesta: $e';
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
