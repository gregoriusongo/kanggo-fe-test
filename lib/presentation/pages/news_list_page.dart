import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/news/news_bloc.dart';
import '../blocs/news/news_event.dart';
import '../blocs/news/news_state.dart';
import '../widgets/article_card.dart';
import '../widgets/search_widget.dart';
import '../widgets/common_widgets.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({super.key});

  @override
  State<NewsListPage> createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Load initial news
    context.read<NewsBloc>().add(const LoadNews());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<NewsBloc>().add(LoadMoreNews());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SearchBarWidget(
            onSearch: (query) {
              context.read<NewsBloc>().add(SearchNews(query));
            },
            onClear: () {
              context.read<NewsBloc>().add(ClearSearch());
            },
          ),
          Expanded(
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                switch (state.status) {
                  case NewsStatus.initial:
                  case NewsStatus.loading:
                    return const LoadingWidget();

                  case NewsStatus.failure:
                    return CustomErrorWidget(
                      message: state.errorMessage ?? 'An error occurred',
                      onRetry: () {
                        context.read<NewsBloc>().add(const LoadNews(refresh: true));
                      },
                    );

                  case NewsStatus.success:
                  case NewsStatus.loadingMore:
                    if (state.articles.isEmpty) {
                      return EmptyStateWidget(
                        title: 'No articles found',
                        subtitle: state.searchQuery != null
                            ? 'Try searching with different keywords'
                            : 'Pull to refresh to load articles',
                        icon: Icons.article_outlined,
                        onAction: () {
                          context.read<NewsBloc>().add(const LoadNews(refresh: true));
                        },
                        actionText: 'Refresh',
                      );
                    }

                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<NewsBloc>().add(const LoadNews(refresh: true));
                        // Wait for the refresh to complete
                        await Future.delayed(const Duration(milliseconds: 500));
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        itemCount: state.articles.length + (state.status == NewsStatus.loadingMore ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= state.articles.length) {
                            return const Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          final article = state.articles[index];
                          return ArticleCard(
                            article: article,
                            onFavoriteToggle: () {
                              context.read<NewsBloc>().add(ToggleFavorite(article.id));
                            },
                          );
                        },
                      ),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
