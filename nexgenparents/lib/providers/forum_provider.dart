import 'dart:async';
import 'package:flutter/material.dart';
import '../models/forum_post_model.dart';
import '../models/forum_section.dart';
import '../models/forum_reply_model.dart';
import '../services/firestore_service.dart';

class ForumProvider with ChangeNotifier {
  final FirestoreService _firestoreService;
  StreamSubscription<List<ForumPost>>? _postsSubscription;

  ForumProvider({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService() {
    _init();
  }

  bool _isLoading = false;
  String? _errorMessage;
  List<ForumPost>? _posts;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  List<ForumPost> get posts => _posts ?? [];
  bool get isPostsLoading => _posts == null;

  void _init() {
    _postsSubscription = _firestoreService.getForumPosts().listen(
      (postList) {
        _posts = postList;
        notifyListeners();
      },
      onError: (e) {
        _errorMessage = null;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _postsSubscription?.cancel();
    super.dispose();
  }

  // --- Lógica para las publicaciones ---

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
      _errorMessage = null;
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
      _errorMessage = result['messageKey'];
      _setLoading(false);
      return result['success'] == true;
    } catch (e) {
      _errorMessage = null;
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
      _errorMessage = result['messageKey'];
      _setLoading(false);
      return result['success'] == true;
    } catch (e) {
      _errorMessage = null;
      _setLoading(false);
      return false;
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
