import 'package:equatable/equatable.dart';
import '../../../data/models/article.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<Article> articles;
  final String? errorMessage;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.articles = const [],
    this.errorMessage,
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<Article>? articles,
    String? errorMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      articles: articles ?? this.articles,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, articles, errorMessage];
}
