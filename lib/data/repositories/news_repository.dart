import '../models/article.dart';

abstract class NewsRepository {
  Future<List<Article>> getTopHeadlines({
    int page = 1,
    int pageSize = 20,
    String? query,
  });

  Future<List<Article>> searchNews({
    required String query,
    int page = 1,
    int pageSize = 20,
  });

  Future<List<Article>> getFavorites();

  Future<void> addToFavorites(Article article);

  Future<void> removeFromFavorites(String articleId);

  Future<bool> isFavorite(String articleId);
}
