import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object?> get props => [];
}

class LoadNews extends NewsEvent {
  final bool refresh;

  const LoadNews({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class LoadMoreNews extends NewsEvent {}

class SearchNews extends NewsEvent {
  final String query;

  const SearchNews(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends NewsEvent {}

class ToggleFavorite extends NewsEvent {
  final String articleId;

  const ToggleFavorite(this.articleId);

  @override
  List<Object?> get props => [articleId];
}
