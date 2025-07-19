import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';
import '../widgets/article_card.dart';
import '../widgets/common_widgets.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  void initState() {
    super.initState();
    // Load favorites when page is opened
    context.read<FavoritesBloc>().add(LoadFavorites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          switch (state.status) {
            case FavoritesStatus.initial:
            case FavoritesStatus.loading:
              return const LoadingWidget();

            case FavoritesStatus.failure:
              return CustomErrorWidget(
                message: state.errorMessage ?? 'An error occurred',
                onRetry: () {
                  context.read<FavoritesBloc>().add(LoadFavorites());
                },
              );

            case FavoritesStatus.success:
              if (state.articles.isEmpty) {
                return const EmptyStateWidget(
                  title: 'No favorite articles',
                  subtitle: 'Articles you mark as favorite will appear here',
                  icon: Icons.favorite_border,
                );
              }

              return RefreshIndicator(
                onRefresh: () async {
                  context.read<FavoritesBloc>().add(LoadFavorites());
                  // Wait for the refresh to complete
                  await Future.delayed(const Duration(milliseconds: 500));
                },
                child: ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) {
                    final article = state.articles[index];
                    return ArticleCard(
                      key: ValueKey(article.id),
                      article: article,
                      onFavoriteToggle: () {
                        context.read<FavoritesBloc>().add(RemoveFromFavorites(article.id));
                      },
                    );
                  },
                ),
              );
          }
        },
      ),
    );
  }
}
