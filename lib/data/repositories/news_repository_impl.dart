import '../models/article.dart';
import '../services/database_service.dart';
import 'news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final dynamic _apiService; // Can be NewsApiService or MockNewsApiService
  final DatabaseService _databaseService;

  NewsRepositoryImpl({
    required dynamic apiService,
    required DatabaseService databaseService,
  })  : _apiService = apiService,
        _databaseService = databaseService;

  @override
  Future<List<Article>> getTopHeadlines({
    int page = 1,
    int pageSize = 20,
    String? query,
  }) async {
    try {
      final response = await _apiService.getTopHeadlines(
        page: page,
        pageSize: pageSize,
        query: query,
      );

      final articles = response.articles
          .map((json) => Article.fromJson(json))
          .toList();

      // Check which articles are favorites
      final articlesWithFavorites = <Article>[];
      for (final article in articles) {
        final isFav = await _databaseService.isFavorite(article.id);
        articlesWithFavorites.add(article.copyWith(isFavorite: isFav));
      }

      return articlesWithFavorites;
    } catch (e) {
      throw Exception('Failed to fetch headlines: ${e.toString()}');
    }
  }

  @override
  Future<List<Article>> searchNews({
    required String query,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final response = await _apiService.searchEverything(
        query: query,
        page: page,
        pageSize: pageSize,
      );

      final articles = response.articles
          .map((json) => Article.fromJson(json))
          .toList();

      // Check which articles are favorites
      final articlesWithFavorites = <Article>[];
      for (final article in articles) {
        final isFav = await _databaseService.isFavorite(article.id);
        articlesWithFavorites.add(article.copyWith(isFavorite: isFav));
      }

      return articlesWithFavorites;
    } catch (e) {
      throw Exception('Failed to search news: ${e.toString()}');
    }
  }

  @override
  Future<List<Article>> getFavorites() async {
    try {
      return await _databaseService.getFavorites();
    } catch (e) {
      throw Exception('Failed to fetch favorites: ${e.toString()}');
    }
  }

  @override
  Future<void> addToFavorites(Article article) async {
    try {
      await _databaseService.addToFavorites(article);
    } catch (e) {
      throw Exception('Failed to add to favorites: ${e.toString()}');
    }
  }

  @override
  Future<void> removeFromFavorites(String articleId) async {
    try {
      await _databaseService.removeFromFavorites(articleId);
    } catch (e) {
      throw Exception('Failed to remove from favorites: ${e.toString()}');
    }
  }

  @override
  Future<bool> isFavorite(String articleId) async {
    try {
      return await _databaseService.isFavorite(articleId);
    } catch (e) {
      return false;
    }
  }
}
