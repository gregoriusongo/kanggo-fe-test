import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/news_repository.dart';
import '../../../data/models/article.dart';
import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository _newsRepository;

  NewsBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(const NewsState()) {
    on<LoadNews>(_onLoadNews);
    on<LoadMoreNews>(_onLoadMoreNews);
    on<SearchNews>(_onSearchNews);
    on<ClearSearch>(_onClearSearch);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    if (event.refresh) {
      emit(state.copyWith(
        status: NewsStatus.loading,
        articles: [],
        currentPage: 1,
        hasReachedMax: false,
        errorMessage: null,
      ));
    } else if (state.status == NewsStatus.initial) {
      emit(state.copyWith(status: NewsStatus.loading));
    }

    try {
      final articles = await _newsRepository.getTopHeadlines(
        page: 1,
        pageSize: 20,
      );

      emit(state.copyWith(
        status: NewsStatus.success,
        articles: articles,
        currentPage: 1,
        hasReachedMax: articles.length < 20,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onLoadMoreNews(LoadMoreNews event, Emitter<NewsState> emit) async {
    if (state.hasReachedMax || state.status == NewsStatus.loadingMore) return;

    emit(state.copyWith(status: NewsStatus.loadingMore));

    try {
      final nextPage = state.currentPage + 1;
      List<Article> newArticles;

      if (state.searchQuery != null && state.searchQuery!.isNotEmpty) {
        newArticles = await _newsRepository.searchNews(
          query: state.searchQuery!,
          page: nextPage,
          pageSize: 20,
        );
      } else {
        newArticles = await _newsRepository.getTopHeadlines(
          page: nextPage,
          pageSize: 20,
        );
      }

      emit(state.copyWith(
        status: NewsStatus.success,
        articles: [...state.articles, ...newArticles],
        currentPage: nextPage,
        hasReachedMax: newArticles.length < 20,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onSearchNews(SearchNews event, Emitter<NewsState> emit) async {
    emit(state.copyWith(
      status: NewsStatus.loading,
      articles: [],
      currentPage: 1,
      hasReachedMax: false,
      searchQuery: event.query,
      errorMessage: null,
    ));

    try {
      final articles = await _newsRepository.searchNews(
        query: event.query,
        page: 1,
        pageSize: 20,
      );

      emit(state.copyWith(
        status: NewsStatus.success,
        articles: articles,
        currentPage: 1,
        hasReachedMax: articles.length < 20,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: NewsStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onClearSearch(ClearSearch event, Emitter<NewsState> emit) async {
    emit(state.copyWith(
      searchQuery: null,
      articles: [],
      currentPage: 1,
      hasReachedMax: false,
    ));
    add(const LoadNews());
  }

  Future<void> _onToggleFavorite(ToggleFavorite event, Emitter<NewsState> emit) async {
    final articleIndex = state.articles.indexWhere((article) => article.id == event.articleId);
    if (articleIndex == -1) return;

    final article = state.articles[articleIndex];
    final newFavoriteStatus = !article.isFavorite;

    // NOTE - Uncomment the print lines for debugging
    // print('Toggling favorite for article: ${article.id}');
    // print('Old favorite status: ${article.isFavorite}');
    // print('New favorite status: $newFavoriteStatus');

    // Optimistically update the UI first for immediate feedback
    final updatedArticles = List<Article>.from(state.articles);
    updatedArticles[articleIndex] = article.copyWith(isFavorite: newFavoriteStatus);

    // print('Emitting new state with ${updatedArticles.length} articles');
    // print('Updated article favorite status: ${updatedArticles[articleIndex].isFavorite}');

    emit(state.copyWith(articles: updatedArticles));

    try {
      // Then update the database
      if (newFavoriteStatus) {
        await _newsRepository.addToFavorites(article);
      } else {
        await _newsRepository.removeFromFavorites(event.articleId);
      }
      // print('Database update successful');
    } catch (e) {
      // print('Database update failed: $e');
      // If database operation fails, revert the UI change
      final revertedArticles = List<Article>.from(state.articles);
      revertedArticles[articleIndex] = article.copyWith(isFavorite: !newFavoriteStatus);
      emit(state.copyWith(
        articles: revertedArticles,
        status: NewsStatus.failure,
        errorMessage: 'Failed to update favorite: ${e.toString()}',
      ));
    }
  }
}
