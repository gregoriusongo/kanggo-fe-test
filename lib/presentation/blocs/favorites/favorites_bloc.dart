import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repositories/news_repository.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final NewsRepository _newsRepository;

  FavoritesBloc({required NewsRepository newsRepository})
      : _newsRepository = newsRepository,
        super(const FavoritesState()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
  }

  Future<void> _onLoadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    emit(state.copyWith(status: FavoritesStatus.loading));

    try {
      final articles = await _newsRepository.getFavorites();
      emit(state.copyWith(
        status: FavoritesStatus.success,
        articles: articles,
        errorMessage: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onRemoveFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) async {
    try {
      await _newsRepository.removeFromFavorites(event.articleId);
      final updatedArticles = state.articles.where((article) => article.id != event.articleId).toList();
      emit(state.copyWith(articles: updatedArticles));
    } catch (e) {
      emit(state.copyWith(
        status: FavoritesStatus.failure,
        errorMessage: 'Failed to remove from favorites: ${e.toString()}',
      ));
    }
  }
}
