import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/services/news_api_service.dart';
import '../data/services/mock_news_api_service.dart';
import '../data/services/database_service.dart';
import '../data/repositories/news_repository_impl.dart';
import '../presentation/blocs/news/news_bloc.dart';
import '../presentation/blocs/favorites/favorites_bloc.dart';

class AppDependencies {
  static late dynamic _newsApiService; // Can be NewsApiService or MockNewsApiService
  static late DatabaseService _databaseService;
  static late NewsRepositoryImpl _newsRepository;
  static bool _useMockData = true; // Set to false to use real API

  static Future<void> init() async {
    // Initialize database service first
    _databaseService = DatabaseService();
    // Ensure database is ready
    await _databaseService.database;
    
    if (_useMockData) {
      _newsApiService = MockNewsApiService();
    } else {
      _newsApiService = NewsApiService();
    }
    
    _newsRepository = NewsRepositoryImpl(
      apiService: _newsApiService,
      databaseService: _databaseService,
    );
  }

  static List<BlocProvider> get blocProviders => [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(newsRepository: _newsRepository),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(newsRepository: _newsRepository),
        ),
      ];

  static NewsRepositoryImpl get newsRepository => _newsRepository;
  static dynamic get newsApiService => _newsApiService;
  static DatabaseService get databaseService => _databaseService;
  
  static void enableRealAPI() {
    _useMockData = false;
  }
}
