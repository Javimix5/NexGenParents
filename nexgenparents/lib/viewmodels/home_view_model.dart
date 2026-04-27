import 'package:flutter/foundation.dart';

import '../providers/auth_provider.dart';
import '../providers/dictionary_provider.dart';
import '../providers/forum_provider.dart';
import '../providers/games_provider.dart';

class HomeViewModel with ChangeNotifier {
  int _communityMessagesCount = 0;
  bool _isInitialized = false;

  int get communityMessagesCount => _communityMessagesCount;

  Future<void> initialize({
    required AuthProvider authProvider,
    required DictionaryProvider dictionaryProvider,
    required GamesProvider gamesProvider,
    required ForumProvider forumProvider,
  }) async {
    if (_isInitialized) return;
    _isInitialized = true;

    dictionaryProvider.loadApprovedTerms();
    gamesProvider.loadPopularGames();
    gamesProvider.loadWeeklyTopGame();

    final user = authProvider.currentUser;
    if (user == null) {
      notifyListeners();
      return;
    }

    dictionaryProvider.loadUserProposedTerms(user.id);
    _communityMessagesCount =
        await forumProvider.getUserCommunityMessagesCount(user.id);
    notifyListeners();
  }

  String resolveUserLevel(String? role) {
    final normalizedRole = (role ?? '').toLowerCase();
    if (normalizedRole == 'admin') return 'Admin';
    if (normalizedRole == 'moderator') return 'Moderador';

    if (_communityMessagesCount <= 10) return 'Principiante';
    if (_communityMessagesCount <= 20) return 'Aficionado';
    if (_communityMessagesCount <= 30) return 'Profesional';
    if (_communityMessagesCount < 100) return 'Maestro';
    return 'Leyenda';
  }
}
