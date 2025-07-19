import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_list_page.dart';
import 'favorites_page.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  DateTime? _lastFavoritesRefresh;

  final List<Widget> _pages = [
    const NewsListPage(),
    const FavoritesPage(),
  ];

  @override
  void initState() {
    super.initState();
    // If the app starts on the favorites tab, refresh favorites
    if (_currentIndex == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _refreshFavorites();
      });
    }
  }

  void _refreshFavorites() {
    final now = DateTime.now();
    // Only refresh if more than 2 seconds have passed since last refresh
    if (_lastFavoritesRefresh == null || 
        now.difference(_lastFavoritesRefresh!).inSeconds > 2) {
      context.read<FavoritesBloc>().add(LoadFavorites());
      _lastFavoritesRefresh = now;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? 'News' : 'Favorites'),
        centerTitle: true,
        elevation: 2,
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          
          // Refresh favorites when favorites tab is selected
          if (index == 1) {
            _refreshFavorites();
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
