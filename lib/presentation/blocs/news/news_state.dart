import 'package:equatable/equatable.dart';
import '../../../data/models/article.dart';

enum NewsStatus { initial, loading, loadingMore, success, failure }

class NewsState extends Equatable {
  final NewsStatus status;
  final List<Article> articles;
  final String? errorMessage;
  final bool hasReachedMax;
  final int currentPage;
  final String? searchQuery;

  const NewsState({
    this.status = NewsStatus.initial,
    this.articles = const [],
    this.errorMessage,
    this.hasReachedMax = false,
    this.currentPage = 1,
    this.searchQuery,
  });

  NewsState copyWith({
    NewsStatus? status,
    List<Article>? articles,
    String? errorMessage,
    bool? hasReachedMax,
    int? currentPage,
    String? searchQuery,
  }) {
    return NewsState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      errorMessage: errorMessage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      currentPage: currentPage ?? this.currentPage,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        status,
        articles,
        errorMessage,
        hasReachedMax,
        currentPage,
        searchQuery,
      ];
}
